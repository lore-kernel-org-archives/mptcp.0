Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993527B
	for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 03:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2MqrXYoAuJPY1mplUR/98XEwSG0voYjd2sW1i+NCnUHM0exdXp/wtEHy6r8W72mP2FQRJcoI3Ii3J6dto2muIgMCsA8l8FooMbc5V4SxPnFvDFFUrMbp6B2vY4VEKhlc1uqE7QSdP6hkeQluCsulaE/AznoV3Nn6RBpKXcD8C/UpzHyC5qI7dtwmo/wMWaMoyyyYwA4+Ubc3/JiTm5VLiXFzKRoHDeK6GeEoCZo/F4DubjVgDOVyXnRUdLAszp+G48KfP9y+Lx2ygHEVlauunslDF3E2SJVedgmsBx2CmVs2SwKSA4M4HaYwhmR60K06mDxi9e01SP9vc4JOhYH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=798bQ/Si6EFd2sPtTfPy/V9wow1XUHUs425Ysa0yP20=;
 b=OilRe3m1nW7Vq9tPi6q1DwmqSlv6m4lq8qBCGJlQZbPmfzJMJ3oNINjk17A02mrdumdvyb6uyYrOB4KPh/04HaWps1o+oKkYu8ZyGEu+9IcUbBLLhqkLTABZsSBPLNbGHx/BEeQqQP58ICXT+Z2cF4TBIkMoOicw/HGQju7/wTr3TLpc/99VmqW/i5krdHb66QwwYY2rL5qxxtawkqd+7q240LAeEl0YZ3Fd8NbGCQii9BN12iIMgvZkxw2ufXlASDa/32YVWFvTQIxzKOvSa5ynq76SlHdiUe3arq+EM/rtl5exWiF4apszcDMJKKmIol3pikIkTc7FYqbdQfaWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=798bQ/Si6EFd2sPtTfPy/V9wow1XUHUs425Ysa0yP20=;
 b=oNqa9IKwrkMTtbaP2FcBRVxb09v+1nTql4uLYxJHYFMEKV0/aKPcD81g6L54EIC4er5YyXXtzcC43Z2Ivijqp4TtEIRBzVR07GSbOt4iEU67+xgCRS0rX+SDpo3APt3xU0PUtEc6m09NrDJg+qgn8XvPYe4GLampiP9zu3/XflUpIH8Q+PyFbsjvZZvyGVe1b70giyhGvJ+9N6XqYShbDZW6oRGkBxGqYebCETuBeg5UG44jRt4LPosbUDfC3/VP36/NJbAZI3DZYvKydADuwQX1o/I3V/NPyYjSHl/YDp+k1dyOi5u9VnNuc/RmruH+WAYqoNW2TzJ2lulvDwvafA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 03:00:28 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 03:00:28 +0000
