Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FE3D95
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648473094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmTL7Ht9bkjAptiE2FiwPhAe2fJVvMUxQjxQnLYzmN4=;
	b=eIsgv547bCtogHGU2BSbPXy9m1s2iHF5+ZCq5lLwxkDGwVtw6v1XLvXoE8DrSuOKgU675v
	OnnqRgox5juryxLMTOZy/yJN0UNLERzYtPyCcpcA/jaUJuJS8qcsjESOGVf+TxTOlLLlvi
	8klBRBk4VFJ6+s9koZIwsu14MHyuyls=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-jvzi21nsPreN_YkQFh39Ag-1; Mon, 28 Mar 2022 15:11:32 +0200
X-MC-Unique: jvzi21nsPreN_YkQFh39Ag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkQ3OlUoL5966znYOa5hMlUYcQt78bt5pyDspKEhxoqFZXjdIbeplEDaFOKCvYBnNjvF8bqnQizARra3YSuoKLy7dvbfvFdPwVJr/akvCYuJMnRwivi/qonVFw4eVDHZ4dtGMcrhd0io3tDYtgCyduAdlyAS7JQr28hKPra+2ZfMX1D9qekkytXkTUWk+WQVW1dVyMA2AKwO2pVAcM1gF+WQ+2n4RgOOk1vpEIINFCb+kJcS+XmAZKWR9rKx9YicPgExmiCr3gibX4mHBmq4cwGffEUNeIkCItVyYPb21dY1/WH9C+VPTyYA1tLs/M4smHGdXpefuFtbB3X0mHCi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmTL7Ht9bkjAptiE2FiwPhAe2fJVvMUxQjxQnLYzmN4=;
 b=PULQAtsC3olOiYgLSCVOmRNXwV0peLNfsjCuOZyunIli14eXS8IqdAYNueHyWLk7iV730LKoIp6kkxJSUzlnvvCB5XuGPQ6rqO+IQo6i/0aQRfd78iz9E+rWDDMJbtIHLomqu2tRRqWWWi5UCUkcABusJKJNvfI8XpyzH48YRdezrBgKsANW1cUVy98H6kB5CDqb8zJfpFEQUWNzdBE+RN9VD9kepikIQ17I7LSDtH5lq2+G9xBXdyFcjbid7pX1YwpchgBCHGtgUaHDNoHZlYH5eujXGiMxATXiHIPPj1xZcSznUljftp4O4jr/aV1TZUoIUPW17GSqB35V6UOSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9215.eurprd04.prod.outlook.com (2603:10a6:150:2a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 13:11:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 13:11:31 +0000
Date: Mon, 28 Mar 2022 21:11:34 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 1/8] mptcp: add struct mptcp_sched_ops
Message-ID: <20220328131134.GA1310@localhost>
References: <cover.1648459865.git.geliang.tang@suse.com>
 <033f8762a38a1d4a838bc737104c609d86fec8cf.1648459865.git.geliang.tang@suse.com>
 <20220328094919.GB18687@breakpoint.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328094919.GB18687@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa58b827-8223-4628-01eb-08da10bc7991
