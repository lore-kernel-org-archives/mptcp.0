Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66A79E4
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 11:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmeb6LmCFvlbAUeOkiW4HSWlbw5MkPPQlti5TSkuos1eacys0jHE2LTu3sIvG6Rm/sucZVAUecXd9M2HLcjBYWo+91CSRkv9yw3G+fotp2uJS8kynTgKLvGZ8xLdEUZB3M66g+MhGVZXBKwDcs4sU1/R4X+QzzPtw7O6XNcXWTQBFo4lZJo/gtNw3Y6eNDNDXanLTxqsUsOFks9uNp0B0eQyDqZw57y+2Tqr0Gcj4iXBf8iieyfTL4RYjHCb8j6c6m+H8kFv8pzh0stQRWoFZMwmfJPqF7UAeXCzuwc1gg7ku3rUu/1YeRSdetvD2oKhWEdG+7cbi0Kk1LUUjpo0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF2Vyv0syxqwgotHdcsYGlrN35zwcCpLnuFsp0TDblY=;
 b=Y4FG2Gk8Bi/ixx93uxRtMVKwawjKAtlpMQNEH4raEoqWZZEPBrA/yfeYrzYaiBZGxO9wicYNW+RBkDDY4cFcjqqFmhExbX4LlMmFx1eGUNUQI337I3aU727zsg71dh5nX/VY7OWRx1J7/UQnFSIzJeCFUgij6ummqGAZymT1Mp6rAQ8TV/+ihW3ZVQYGACF4kUjqCfXpI3r/kPx9yHxeNm/52+d5u4MbQWdVuXAdHmf5Om+QEGi3xUotXtpL+cxLb1YU8ek3JZmJ9oX8Y11TwNdtE1NNzbhxzDW3sBfrmU2w1BkMmRbrQzx3TcX56f2SYBGvYS56zUMuLNGQS+lIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF2Vyv0syxqwgotHdcsYGlrN35zwcCpLnuFsp0TDblY=;
 b=mJa3QCdBAY4dOGqzat9P9PFVmiJ94av9vfojI05Y0W7IndQatXlydr1XPh/0K275WBrPXo0SMxdhVtIDKmlV3laHagg6OrgfuTzXbYhZte6gFR2rGv98oMXl830FCgmwIUL5BJFRWil2KUBGHfZPKVT2XmuVqfoHDJENZBGC1wVrcldKPKOAU8rSWTHQYXEsSNOgxLmqh+zOgFtLkK3dePpSal7dS6h12E8NNFTXRg83Ku0SgDw1/BoYNxoz0TydOUB+YNT3shB3CKRt5IOS4Y4Ca6+T3SCmJqBfu9x++tRPRi/uMCKNucVKyeNBsts8Kv3Yn0p/uEtD/gBRRjFxhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 11:03:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:03:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] BPF packet scheduler updates part 3
