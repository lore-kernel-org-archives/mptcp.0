Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A47EAF1
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 08:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dghe3ZTaoczVjkhUlktAyX4HZiqnMyjhE37mVBxOv8zVLvJ0xJAVD79LCaMI6601E+5OgBtcwcoYkbgLBGWlQEzyvqDLdR8sULeP63GZwfmy+moS1sBjLbgU6kpWW0q7goep/xlvpULbm9yROGuQ4XjuY52lXU8bKqYfchkr54XGteaORAR2qsRx+9ujdNPsdtYFxVDn9lnIbK92ipE3cyXtnpboe6x7E7H8MRtdnen2UKXpF6h48jdkftonVHRpOCtJs+leksSrP1Tv6nU+eRoNK1LQPGXW8TYM1sYftRse8BdxfWEZw+hf4L07/fHchJIOiNZc9QQknI+3tAGCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK9BidGYrpL1XPrG1MeEFdepBuuStgvrOuYIfs4Rqps=;
 b=BJavPiJX7VbVgQfUNCo2lpfFfE2RgYwWpKlV7RZWq5zDesHH2F7r74LMRIF10v8dAcQJaGPgUwrh7yZ5Thm0eJssMBhNT4N1QNtKOmOpjm/bewddD7l1AfrxxIE23ID3MwT9eF/TAYSyczAut+N9XBosIoh/LZ8Z4/yAqGzZ7rWwTGCJzqneWfgxX24eHfjDVgX1oN1H682YU9BSUarI0OqO36hD8DTkghUTOHHoFda2ZGMVYA024eQ5u2uGSKIv/7vwZr92Wb6Zy30D6XHFnAGzND0/shRonWCz+RitoS7rHsho6GUzYpp8tIBCgrc9BpvWqQT9vctiln9E/EAErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK9BidGYrpL1XPrG1MeEFdepBuuStgvrOuYIfs4Rqps=;
 b=v1HFin0Wl20W65Wul4/vWtyjeL7o2ItbAuAE6NuWMkWasYvJ2ffSbA5oNxfEpDJQMv28quBMCQ5Cdk9JIdFM4mbmYLG/tnJcuJ4Jd2HjIycJF1WFzjodZZrEAE3KsESrXbq9H5jKDtLeNVMQ8WfFQpizJog4Du9R0OEY1CCYYZkTBIrEJmNfg0+J+Q5g+LqkE+UQaeO1TT/9QDXm3Lq/vEcWcuJH5rdj00HiFVXtZ4gQV1Jb8cvgrFtKVG5gQo/Bk7uO9OxtDK/2CZxcFCbB/Zf8A1Gen6lH3kYm9HKECM00azUjCO05dPbapNK7Bt2BFMVIHqytNtsIhNiH5UreRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 08:32:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 08:32:49 +0000
