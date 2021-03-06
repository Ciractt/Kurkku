﻿using Kurkku.Storage.Database.Data;

namespace Kurkku.Game
{
    public class MessengerUser
    {
        #region Properties

        public PlayerData PlayerData
        {
            get; set;
        }

        public Player Player
        {
            get { return PlayerManager.Instance.GetPlayerById(PlayerData.Id); }
        }

        public bool IsOnline
        {
            get { return Player != null; }
        }

        public bool InRoom => (Player != null ? Player.RoomUser.Room != null : false);

        #endregion

        #region Public methods

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;

            var t = obj as MessengerUser;

            if (t == null || t.PlayerData == null || this.PlayerData == null)
                return false;

            if (t.PlayerData.Id == this.PlayerData.Id)
                return true;

            return false;
        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        #endregion
    }
}
