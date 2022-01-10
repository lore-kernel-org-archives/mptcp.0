Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD072CA1
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641818004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQmHW1todFd6O89ERDGScDdBL2mEEkLSm6tLjyfIyxE=;
	b=XuI6e5K9OuiXzolXIYBVF7KJNeVSYLs1BpMAoqyCR+OrCwgnldq6Md7bi30jFygkvQk79c
	/TyPRkGJGkl/1XJ6kBCHru554z2rzE8JR2AuIcwKzI51MEEwg60EbXMR2Dajkcybsl4Edu
	DYoTx6NKcfmFy5Wd0n/fCJWN0HNcfuc=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-I88x9nXMPJedQTIW_qqkog-1; Mon, 10 Jan 2022 13:33:23 +0100
X-MC-Unique: I88x9nXMPJedQTIW_qqkog-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChPktOBzazQ7PB8qEnQv5Y089ROFhlJSmTIE9ZBLWRUWMnAbzZiRcuogLQxBKVKFWzvsuLl4wWeEowKtIzmbaDtkZBAySkz6sMfXQzeFDyJo+rFfcU17r2hDzX4ghRbXvOCVEC92hzMz2dJEat33rMmflIjx14WwtUeHavRnia+us7EwPw5W+8Q+kFh11BUdfY0EW+rZw++IgVA0ATB5izEejZhhM3TVaXTaTHbqoRh8yOYze2tPL/HdTA2IsnFPd6ysX5XkVpuxBSElkaPQ0AlaE0HQ8fz53d7sRrWxsQ3GDFVTWkh8y60BUacuI2Qgy6U8FuQ7bDDz/FZQ7gHMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQmHW1todFd6O89ERDGScDdBL2mEEkLSm6tLjyfIyxE=;
 b=VchiQSt6A/9IphKQoWJvnFQpyWHihyOJa91ZZDhJa+UNqDV6JNtBAAjF/+iUnZb9tmt6NVjelDBEq91jEoixB9s4MKEXPN6BFsfW3spZve72IfWgdOd1lRuTKJtiYX46Ko/pPHVr2dc22AntZlGwLTMaFEwqoKoM7sOsfGrKQfbzBss3g3G5D/1E0IaXhw1EtxLdbgzNeRc5I7sPdnlRvdR6hMkdrgRV6t8kA/S4EJopC1MhKLMQ5V3kv/+S71981nJS/MA3lX0aXufCnUxErphZY+AT24Jd28Doa7YAwa2Dph8tD0GzhHzZh9mt135Zrt6PORMB65IoeVK++nzTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB2955.eurprd04.prod.outlook.com (2603:10a6:7:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 12:33:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 12:33:22 +0000
Date: Mon, 10 Jan 2022 20:33:18 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/7] mptcp: fix removing ids bitmap
Message-ID: <20220110123318.GA3145@bogon>
References: <cover.1641785106.git.geliang.tang@suse.com>
 <c0f7d6c068b3047308263d83a2470003858cfb8e.1641785106.git.geliang.tang@suse.com>
 <b3999648a78756fe4551b821d26b2d0e8423ee44.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3999648a78756fe4551b821d26b2d0e8423ee44.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:3:1::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b810b944-418b-42da-2ecc-08d9d43563e8
