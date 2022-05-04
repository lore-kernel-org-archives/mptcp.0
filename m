Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8192566
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651666476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFuFHFPzylOiZaDRAN8WQqyGi2ccF9bt5kXVQ6sqknU=;
	b=N+CgVodFZ9NIfwsxH4co/XPS2yI75JR0pD1NNPPMRp8sneLVHVrDYKvp8V3fI7fI77fmft
	1gEY6/ak6P1Vo+zqhD6ajrukEIjAhGEHW2AfT/HV0SXXO+7S8kNlmbsUWMR8mqwpy0NLri
	nxDu7k3FVwxkjJ+MJ0mg9zK+i6sn6ww=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-l6qOyomkPXyB96DNPUeAWw-1; Wed, 04 May 2022 14:14:34 +0200
X-MC-Unique: l6qOyomkPXyB96DNPUeAWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrwulznSrXPIYR+2xtCBF892h2bbzS5nd+0dIsloxbhsaH3t+9FKHD465exm7Z6MWkXejyfhfHGwyJzvkMEa0T3HqRf45r5qSUDmzqLDqZrvCbmv5pIOKvtICS2GRq1+KUDYUTPJOgFKqR5uvGpsbIxeraHlTHJOnLRdKPqzuY5cFKyPtaXDJiBWVktKUR+OcS5CUsHbybMN2oTrLslufgOxFufDkx+yROcCtq0sZqrc2IG+AIoKzveXUuqJFGCbPuvfq7+p5Nff1QAwfDU0t7gDkmMhLNTlA/cyXh6I1zHtSizU3QQjneZDe01zku2S2H+qZnIATetCv1/M8dtWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFuFHFPzylOiZaDRAN8WQqyGi2ccF9bt5kXVQ6sqknU=;
 b=fZ8tyNaD7k7z9uHQHZA9w08yuzyoK/bTz/J+GLif7+m16JQCuQyGNvHEtqBjUzB/3eF4stTxu5o3FhcbcD13JjpkSL5SaPvz2Z3FNSGPRV978lEw1wiS3C9kTtXMF8bd9ys/8a0MMd0sQDPUc+tRCP6tc6blKoOkRrOUVe/XbJg1nW/sFiwdklY55O6ojaDqIg6oSBYejSeIc7mpoZg4dxCaZdv/D6mX1oxrBRqgd3R4sjgGH/GYogS+9sa1XNNWBwcSfeTZE3IyihmJSzovs8u7Ba6x4H6zTNdZnwFQAHx1So4nVDSRlWMZ5nPDw5syR3d9en5hMSjHwqi6NNof/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9107.eurprd04.prod.outlook.com (2603:10a6:102:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 12:14:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 12:14:33 +0000
Date: Wed, 4 May 2022 20:14:29 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL
 reset testcase" - cleanups
Message-ID: <20220504121429.GA18870@bogon.HOST>
References: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64659878-eea3-4d02-e433-08da2dc7a5e6
X-MS-TrafficTypeDiagnostic: PAXPR04MB9107:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9107BD01DBB2059807D0617DF8C39@PAXPR04MB9107.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mzibCaZVh4b3aEK7xd+M9IOJC5n9bbgxAoztrHuETp1QLinrmKmSBJwuiLruYE2vran0Hi+Z8r29/Ju/0xvJKpbIE+CI6jW5Kx6HQaIKJYSfghZCVh/AeutYqfEa3ObpllDzeTMcJVLLQryHsPcTMFKI0H2HyDzRl4Pdf83cgb7PZ5B487TXs+I1fVECYCP+XlWQqw4hfQyzfcJAopgtsqB1A4c0/raG4hqeLT/cISndpSWCnL2WTyl8TzRN7DKimPYLpY/SYduoiy8lAieeWIclAUGOXxLfbQ/reG8VuPfv7jYuopYC5pJ0bharB2lZECozOdSwEWGQYUmYgEptwMFG9A5I4FrRMyyw3orEnDmvwJrP2oDJ/INsmaBiXOR7zqPSBct1a6bqZSNdlQspwG/uBZcjIe7U9HN9U6juK7on9lfdKhvUaVbX8UV9Q0DHzd0SrlR0c1M54aLgv++mK69O6j+VjMqshe2vaxGm+5jm252AsexeDNb6WQ0xrRCpd8H7y+jB/5DWfRqhdTf3UYHrl8DyspNmg8PKphc3v6aUEeHXBcJ3YNk1VGd8DLyurl5M1ssUmSWODiXYbe2i62dEUpC36Lp8jUAn5az/Yvy3Pr7NYrDwJmD+6n2wWys/duiRJ52cqEl8x3tnbNsWE8KQbJwzlqMIX9CPXeSGyJeTxCafyJDUJ5n3VyatKpqe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(1076003)(2906002)(508600001)(6506007)(66476007)(8676002)(6486002)(6666004)(66556008)(66946007)(33656002)(9686003)(6512007)(8936002)(44832011)(36756003)(5660300002)(86362001)(83380400001)(38100700002)(316002)(6916009)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COkQ6z5kfJpCNFin4C8ESM2pH8HJGchOIIHHkVZP+b3y9/6xzQCW2i1Z/BEb?=
 =?us-ascii?Q?cESYuya6rJ3EVUpgHUPCJSykRt5MQFizXLINQfCKE5kI47y/BELEmSUZdpY2?=
 =?us-ascii?Q?1HQrCg5QKzxlqIDTVrdwYEnXyjiKtMmeAiczU2crSb1W087nu0ndN0haWBDk?=
 =?us-ascii?Q?ohHAzHeArOFpyIxq8lwE3gDbZloC2Kw1ladTxoYBVOOM1KKQCiK7FQafysLd?=
 =?us-ascii?Q?Z6YrrEP3jciAUoWfQeriwrtKVMNa/aOhCaUzhctFfuJVJKGJs4HU7OXNrutB?=
 =?us-ascii?Q?aJgSTY/Lq8ZFU8Q5YL/1twrQIGuKZrFJDPsyOhRxy0OwzycZJlF4wOLHciyD?=
 =?us-ascii?Q?GIwoGI03cbIuqZcNYo/JdhgcmVQ/lxOeyGOcp3qiaE7CNwygiIHj12+Uxe1q?=
 =?us-ascii?Q?9FPL38Jj6jFOoK/7gOqr5gliElxnjyem5F1UWqJkKow9uzoF5bd1qlzIS5+w?=
 =?us-ascii?Q?fayNjOkF9rIQxsCzC9Mu1zMvmf1kGpdM+c3V+Bk2fcHIb6Mz7EBbEn9kcMqS?=
 =?us-ascii?Q?HLo5S3xa1mt1KA0OO4NiXWTANlN4xpzIkNCiuM0Zzai/ZyURxOGuwKE7Anmr?=
 =?us-ascii?Q?ynv9i7jUTOV6dw2mfs+8GN2xsFr5x5lkYDc+raP6hWMajkqKFcSfI0qdsxLf?=
 =?us-ascii?Q?k4BPZhHUNOzORsDEIorhxI3+oP5L4KLw3tO+u5oyKcbyY7sCd1kZ3Fu0Lj3h?=
 =?us-ascii?Q?DryuDdcurlXm2ZoI+xHa8/B3Q255iEt2YM3m4UFKknZ1ZwrCa93tVwk6ozuS?=
 =?us-ascii?Q?QyR+Ez/vnR32hFlZ/HO0jhAyFYimvIvUkXfE15CXwnj12hU97YiC636q3uoN?=
 =?us-ascii?Q?BnXJ79+jJyo/n+el+2Iw3pT0AXtbrVuoMOsXGHjby+I4fmVoxfUdPSMvTZuv?=
 =?us-ascii?Q?KMvg6+CkTZEyGIKWPWRv9ZGIMsl5IalGVJIoYFL4kkuz5JgApR2yQQXPf0BY?=
 =?us-ascii?Q?xgIUAE4LqjRiwnpcoBZ5mfQlGCGvuW/fe3uc7CJhWen79ocFRbY2dWhbTy2I?=
 =?us-ascii?Q?bHzYGI0iUTtodWCnTg7t+BfPAijU9o1QQYQ/qpSV4/b9CibDipRHYydta1W+?=
 =?us-ascii?Q?MiVP6QB2PCQMLJ+QpKHWWCnGW4ItwbtYd9ekEI048jayRwAWDwHFFcAVF33x?=
 =?us-ascii?Q?qHMDcTLnO4qxZTkr0aXsG2f4Ro+dWzEy7IaymItQ9fYR96fVs8rWzqDomvze?=
 =?us-ascii?Q?54HavzTl7W/E6ThwaJdI4cAlv6Rd83/gLHaYrbpQfwdZq7EKEHwnfv8UoG5z?=
 =?us-ascii?Q?9T/fzXR/3i9/mJcQDzX9sTzMUlSLWoEyYwjMuBWeuR26qJr+Tv5JKZm12fKd?=
 =?us-ascii?Q?Hb3XepJNYKzciDaFK1xUJKqhTmfhPoEFcBQ5ENTtK0Ze2dNA7GzAT1wQ/IkA?=
 =?us-ascii?Q?CRjmbSs9XeVZfBW6Bxi6UCBs3c9KLI44fty6HyVTGYJq2rYNgKq3mDtTmYME?=
 =?us-ascii?Q?b9iEqX1E+S56f7pZ0THC4XDOyHXBnqGl4WrHsG2pFmojayHE6FM7VQlWaoDr?=
 =?us-ascii?Q?2rcH9zrSOjmE/DGs9L+9fLm6+9rUVkazB2YQZ34dgOfiui9fpCmk9SZQ4Uh4?=
 =?us-ascii?Q?Qd2m5VrUUkS5C6uA7M4TYnv1xyHSlAh0Qkqm3BSy9k8YnvHbMvwBnpWsrvss?=
 =?us-ascii?Q?lPvrOec/31EafqjZec4Bvn6TpWED+AerdvmzglEb1Hw1YPVlYbL+GHJgMqT5?=
 =?us-ascii?Q?w+7TI6W9AV2P27gy93CNF+ygcpmAb8zaECuQFJ4N/8Tlxsdh/38OSq97Jrxg?=
 =?us-ascii?Q?RdDj3rvwLHw7TFT2/t9dxSjEEG7Fgr0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64659878-eea3-4d02-e433-08da2dc7a5e6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 12:14:33.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDB2GxYH8Fh+tZWIuYQlK6TPpyCYM4blKKrm6Y5tVxc+ilvN4mqDQ4WjZwIGzI0YEzYBYlyv96RjK/qD+TDEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9107

On Wed, May 04, 2022 at 07:44:24PM +0800, Geliang Tang wrote:
> Two small cleanups for MP_FAIL reset test case:
> 
> Reduce the test files size from 1024 to 128, to make the test faster.

The original commit log needs to update too:

 1024KB -> 128KB

'''
Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
reset case. Use the test_linkfail value to make 128KB test files.

...
...
'''

> With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slow.
> 
> Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
> extra checksum failures now, no need to add '+'s anymore.
> 
> Depends on Paolo's commits:
> [1] net/sched: act_pedit: really ensure the skb is writable
> [2] selftests: mptcp: fix MP_FAIL test-case
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a5e90532eaea..91c840ec91c8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2739,8 +2739,8 @@ fail_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 1024
> -		chk_join_nr 1 1 1 +1 +0 1 1 0 "$(pedit_action_pkts)"
> +		run_tests $ns1 $ns2 10.0.1.1 128
> +		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
>  	fi
>  }
>  
> -- 
> 2.34.1
> 

