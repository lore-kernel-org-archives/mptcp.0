Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725116400
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 13:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVKJB7LcQF/szmp1tsZu8LgXjgA0VqXTNVZwZAf5mj3bXQdU1nUPtBbeY0Asp7Rd5gA5AHrqMH0HEsheuTXuZkWBVBHO+6aIDKxcJy8Q47jFM4vXMcMSeKhzyC3Uh3ERQpKE/Y4U5n4xalv6mgsed8e49VrOIDk0aJSEiv8doMCKb/zSAhrncaYLTzmCmgFXjNK/5EHVDtdaOKBlYBdgiFnGeiw+FPwrGqw361CXC0Am3nqOAhW+66oHgbbujxTYjhP+cuFnI4EB2Im00lmG/+DWgolKiJXOSZ8C0rwM3SD0H+Lz+C/ms7QlmxgCe61Mop4CP9kyQqoo5P2nQ9WsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s68hOHw7djSBTwHqajrzRSHGxZK2vB4r79rRsVzxgWk=;
 b=e/+xJeDjA6NJzruICV//kG7DBrrgzq5NQCPB+iQYiyMVN7LOLgwF1COL0IMp2JpZcOqyWlQ9kgzFIUaEsuVoM3gU3TrtzLwLOyonGS1wobU2jg2DFRC1tw7yEsjK3CWFXr0OHyUrtYOgU5iWGujr9AvUvZW21LVG1t4mzXcUYedTa1rOwr/ypWXb7ZBQwgNDiMLegnPUx5fJunLuc5JH3+6w2tVis5P5kVyfoLIuI1G42luoYMZkEaL07yyJNI31VgJcv0kk1zwuB0XiaW30pe14vwebiT0q4Pz6wKMc9NtiSUDT6TA+yH2N8iplh0CHcMK1OliEM492q4DpN1lRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s68hOHw7djSBTwHqajrzRSHGxZK2vB4r79rRsVzxgWk=;
 b=iiGT1Gwiya5zEN24uRvUXHymfoHY5OcaM5DDn4Yt75A68T9qLOCgoJ+SfFuA3rIEr68acvuEmvjqr8YlGTvhmtKLpxZsDWmjK0kSQzNGvTnX4QICl6N6NevldIAcgjrCb5dDrG3MPfB6Uu8msOdXwjWAs4d8cnSjvGvdQ3onCVg0P9JMjLok/6Lt/Z5Ilm4gGOsbEFYvCsUp64wJ0oCSjhYX/rsGqFt9K8y50T8OFtM4sp5jRyLjw+PW3+uxbA6mpuWguRKnsBjJcx0wMTQB7XegleKabe4Ttk+tMWpTUKx3wLVRq+lvkAXTQ2+tA3DQqs8KkGTglzgJeHXeX4DH+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 13:32:49 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 13:32:48 +0000
