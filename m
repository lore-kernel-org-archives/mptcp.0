Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1C17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDT5DYXbxccOO0fF5dWjWGznrzGbp9E647RRqKgE5pgOX+h+IoBdN3bP0wVNp9cKiuc7JgZMXFv6m2hN1P34Ggq5SYf2t6ONMnG71/1sS6OZhMicV+FpvGtOry26xCy70VuZq5YIUgXhd87arxMftLIpw8UTgf/g64NDJlgSmQUzapL53Ng3unhxmWeQ3/qVhToP4B3jVsoSUXFKIm6XKsV/yaa54zXZJgbB0+G/G86cZAk+1uedjMKIwSD5TgSghRKrETTaMJne4+uJpW4/f1rygEWfJxxTQxv79P1P/GBL4YwGfqPGS7PKgnmNZrMqyuwpFmiOosKUue3tDqlSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxuiV3j8zKXnqoknvrj6ADXxb1pHfgDiHLVt3oTLL+A=;
 b=cD7xiTVmS0eBTQ/gajFuPVEdApJC48UAWdMhfDkbWOZFUndT4VTviUebXzkHgzjb1dRrqaxNGcj9452oWarWu0rlhgINETLAoYYFtsSmf/kIV4nU33L8LJslIWjHx5o80oUKNeJVJUV0sUXVCV7c0aGAe9eOdvk1W2x2XbRNSSYY7sspOmO4wwFwCHxvSioN+hEWN/uyZAPwv1im7Q8fbZcCM2z8LXe6QrwPEZvTqS+k/Pxr6St1C4+hOQoyoGH+HnLM+o5xn6AedRCZT0Zypz24xPpuocBclSsvu956pDseJrUfflQvXP2jbOtL3ZhSApmw3GID+srYZG0g0T/WaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxuiV3j8zKXnqoknvrj6ADXxb1pHfgDiHLVt3oTLL+A=;
 b=rTXyXhGHq/Y3CsSHGAGSsR+xsn50uYaXqOFof50se3IWbCwgLAUDIPFC3B5+EIim0FInKEQOLqSU5YmIsS1XkBbaweJtkEHh8uuqJOv7E0VWvGa+y1OfVjWqR6AD/J5iqHz8/IH+WxJWASDQ8PopuYTjAffwPsfQ8VYzustlF7BmxTutEr3vR9P2cNevLNo3+vMsdCbBSvs+iWtdTBi+B9+2QhPes1WnR+qwEBUe2HawQlIrRVQdrjFCEnjnL9R5fiY/hJpfWt2vmI+xdJbE169dWAwofjEQEcBDfVpU3Ocl4a8Tqee1vHSrvYkudaumLINPQ/uvI/jH1mCGNCR8Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 00/12] refactor push pending