Date: Mon, 31 Jul 2023 19:03:14 +0800
Message-Id: <cover.1690801329.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0507f623-1857-4d27-377f-08db91b5b87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	URIIT+lNo+rm7mDetC3N2CwIt5iTsKo+tvtItrFAtuB6LmmsS4loR0M2yugdmLs3u+k54l9Ey0vnOVCZnB0pvJRyuzW99X8wcZ6GSdph2Q0MszWIDkxr7/lJuYjXztcj9bI6ZjPqP75VtiPUoY9VVL0fcb+4pL3h59fpv63fEaUc3DMh2itOBZplzFlhR68YfKlLqanKaPRCPloRZZHzHgqbejTqGeZZ9lILDC8nSD4cLwhacY1y7oX8J4mOEHa94NGBlepn8hYVa/7YziRPhTovJdyg9ytiQJa09asHSaWg4Fik5oH7MOR2E8OomZQ4Rd3D40Mn3q7gmzmTOXroC8yLH0eV9HF9qPfzogJf+zSrRtkbeqL4yMxJTfHOhSUqVHJoimygryd/iApYxY/cnbsz/qn2Dm/GqYfQmONVAAgwyYfd52yuJ9zxVGKDIDN5tCjEUeXjJqqIw17nbcl03f51pnbsAOlbYrn/qDMtTM/OmYd+h5VxRvqeieLjD0E3XiG2vbd1oy3mZzDvQHm+PbqF+Tn9FzF9sA0hA0jDJhL7EdlPTkXtpFdTUDgXRjUy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(6486002)(478600001)(6666004)(83380400001)(6512007)(107886003)(6506007)(26005)(6916009)(66556008)(66946007)(38100700002)(66476007)(2616005)(186003)(4326008)(5660300002)(44832011)(316002)(8936002)(8676002)(2906002)(41300700001)(4744005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rlk40hSSS/Hu5agSWJ/PufvVLPjtxThxsHkkR8hw6+4iR4kIjhayeu0mj20P?=
 =?us-ascii?Q?qTAoQqXsZJwbYeZ2BbSGVTyuJnHxUjkarKSZwPRwrTaqD3ADdWFVp10h+3eG?=
 =?us-ascii?Q?+emqhRDiJlaiHDJDMFTOEY0aLLPVqu0dJghy6WjPjMGt7t5G+OHAF4e+qQD1?=
 =?us-ascii?Q?F+SwWGHKJOXH19U5Du8RnW3Ptn9UtwyRr3kW6lM1PjHlLYhk3fn+jX/ugWt1?=
 =?us-ascii?Q?PaEM5KNRCmR1nRSzKA2xV1iDJfZyIBfzOeSX6bA1mX/mEeH3URC8zPogUU8y?=
 =?us-ascii?Q?nW5GHGxYFvJ6WAVUQBqevCr6h41nFjSQbUOEIJlqtPrWo6ronqSW/ytmhuLy?=
 =?us-ascii?Q?gl4KEuPxUucloDYVXXek8r+npOFHmQtXIslE8GVNEV9T8nPmKyTzxbeWB65W?=
 =?us-ascii?Q?pNRTFqdXRut26nLvU0sDw090GWTedUDsnqAm+s/heZVOwGp8rLYoaOOtsWTp?=
 =?us-ascii?Q?KTrCWbjI5l3l/ZgCgwtlkxPGjrtYuWgZ4fOig4MrqlLJ/etJreXQYJLEKJDv?=
 =?us-ascii?Q?irLr1jy0gFiu4agoRSynNmmFoZ6WvqDrFcdXT2OWphtO/MSQg511vuAITbAq?=
 =?us-ascii?Q?EMjHUsXO7xkiFavsx6Bcv3TR+xkj9b7yR++OAdMrtFFypE7yzepytt8w7jKD?=
 =?us-ascii?Q?75YI2VBLkD5EvyX0ZiahtiWrq/K3PKEHu2pyGQiT1nbMdF8SsSqwhCfR9t2s?=
 =?us-ascii?Q?e17UZgrqLcA+IAIltRBVnI+DUQr2wsx5ceDVPsjUdNQVP80Jv0pG5W8U3E8a?=
 =?us-ascii?Q?IGUvc7V4viF9pfb4M1Y5u++zfvAczwPuBprnhbQIuszzn7akjFF8gF/MI/ZK?=
 =?us-ascii?Q?U6TSV2LXBiP5Kg+9EEfYICw/lmG405TcXiNDViJcLF4wReZoaNSl42rD34J0?=
 =?us-ascii?Q?NyStpT0NQvDl3ZgeJOHSoStTX1QkZJ1Vr5CUNP6UyPScSYxXmaY+udkjkVqw?=
 =?us-ascii?Q?K4LgL+zvHMw1W+9+Szt/LyfMjc/4x4Tutr7hiByCmQUEWYRoHUoWhj241/Bm?=
 =?us-ascii?Q?Thu9dv/4FKbaxdux8VZjFis5b+WRqoRxHv1ybBMfnLpVuHS+GT8R+Bn160Ce?=
 =?us-ascii?Q?yb1D8tLuxmZa0ipUKqhKVoYJ79L5PnnLl+DF8+KV5VnJEodb+828awHW4Fn6?=
 =?us-ascii?Q?LyKT+2PxVDuypeN5YpUbLAAuCxfaVwi5PvN0kPf9gbamvVRpJRQtNbNf6Chg?=
 =?us-ascii?Q?Chmf9tcMvkz+yXKTks3+olZe+4Gak+VvoqB4VJFSslH6L4g15excZTQZgW5w?=
 =?us-ascii?Q?tmfWzO/YPz+H/QDO2BvZme2+1m0uL0Xu14H0iP/OrRLlECtopSal7UspqUQ4?=
 =?us-ascii?Q?XXXkd0Vl24HCqus0bOY4y+cdgeoHynvlWHXKMJ3RjjRZiOesK6+Aj/SQMQpR?=
 =?us-ascii?Q?MqTfzgIAKAGHSamVGgv6o6aR75fQ4AprRpcxX0+XQE7K5k2x3ldbY1pBwhEk?=
 =?us-ascii?Q?qFancQYI/r+MrToW7gIgtibPfoCR/6N/nVwbJjg/Ii5DqesQT9FsVuJQGqRz?=
 =?us-ascii?Q?1y5HtDzYl/8HmYseZDf0eWGpX3edE1Dbj13agv2LZ9f//zIVGIHTDSlnQwPH?=
 =?us-ascii?Q?L5PnyEuD4coIi9L4lnyIGpp01Yme9KYHZ6i3SIOx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0507f623-1857-4d27-377f-08db91b5b87f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:03:08.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37Dpe3v8p4zBcV/jeqotE+09uBC7owsC1VOko69s0aTM/7wqwHBuYA/UWEpVdJFAw8cc0dU8LVyiwf4NTu9OEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Some cleanups.

Geliang Tang (4):
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: add two mptcp netns helpers"
  Squash to "bpf: Export more bpf_burst related functions"

 net/mptcp/bpf.c                                | 10 ++++++++--
 net/mptcp/protocol.h                           |  6 ------
 net/mptcp/sched.c                              |  6 ++++++
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  1 -
 4 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.35.3