Date: Fri, 9 Jun 2023 21:32:36 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
Message-ID: <20230609133236.GA30403@localhost>
References: <cover.1686202841.git.geliang.tang@suse.com>
 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB8PR04MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: d943db21-94f1-49fe-088e-08db68ee03d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t0QrPvGMcRp1CPCsxuEIrbtJ2jC+s1FUnNJD6UxwVSY96Ph28q6MNwufLe6zDq3oHsyoeuT5Fu/yc23+xpe/v2R11fvokwzt/WWYoszZBKO7CYwDBn8jYRp9QBvX4Cq4QmkXSxVbocQnHxKpDJkMFyZP9oa9dY0mykLVjtcQodaZVX58WhTiXTgdJvfevler+ypZoyJL8E6R0xqWbz6Exi/dtyfS+GTL4X2vWLQvsdRl93kzuexAiljKyQmF7f+3fB6GK8eDnfJMgGo+yyWfXgMGwdFDqq1O6h+L1G9qEVNA0NIyrw7dNCSdvLuEdR3wuaiUdteRD3H1LliUv3sq1bpygOLq9flERQ7OzfqnBYuqlJnnRty/mHNr1s/AALozOkYaDyM4t9G37m7EBInp9U62SQzNXOaaYtxhX0yR5zabQc4n8A42fz1AymVe3WvtZCpxVh7Ys4zNsfeaKhNECZ+dMdJOMWCjzB2VRhDJryfUYdnRGpi5DwqDqWcbYxQfk5ZJvJbyfLexoEML/w2Km0Ap/v9i64hAZbkqHunuLgUWjwwh+QhBuhzKoEwkrRWosHyMeLudUKzICp0dRqgAecvQ5G56R3MaQkqz5rZTYyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(86362001)(8676002)(8936002)(478600001)(41300700001)(6666004)(5660300002)(6486002)(316002)(6506007)(26005)(44832011)(4326008)(66476007)(66556008)(66946007)(6916009)(9686003)(6512007)(1076003)(186003)(83380400001)(2906002)(38100700002)(33656002)(33716001)(9126006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9iFxhXZG0auf3d0GJe6Z2KStmyMW5f+hSpSF/EYe/7y+4qzTnGfylLr4JrF?=
 =?us-ascii?Q?JKMHAydaBSZ26DNPmIx7RD/0dVvdV9uAsn9NlT8iT6qhnMgMwQQoMgiI43XW?=
 =?us-ascii?Q?I796RAuuvnA6it5mJNeRo2UaM0+iYJmacN2//Fuc5QDQ004+ewgLPExADl1W?=
 =?us-ascii?Q?0V69TKDOoJxAsmAZX3Btvp3kpDJGn8AETwhWHwBOblUN5yJwsZ4PgxNW82w3?=
 =?us-ascii?Q?jAok8H14N3zN2yQiiWaCYmmIY1fNe6olyUt/68eue74PtoyjLtt8kfmi4RQ5?=
 =?us-ascii?Q?r8Q1uqUQGPyRNPOvwZcFD2whqI/EM33uhtgsktJ0bv2QOFf1M3ALOmCz1SGU?=
 =?us-ascii?Q?mliCirQ3CwqFvrPJ0MTVh0KkQhawhRpp71R9E4Lx5kVJUtmSjvTcowBBAl65?=
 =?us-ascii?Q?8yh68TCWC8MkAta1siWNAfqcEz9A2UrhYNwSNAtIHu2LVlQgqwnAIZyTPB43?=
 =?us-ascii?Q?r1ukIXN8uMDhNnwxjGUlqNEP30319G6ngZa9mk86lJeGvKppyia4ynb1DBre?=
 =?us-ascii?Q?JjRJLlv/QQkIVTnCUASpicXH25HDS4FD0n+vhKrBdRI0CfV121LUNvb0ZcJk?=
 =?us-ascii?Q?oUHVqH/Uu7aDO0/QFogH30h0O8l2jBV/5yuQnqOUVIuwQsRBbIuclhLWl0Xu?=
 =?us-ascii?Q?r8IiHxB74LjHXwqPamLst3LSQs2gw0aSn/y38bIaOv18yauz2grwKAhOmccO?=
 =?us-ascii?Q?w3s/Q29Dxi2jT/S08tp3CyT++43ma80d3en5JGYDkxHsaLk0XNdR8a3w0QeD?=
 =?us-ascii?Q?8c6kF3z1YG+iwYNtEXYwbX/HgIA9rdH5uXVjiC6RchUtkr0euWG3em8naKfF?=
 =?us-ascii?Q?XhjWBSLYbHaoNBunznYDrbB22D4+u1U8UDfc2DB4luNEV+2QumpcurKRaJHN?=
 =?us-ascii?Q?qF7LOKfzwAB7gnm/UNwWnPyYIOilDpKc3K4l7M1enkH/k7Iys2q9VmrxB5uh?=
 =?us-ascii?Q?yrL9MpwKKDqA5excdUchGN77RABXBKsQWVQpNzq3DMPOfnes3Co+KodwjX2S?=
 =?us-ascii?Q?ndrlMlHR860gWaK/SaPJ8HgRUjDy2fD6xnRHECSmZF/n1MDroWIIFfgYTVZk?=
 =?us-ascii?Q?kCIXinDXog3NpT17zO8o4zNxlB9JYuN6gZMLLtI+FLC1f0xTMTBHch4bTnHu?=
 =?us-ascii?Q?UkQBZLbx25cd+dPF8DcLHp8TESOXI629z/MPWCTD30jF9grxKOl08q2t6mCH?=
 =?us-ascii?Q?hzzXOzk/fVT8njyu77Wi2ui5WCZton11a74/ITbsnzLeYc5Yaa9zo99RRxFs?=
 =?us-ascii?Q?SLMwDe/r5gOgJ7RDmh2hm7hYKN67KYOUncoqblkWH9xutjnNt8Gfc+ewRtcA?=
 =?us-ascii?Q?iSg5qgVdxgmjl1iWpoh03OyQpcZRY3tZVGnZpVzbOdFwljMADhCJ/bl7tIiX?=
 =?us-ascii?Q?vaJXSNqdS7p5BpqfzWboUAa5g9IqIGc7bDsrh8NBQf2W9qGSjeVk4cx0iu/r?=
 =?us-ascii?Q?KihmzEpzVwZiPj55vICEaA+k3MCZ+JGVZG3dI4IQiG0U9R4V04fJypMTJq16?=
 =?us-ascii?Q?8izFzBHa7Cl3gie+4A1nAao8i7LIwpRpIikKezy726o0Ay/QkdfIPWtU3W4g?=
 =?us-ascii?Q?zLJpiYL7DwXZoLV/3CFt9FQE9r9VghhEleEhfnIak/C8xZbDjfSoh/9CbqWR?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d943db21-94f1-49fe-088e-08db68ee03d2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 13:32:48.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul5uoVZvLutQX2wJ5muQEXzY9agjWiGNaKDEpghuvjhfIhclIwiU6jBieVSDWw3SZltunxi61WcjpplyFy7PsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923

Hi Paolo,

On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> On Thu, 2023-06-08 at 13:46 +0800, Geliang Tang wrote:
> > This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
> > which is the default scheduler in protocol.c. bpf_burst_get_send() uses
> > the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
> > uses the same logic as mptcp_subflow_get_retrans().
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/bpf/bpf_tcp_helpers.h |   5 +
> >  .../selftests/bpf/progs/mptcp_bpf_burst.c     | 208 ++++++++++++++++++
> >  2 files changed, 213 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > index 44c356772798..927a00f663f2 100644
> > --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > @@ -36,6 +36,7 @@ enum sk_pacing {
> >  struct sock {
> >  	struct sock_common	__sk_common;
> >  #define sk_state		__sk_common.skc_state
> > +	int			sk_wmem_queued;
> >  	unsigned long		sk_pacing_rate;
> >  	__u32			sk_pacing_status; /* see enum sk_pacing */
> >  } __attribute__((preserve_access_index));
> > @@ -234,12 +235,15 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
> >  #define MPTCP_SUBFLOWS_MAX	8
> >  
> >  struct mptcp_subflow_context {
> > +	unsigned long avg_pacing_rate;
> >  	__u32	backup : 1;
> > +	__u8	stale_count;
> >  	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> >  } __attribute__((preserve_access_index));
> >  
> >  struct mptcp_sched_data {
> >  	struct sock	*last_snd;
> > +	int		snd_burst;
> >  	bool		reinject;
> >  	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> >  } __attribute__((preserve_access_index));
> > @@ -260,6 +264,7 @@ struct mptcp_sched_ops {
> >  struct mptcp_sock {
> >  	struct inet_connection_sock	sk;
> >  
> > +	__u64		snd_nxt;
> >  	__u32		token;
> >  	struct sock	*first;
> >  	char		ca_name[TCP_CA_NAME_MAX];
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > new file mode 100644
> > index 000000000000..b860fd517787
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> > @@ -0,0 +1,208 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2023, SUSE. */
> > +
> > +#include <linux/bpf.h>
> > +#include <limits.h>
> > +#include "bpf_tcp_helpers.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +#define MPTCP_SEND_BURST_SIZE	65428
> > +
> > +struct subflow_send_info {
> > +	struct sock *ssk;
> > +	__u64 linger_time;
> > +};
> > +
> > +static struct mptcp_subflow_context *
> > +bpf_mptcp_subflow_ctx(struct sock *ssk, struct mptcp_sched_data *data)
> > +{
> > +	int i, nr = 0;
> > +
> > +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> > +		if (!ssk || !data->contexts[i])
> > +			break;
> > +
> > +		if (mptcp_subflow_tcp_sock(data->contexts[i]) == ssk) {
> > +			nr = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return data->contexts[nr];
> > +}
> > +
> > +static inline __u64 div_u64_rem(__u64 dividend, __u32 divisor, __u32 *remainder)
> > +{
> > +	*remainder = dividend % divisor;
> > +	return dividend / divisor;
> > +}
> > +
> > +static inline __u64 div_u64(__u64 dividend, __u32 divisor)
> > +{
> > +	__u32 remainder;
> > +
> > +	return div_u64_rem(dividend, divisor, &remainder);
> > +}
> > +
> > +extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
> > +extern void mptcp_set_timeout(struct sock *sk) __ksym;
> > +extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
> > +extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
> > +extern bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk) __ksym;
> > +extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
> > +
> > +#define SSK_MODE_ACTIVE	0
> > +#define SSK_MODE_BACKUP	1
> > +#define SSK_MODE_MAX	2
> > +
> > +SEC("struct_ops/mptcp_sched_burst_init")
> > +void BPF_PROG(mptcp_sched_burst_init, const struct mptcp_sock *msk)
> > +{
> > +}
> > +
> > +SEC("struct_ops/mptcp_sched_burst_release")
> > +void BPF_PROG(mptcp_sched_burst_release, const struct mptcp_sock *msk)
> > +{
> > +}
> > +
> > +void BPF_STRUCT_OPS(bpf_burst_data_init, const struct mptcp_sock *msk,
> > +		    struct mptcp_sched_data *data)
> > +{
> > +	mptcp_sched_data_set_contexts(msk, data);
> > +}
> > +
> > +static int bpf_burst_get_send(const struct mptcp_sock *msk,
> > +			      struct mptcp_sched_data *data)
> > +{
> > +	struct subflow_send_info send_info[SSK_MODE_MAX];
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *sk = (struct sock *)msk;
> > +	__u32 pace, burst, wmem;
> > +	int i, nr_active = 0;
> > +	__u64 linger_time;
> > +	struct sock *ssk;
> > +
> > +	/* pick the subflow with the lower wmem/wspace ratio */
> > +	for (i = 0; i < SSK_MODE_MAX; ++i) {
> > +		send_info[i].ssk = NULL;
> > +		send_info[i].linger_time = -1;
> > +	}
> > +
> > +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> > +		if (!data->contexts[i])
> > +			break;
> > +
> > +		subflow = data->contexts[i];
> > +		ssk = mptcp_subflow_tcp_sock(subflow);
> > +		if (!mptcp_subflow_active(subflow))
> > +			continue;
> > +
> > +		nr_active += !subflow->backup;
> > +		pace = subflow->avg_pacing_rate;
> > +		if (!pace) {
> > +			/* init pacing rate from socket */
> > +			subflow->avg_pacing_rate = ssk->sk_pacing_rate;
> > +			pace = subflow->avg_pacing_rate;
> > +			if (!pace)
> > +				continue;
> > +		}
> > +
> > +		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
> > +		if (linger_time < send_info[subflow->backup].linger_time) {
> > +			send_info[subflow->backup].ssk = ssk;
> > +			send_info[subflow->backup].linger_time = linger_time;
> > +		}
> > +	}
> > +	mptcp_set_timeout(sk);
> > +
> > +	/* pick the best backup if no other subflow is active */
> > +	if (!nr_active)
> > +		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
> > +
> > +	/* Get the ssk directly like this "ssk = send_info[SSK_MODE_ACTIVE].ssk;"
> > +	 * will get an error:
> > +	 *   arg#0 pointer type STRUCT sock must point to scalar, or struct with scalar
> > +	 * So here use bpf_mptcp_subflow_ctx() to get the subflow,

This comment needs to be updated:

        /* Pass "send_info[SSK_MODE_ACTIVE].ssk" directly to bpf_sk_stream_memory_free()
         * will get an error:
         *   arg#0 pointer type STRUCT sock must point to scalar, or struct with scalar
         * So here pass it to bpf_mptcp_subflow_ctx() to get the subflow,
         * then use mptcp_subflow_tcp_sock() to get the ssk,
         * and pass the ssk to bpf_sk_stream_memory_free().
         */

> 
> May I guess you get a similar error if you do:
> 
> 	subflow = mptcp_subflow_ctx(ssk)
> 
> ? (just out of sheer ignorance and curiosity)

Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
considered unsafe in BPF context. So here we pass 'send_info[SSK_MODE_ACTIVE].ssk'
into bpf_mptcp_subflow_ctx() to find the related subflow. Then we access this
subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This can make BPF happy.

> 
> > +	 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > +	 */
> > +	subflow = mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE].ssk, data);
> > +	ssk = mptcp_subflow_tcp_sock(subflow);
> 
> What if you store the 'subflow' pointer in 'send_info'? Will the
> verifier splat with that? and what if we store the corresponding
> context index 'i' instead?

Storing the 'subflow' or index 'i' don't work too.

> that we avoid the 'mptcp_subflow_tcp_sock()'
> call entirely.

No need to avoid "mptcp_subflow_tcp_sock", we need to access both
'subflow' and 'ssk' below.

Thanks,
-Geliang

> 
> Please, don't send directly a new version, I think it would be better
> clarify this point before updating the code
> 
> thanks!
> 
> Paolo
> 