Date: Fri, 18 Aug 2023 16:33:15 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Message-ID: <20230818083315.GA20788@bogon>
References: <ee69d8a0379e89d8b194d753129d09d986f7e674.1692247869.git.geliang.tang@suse.com>
 <f71d2015-aa11-473d-ae85-43e760770298@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71d2015-aa11-473d-ae85-43e760770298@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0336.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: cba0061b-6baa-4820-4be5-08db9fc5b4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bob5HoTBm8qLxFqgHwDs3pxhN1e+f8rzEbQe3Zq/xM3DBq2h1vAv/oB3+t0ufSsDVitBkIPeRLA7ZQwgP3OAeOOwNal2T5aFQBHr+BKRz1cLLLkwzJHB8VMkojwkMjgrXpfD6+M0cJIlLHi+xhxC00M59Hu8NFx2q1BBPzMPgMbbZhXE/niPtCNFhWYbexcVNP6GiOnyv8g4TWJ+osugLrLjU7KxG24g25+L0td7+jVt+9w/MOXzIhdZRl4CMgwwoUWWGkOaeUv9XwMcY4w1QK+J2EMDwAlvjKGk2pWd5OmLMwMiDQMKNWckogpyF0xPmoNyGk5C1sodhyg25az7pFr5v0a8aWGIFTR6ZEiQKEOKbvXAWPe9o4tsNtcsNuAz+fxLXAFoSlPH7SBahXG57STCuwU9ozPAihOClChdFeusRDX9t5ZRekDpFRveLImONhptfoLQq+rXly8Pk9qUIPfRRi4l2heVJaYeHqf5MDenQpr/ZIVdp8XQ6YYaNUdYtXWaaV2eeEqywTLCQGfBwsXFlQP6teaoBiqaFy1mchZhor0MHlp/6bkJnNzoxROjaq4tysNBPon9pPHygCzaV4VDcA2oCdo1mKKO9r0PeBovQTE13+6ShvmrsZCiIgaf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(6486002)(1076003)(6512007)(33656002)(9686003)(53546011)(15974865002)(966005)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(33716001)(38100700002)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oG8mpg/Xvsa8Ax1WY3AKAoqpmG+JrmQlRjPNzLk+Ki0VzLpevFuI+/GDTcjo?=
 =?us-ascii?Q?XlggwzgZZklNr78Nt7oDWD47yA8M7TONVV5lluKlXooO9lBFcu2AGa+O1zmU?=
 =?us-ascii?Q?m3aKYWWzQM15x5nwSNaegMk+sf8RHoaPFb092WEB1ZWXn4LLY3gOu2I1vZq1?=
 =?us-ascii?Q?N8aR+70p6hvtwnVt/hG1XqlMeMt+vs8tcF7i03F2nhFGsoutf58vptJsSZrR?=
 =?us-ascii?Q?XCd/MsrWZKdaAj/2ikxI63yZ3pUwr42fGeH2sHg5o83e6z3doQ/lUpsuVGIR?=
 =?us-ascii?Q?YTeUpJI499bgTSAWLc446IdP0RDnbkVlzw2Vj/L5fdSUTqG7nWxsd4x7HfJ4?=
 =?us-ascii?Q?wLbe3Rogfg08J2ubTtRvK1wz/ISNWL6OWYBrQ8QEC624evS/ZiYn2VSCY1nz?=
 =?us-ascii?Q?3SI9YP+ExNSpL3ULfoFJ8BumKbMx5wrrQpfLljcqyh6G3AnPEKLl0A+t7WJk?=
 =?us-ascii?Q?C702jOr+EK5lS4bhFiXyhzcSUpLxJ1BhogIG0X3OJyWzCI0JD6DjnfFQFWxc?=
 =?us-ascii?Q?2swfXc8JnIfrB/9gpe0V+ke/8nr1Kk/l5ebM6XKPqfEgvBGmen2dmr+CD9CH?=
 =?us-ascii?Q?teUbJf6v8lGd6T/1DbuuxMsfLN3pOgAbo/V4dmFUfpZgxJk1GFfYbkBFD3nK?=
 =?us-ascii?Q?Vi15vlXsJ/ixeUbZZLoEVW1JeKHH20bEwgrDHtzllxEcQvnGPrpMZdxe3jEo?=
 =?us-ascii?Q?idoEBOUP3PR6D+0ys1lV7NSW0ojEk7bMiMMxS4rfcCp9azGRhQrvYrd2WQMD?=
 =?us-ascii?Q?VX3YFScKt3R8o+CUaKInX69qa6XrpNzHqPW7fw/DTDmqcgUysBRnnqn+L07K?=
 =?us-ascii?Q?3iMfIMjMwE83LVpAiF14LXwhrK4GypHUcgkx7El/5RM5MVFPD3lG2ovMluYj?=
 =?us-ascii?Q?Hob4Ll2oCImsDAJCLCEBbKnDNTAPFKy1bw4yOTd62fc2yOxEu0mlBUf5EJtC?=
 =?us-ascii?Q?rXOqNorhzYul1sMEKub/JgtaPdQ3kmbGvJjvwl4i1IPcoetZw6pGMUVwuxeV?=
 =?us-ascii?Q?+BUkYZxsSffbirHYWA8+BPVrW6bYbwRMa0J6B3Qns08g2dn8gs+39vnDsF1a?=
 =?us-ascii?Q?mYSNpyNh0QOJo0EbIOL8onW2CNss0QR60ZHJYD8y6UkyYD24tCLk7OMLSnhs?=
 =?us-ascii?Q?DOzokzLYK+vsmLaohGOt98NzRAkKTqx9qsKvyVJqPPUUjxNQNK3ZPnYuPMgR?=
 =?us-ascii?Q?quUeZh9IfRjHlbSOU0pgSvOT0TnAapI0YtMz/fq/3saYZ4ZU6DQTrgV1HbsG?=
 =?us-ascii?Q?CdEz07nvlJaSjvttfTFVuvAQXA0WQvL5ib9wpGgrOp4RBSR0WGzW01YqQ8Z8?=
 =?us-ascii?Q?6QsWWHfuXh/XTLUUYluq8zqb4wVWPzJQe+nAmaDNGn8xmZAznBijy3rmJvcl?=
 =?us-ascii?Q?AqeDl9vWcj8Z/glz9sJXCBUScczMXEYoyqmaK6/orDa94uoBOhw91XmGX4aY?=
 =?us-ascii?Q?KZpRapsjMv+6s4kbui38nHQmGjMG7tNasRANsTDcJV73uADJS5yFNL2hvH9l?=
 =?us-ascii?Q?SYEDwym5xK5pHIl9ukQnQ19sf06x/dGx/52BsS7AjY1JinnH83oKWFIAI5J7?=
 =?us-ascii?Q?aIsewprDtEdCzxLc+fNIfLw1zXCnYLzo7967DdAv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba0061b-6baa-4820-4be5-08db9fc5b4ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:32:49.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D5+ciMvjEUxov3HrJHbCbYWpOiwPKbuYZfdyIHrSeKHp3DYtfByfBHJyxY091asVm2mVH0ouHOxEOFW07Tm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

