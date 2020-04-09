﻿using FluentNHibernate.Mapping;
using System;

namespace Kurkku.Storage.Database.Data
{
    public class SubscriptionDataMapping : ClassMap<SubscriptionData>
    {
        public SubscriptionDataMapping()
        {
            Table("user_subscriptions");
            Id(x => x.UserId, "user_id").GeneratedBy.Assigned();
            Map(x => x.Type, "subscription_type");//.CustomType<GenericEnumMapper<SubscriptionData>>(); ;
            Map(x => x.SubscribedDate, "subscribed_at");
            Map(x => x.ExpireDate, "expire_at");
        }
    }

    public class SubscriptionData 
    {
        public virtual int UserId { get; set; }
        public virtual SubscriptionType Type { get; set; }
        public virtual DateTime SubscribedDate { get; set; }
        public virtual DateTime ExpireDate { get; set; }
    }

    public enum SubscriptionType
    {
        HC = 1,
        VIP = 2
    }
}