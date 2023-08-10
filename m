Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB81E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMMfKt1QMiZnJu9zurffzyC8HppZ3gLV7ajC0bgPPC8fp+zrLyIyQ+QD38l3vbWyxCPWUrQRzvYwpPYIUrHnOw2Bf0QdEZz/UB+R3pAWXxLwj1Fv7OLcB0LH/M1uAG/ed7omRP30uJe96SJGXtPyOVAVHlf9L98fNJZKeHfE3hgwMlzF/GX28pBzZyo1c/2EbU/Lk/VuC7lObtkoslCDksOJZwm+EjHPVnCvv7x5E0qefkZ3Pz2EBA1SctXgwsvKz8D80D+7Wf4pwOsBfY3bjiibERmOgtE8oh46XZSlY1u4HPNGO+zY2zqiqRVw2soUEZI3xsMzncFoTKtQFyFvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZJ33ou0b17d7s4XNeEsCoK0evClp5/dTAMlfD3EoAk=;
 b=gkAYmasye6KgWA+XzpVjKn1YosQXz5TBJNR/l0eKU6PxdrkRhSnSsActAjFtkin6k7URm3DoYOMN+dNLnS3V2f+hTWtqj2AifAgJJDygMOTFcsBf+JMD+B/ibDBqOHeAsHlDJCCcW5IXzCTPPTMP8EwU4C71aQByO+er4VfmykjBP2+rFZ8vb7QvbU4oAv+t/DPWEGG1uHfpChSRKYuyThTKi+MW8P00ek8RhBhNwuJmcJemFdkS/rYU4h0Kt8kjIsBkBgA4/3SGWjCLMVxwQAsS3m0PkaEMTY9ro6tEOrBSywZ0ZXi+o6xeDB0pRExo65UL/jcifNFEAuoBJzPyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZJ33ou0b17d7s4XNeEsCoK0evClp5/dTAMlfD3EoAk=;
 b=DV9DglkVNeQvAm18V49vcv9NDZNz/VnlqXJWzjXHNbbj095SI7jm6d2TOgetV2QumRRqnWavwd5tQfZJEtovByLxWGRMQGkQbMtS3BPwL4mC29ioyWfq+XNfMww+UPSn0C2b2rzz85V6ypwhm8k0b2o+DihC11d+YSmdf9W7TUf0KWHeiI6z1GeQNupCue9isWjIYgjPH4gKWGzI3BGtqcGGY9yrV0ORCtW1eL7rBBCaW87EAhRXGbf0rKBCyAHNDkq+bO38h8lVgu9ElGIS5Y1QcQ6LzGkcoNXXASzhtGKVh219sR2k4jkCACk0jgF4WhHi+rL5d3kgmQbkLRU/Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:10:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 08/11] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Thu, 10 Aug 2023 22:10:00 +0800
