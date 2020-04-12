﻿using Kurkku.Storage.Database.Data;
using System.Collections.Generic;
using System.Linq;

namespace Kurkku.Storage.Database.Access
{
    public class RoomDao
    {

        /// <summary>
        /// Get list of public items
        /// </summary>
        public static List<PublicItemData> GetPublicItems()
        {
            using (var session = SessionFactoryBuilder.Instance.SessionFactory.OpenSession())
            {
                return session.QueryOver<PublicItemData>().List() as List<PublicItemData>;//.Where(x => x.Room != null).ToList();
            }
        }

        public static List<RoomData> GetUserRooms(int userId)
        {
            using (var session = SessionFactoryBuilder.Instance.SessionFactory.OpenSession())
            {
                return session.QueryOver<RoomData>().Where(x => x.OwnerId == userId).List() as List<RoomData>;
            }
        }
    }
}