X-MS-TrafficTypeDiagnostic: HE1PR04MB2955:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB295514E2F57BE0DD2D725990F8509@HE1PR04MB2955.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LT5Mm4dnIE5STL8Dn7gj0R1Ijai0yjo4cbPSK7c9HWCh3up5O6Va6PKC5Gcs3bUhq96EDMc1M5P4W9+0Gp3I8uG6n6FctwqNYOZ4zA7Aw5/ur6FQRtVKJi+U/W9wcIxBlh6cFOatA+Cyn+MalurbluBuB4ldCcXjipsHWw8PWZnBUk5Tlm0qJtdmHYe/lG2DLtVgXsBlhseiiUySYHXIYLTYkA5PnVPdi/eERBHxvD3Yhx7/mNiV3kACkkznoW2jyNqibU4fLndEw7vNA3FMuMrx0w152wKif9FokPEwtNQ8psPwk066Oe2pm0FUv6ToI6i/osf81kDju88kojw7Z+m5PYx+fq/pXoCQvfVTxOX/b3T9P38VxcPZBmY5ovwEHeMuh9pkUIHWU+d9gJHjaFsePBbuizqwarM1lhRwrlIrjhvUijS9tSzeYxjHTyiO5pom0gRskAwDpW5TWBPYekfGblAgzoV+XlIhtTM8N3OU1TUN6n8EP5EXYmACpZ5ZISHVPuOSbSR9H1/c5U13eGYkXVwECTF2P+IgAGF6y81b7n9Ngdjh/+r/NW9dAxPhm1GCn3j64rmL2lbiSr5f7DSodshMpCDtl+QpQ4Un4ExQ5nqrg6esd5D6lMphIoLTLG06xrKXj+uYQEPNiCVohQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(86362001)(6666004)(33716001)(508600001)(6506007)(1076003)(2906002)(83380400001)(110136005)(316002)(33656002)(8936002)(44832011)(186003)(8676002)(66476007)(66946007)(66556008)(38100700002)(6512007)(9686003)(6486002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UhVqqIcMmKY59dGkDj7ymiSgCaUO8U9UZB/vo6QfICOgk8pLrMwH7zCZMBU9?=
 =?us-ascii?Q?j8tARwPD0wQgFPy/mw5bNUU+aYb+YAaIqyWmgQcRudv1sLG8rRT6ghwmhTPu?=
 =?us-ascii?Q?FJWeLqe0wmQDCmXWykvYNOiwkmk+qTvszV85p/76+w2G2eT0I1vzPz8rL9nr?=
 =?us-ascii?Q?SLF2YIAViA0NIIc7UmXv0BfYJxK+bKm8oUs6yUoK9P7vQJnIFAWJ7k6XskJu?=
 =?us-ascii?Q?aS+PZOPa0H6eoICYqngS1Ehafupk01MjUc/90z539LNwGw3R3of+7bu/BCBN?=
 =?us-ascii?Q?r9dn6IvkG8QUkzcegXLnziFA0d7d95LmQlD/jXqQZhtwa3ptk9aArYR74EX8?=
 =?us-ascii?Q?xEZMf9RK8FyRGhTQ+p9ZxqbHlAJT0tNK8IEsXzB1u91tL5w/PY1erwIHuJ42?=
 =?us-ascii?Q?HdLVASKZrEpIhibPCT1wUvQsSS7zEslolD5NSpOJOrmV21DFizx4vKMUnahw?=
 =?us-ascii?Q?nM0YdQfZIBeyq/PEW8xewgKh6qDqJKyZbF6P8MTMT7fcIHOi0f5yufuxWBIN?=
 =?us-ascii?Q?hoJm5ZDBvOPGr2aL1ulLZ05KCJmY0E5ya9Hwj6vYaPdFz2YMDb56ymS0I193?=
 =?us-ascii?Q?AGXXaEp21GpUBTxMJOd82oWDR/vTha+syS+Xp2WYkCiubEd8IKy4nQol/Eq8?=
 =?us-ascii?Q?dpFhS/7cGIM2Mao2HxlPlIu2ITTRGqZ6qk6bO1a1gCjGRsz0fbOW2GB6hMi7?=
 =?us-ascii?Q?sNa6DTelyMFE+kpDZUDreuXCIDB5G36r5jhbG1uKy7jOc4qoKZVbTaPjy9FN?=
 =?us-ascii?Q?Kv91Cg9LzZTnlWRC7P+2WWgnsAmQL+2iD+fGXJ0B4Em+ydBMoCeMu8IR7A8t?=
 =?us-ascii?Q?yZipljpTIq7NvoarP0iBrPzvyxCZZ2OTXqe7w5mp5IsnrqPpMH4srGmm04K3?=
 =?us-ascii?Q?LqaaznT1j7eS8MqyboJmjcDNlutJVNXOoYIGWygeGA1tt4u0KUUWwtesWmhJ?=
 =?us-ascii?Q?dlgqJ6OYwxspI23i1V4DGDRc398kkYZdcuiXKb0hg2hOBOo4VMvJt5UdlHGS?=
 =?us-ascii?Q?F0tc5AtKIT6VUb0+xz6jLKHKOcJdmqwthOAvjK9upRPHnjkUYAfqmOvYnDQc?=
 =?us-ascii?Q?7Dt2rmBGFZyejPo57sGzZU7OcDjrjuEqdP99lxnMTzd3bOGAus9ifXXaqKxC?=
 =?us-ascii?Q?D47Gw03zSnBtHvITcZ8yrMYAbNs4t86w8ZUkYDP1ptsQobzefk3J/6XymmDN?=
 =?us-ascii?Q?8oifecfQGPBNkOqH3jGscu9Tg50jw/2DY5+VgK1ilYoR1s9EIhBsq2WhqcZI?=
 =?us-ascii?Q?MocTHwZwZinBB779E3YlLTtEx3KmfW0S4I4BIIgLrdgU/yvWscu7tgS6pcmq?=
 =?us-ascii?Q?1ChGE/7kt28sSMEjAIWGobt9eULzCsHjoRy4Hj9vbPFNHHjWKoGoPuIVLIuu?=
 =?us-ascii?Q?4Oz/bBz/XwfMRi8YC2GA3T9Y3onTSmxEtWClDN+/oR93zwYTah0sL/VTF6UO?=
 =?us-ascii?Q?z0fU5rTZLo/izMb3FVIz8ISRuZyyRPuxDM1xDYr930Rp/PlRHXQua8pRJ8PU?=
 =?us-ascii?Q?1IC57suyLp4Z9WwWAAwOOdnmbeVfvhVjZyPWGiCQpXFLkDacaMUZvecde1mr?=
 =?us-ascii?Q?THVxi1C8rSrYykTDtKEyAn++QusvfljBZsxvyBhmyvpoUv3YhVExnqsfhmmm?=
 =?us-ascii?Q?p325g1jBjTmHMsQLw8AHEFL1HQZZCX/AZARO0WunWZHA8Sp7pfTDqGm6D26f?=
 =?us-ascii?Q?7wMOXgmTrzXJkekeFJ4OVQMW4kk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b810b944-418b-42da-2ecc-08d9d43563e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 12:33:22.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIxNp/2A8HjbbgUcjsJoKDHof/dLGoP1TiNwWbM5ecBajyvPC5fbIklI83wIZh79Y8gODIlnSSBSx+6rAfyGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2955

On Mon, Jan 10, 2022 at 12:40:14PM +0100, Paolo Abeni wrote:
> On Mon, 2022-01-10 at 11:29 +0800, Geliang Tang wrote:
> > In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
> > id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.
> > 
> > Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/pm_netlink.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index f12effa71942..47ad00d01cf2 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -777,7 +777,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> >  			removed = true;
> >  			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> >  		}
> > -		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
> > +		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
> >  		if (!removed)
> >  			continue;
> >  
> 
> LGTM!
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> I think this one could be spooled independently from the other patches,
> so it could land on -net early.
> 
> WDYT?

Great!

Matt, could you please help me to update the subject of this patch to
"mptcp: fix removing ids bitmap setting" when merging it?

Thanks,
-Geliang

> 
> Thanks!
> 
> Paolo
> 

