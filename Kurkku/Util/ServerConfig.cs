﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Xml;

namespace Kurkku.Util
{
    class ServerConfig
    {
        #region Fields

        private static readonly string m_ConfigFileName = "config.xml";
        private static readonly ServerConfig m_ServerConfig = new ServerConfig();
        private Dictionary<string, string> m_ConfigValues;

        #endregion

        #region Properties

        /// <summary>
        /// Get the singleton instance
        /// </summary>
        public static ServerConfig Instance
        {
            get
            {
                return m_ServerConfig;
            }
        }

        #endregion

        #region Constructors

        /// <summary>
        /// Attempt to read configuration file
        /// </summary>
        public ServerConfig()
        {
            if (m_ConfigValues == null)
                m_ConfigValues = new Dictionary<string, string>();

            if (!File.Exists(m_ConfigFileName))
            {
                WriteConfig();
            }

            m_ConfigValues.Clear();

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(m_ConfigFileName);

            SetConfig(xmlDoc, "mysql/hostname");
            SetConfig(xmlDoc, "mysql/username");
            SetConfig(xmlDoc, "mysql/password");
            SetConfig(xmlDoc, "mysql/database");
            SetConfig(xmlDoc, "mysql/port");
            SetConfig(xmlDoc, "mysql/min_connections", "min_connections");
            SetConfig(xmlDoc, "mysql/max_connections", "max_connections");
            SetConfig(xmlDoc, "server/ip");
            SetConfig(xmlDoc, "server/port");

            Console.WriteLine(GetString("mysql", "hostname"));
        }

        private void SetConfig(XmlDocument xmlDoc, string xmlPath, string configKey = null)
        {
            try
            {
                m_ConfigValues[configKey ?? xmlPath] = xmlDoc.SelectSingleNode("//configuration/" + xmlPath).InnerText;
            }
            catch
            {
                m_ConfigValues[configKey ?? xmlPath] = string.Empty;
            }
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Attempts to write configuration file
        /// </summary>
        private void WriteConfig()
        {
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.Indent = true;
            settings.IndentChars = ("   ");
            settings.OmitXmlDeclaration = true;

            XmlWriter xmlWriter = XmlWriter.Create(m_ConfigFileName, settings);

            xmlWriter.WriteStartDocument();
            xmlWriter.WriteStartElement("configuration");
            xmlWriter.WriteStartElement("mysql");

            xmlWriter.WriteStartElement("hostname");
            xmlWriter.WriteString("localhost");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("username");
            xmlWriter.WriteString("root");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("password");
            xmlWriter.WriteString("");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("database");
            xmlWriter.WriteString("Kurkku");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("port");
            xmlWriter.WriteString("3306");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("min_connections");
            xmlWriter.WriteString("5");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("max_connections");
            xmlWriter.WriteString("5");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteEndElement();
            xmlWriter.WriteStartElement("server");

            xmlWriter.WriteStartElement("ip");
            xmlWriter.WriteString("127.0.0.1");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteStartElement("port");
            xmlWriter.WriteString("91");
            xmlWriter.WriteEndElement();

            xmlWriter.WriteEndElement();
            xmlWriter.WriteEndDocument();
            xmlWriter.Close();
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Get string by key
        /// </summary>
        /// <param name="key">the key</param>
        /// <returns>the string</returns>
        public string GetString(string category, string item)
        {
            return m_ConfigValues.GetValueOrDefault(string.Concat(category, "/", item));
        }

        /// <summary>
        /// Get integer by key
        /// </summary>
        /// <param name="key">the key</param>
        /// <returns>the integer</returns>
        public int GetInt(string category, string item)
        {
            int number = 0;
            int.TryParse(m_ConfigValues.GetValueOrDefault(string.Concat(category, "/", item)), out number);
            return number;
        }

        #endregion
    }
}
