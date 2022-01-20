Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB42CA7
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642674053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dpa3yA/wTtGL8AHl7XvFKfcKrJVdIjmrVlDhA0JkwD4=;
	b=klUij49j6SXaMRWrrdLE9F8wkbkNSW6GxnBDEICVrwAvmRj1U94S5yW4VYV+ssfpnFXfZa
	XMtO/i8KgEfGxBGEDGrlFlM4U1hKIdPgoVa+AnImneTBSAewA1AeefsjFSc7/n2d6tVclO
	7oxcbblW0c6mQ8CXPS4/App4ELU9g8c=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-nNzi4tlxMH2jpjbYrhHsvA-1; Thu, 20 Jan 2022 11:20:52 +0100
X-MC-Unique: nNzi4tlxMH2jpjbYrhHsvA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYAowGDsooYLrdQ4qZrC7fZNyEsEZ3BzD2uk8i4j6ezwXDAICO02O1Nhzlxs1pG4qNpN8M9O9hQtOyU14giD+GQSwD6WlbAhOs7IMSnTWqkr3qH/dY1Bn0s0Fne2ojzfZLb74J3qsF2iUCbxCekN2dTpnGYDQ3QImtAU58zsnKyyqpVOROxgNqJ+txodLfpq5XZHmEkTuzZ3885HNt1qklOLF/LuHkGn/FXZ8KW5LA8p7Ty1uZx32/NtkQp9xcZQUIED4Y/UDTM9O1cLQNfGTxM74ckNogb6/P55g6eCypo978Tx6cb/uZ+iERp7NpT/SwEsXqBNesjNkWuQ3ISBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dpa3yA/wTtGL8AHl7XvFKfcKrJVdIjmrVlDhA0JkwD4=;
 b=lVBgPNwu7txmuGdM3H7QJpGy66+anwLTcgnAqqW5/530PyJ3yX9Aj8E9sYXDHLEAwL6XUn3MDcABfqn6SaYn7Ytt9E955eeyyQUOSFRuMiJIIMiB9dgn0F+7xB9J+VC2QoiyIRFIoO+gJWhYQk9UcmHbmLW1x4erMUYuE4WLqvBisJTuKFXqCNlPlWO+BFXSgoyQZHjJEFinAnenPFBSUVzo794Zm2G29VL7ReC7m+4L5pyLdiomiUgvraWF4YISIYe5RuBaJL5CoHn4B7+ec2hklQek7T7dNjpesWNh5M9HsT1TMWeCPYtO1ftlFzxZDVjhpsSOMwmfw4H/Th06yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 10:20:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 10:20:50 +0000