Date: Thu, 20 Oct 2022 11:00:23 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 6/7] selftests/bpf: Add bpf_red scheduler
Message-ID: <20221020030022.GA31465@localhost>
References: <cover.1666185947.git.geliang.tang@suse.com>
 <fa8fa105a91e17b619cafba6b570e2b5b1c42e84.1666185947.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8fa105a91e17b619cafba6b570e2b5b1c42e84.1666185947.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:405:3::33) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM0PR04MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5477f75f-f46d-4b8a-fb60-08dab2473df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vear7c3nm6vjXygaPyFDv8xrUwkb2TQ1ZPrdybPodpoju+HZ9ZyITHX+yCkjwgaop9oZjCCbmZwi8gFNpwSwSGvrJzhqMI4enNOd8b533Zx0GiRplMdxGhIsWadQwaESWdWS2D+Ah4xrZKAwGIDs5wpG2MmjlPoOG3jtICXlU6v23A9kEv6UCH61Fwgm+J42KFamMsv9vJ5Idz2Rmz4OvVE9MqsA3k0/txPQOZaqViju4ROikVFd4a6K171Oq1zapb2e2hCEO3mrYYcLBWmPnLViKBn4+NXIYGIvaCxAdDG2B53RUYliAosQW0dGxwH1XhWDy6AjQ35ItILIqY3c5evWbp2pSfCXTmWOptqSzDeAS9RGysq6WQS+8O54h/mWbTF7Xg9qWK0YciW/Cfkjo96cHlveegOq+Btpnq2nRLc1sTtSFzw31Li2NrIemvxIhYEnAQn1cg37jWwM7piwbTzbEcNEDNN9gOExzNauR/ZouUFLjqF8MBBhHCDBdXs7ztAGstYXlGYf7gFHmuXRVvuMgKtcbf8G0HUWtcJvEe8KTQ+tYTak9PW+MaSlTmhbCM6dhsGVIDOuAXUbOi3JsWOvwQqtfRTJTpddd4ISnBAIX7J6Hr3qZGGJrSvU85jFF15FkigCx2ECRnp+7pfaLKh5fSnCcGa0baDIIO5KowaJnycg3NaNEwCIIbVYsngEII/AyZJ0Ptw6lITpeXKK+teo0E7mv5CQc7LeG/YUytM37q1O0cYguP0lVh+smztr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(66476007)(66556008)(66946007)(8676002)(41300700001)(6916009)(6666004)(316002)(33656002)(86362001)(44832011)(1076003)(186003)(83380400001)(6512007)(26005)(2906002)(6506007)(5660300002)(8936002)(9686003)(33716001)(478600001)(38100700002)(6486002)(9126006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/3ws/sbv+U2Juto6JexHkvPSPXbtxHQSjXm4vYBwuarPsY7M1+pMnnaHEiV?=
 =?us-ascii?Q?ZWZDCDPv1ZbcN1D4SnD5rfiqi9V7Knx1DyjPnkvDXde09L7pNOZ2vP6Q/SK2?=
 =?us-ascii?Q?lCJtDAvEz9gK/WEpQ1+5Zj7cSDrRDJaD1PCYRbVlBAgCbXn/YoH8jfSjKl7l?=
 =?us-ascii?Q?KzE/AqQExgVUb184uN03NTKLp/hrhFSk+Vcj1NREN5N5FAjkUQGITsbLr/Xr?=
 =?us-ascii?Q?qd1/OUP2/AlsIrXB1ivTQ6qYw5Aq383Ws6VVkSLUQT/9hTJnmJOybyRAcbEG?=
 =?us-ascii?Q?8+NSeReOwPmw+8TQLlcDdD5fHHUFtFuSQAmGW92VIxsZbfDCX4z1b4oP2K4r?=
 =?us-ascii?Q?eXi0/TJ/OS4j+v0Cj+fYt9uvRlzjpCfMr02YtvAk2IsPEaUuIgBWmwVh6s34?=
 =?us-ascii?Q?NoXooNy9K18pifV9O9z0PKqDR0uzKA2RGHMNEbTIo/nDswdS9Ho8sByNE84j?=
 =?us-ascii?Q?H2WGs8+MDItm4C8Q2xj8oy0Rdy6O0fjYLkoU3dIfaVrGVbSKTgIqhULYVCR2?=
 =?us-ascii?Q?tdr81glpVzterRrBBHxHkO3EMl050SRDSsH4LAJe9AGKarAixfP+QpiFLbom?=
 =?us-ascii?Q?aERqw/7MIMNCtpoZHZCGLxDweqyRH2hKvmDixT4LwsNhdR+zQz2urry4IYDW?=
 =?us-ascii?Q?pdyOCmKvIaEAE9wuXRBS0rf7zEJ1EaCvOLbYf41HAhFF0qfnGpKyOsh0uYKN?=
 =?us-ascii?Q?PboAKyYErPhy20PvOznZORjSDzN+VM1LWP54g6kguQU2PjJHkOiTZC00B3Iq?=
 =?us-ascii?Q?2PjZhevsiCAeqiCXZWYGoO8hjy8bxBBBiEiFf9cXWP7334yl8ttDqq2UHEdi?=
 =?us-ascii?Q?TA2L2+8XE/G1XLKwvYzsqQL44kgSh8IWF5ExE5U7jY9Yp729mA9+wOeNpxwW?=
 =?us-ascii?Q?gx279o2rwdzD0KBCOW1QBA+A0ZSRUNVecAf8yX1yTZn6Cg3EO1nv02OUkfyK?=
 =?us-ascii?Q?Yy4IrAZ7Q7mBjAeP1bmElAQFjDHwHem+si8GcjXd1iPxDPDswtFeYuxfBOHg?=
 =?us-ascii?Q?UrbKdK+OAAyD8cxY73guK+fktriBsWGYqR0NWWGn7VjpZ6J0GeuNHpBP10Ta?=
 =?us-ascii?Q?xcqMkGr62aOf8TZeYscCh7MpmFea2hFLKF/dyre8KBOwGzxY4xz6mtHBXk9s?=
 =?us-ascii?Q?cfDgjc08QbfXoqXUqmvYpCo4kw7tnpYuByjHU0E5XreGQqa5Lnm0KgPvIqQr?=
 =?us-ascii?Q?UKkg6MdjwTPMjq2mWBWcHox5Ioq8M6LanOkd9XSzGZQpfS4e66eWFAEbfO74?=
 =?us-ascii?Q?iQPb72mWQBirA6UX1Nf0inhdbGUJVO/uTZhk7kW+raxBVh3b2M6dztZVC3JX?=
 =?us-ascii?Q?cBh3hBN0utw1b2fuRcFGsmqxejbg11DAJrbJ7vq7Ntt+wUYgJjZKChU8iS5d?=
 =?us-ascii?Q?S8iQOUqzRsfRO5LsGtWzedTwqsLd5UwEjytv2j72prxgp++aixS64PhT4Ym0?=
 =?us-ascii?Q?o3ZxDIBOas9gS38iKspzgNb5lZKHHe4n7yi5DZvuGuaueI2dwcNQgDX7WlgX?=
 =?us-ascii?Q?Q69ASKdivG6X1UBuAqdQRdrMvQkMKnWz3J3FW6TWPRZ8oF89IoVK+kbkQkr6?=
 =?us-ascii?Q?TMBwbb0ywgNd2jSvTiEpUzh3clMpfRP4lLePmOJi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5477f75f-f46d-4b8a-fb60-08dab2473df6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 03:00:28.1333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSziIcgT2ALW8gf10Joe1swDLegOAXDn20/NbxLPatGGycyAxURBfWvSOBW56aoNqorxLEWS3wTlTTXrS0S67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010

On Wed, Oct 19, 2022 at 09:36:04PM +0800, Geliang Tang wrote:
> This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
> which sends all packets redundantly on all available subflows.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../selftests/bpf/progs/mptcp_bpf_red.c       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
> 
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
> new file mode 100644
> index 000000000000..f8a9b4d1630d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("struct_ops/mptcp_sched_red_init")
> +void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
> +{
> +}
> +
> +SEC("struct_ops/mptcp_sched_red_release")
> +void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
> +{
> +}
> +
> +void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
> +		   struct mptcp_sched_data *data)
> +{
> +	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (!data->contexts[i])
> +			break;
> +
> +		mptcp_subflow_set_scheduled(data->contexts[i], true);
> +	}
> +}
> +
> +SEC(".struct_ops")
> +struct mptcp_sched_ops red = {
> +	.init		= (void *)mptcp_sched_red_init,
> +	.release	= (void *)mptcp_sched_red_release,
> +	.data_init	= (void *)bpf_red_data_init,

This line should be dropped. Will update in v15.

-Geliang

> +	.get_subflow	= (void *)bpf_red_get_subflow,
> +	.name		= "bpf_red",
> +};
> -- 
> 2.35.3
> 
