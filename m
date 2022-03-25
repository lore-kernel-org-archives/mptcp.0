Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DC7E
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648225807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zMwDvakjPi2xFOzpImG+6/culkju+a+AWWzCTbHyw+8=;
	b=NpUUGiNdlcqTMd8IrRjiVDEX9/NcPFYeQQbme/+wzWRp6z5Z9fbHkDv4RHFJdX8OfvLmOQ
	XNGhSPc0DLprwMTpTRNEJtYTlHMGIZDtDMs+T8eZqWITkUwgC0EDEHKlqz79rBFvE0iYLb
	ci2MkcnToWrvTWT3FbmftFg0D6y01ck=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-qE5TTPzxNdK0AXzeHr5OSg-1; Fri, 25 Mar 2022 17:30:06 +0100
X-MC-Unique: qE5TTPzxNdK0AXzeHr5OSg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICgRAfXRZe0QwKo+H36TVt/jKV3017CluCAxkULwOB65IMZSg9PWFDYdzlzE3q4+2GetJkC7MuL6a1fdVf1eNMbH3lBdWG/U+xvQRP2geK1/MDYxzVSYiq8jOFE8zQxNU1LjlkMhv4HMLejjA7aCMwN4zwXfVwF8vrhs+vA6ygHFZtmdd4mQgb4/lzmcgxjA2B9KmxcN8NNLSKP1YBo9Nvk1GNj9CycqCh7T9xqyuMLxXFUAIyRCWedNJVkbPWhLRPDXNFnmZQOluj4D6+FADHnTB3tJA41MA3O5xtKXMQBqaeDfIr1pSBEXhyK+Mlu5kVypAkoAlE3yE9d3aW59HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMwDvakjPi2xFOzpImG+6/culkju+a+AWWzCTbHyw+8=;
 b=jWwvnl/rwSiMfzZY/ystLJzE9R6hjb3z820cFG45cqiFxr2C8vd4PvChSwfnPqb1LFImeYoNhlWMRH/ikgpdQIniJlyCBDAxGpR8TlvEhYBCZUcWcF9HV4NFR081a0CAtAZEpzJfgcSysFlFgG2ta5GGoK0NkuNQTgaUIZiOpAneDI2NeFC+pu1apguFkNY5D+9/+moC3qqbZevXhh5EE++qG8VZN25MxTOABLr4a+6myH4N2TROyRHlq929BUQNJtzBuT6JUDYWLnr+GelRX8YTlmmtIrPjkcfK2m3HI43O9LxfsX298s3ZVFbaqYvNwKZzhZzk012wquhK+lcspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4653.eurprd04.prod.outlook.com (2603:10a6:803:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 16:30:04 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::1ce7:eca9:4824:d96b]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::1ce7:eca9:4824:d96b%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 16:30:04 +0000
Date: Sat, 26 Mar 2022 00:30:04 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct
 mptcp_sched_ops
Message-ID: <20220325163004.GA16088@localhost>
References: <cover.1648130637.git.geliang.tang@suse.com>
 <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
 <3c9de8-eba6-881d-b869-d2339e76e8@linux.intel.com>
 <28cba8c9-f91b-2d55-2611-cd7fc6a3cf0@linux.intel.com>
 <982cae21-f36-3ee0-9ab-a53d9b6aba96@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982cae21-f36-3ee0-9ab-a53d9b6aba96@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eea4c70c-334a-4b4a-3aaf-08da0e7cb6ed