Date: Thu, 20 Jan 2022 18:20:56 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 00/10] set flags and selftests
Message-ID: <20220120102056.GA2930@bogon>
References: <cover.1642320655.git.geliang.tang@suse.com>
 <c135c322-e71f-f525-ba83-ea53691e65f@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c135c322-e71f-f525-ba83-ea53691e65f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff24837-bc78-4116-bf60-08d9dbfe87ce
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3275D11DFDBC59BB57D275D7F85A9@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nNYf2ALVdDhDPgnh9qCZA6SwisG9+WFjWwgZVNpYB1fIyUEAUQ5IFwInmBAZ7y9CxNQKVx5rsSKyFAzcHm6nqH8Bc4FhSTb73uHOF7S2ANf8cbk0vogFfMVhJXDYHcIiQ6W6I3U6vwTYLC+IV9YdHsPRoSueGI/+89NrMZljd2UPZUmT9b0h62twZK4OFX9ck+j2G00oFCZ58y+sH/Za7K3T6YBSn4H6Tx5NWDp5+0s1bdQkGAJxIShqHfFxBT64aHtjKr2oSvFs2Z8/1XRDxrH7GTJfzb/r42E/lCwSVmC+Hsu4mQZlOuq/Vjoj6UKvSAKt7d9vVs/347/6TrWspEWbmE6x5r671wdAEAHu7qRIKISH6JhvT8yJG5vcShWCuhfnLNsbAm6wMq0Kmx2qRqrnbeK12qsg7RYBst2pFOySyXLGfyPX2ee3z5uIbQE5/9bpb6hBGhhP2aRYmW3qA03WZyOOLLnff5KA1wpcaJGsjmhrhmneLjce4wjidWjDoLuqFNgW7I2soRjPPHWC0pla94kvj5RB16WGKI7tM/OAKpOP3C3B02qt3wza+h8C7xZtFSVnwccMhsp3HjyiYlbhI+3yTuC3o5tMHHlZIw8PbP4iCeCB3b8r3aYS4AdJj+ghu0rOFLAM8B9aDTyYoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(2906002)(6916009)(44832011)(33656002)(8676002)(316002)(66476007)(6486002)(33716001)(1076003)(508600001)(6506007)(186003)(5660300002)(4326008)(86362001)(9686003)(6512007)(66946007)(8936002)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IaB0FNqCCN4IMi2V0Itv7jc9gc1M3lY7ZKqQBpV+w07M/dv7thKsi7AMLa7l?=
 =?us-ascii?Q?nNoky4egzNashwrB171OBzyg2nVm5q60BvnbnBOslXdpn7iZtihfccBYP11H?=
 =?us-ascii?Q?tvv2MLzgzS8BeGP3tUqw66LUHNUwKgMicyNqd7R6QE1HhMz8lrFx3b7nxcpr?=
 =?us-ascii?Q?tmjVCmzR4HMEchB4CjY3QQWNf4GMtb9KCwG0lyfFsI52Zl8zd/m5iNCbifFU?=
 =?us-ascii?Q?3x/044sK+MvRobnRcYmM2eDmoNeZw2Y5vX0ZBz9WIi4lW8kGsDgq7sli3ycs?=
 =?us-ascii?Q?SEZlFUKw+fbCzsAjL40zKXZM/2B5Y+M6bJRWGMb8CQrOznfT5Dk6RiHX7zFV?=
 =?us-ascii?Q?tGRhIjD7Cpwjt7iVDdiZJb0fFrLp1fi5KAy7grKVaWPQ+R1InKeORlEHcpms?=
 =?us-ascii?Q?Fga36AevPCKxqoksocArhAvVlapPTM+YYgkKD9DpAPsCy0x45cpENDdr7tSo?=
 =?us-ascii?Q?/eqmc2GMd66pbsqyfRgMS/SCP+5VI2fOy6l0Um/n8Toj+eei8UR5/bhGtqEQ?=
 =?us-ascii?Q?J1dHe874qKqtn7y4/bbiVPCDct4bAGFi8Vtag5q/zA22svXHuft8Qj81Jws8?=
 =?us-ascii?Q?oMpN8tT5WHSUGN4ndCDP6TSHmu0VkYTZ82zRP3i8/YoJpmHuyYLad3A5BHvc?=
 =?us-ascii?Q?cgfTRHkY/zWL44Pr4vx4JWPqzeUq51jTSBoswzsFymlZKy49CiIUuVsObpNb?=
 =?us-ascii?Q?OjzFui1s+Cqe+6kfGsfEv4Z34gfutLo8jN2zF+jGQEZ4633iISrNScmtyTk0?=
 =?us-ascii?Q?bs77RubkeWzHnr6lbpsr37aw4LgwWqefiu9O6Kj2+ETzLVdVcTTrNYVLKRBa?=
 =?us-ascii?Q?a3y8skNsLMYYzr0vcagVSwpvnw4a5EKqiee/OObh1jRRnKFqvCEn1pCcxn2M?=
 =?us-ascii?Q?SWCkvQydKMKDa6W4oKNXSYxJAmcr9QIeHhkRO8UO8vxjuQYYqd75C+TtZc8e?=
 =?us-ascii?Q?2ICoug6FwBgOkOVr+3AtxSLSJV8fTsdt0EHhs1vMMXUZ9IpkJOVfzkufT8AU?=
 =?us-ascii?Q?QTveeSji7S6lqeNhejQStOESLDRq6NsFVkVb4qYjHj9CUAvAN/luZYjKe5RJ?=
 =?us-ascii?Q?Dn+stigyv2Y9i8v1Ct080gsqme7KOfiuWjRIhOoXG20Ft+T2SzQxMcTkXTuA?=
 =?us-ascii?Q?QqCarPQemnT13/gCmRv7AS5smmbAOPT2WLCNLHpMfhkFDUMnMbPZN5qWpl/D?=
 =?us-ascii?Q?ZAvrJevd6Mf+GGah4YwJm2e/cyZ9WjuU5CpxtQWTc4yVmlGNcQavuFO+T8Nw?=
 =?us-ascii?Q?NoA0+ymZ2HmGoPIE6FVah9xuv6L69D17oFWnLWW+bU0Z8xQYwYe1Ljc3/jG9?=
 =?us-ascii?Q?IZsgatWJqCRdxUWK+PB/MrNGjJQLvjiNM/BuD93u5h0fM1LEf17UJE2HjrDg?=
 =?us-ascii?Q?391BD2PF+uUY2QauwJuo9tz6UAkWJFcG95bgis5oQ7vygdMf9My7tJWD8rKN?=
 =?us-ascii?Q?UuGocQEnx7BIZCphH9nGQeryCIhGaN8DH12ClkLc8+cC3qiEU0SHneNd0PrV?=
 =?us-ascii?Q?5BFWAxFnO017iqXgCqPwP6BBoLlI8CqaPvAMcCSGZGchrSujweR3jzZKvD4J?=
 =?us-ascii?Q?o3g2nLEdLktEpiyd3YgIYpiFdpNqmr136NRVQMqYAxVNK9i9M7WReCq42LKs?=
 =?us-ascii?Q?lTeqnPf1f254xi3a2z8Rr2B6iKOtcRIUZYaVFj8zuTBhILuYTPxU8TxIWdbI?=
 =?us-ascii?Q?PKn9XfT9+b0j4hKGk18vEG41z2Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff24837-bc78-4116-bf60-08d9dbfe87ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 10:20:50.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQYvTeXH/DekGCYdW4E4bfzU3/P9VNXam+OzKuR2XQiSkWPJS797gNooJzvsgLApwnD+smoc9oErHj5v/PjHwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275

