Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DA17E8
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYReTg5Ep4jmf72M3uVPhKrsUsaHC9uTsCNpBegX9wYSNtLgPmmcOZYFuSCjfKLdR2UfNXLZMDhoI2HYggSWcg+1hWTZJI4Dnj4V6MXE9yVlwCZdKHZ/x8EFeiTH8AMr/rACrGcVEZqiai55y30l8d1qG/xWf8Q6MR5Rg0Oojy8250cH4Gg7kwO3XtzLE0/b87Zq2Fv+W18ymehwUyfnMiDm7QbaPm6MWRqo1jryGAj6gKNedgSpeHlhwLFLS3Ig8Qq681bddk0oxWLcNhY0Jy9kjqpjVSaUQnqw9I7sL5Sv+3bxW5B3Fk8PX2f4bdnkNMfYOk9RuSghbp5Cf3AJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnJXT5BEI+lzsNnVBgeBDlRYMZ+HkGFJj8yAfLUN7GQ=;
 b=jic2WfoNSgSsEHtIypktUatp9hR7V/iRfbpL0K+hGpBsltWeZ4IQsB1y9S7+1OE3fXeE95saKgWrqcSi1zy3pN7bvcXdGWWZEQ8UOCqQStaIUuSF0YRf3YhSACig+M5a3aUnLrUlQXVfN3cQCEw501Aw56aOBkSwTlraAJniGbI0GfhJCD85LTAHR1bgnls3y1q0oOKIbWk33Jl6FBeH5LFMh9y/Npse+74Ir4Zdo9wflku5W4w9kLFODKX6f/pxGiKlBms78Yb3N88nFSXXuXvAlnGxbqfNxsdlWo3GOerzXsmkbJmdryIYcNWrkhtfTC40nF160TBAfG7eCHI50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnJXT5BEI+lzsNnVBgeBDlRYMZ+HkGFJj8yAfLUN7GQ=;
 b=EAYYqVwJmKyAg94BvPChmO2rCWyQN41rV3q3EZS1fARqCd0WaN+N2q6cDTHtDQIpGwC8rZkgs7G+gO93+8c7QlcoOCDqAUZ44LdEhWtV6GT0ErPxliOj6ncnvxtiUheTnq7m83IGrnq+KaNCcDoQW0NOc3r3IUxA3uQ/RB+a8ZH1j/1fY6ctPn7I0rH/ndDy1LsCoQh2MNeGbVUc3vqwSkDYGUgxg1TIl4oDraTD/r0bo/17TEuJglaM2BoruV4WHFMWX67rxv+iPJwQO5a95+25mBIoyp7CAWFvwdpNJ69ncuE4Mg6g/R2cuSZ+PEZHKwW73xhKwWF2uOUnEBMKZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 02:51:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 02:51:25 +0000
