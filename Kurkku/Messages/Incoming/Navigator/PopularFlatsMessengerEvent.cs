﻿using Kurkku.Game;
using Kurkku.Messages.Outgoing;
using Kurkku.Network.Streams;
using System.Linq;

namespace Kurkku.Messages.Incoming
{
    public class PopularFlatsMessengerEvent : IMessageEvent
    {
        public void Handle(Player player, Request request)
        {
            var roomList = RoomManager.Instance.Rooms.Where(x => x.Value.Data.UsersNow > 0).Select(x => x.Value).ToList();
            player.Send(new FlatListComposer(2, roomList));
        }
    }
}