X-MS-TrafficTypeDiagnostic: GV1PR04MB9215:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB921556601C5522CD493EEE18F81D9@GV1PR04MB9215.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sKiSpVEtrhVLQqNTpQZYdLfGrU9/hKooB6vN2ayTm9eZN67aZQpxdPFWh3UMj+04jZzkUSsbIUFB2RRgoWvgymp5uQqjDvQlDjCdQtgc/IQFhB2oAMfC6KTLA8+VXMKl6W3epKSl+GHC5dLOEPehn5Nu59eYmrZr7qgMlRfVgOGq/LyWbsc5w75jfaHvyjkt+364EvXA6zto8UpzMDUnEzj79FUxGEI00RF5xkvDiVJWmqWXLx/llHTf2E7p7O5W9vEqVujWqiS0rdRhAigEXGMQFeqpdilLia+IgJVDqFpl7FNM57AT7GgsZ3WGtV+zUAsPn+BvZ3hpJn4G77K6iwwe1DvYSBsQQaNBUAR8eHuVlUk+ril+TcjdbvY9q0A5cNUwCv/XxqLWjt9EPh9lUcDgHLDGOW33ZWJY2P0jDHynq6624CZN70s523144mexhYRzOLCRGnyWqiqfufUmcIuhbIv/1ZB5e1h34WIfub01ttv5M7+DLD+AUIHMYMG1yz7g9mXKBf5XhJvOrCbc+GKjdDVUD483S1nxiBcDWWpz6Rlhc5fKptPRjqVAePCbWFc8E4KtG1m1QzHTY1QoFX5/ZTxQIJThCYuFISF7qo3X7hhw09dUkAWFOFELUDD9WwKlHIQK/I4moc8uJLbJxigImpdk/cRi2e0lqNWun7YBOMo5oDyJIQhPvJ6+puyX+m9kXr4O+y2jgoiT7QKooA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(83380400001)(86362001)(33716001)(5660300002)(6486002)(44832011)(38100700002)(26005)(186003)(2906002)(66946007)(8936002)(8676002)(33656002)(9686003)(1076003)(6512007)(316002)(66476007)(6506007)(4326008)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HhT8oGEOxH7giKAQq7Cny2Li7Qces5ho5lHQi/mKcWrvp05oEqx7bpx1KIFs?=
 =?us-ascii?Q?kKJqGR5rWDT9znsvsht23V5vVnySOZUNXLwY5Es/5D3DG6tj1KyaQsUi+W2O?=
 =?us-ascii?Q?3EJN6psHzfJA0o5j3LHErq6aqC3YmQKi8H08zuLr6nhvqU60WezHVt9/z8iq?=
 =?us-ascii?Q?CgSr6ibqYOVbUjhEV8gqaCUCngCEEl0qQdzQjRiDnRNU0dTQ4O4hMMbudMBN?=
 =?us-ascii?Q?KbqsWLI2B6z6Dx0/smMb2r3ue7Z8adXj+VSjdb0TkXCqm3DqwrqDaaIrNCV7?=
 =?us-ascii?Q?Hj6YfqyRMfxP42INR5jYgFcjRpooj7BEqOAulqAd/GQAJIbMU96g7y3MDpdX?=
 =?us-ascii?Q?VFf1sKOQchUySJ/6sx1momq+shBBFOzggiZfApu8PZxQV54KepY8u6GMqQys?=
 =?us-ascii?Q?6GhMc2yySEbtIf/851rWNeEsiviIn+cGXPwaO04hw0L+fUlMhhIt2R7o1VKI?=
 =?us-ascii?Q?zh+WLfubhpmc5NJsmmihDDOPP4y+2vO2enr7aNGFazdIxtXxz5/x2NGWi/dq?=
 =?us-ascii?Q?98Q0ehYBx4665hSVglxG7GuophiIxPpvyT/v+9AFYN4HiEhLAtW3p2dPNO7m?=
 =?us-ascii?Q?SeP1LZRz1xs62lyemoa6H3lK+4uhjS0ODAooAVgRep8QX+uvehkbYRphmptd?=
 =?us-ascii?Q?TOCgd6n6NLH1h5pfKRiKrtwfJ1NC+BzAa2dCDDMokyQWhAy6+b+8gXuXW3fS?=
 =?us-ascii?Q?UoJfxfEH9ob/LwlpJu/2DNEY37OeIfPBo90DCZOdbnW04XpdPCrpZzNPHoLe?=
 =?us-ascii?Q?kpPObsaKWU7KBbQo+qNVVacJbkvJPjKj+IA6YdJ7fq0vt84FFUhSWKKps2hW?=
 =?us-ascii?Q?NjTUIRkDfmQJZtx8HCs/SkzmUl4iRG0e+bKlH6LbtgpAoxYDKzins1s2EFNv?=
 =?us-ascii?Q?chWjPVnSy9TeMgFPf1lLAxAAtPsvSVIqDF0NSUj+go3K/e7MnJn+08LXfQaQ?=
 =?us-ascii?Q?ReVs5BS4K+THT8RlD6pHq0aLxy5ofqKxefczFT7vL3N2b+ipzuk/DkTD/MK6?=
 =?us-ascii?Q?6tTJAUITWGPbAlb9TIsIaUAYrO1uNvVbW90uyvnqnUW/OexSYJjefMW1tj29?=
 =?us-ascii?Q?L9ra3JpStwafTa38ype43n5SLQ39rULaXxdhVnFk/Txqhz3Jc8gj6Rpf8iS0?=
 =?us-ascii?Q?CEF48DyM8gL9QXoCb0ARhFkxIdv3P3ZXhsu9ppBHwkhMJm5aLBq+yds5tYX1?=
 =?us-ascii?Q?QcKE/24cUkoZSsFzYqQDODg/2ZgPGUZJoSjC7O8ZgoVnmeDWpRHPRCox33JZ?=
 =?us-ascii?Q?wfki8Emepv5lo8PQ+LJbgacf6cCeuolxsmFQyoyvXWlIxLlGG0ngXO57UMIN?=
 =?us-ascii?Q?/vrMomc+bAEI3GhP/3Hv0IYpySwJ10cELqLQQhlqUrhcMyGxrfjNzCMkQ99q?=
 =?us-ascii?Q?y4ywueTa70x08HpUQuKKZDaX34HN1ubVIQfLmya+cw9GKBJGI0ebchhLl/5c?=
 =?us-ascii?Q?3kPvlqXEj3gkC+tJ9qfUotXwhS23HdQYeZbDKIigEMWjhxnIdziNXEiUCmPo?=
 =?us-ascii?Q?aUm3reV6JKih/ASencECPKiGnZ7wNUl7cPj6RV+F7a6cMZth94JB2KH/5Nwa?=
 =?us-ascii?Q?ybiG2Y2BteOkVcanDHzFgYZ5tnvq8/2KWzN9DEFEHeAAAQ/h+fhzD7Gpfiaq?=
 =?us-ascii?Q?3FnI/MHVXDf18B2F3cFXX4chwwTIT6NquEVVgNbv/E8YyIgP24H/ZqilFH/M?=
 =?us-ascii?Q?HHpDfLQ2cPXHHXUw6cPFqRb1n+4SC9Gunk0sl1nY10BH9MBKKeP6DkV5MSY8?=
 =?us-ascii?Q?4XEFK7zjHmKTXAFXhU9J0ZSSUxd0I1E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58b827-8223-4628-01eb-08da10bc7991
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:11:31.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZQRK/V79BcqczvauDLHUsweGsfVKHY4qoQLHtorW+WUJ6Rthmg1uecTJpuGFMkCHyiRqLIl3tur9J6Tx86SCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9215