X-MS-TrafficTypeDiagnostic: VI1PR04MB4653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4653BA5A0190D9146C31CEB1F81A9@VI1PR04MB4653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MRW/7AcSsPnszrEYspgXmqSZv7JVqvgT+bYdbFw/1RxcvWNf3Cqtn2znEBojtbAnVl02+Au6cY+Axor3Q3oZxZUa3362mvU3dwbjlsBSRBvvZ/WuwxFBnEYS8xpW2JZ2HZpIWXQg7nXtzpM2IinhK8fX7WLuUOlIy0w5sH5vahb5ers0G9OErUiNuoJHd2ZVdVU9ZBSpFtpTrmgX9xGrwswIRfLj0VkRUnp9waULrEXDA5XdFc1WlsZRh4qamPdlhUOcEH4q+lNZwBCYEPpqkjxGIZ9IvB+htPZy5+YG3R6By0Vghp2/nk1+l8ocj7sl35d1vkOoIinGQSQVvsPHl0oroJHc6qce1qotZkUr3ala82GNgfVRwA1i/506s2q9wg7AdN20z05YZh2satk0C6w/jQ3Cr3vTi0RxEfEBZk8qU4rxJfK2wrKAYolK1nsIAK7PqrKNUT4VpWXDFuZ6TjI0kizAtjpWLUwfWjMy+qQcctzpJ54sV3PQIUYQ757deAwQG/y4ozRoTEKPiqhX6bP/FQuYDNY93NXi1aWyW+TJ5BlYulVShvsKUQsjZWFFMYl/pxMFTsqVRnxUMDsUXWzngX8VhjnpSUX+SLE5r5kfBkVu0AaXbuJfGJgxDk9OT78Xz5IyUdSGDMOHWKYOuVjZdvL0Sj8+Thc3b3TfeU+GSaeEzU62AgfOmPoExetE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(4326008)(33656002)(83380400001)(33716001)(44832011)(66946007)(9686003)(5660300002)(66556008)(66476007)(1076003)(26005)(8936002)(6512007)(186003)(8676002)(6916009)(316002)(86362001)(508600001)(38100700002)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3Twlw/P14egPSr7pXOT1v35ik5Cc7M1oeWUmC8xNEixacbYawlDqnbdailp?=
 =?us-ascii?Q?gzdamW3QX1f8bpb6L22H9tEPv93ZkrkDSkCAJ/KwYjyX9vEaumgIufkheaa8?=
 =?us-ascii?Q?imNBIyFPcsB+VUQpAXuD79gwWP5vWWY8ItKYW2Ww5t19MqNvU9swlXl8AHTd?=
 =?us-ascii?Q?TmGi+z11ymCZu2D06HvPqztLnQXW1C789Z6btTY9f3QJw3TfPcTbjsueCxW7?=
 =?us-ascii?Q?HUtFbC2fcHEPLHrq+nm/0E0DhVXfxsF2mI4T0yDIpg3EU1AIb/h2GzkFxQQZ?=
 =?us-ascii?Q?CNXirFmrBawAYDujcGmncSOk3Fs0Hn2N0rPdglZE5dUfQo7e7To2zHR5D6Fg?=
 =?us-ascii?Q?hjNGeg/4B1VvxG6xUSRdZWPSCBJRgF5ayrFmdDHTtfWPv1/asAmIPD0cufQh?=
 =?us-ascii?Q?Y/i10LXnwa4tIgvHOzpiq0P0vzO0CqJx/Yjiiii4wM6M2vPGaz3grdd4BHPz?=
 =?us-ascii?Q?Nw+vZKl0/74Py1JEK35fbGlCqAP2Gzv6HPqLHAvASoiGGJCH+HvnpseXGZBp?=
 =?us-ascii?Q?Vqaz4068Muezokaa6eVAsR6n6ccFD5XH8FxLcJr8F+tVHUHFDg6SXQoN2mkM?=
 =?us-ascii?Q?33K8W/lvmgDfkE1Z/Tibabn+e8muj6wQcS5WhGCPCzZCXbrN+XBxObA4Ww6i?=
 =?us-ascii?Q?TyKG77PAVHfGep1J0qX+IkJ+JI5XAOZpC8bIEhdF/DjK8eh3eKAhh6k7uBJ5?=
 =?us-ascii?Q?D0OJupS9oISjlGAAq8QO1dPsgns2M8tTaO5WYowlMmRCUIUj/ep17zVIM7vT?=
 =?us-ascii?Q?Evvy/qn2cmQA11v76UpzI1sx3/lVjINFNHgnvrOYjbKwfED+NLeiexr3X/dl?=
 =?us-ascii?Q?kRct20Fk95r1hhv+RIiK4kzeR2p5F1fOJ8E8CAxEowuj+se7zeek+cf8gUoO?=
 =?us-ascii?Q?TCXa7gT0cDAuZMeYU946w0mLRXr6fXgkNr/+cE2yRFwpYMqYgU//S8QNc7C+?=
 =?us-ascii?Q?DNU1LG3tGIGtz15Y0vW3+ox8YRVv72tLuig2DFpblB+XFlQDQEYRVQNkShkO?=
 =?us-ascii?Q?qlB9UfTmE4T2a0lFje1vH8WkZYcSkukY66vPbt2cS3b5yyiJHdG1F02sZIkz?=
 =?us-ascii?Q?3MLrsylUMGnZE3zWzZHc+BorgGKaHZalj+J5dtZMpj/x16Y8bk132Tux84zR?=
 =?us-ascii?Q?g4/WE/G4eu/SeS1Ojx2RTC+9av/nVEcfm/q63bKdSPxsAU1R+7tCWMnqq7x8?=
 =?us-ascii?Q?prLbFJvjjLfsoI1IIQOrLfvqQ0iJnCwml7Z39duK87Al/w3J8UPYNEwszXRO?=
 =?us-ascii?Q?jpIefV00+6vDqAK3FaU0aBgXCgo8roWq+Owag2rGJP2XXHZXr5s365EsPPPO?=
 =?us-ascii?Q?r9wzphBTV8bdSc0Go3pmmXJEAM57yXt7CxKHMP1fVZUjpldjDgryu5UFdCyz?=
 =?us-ascii?Q?ScV6z+sYCB1U0qsZtvlhR0SyINDu5RZbH4fg6Aadj7VLLNTZieEWDzhK2Ovc?=
 =?us-ascii?Q?tHnRSBMlR5fDZoX3vg1B1Wv6umhNkbxPqHp/now1FhFZ6xBN3Nq+6hrle4bQ?=
 =?us-ascii?Q?QNI/28j+jUI0Chztv3DFuL2HIfILa8V2BvO2ob1T4xuRbcCWndobLQgujqa/?=
 =?us-ascii?Q?y1tt22SphOhR6J5RedgIJiH67e1wk3K8ehNaCmi5M7LPr5udht/F/ashmxi3?=
 =?us-ascii?Q?92SbWZWGQ6nYBlsOfz2KqvePHWCwk5mMoEIPykedyY0x2osyaX0Nh9JS+R9P?=
 =?us-ascii?Q?aikfPmv34UW6COdI9B8B/u8vqVRJc8iuQSENu9Fg62VTN0w6dRBPCMfmky4B?=
 =?us-ascii?Q?rP0Ici+zqgSY04KgkDdz2YlDRbQGmUg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea4c70c-334a-4b4a-3aaf-08da0e7cb6ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:30:03.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq2Df26W7kOv5iOi70GqgahDJ8Oe75P2nvOR1eMunc5C6/SOi58y788A0ooflcmHuprQG2arTT2ZbaM4+dOIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4653