Message-Id: <833a2e32f438ac7f8a271d62f42f2bdb3d99a5fd.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0310.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3d8fa1-a25c-411e-921b-08db99ab9ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wz7RHfJSLjFP0mWzHwE3bZqzEFr3NGeUdwwj31RizecKCN9mbAovUnGR9MJ6u6+legy8zcHnTMcMnZqjlltoWLkmiJ3azC4QiiWsIqU8AlHDMbxM0wFjr6qoukz4kntKnxgkOhGwghYbqGIlu9Gty3zlNo566eEeVg4iVz9Zj/aAYPbAkELStVpp6z2YrrzfDPSCC7UY0T40Y4lDjX9VD74DGhpI4k03RsVyfp4i2OqxM879e1jTGRpLuldwb/L3zh08Di3fIApoLqQNUrs1mcFWWYfVcZR8g87TWkoYZ5raEkjYBH3NjVaVLDSPVZzqNp86KqrrH3mbqHDU/wtf2zY07BFuCyQhI42AzsJlpNfoVIqqFk+oQrEzL14ly07M3zKVEMDr2b8lfSz0NqlyN1ebp3cXIaH4YNPmytQBMezwdpQ1371ixF5xCxh6fnptv+Z7Qq0rUYjLipJMmCvdjq0mKcWI48gND8iOQKTjFaJ6HbAyspw2skcLWGibY+NuYd663zms3ybr4haub4saALIBf2JQSE44xl+/xkL/OLkmq2mAMT2MCJIJKDKlIzI7bFNuHs0HhTXiXJ29v97dLwAiUwCSzPsrSL/AcuvbXbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(107886003)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(4744005)(2906002)(41300700001)(316002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4aW9JMW/8UEmf8gIAa0UoSUGmkyPVsRYdHA/tdZetSoBxlwDOS5gQuN2Zd6f?=
 =?us-ascii?Q?vTcFj2SEFHTzcJOApg6Wk6SO0wxbLdIJpk7KdRTcD0lWZd1ZuFm79MnM7H8p?=
 =?us-ascii?Q?2iCyoDCQJhpjTGrAN8scDNMwy55CoYwdZzfL9aJchNIH5yEFDPdr/9er3Grw?=
 =?us-ascii?Q?h7faKkCh9hzfmepuaSO69wjj4zAqL0oStegqEXiOgudMHGDVkUvq6uwkggnt?=
 =?us-ascii?Q?OoY/XeV+gqK4aaEG3dfWIXpoeZKgMyZ1+0ycxbXxq4x2hVlaEwMlwLym10F/?=
 =?us-ascii?Q?+B4e1I4hLUg95zyOAj9o0SwqpMbZG/qEwAL37XQQfHJQvQgdwnQykQXo6IlS?=
 =?us-ascii?Q?haOpUWEwQSfwxFEemnwEzCO/N/anODTl5kfo/KtkmIJQkOcQMKMK/rDlLXUl?=
 =?us-ascii?Q?GujYsohj+/GI+uVolBfM0B+BrSGvLBn22kAJI/DRKhG/ZNJmk/LPMzpBxRys?=
 =?us-ascii?Q?Cl7sK8YppU+cqKlp6k2mj0DoXtMDcyIe0rIS7iCpsSCBCZi1X98LCqU+zGiZ?=
 =?us-ascii?Q?GR2jG+7rpoxtcdOs7+GDvVY1eVYOLenM1rSDTNKHEXzdCw5M1CkEG6gJoJIx?=
 =?us-ascii?Q?+Vg9t/5PZqGyIpnE19MvFRudE6UzEF3JXBWIoseiQESK8q0hqKTushVzHIZN?=
 =?us-ascii?Q?cnzebnYav3pE6L9XuaTuf3xTDptc3q861+Pi64YdZfsJYvlztpnGWhpmzF1P?=
 =?us-ascii?Q?SIle21Vy7qCHRo0Py5GHXkegBOjb5EvZ0HKYbMqEGsSyBDuV9WbXkVATnX0t?=
 =?us-ascii?Q?9elDIgXs4f/Cwq3+Ck7SFB6xUUkEIgbfi0biDS4iYqJsReEN4JmMPvO9+Dc/?=
 =?us-ascii?Q?eJVHZYWEUUM2iNrMVBlEPnO0SXxUCbhqHXafzuDRIZW4wpzHknajx2761+rx?=
 =?us-ascii?Q?PBqlDMLm7HyEhy+NQ+8Uzzs1mZyEW0spdUWN/qxygyfXzS5pOK+h7IrO8F6T?=
 =?us-ascii?Q?PqLVjHgCIKPHa9N34h0d6dk+I3OxCWqwUrsXTK2ie/HyVzaZ5eoCsCi5/6JT?=
 =?us-ascii?Q?QVJdGe7GMbv8DAYw8igekPb/nyZO2+nE9SuTwWC+PUbGDzHtIYXhdIGPSeN2?=
 =?us-ascii?Q?jVVPCOBZilvqhjIvj6yFDpB5UZfx+KpcWeFnwZUlmWR9eBcZi4wevuXacVNV?=
 =?us-ascii?Q?ILqyUzamGdfSJCz257I/zmKe/SnYrfmiI5q0qQJnL3YBops690hMFWVs7X9n?=
 =?us-ascii?Q?xqxh972wsgOFv18yLacdr87rE1Qx//Fhd4aPckInDDiaq7acMuPeXLpEQXNv?=
 =?us-ascii?Q?CWXSS/cdWcwDyV5sGZuXzcGD51SEG9aPSACtzpj1Jz8k0QJ5umhNztuHjlPh?=
 =?us-ascii?Q?ZcypI0IlRUJbas+res9hcTm9JKn5wXK9ZgKp0+kUgC7eFcLgOmBfueRSatYN?=
 =?us-ascii?Q?hH8fY5kcQKn/33CMbKUovaBbjf1msgulKHtPJtuwTlimtB070jSQ01xTL8Qn?=
 =?us-ascii?Q?ydh8HEari9Sh0bpSi3xuDwMQ2g1XwOKpDONmAPZ6PUifFxwO3gQTY/OLoKOF?=
 =?us-ascii?Q?8yeYEN13tHw+X5NYsXUXoD7/AsATkJFr5xjoAwnqurWWM9slkzFlDnE4XHvv?=
 =?us-ascii?Q?rxsE/O2nLj8Bwx7MY70aP5biNIKGPVHU1oME0uN5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3d8fa1-a25c-411e-921b-08db99ab9ed2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:58.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8sCLxytxooELRkis4MC5M+Xy7x5hRtHf1R0r6DzNpBiZzg9/bynIAOIo8Xk1OEaoeMd0h1n5UH6NQ0wCP46Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314

Alloc and init mptcp_rr_map first in mptcp_sched_rr_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 8d9442996e0f..5842b47d9c5e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -20,6 +20,8 @@ struct {
 SEC("struct_ops/mptcp_sched_rr_init")
 void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
 {
+	bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
+			   BPF_LOCAL_STORAGE_GET_F_CREATE);
 }
 
 SEC("struct_ops/mptcp_sched_rr_release")
-- 
2.35.3