On Mon, Mar 28, 2022 at 11:49:19AM +0200, Florian Westphal wrote:
> Geliang Tang <geliang.tang@suse.com> wrote:
> > This patch defines struct mptcp_sched_ops, which has three struct members,
> > name, owner and list, and three function pointers, init, release and
> > get_subflow.
> > 
> > Add the scheduler registering, unregistering and finding functions to add
> > or delete or find a packet scheduler on the pernet sched_list.
> > 
> > Suggested-by: Florian Westphal <fw@strlen.de>
> 
> Huh?  I made some comments on earlier patch but I did not suggest this.
> In fact, I don't like this at all but I guess I've been vetoed wrt.
> pernet design.

Sorry Florian, I didn't use 'Suggested-by' tag correctly here. I'll drop
it in v8. At the weekly meeting last week, everyone did agree to use the
global list instead of the pernet list to implement sched list. I have no
strong intention of which type of list to use. I just think that if we
used pernet local_addr_list in PM netlink, it makes sense for sched list
to use pernet too.

How about switching to use global sched list in v8? I guess Mat won't
object.

> 
> > +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> > +					 const char *name)
> > +{
> > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > +	struct mptcp_sched_ops *sched, *ret = NULL;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
> > +		if (!strcmp(sched->name, name)) {
> > +			ret = sched;
> > +			break;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +	return ret;
> 
> This is fishy.  Either caller must already hold rcu read lock,
> or mptcp_sched_ops can be free'd before function returns.
> 
> I suspect its best to force callers to do the rcu_read_lock and
> document that this function is called with rcu read lock held.

Agree, update in v8.

> 
> > +int mptcp_register_scheduler(const struct net *net,
> > +			     struct mptcp_sched_ops *sched)
> > +{
> > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > +
> > +	if (!sched->get_subflow)
> > +		return -EINVAL;
> > +
> > +	if (mptcp_sched_find(net, sched->name))
> > +		return -EEXIST;
> > +
> > +	spin_lock(&pernet->lock);
> > +	list_add_tail_rcu(&sched->list, &pernet->sched_list);
> > +	spin_unlock(&pernet->lock);
> 
> This is racy.  Lock, test, add, unlock, not test, lock, ...

How should I fix this?

> 
> > +	spin_lock(&pernet->lock);
> > +	list_del_rcu(&sched->list);
> > +	spin_unlock(&pernet->lock);
> > +
> > +	/* avoid workqueue lockup */
> > +	synchronize_rcu();
> 
> Hmm.  You mean 'wait until rcu read sides are done'?
> But even that makes little sense to me.
> 
> There is no free operation done here so this is safe even
> without synchronize_rcu()?

To be honest, I don't know if I should use synchronize_rcu() here. But
I've tested it. If remove this synchronize_rcu(), kernel will crash, with
"BUG: workqueue lockup - pool ...!"

Thanks,
-Geliang

> 