Sorry Mat, I gave you the wrong feedback at yesterday's weekly meeting.
BPF does work in different namespaces, see kernel/bpf/net_namespace.c
and include/linux/bpf-netns.h. I think we should continue to use the
pernet sched_list. v6 just sent out.

Thanks,
-Geliang

On Thu, Mar 24, 2022 at 04:36:51PM -0700, Mat Martineau wrote:
> On Thu, 24 Mar 2022, Mat Martineau wrote:
> 
> > On Thu, 24 Mar 2022, Mat Martineau wrote:
> > 
> > > On Thu, 24 Mar 2022, Geliang Tang wrote:
> > > 
> > > > This patch added struct mptcp_sched_ops. And define the scheduler
> > > > register, unregister and find functions.
> > > > 
> > > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > > ---
> > > > include/net/mptcp.h  |  13 +++++
> > > > net/mptcp/Makefile   |   2 +-
> > > > net/mptcp/protocol.c |   1 +
> > > > net/mptcp/protocol.h |   7 +++
> > > > net/mptcp/sched.c    | 114 +++++++++++++++++++++++++++++++++++++++++++
> > > > 5 files changed, 136 insertions(+), 1 deletion(-)
> > > > create mode 100644 net/mptcp/sched.c
> > > > 
> > > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > > index 8b1afd6f5cc4..e3a0baa8dbd7 100644
> > > > --- a/include/net/mptcp.h
> > > > +++ b/include/net/mptcp.h
> > > > @@ -95,6 +95,19 @@ struct mptcp_out_options {
> > > > #endif
> > > > };
> > > > 
> > > > +#define MPTCP_SCHED_NAME_MAX 16
> > > > +
> > > > +struct mptcp_sched_ops {
> > > > +	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
> > > > +
> > > > +	char			name[MPTCP_SCHED_NAME_MAX];
> > > > +	struct module		*owner;
> > > > +	struct list_head	list;
> > > > +
> > > > +	void (*init)(struct mptcp_sock *msk);
> > > > +	void (*release)(struct mptcp_sock *msk);
> > > > +} ____cacheline_aligned_in_smp;
> > > > +
> > > > #ifdef CONFIG_MPTCP
> > > > extern struct request_sock_ops mptcp_subflow_request_sock_ops;
> > > > 
> > > > diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> > > > index 0a0608b6b4b4..aa5c10d1b80a 100644
> > > > --- a/net/mptcp/Makefile
> > > > +++ b/net/mptcp/Makefile
> > > > @@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) += mptcp.o
> > > > ccflags-y += -DDEBUG
> > > 
> > > This line of context keeps making 'git am' fail - looks like you
> > > have a debug-enabling commit in your private tree?
> > > 
> > > This is probably why patchew is having trouble with this series too.
> > > 
> > > - Mat
> > > 
> > > > 
> > > > mptcp-y := protocol.o subflow.o options.o token.o crypto.o
> > > > ctrl.o pm.o diag.o \
> > > > -	   mib.o pm_netlink.o sockopt.o
> > > > +	   mib.o pm_netlink.o sockopt.o sched.o
> > > > 
> > > > obj-$(CONFIG_SYN_COOKIES) += syncookies.o
> > > > obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index d3887f628b54..b1d7c8b0c112 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -3807,6 +3807,7 @@ void __init mptcp_proto_init(void)
> > > > 
> > > > 	mptcp_subflow_init();
> > > > 	mptcp_pm_init();
> > > > +	mptcp_sched_init();
> > > > 	mptcp_token_init();
> > > > 
> > > > 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
> > > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > > index fd82fd113113..3258b740c8ee 100644
> > > > --- a/net/mptcp/protocol.h
> > > > +++ b/net/mptcp/protocol.h
> > > > @@ -608,6 +608,13 @@ int mptcp_subflow_create_socket(struct sock
> > > > *sk, struct socket **new_sock);
> > > > void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > > > 			 struct sockaddr_storage *addr,
> > > > 			 unsigned short family);
> > > > +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> > > > +					 const char *name);
> > > > +int mptcp_register_scheduler(const struct net *net,
> > > > +			     struct mptcp_sched_ops *sched);
> > > > +void mptcp_unregister_scheduler(const struct net *net,
> > > > +				struct mptcp_sched_ops *sched);
> > > > +void mptcp_sched_init(void);
> > > > 
> > > > static inline bool __mptcp_subflow_active(struct
> > > > mptcp_subflow_context *subflow)
> > > > {
> > > > diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> > > > new file mode 100644
> > > > index 000000000000..3798a5cefeb6
> > > > --- /dev/null
> > > > +++ b/net/mptcp/sched.c
> > > > @@ -0,0 +1,114 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Multipath TCP
> > > > + *
> > > > + * Copyright (c) 2022, SUSE.
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) "MPTCP: " fmt
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/rculist.h>
> > > > +#include <linux/spinlock.h>
> > > > +#include <net/tcp.h>
> > > > +#include <net/netns/generic.h>
> > > > +#include "protocol.h"
> > > > +
> > > > +static int sched_pernet_id;
> > > > +
> > > > +struct sched_pernet {
> > > > +	/* protects pernet updates */
> > > > +	spinlock_t		lock;
> > > > +	struct list_head	sched_list;
> > > > +};
> > > > +
> > > > +static struct sched_pernet *sched_get_pernet(const struct net *net)
> > > > +{
> > > > +	return net_generic(net, sched_pernet_id);
> > > > +}
> > > > +
> > > > +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> > > > +					 const char *name)
> > > > +{
> > > > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > > > +	struct mptcp_sched_ops *sched, *ret = NULL;
> > > > +
> > > > +	spin_lock(&pernet->lock);
> > > > +	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
> > > > +		if (!strcmp(sched->name, name)) {
> > > > +			ret = sched;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +	spin_unlock(&pernet->lock);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +int mptcp_register_scheduler(const struct net *net,
> > > > +			     struct mptcp_sched_ops *sched)
> > > > +{
> > > > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > > > +
> > > > +	if (!sched->get_subflow)
> > > > +		return -EINVAL;
> > 
> > Should also validate sched->name, don't want to allow a NULL pointer there.
> 
> Oops, never mind - name is an array, not a pointer!
> 
> > > > +
> > > > +	if (mptcp_sched_find(net, sched->name))
> > > > +		return -EEXIST;
> > > > +
> > > > +	spin_lock(&pernet->lock);
> > > > +	list_add_tail_rcu(&sched->list, &pernet->sched_list);
> > > > +	spin_unlock(&pernet->lock);
> > > > +
> > > > +	pr_debug("%s registered", sched->name);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void mptcp_unregister_scheduler(const struct net *net,
> > > > +				struct mptcp_sched_ops *sched)
> > > > +{
> > > > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > > > +
> > > > +	spin_lock(&pernet->lock);
> > > > +	list_del_rcu(&sched->list);
> > > > +	spin_unlock(&pernet->lock);
> > > > +
> > > > +	synchronize_rcu();
> > > > +}
> > > > +
> > > > +static int __net_init sched_init_net(struct net *net)
> > > > +{
> > > > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > > > +
> > > > +	INIT_LIST_HEAD_RCU(&pernet->sched_list);
> > > > +	spin_lock_init(&pernet->lock);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void __net_exit sched_exit_net(struct net *net)
> > > > +{
> > > > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > > > +	struct mptcp_sched_ops *sched;
> > > > +
> > > > +	spin_lock(&pernet->lock);
> > > > +	list_for_each_entry_rcu(sched, &pernet->sched_list, list)
> > > > +		list_del_rcu(&sched->list);
> > > > +	spin_unlock(&pernet->lock);
> > > > +
> > > > +	synchronize_rcu();
> > > > +}
> > > > +
> > > > +static struct pernet_operations mptcp_sched_pernet_ops = {
> > > > +	.init = sched_init_net,
> > > > +	.exit = sched_exit_net,
> > > > +	.id = &sched_pernet_id,
> > > > +	.size = sizeof(struct sched_pernet),
> > > > +};
> > > > +
> > > > +void mptcp_sched_init(void)
> > > > +{
> > > > +	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
> > > > +		panic("Failed to register MPTCP sched pernet subsystem.\n");
> > > > +}
> > 
> > --
> > Mat Martineau
> > Intel
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