Date: Fri, 18 Nov 2022 10:51:41 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 0/4] add pm listener events
Message-ID: <20221118025141.GA13950@localhost>
References: <cover.1668662624.git.geliang.tang@suse.com>
 <1ac7039a-3872-9ce1-0e7d-fc6ae13522d0@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac7039a-3872-9ce1-0e7d-fc6ae13522d0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TY2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:404:56::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc205cb-dce7-4537-14e9-08dac90fc899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxuSkKVQp2yhOGt692pwToENy4d/pkKt6K6Qnr0qQDcBALSa+6sh5WjVDxJKcxYh8DwW9fQi8lMZgUB5FqRHmV9+CucrjTLA2WV852uC+Q8lfgh9JbbzY0ZinEBNBmd7I0hzUCwR5J6nvzv1V16ZFXE+S8R4915sKfLk252epDUcy27k6vk6SYWhi55nL/x+vZUyud9WnXMOJHN/Ca6yv4HDvAHC9rlaMXRf7ZhKfjyPTMJjExU8dGHo7YtmeXFp/OaUixm+6vVftCptgpwSeGkbQ6svECLrq38pE7+fc7mJ1ihOrEPCbF+Bw6tN/u90CTXz4G3uOcK4aZtK/FiCBNjyKo7Ew6InS8iM2s+IIDNyMjcRaXIMEsxuxSFqnzl5bPE0MGmtEcyLmX1lm9w+N0ObFCbTF34soCggn+rjzkHSxEvpLG/SzbsLdFcXjtmGsb6iADzobiyH7FoqgI4P9vU5+U+hljK9FAEWNxVy1SH3ycCwsMn5RjHmaT8WP/34bwPfrCMJ6PZRSq+sEKyIvrHz8QywoYhXLdPuNIXSDpXItx5W0lxg4MMk42S0IbO/PnprZamAjBTE+GiD0dD1VTTfqIMyuLAlvQVp4bl/wmSoc9vyDKN99C5KW3ChwL8a8agxFd15M38+nucNFgCEK5BCYrKgc6Avz4pwjf+iUAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(86362001)(186003)(33656002)(8676002)(4326008)(41300700001)(1076003)(8936002)(66556008)(316002)(66946007)(5660300002)(6486002)(44832011)(66476007)(26005)(9686003)(6506007)(6666004)(6512007)(966005)(478600001)(6916009)(38100700002)(33716001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3C94m06bFFzXX5I0Km+TEAHmqOsxq5GimOOYjXI5dPVakF4cuaLqFUGrDT/Z?=
 =?us-ascii?Q?CYcTViAONvnqJOU/RJ3FCLAW5bzKRMn0X/kf/Ph3Y6iH8GaBhhQvsGD1Dp46?=
 =?us-ascii?Q?kh/HUCuY3+xlZYdqHaenV1+4aKHq5FGMUXDdEFgvD4qhP4lsCmeeOoz+p0y6?=
 =?us-ascii?Q?j/fbAZvoamGvP4YL74SZHklfXAXwlNByPtEET4QXSkDtDZEHqdHnpWGkIKOO?=
 =?us-ascii?Q?p2fQ9Vtf3kVQFkzje0s8gntwdsym/lRuNu2EFbCW3e/Gz2D5dNOFzko9XJbA?=
 =?us-ascii?Q?IIm2p6cG2rjTvPbvuMI8k6xRKc8oCBPb6qg9ByJlH6O1ZJWfMlk45TB1hhuI?=
 =?us-ascii?Q?fH9yUGEj/wgL+SdKgOA1on92yytA2O8iDEiu62CZrYtwOK/+GsXQom+qpB5U?=
 =?us-ascii?Q?s7VcXQ+tZqJ0vGFTIi839Pz8aNBEiYXPF5efVM15Vv7r85fkPtGwxN63knqU?=
 =?us-ascii?Q?HHxShfgegs27W9K8FyRjMWPMgX6ptZc6eHc3VPRCNUsEMRzf7wDq5jZTn1/h?=
 =?us-ascii?Q?7rOx3mxZ7liOzFw17ez7xwZ7xNHiCZjglEDq+ooEp7WImtt2rTNICvIAUp+G?=
 =?us-ascii?Q?VgG35/+LsGajPDoisXAItsK2ui7X4TLHilG7wOKUXIwre+Ieb3B2+Uex8RTN?=
 =?us-ascii?Q?WIsWMLXt/ss+WXKZWvm/YyMyz65QvRu05pmPYOO9fZeqFSKJ/rAExDjOe1ZS?=
 =?us-ascii?Q?ClDuqyZi9kUiQ+zScIqK7MwSSvHMUkdwq+RrIODNSSLggEopu29aEWOM69DT?=
 =?us-ascii?Q?DTg/wYnFnC1TRYSEh1hgPAveydd46BCl3Kn7h5/KJudrfB+7dHBi/vQEthJv?=
 =?us-ascii?Q?677vDozaxle5PCFvYVqs+gMHOc6LWUrGTxkZ1975NaK5yY/uK4/czp0U6M/Y?=
 =?us-ascii?Q?hf7AD2StkzFTpSLGsXv1NdkvQi7FOpXCXAO+2UVYlt0ugLMV6d/2xvkzBtuq?=
 =?us-ascii?Q?dH6H9vHRT7P3KrtJRy+vbnKXdgKLp6t1MFVS1wZGsOCjLJ/JEkyBIAZ2ylkn?=
 =?us-ascii?Q?9hquNXJTBoGWPKqGEtK6OcK1wSMV4JYiLojrISjZ+Lch+T7SoweCoMFnxOd9?=
 =?us-ascii?Q?oX1E50WIwRby8UtjXpvwn5pCM1ps9/Rw/r5HVlcXMOL4N6F8Ojz57GxDmvoJ?=
 =?us-ascii?Q?xg9dUdxir4m54yIhU21cRhAQo/2CfEzCLi0P2OwkiBWqawzbIaw0tY5z14UV?=
 =?us-ascii?Q?EDUWyPyoRlydQHkRYCsx9GoSZxmy/pRDy8UYFqAQvYBW9ogY4OORIR3Obgik?=
 =?us-ascii?Q?6sjVS5+IrQOHThbUGnaS/eX6BBfzakB2TqiOJAVI/XOqwPd8PilTMUuqRNSi?=
 =?us-ascii?Q?htTwlWV/D6E+2/i2J1KfFztqJQVZ81ZhAMIlTVoSgGCcTkTiAb3nHSwTluS5?=
 =?us-ascii?Q?6GiLMmdr29BF7LRLJv1v04FH5dIywAawFqcOiycyBWsle5w5wsM48FL2y7ey?=
 =?us-ascii?Q?+dnsB/58U6Fs2UZ4ppMOpXwmlzlKgDX6UMJzkU83vOFqHsGQLzjy1uyu5nq6?=
 =?us-ascii?Q?vDq84BMseCtx9JcQ6UkacA0Gz3YuADY/g/UWCvPzmWJ3w+HiWT1Lky6TSle5?=
 =?us-ascii?Q?aeE0A10e57UZ/IC0O16HCXKIC7ZYF0E4XPMKcbsk2m2zgufyC/qm8UtgDwGl?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc205cb-dce7-4537-14e9-08dac90fc899
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 02:51:25.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2P0STij0gKLcYgMQdhXlzwSUAhhtTEGok0zpzOFYWciF/iVJnJcBU7IR9jtPHsRJfXAN8yNfdH/OXGNERBJrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

On Thu, Nov 17, 2022 at 05:44:10PM -0800, Mat Martineau wrote:
> On Thu, 17 Nov 2022, Geliang Tang wrote:
> 
> > v5:
> > - use GFP_KERNEL instead of GFP_ATOMIC in patch 1.
> > - add the listener event checking in the existing test in patch 4.
> > - update subjects and commit logs.
> > 
> 
> v5 looks good to me (one minor commit message change noted on patch 3, if
> it's ok with Geliang):

Thanks, I agree. Please help me update this commit message when merging
it.

-Geliang

> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> > v4:
> > - split the selftests into two patches.
> > - do some cleanups.
> > 
> > v3:
> > - add selftests.
> > 
> > v2:
> > - send created event from mptcp_listen.
> > - add a new patch, use entry->lsk directly.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313
> > 
> > Geliang Tang (4):
> >  mptcp: add pm listener events
> >  selftests: mptcp: enhance userspace pm tests
> >  selftests: mptcp: listener test for userspace PM
> >  selftests: mptcp: listener test for in-kernel PM
> > 
> > include/uapi/linux/mptcp.h                    |  9 ++
> > net/mptcp/pm_netlink.c                        | 57 ++++++++++++
> > net/mptcp/protocol.c                          |  3 +
> > net/mptcp/protocol.h                          |  2 +
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++++-
> > .../selftests/net/mptcp/userspace_pm.sh       | 89 ++++++++++++++++++-
> > 6 files changed, 221 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