Date: Wed, 12 Oct 2022 12:39:55 +0800
Message-Id: <cover.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3590a3a9-754f-41a6-788b-08daac0bdb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ogUjEtN3pP7dwqhbKnuSmbdsqy3OrG3lHxZDRqoXw5D/iVATgr4oB/WoGzFqL1D7STjOJkt1Rh2d1WxKWhsy8V6VOvAyHmsCxUxZJL+dioIfuyCJI1oBjBHN+VJ14/DLiS6LHR8BVk8StTEBicGAvbJRohW1R/Ic2hZsQ+UTi9iYNgPWOYjODTaIBEvgZ/U5XCxgOYAJnOpICJNOKZxv5y04BsLnyvwrnSfRAx7HOjCwPNH5Dpo8+xpz31xol/GjWBDziEWDICw4N3/NVaZat9IC45ABEHn8cJV/ompeXgtILVJvoFlRSvsDcO2G7jMp6JEp+MtuiukZiaIV+KWNHeVdigoqPc1Rgo66apw/usVAHEM4ozoVisutPeQQ/wxSVng+lGbYGDh5PCaSFV688X0TueMh8OJGFjJgsNYLh19eDhlM18azWJKCQvUpPh8o3BWkB06XUkOy4xhLtIQz4CKV3GYTr3hhIPWNTvvT2dLhRGm0FOv2fDXv6p749pzN3qeTLRAS5QscA1ZOVJcBglYzxibI0WJuUcIghNP/VEdXqH05/zNf9l29smgnNykJ2XqudSmk2C0AykkrfRB45us2hsOGWSZgHuAU1zRgkrRBYf+C3qQ/rBbwrUxTNhueF4FJYkcJArgNvdLtbYBhjPjN4DOS0Flw+gnoCVFnXDfz4ytQaBFbSus7FEnDe8DrBVE4vkBVaM/Sp21WFuA0ImEOQJXyLn45fzTvqZBM4c+mZoWFiFXVsAuTl/uTb538
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVRAzioclstknmpIvK4FNYzdZ9DboIXjnn49Ft1qTzrN7AeDM/3jrzoEvfEJ?=
 =?us-ascii?Q?382wI5zFtluLXGa4StyWUYxbklVMDlkamRhCtcKl5/jrPDM+ytH1Bn1UnfLc?=
 =?us-ascii?Q?y32jio2Ugn0gsn3qksgKkoFjau/Jz/yIxOcaYFffPcRy7wsvKTYwrVHCZDC7?=
 =?us-ascii?Q?UwMSTn+3oPNLHZc6ishFvKfoAflgOPJrEuyjXG3oX5SHZB1xIXXbBnp9maRz?=
 =?us-ascii?Q?OMXtsbKWSRhQIiKLtG9IfbjPvVwzULTDFx3saJsyTAz4ZB6OLoSmgekNNNev?=
 =?us-ascii?Q?g2P/Uqkouj5Ra5e260FghrIPkmpRdbw0BhRsn1JODvc2hNYbjVORjt2tMQs8?=
 =?us-ascii?Q?lwP8Ml7xuBibuUTv8cvKznygXwiK2fh9LuLiIhDnMK4jOts1nRDGs0qZrX9E?=
 =?us-ascii?Q?6VwIbm3wsyMMF98dpN4eL9bZqI/YZ5zBXxiLzqY80cIZ6PtfHmw7cjTeH8Uh?=
 =?us-ascii?Q?SGbzhhmdYzxBPFljFTC1Oo7ZKq5jDkTsSFo6dbOj//cu6EYx8o4gwOtF0Lvl?=
 =?us-ascii?Q?rsFbzYmI2jC68bzUCr4lP9kL6KVXeROiauxIs1FaFFDaL+xkVkHMmbUh/FRe?=
 =?us-ascii?Q?Vve9rxWYxAoI4nOhJZhLvYROZ5Cs0gw1/9tdwYC1gLYulq1yjTbKkctROcNN?=
 =?us-ascii?Q?WMt6C8uu9nOr+mavZQOY1iSD7KHnPzAP9xtMPZnLwNwnFrghtow4j0M/2h1Y?=
 =?us-ascii?Q?ncAxrhUqkZeeVND3w38fsoSKsnS+Qp5UJw8vNRmiQCzfQ0x3cS6Act/g4qKr?=
 =?us-ascii?Q?McBeSz+GyFPKBEB4L4vhsfv2tXUot88+yzoU6qKItaloS59TP/s8NgvluntD?=
 =?us-ascii?Q?lpWMcnxXzGPv2EeeIDidbmwJ5bOfjpCdmZUbCCS3Qe+t2G9P7ni4r33n4W8G?=
 =?us-ascii?Q?A5SqQRULovYaZgoKfp7IXjCuXzbxr33j0hfGqDFYzLz9Ng84LabE8nwG6r2Q?=
 =?us-ascii?Q?ESNTGUTUSy6wFQr2seg2FjtCKJX9bbWsCxgsFVNps2z+IH/95K6qu59b8Usp?=
 =?us-ascii?Q?ENywrTshnpc3xFsKt06+HwVfRNc9aoyBgiubws70gx4FeTmcW3Tt5TK84ELN?=
 =?us-ascii?Q?Gm4xhqzYMlEEGNlvPIhxRU+mv7T7yFmHZkLYoVLLMWeUWSXE4zaKOMOcBQqG?=
 =?us-ascii?Q?aCJeW5XNu0eSsPn7cQ5Fg6RRbBZyqRu/x+d3BIfm2vGeOEq5ZuQJq57jC2Xv?=
 =?us-ascii?Q?ztJ71UZO1kbe6YMCQ2lXJU3wAfyhftawyRXpznTHTnJGcXtyVUs0BPPl29sm?=
 =?us-ascii?Q?2yhRefXZMO/3nQlUhpBpDnuDC/tx1KdP/ABV8ZahGpNuizKwOFC3KljY8H1u?=
 =?us-ascii?Q?fj7HlNJtP1M8+Ehlqsj6nUBQosCuHuxn51M1ALPQ81+BYzxu1vmeQp1jMBn5?=
 =?us-ascii?Q?MrEgyoo69KR/4iwqt5hV5uZ3rPb3cDuBzzizGxxtW8sRpKX5GvyOyPE4aRTW?=
 =?us-ascii?Q?NCl4g19Valh8D2ujn8+Ynf5appUWUJ6vmLKpZI4RzPCnFylWfnKpHilNkx7X?=
 =?us-ascii?Q?bqw4vFCX0nDyZlAh1jiCMOljPHpOcKisgrA18a33Bf4549GfOQlAy0cNF4J7?=
 =?us-ascii?Q?G372dSCC/yNcphUyTAiH2jOa/mYA9j2TZY5SGgRhToB6qtaRdk5F2HqowrqK?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3590a3a9-754f-41a6-788b-08daac0bdb19
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:14.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqTVGrFfFXtn370qPCIAE1agQCAwG1TfK4iVpwFgbXklVMziT4n9Id9Z2li1hKSwi6ZF1+FR9wNNqD44xeFIag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

v7:
- update delegate sending in patch 10
- rebase to export/20221011T063543.
- This series should be merged between the commit "mptcp: add get_subflow
wrappers" and "bpf: Add bpf_mptcp_sched_ops", except the last squash-to
patch.

v6:
- drop all msk->last_snd, add last_snd variable instead in patch 13
- fix lock_sock issue in patch 3
- merge squash-to patches

v5:
- address Mat's comments in v4.

v4:
- update __mptcp_subflow_push_pending as Mat suggested.
- add more patches from "BPF redundant scheduler" series.

v3:
- add a cleanup patch.
- remove msk->last_snd in mptcp_subflow_get_send().
- add the loop that calls the scheduler again in __mptcp_push_pending().

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (12):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: change 'first' as a parameter
  mptcp: refactor push_pending logic
  mptcp: drop last_snd of struct mptcp_sock
  mptcp: simplify push_pending
  mptcp: multi subflows push_pending
  mptcp: use msk instead of mptcp_sk
  mptcp: refactor subflow_push_pending logic
  mptcp: simplify subflow_push_pending
  mptcp: multi subflows subflow_push_pending
  mptcp: multi subflows retrans support
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 283 ++++++++++--------
 net/mptcp/protocol.h                          |   6 +-
 net/mptcp/sched.c                             |  61 ++--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 -
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   6 +-
 7 files changed, 186 insertions(+), 183 deletions(-)

-- 
2.35.3