On Thu, Aug 17, 2023 at 10:58:13AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (I also have a question for you at the end)
> 
> On 17/08/2023 06:51, Geliang Tang wrote:
> > The commit "bpf: Add update_socket_protocol hook" on bpf-next tree will
> > conflict with the commit "bpf: Add bpf_mptcp_sched_kfunc_set". This
> > patch fixes it.
> 
> Thank you for the follow up!
> 
> > Please update the commit log:
> > 
> > '''
> > This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
> > mptcp_subflow_set_scheduled() and mptcp_sched_data_set_contexts() helpers
> > into this id_set, and register it in bpf_mptcp_kfunc_init() to make sure
> > these helpers can be accessed from the BPF context.
> > '''
> 
> Done!
> 
> I hope everything has been applied correctly.
> 
> New patches for t/upstream:
> - 134c0805ac94: "squashed" in "bpf: Add bpf_mptcp_sched_kfunc_set"
> - de64a137c29f: tg:msg: update after the recent squash-to patch
> - 0642c8af7143: conflict in t/bpf-Export-more-bpf_burst-related-functions
> - Results: 88082befad3d..f28cd69d6233 (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230817T085246
> 
> (...)
> 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 4911293919c2..92cf6fbf8275 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -144,24 +144,6 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> >  	.init		= bpf_mptcp_sched_init,
> >  	.name		= "mptcp_sched_ops",
> >  };
> > -
> > -BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
> > -BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> > -BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
> > -BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
> > -BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
> > -
> > -static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> > -	.owner	= THIS_MODULE,
> > -	.set	= &bpf_mptcp_sched_kfunc_ids,
> > -};
> > -
> > -static int __init bpf_mptcp_kfunc_init(void)
> > -{
> > -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > -					 &bpf_mptcp_sched_kfunc_set);
> > -}
> > -late_initcall(bpf_mptcp_kfunc_init);
> >  #endif /* CONFIG_BPF_JIT */
> 
> Do we not need to move this somewhere else?

We should keep this "CONFIG_BPF_JIT" here. I tried to move it at the end
of this file, but BPF maintainer suggested me not to use "if CONFIG_BPF_JIT"
to include bpf_mptcp_kfunc_init. [1]

[1]
https://patchwork.kernel.org/project/mptcp/patch/fc284a49832630e4b908f11c7e07a8066b7bd789.1691069778.git.geliang.tang@suse.com/

Thanks,
-Geliang

> >  
> >  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> > @@ -181,8 +163,23 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> >  	.set   = &bpf_mptcp_fmodret_ids,
> >  };
> >  
> > +BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
> > +BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> > +BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
> > +BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
> > +BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
> > +
> > +static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> > +	.owner	= THIS_MODULE,
> > +	.set	= &bpf_mptcp_sched_kfunc_ids,
> > +};
> > +
> >  static int __init bpf_mptcp_kfunc_init(void)
> >  {
> > -	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > +	int ret;
> > +
> > +	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > +						&bpf_mptcp_sched_kfunc_set);
> >  }
> >  late_initcall(bpf_mptcp_kfunc_init);
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