On Wed, Jan 19, 2022 at 05:01:53PM -0800, Mat Martineau wrote:
> On Sun, 16 Jan 2022, Geliang Tang wrote:
> 
> > v2:
> > - use a mask of changed flags as Mat suggested.
> > - squash patch 8 and patch 9 in v1 into one.
> > 
> 
> v2 looks ready for the export branch, thanks Geliang.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Please add Paolo's Acked-by tag for the first three patches.

Thanks,
-Geliang

> 
> 
> > Geliang Tang (10):
> >  mptcp: set fullmesh flag in pm_netlink
> >  selftests: mptcp: set fullmesh flag in pm_nl_ctl
> >  selftests: mptcp: add fullmesh setting tests
> >  mptcp: allow to use port and non-signal in set_flags
> >  selftests: mptcp: add the port argument for set_flags
> >  selftests: mptcp: add backup with port testcase
> >  selftests: mptcp: add ip mptcp wrappers
> >  selftests: mptcp: add wrapper for showing addrs
> >  selftests: mptcp: add wrapper for setting flags
> >  selftests: mptcp: set ip_mptcp in command line
> > 
> > net/mptcp/pm_netlink.c                        |  50 +-
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 936 +++++++++++-------
> > tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  19 +-
> > 3 files changed, 616 insertions(+), 389 deletions(-)
> > 
> 
> --
> Mat Martineau
> Intel
> 

