Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDA125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5edygwDbdifxV9gCcAVcyreruDf+YlRwCB4ytTax+PYuXFehtqgsoaobIBezA588y6w7ld6HPqm8/ZWggEjzK2aFaFF/I2bNBuyPVvGizbRT0+/hPkv9kRNa+cTAA/owNeoF1J0KjtXXXyHEccTRNHATt8pa21If3qH+4oGaN4yfeI20cdBwPhjeJr3Fo/heIKtac/3urf91O/XXHPZwUnVUcJd4fGCe6q5hoHwVTVkfEetHqaALpCZ/BblrzqI7onyxTihzmBTZETITe/NbB+PQ8bvnkNJkN56CoZig2to+S8snBG1XXivn68LNrTjtBJGnQ0c+tPJauCkm8ZzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzNUlyrpNg5EmO3QVHLRPy+rNpsmlueWlUnxkhTlKnw=;
 b=ELlWCI7ZixRk9LyXBxE8bGSHS2BrN2S84bfSpvrn/ZRkqJ8HyswbltqAx4QRPtyAv3xm04oNiPUJe94rzVui/cBhqklsFifvB7VIco+sVg0nLk3Gt0xZcEosFEigo5T52x3I/95aBGU77EYxLxq226dUZf6KRmRj4eK1zECPGy81ljQVwuUTG5DHdg1pCXmImkXgXyKSmA3HzSOuaqmpTg4/R0g5a25Dv4lvcnYFbqvTePLo4hXR0OiL8tabZbKn5UYefvCWlspOU4Zd8Ax/kyklWCH6VLTKFAgHna5GhffTO5M8+GFbwc6Ccw3NbK/Nmphw6CIlsdQiBXhyIuwwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzNUlyrpNg5EmO3QVHLRPy+rNpsmlueWlUnxkhTlKnw=;
 b=geuQ6k1kKBFJp631BauIsFBkRfNhQDgvZSAP9XZWsvK1jO8QHgY1oK1DhFyk4p6QG1u1CDO1vMPqR3pX4M0V9Y6YP+2Sp/8o3xfV+6W5SU1nulVjG9kn/7kCN1pdfPYIWpvy8rTcxnQcdzsCmu3fcU4J3AmmFK57oqnC3h2NQXyvm1YC+uqeEdxTPE7foAAuG6MTPK1ROLhCBtvsum7/Fzb9MZl1/wkILFeQq7h1Ok/XbLvpqUaj5UptZbyXN04G1U3MU0PGUxKrhRfW9jdWNJeaVluY1Z894SVFnAYf0LIIMf+VvO2gcbj9fAcH68fmCDBUT2qkXtnXT/iHCd9pnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:02:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:02:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 16/18] bpf: Add subflow flags write access
Date: Tue,  6 Jun 2023 16:59:30 +0800
Message-Id: <8530ffcacb4fe1da6a5ef0d6625f6f6223fa835d.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f2eac7-b1dc-4682-7150-08db666cd023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvLLUaMCEplc60sq7QNugSo2a9AkI83aSSmdgSbMILZCyGrC7Eoju6cI7SQASPTfWmSHswgmxAAUzQQUNW5Ja7sCwpHkGR8gsuYvY1F//d8+ZYlOfWgpxbwAYiNmk7GS9WolUoFZiH5BG1cTFzEwDlNrieyeXXD6hRZfShrYJ455v69lBzt8DcACo+PVdpj8SXVnCkPzG/ELWkIrlpfnvJ45R+Tkw0GbU1FVhcuybgJpcGpxgADDQjgCEnthkMC0gFfRQXMPV7vdc2kJED9BRusg5sattF8h/5GWLyRPeSYOAxQSwXQ2DkqTUUXDxoiocY0F73v2AxLZnU3ZU2M02kiuhUf7jlh+noqxpUJJl+04T6O70Y4qzupVsnV9UBDvw9uRpZhgy4ipilAjMm82OhVTzV1jeulmPhypd7Zx8NI9fFJSSlfprYV/cCOEBWHy38NJNyyCx5YGjMDQN8ko800BcE76Mhl8equlZwXu2CTH0orfiAgmyv7fOCoCK8SeEVLbJOWCgc6twGHDt/irRXxnQ589D8xv3N18XwnBDU1rkv4XZ/GvZ8i9IFco8aZP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(83380400001)(186003)(4744005)(2906002)(2616005)(86362001)(36756003)(38100700002)(6486002)(316002)(41300700001)(6666004)(6506007)(5660300002)(107886003)(8676002)(8936002)(478600001)(66556008)(66476007)(6916009)(66946007)(4326008)(6512007)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mA8IsUJF7AzoeVRlY//isb/o7Utbu/vYTS4MjJZmtxj96jW3PQxuZ1yZzL4L?=
 =?us-ascii?Q?/3bshhPd+T4kxspHkZTst2U/mXwY958lPqBLT8IyjX7XszgVTY42bIpRZ+pB?=
 =?us-ascii?Q?ZWjJI8CHmF5N3YDpowB2QI3ECPscs8m+kc7LKatw6ptnbF1UshHwRNE21gUi?=
 =?us-ascii?Q?uWzRe0yrWgz8cQlyM+lcYF3AwWqBCYbzrbFL5cr0QxS66ME/7/j1B8st7TRN?=
 =?us-ascii?Q?vSALYnoC+O98ouzBIW5sNXru6yg7TQFnKtZ4vkvg6IcPPN4tvkUmKh73Yvge?=
 =?us-ascii?Q?1RgTH9kiHV3xUSkOxLmhXWoDKErwU+iF9ZJYCoD3HEjIxgSnhgLvd7AXjRt1?=
 =?us-ascii?Q?EUpiurQNEP3HRETW6xLpyaIeSy3TBpiZ5j3BZHta7QdwlcKXghApT+xoRnZR?=
 =?us-ascii?Q?BuycAqkLoZSSbYeB0HYG8kea/bX5b6PYv+dHKy+nGpl5BqIIeb09rPJnDvZc?=
 =?us-ascii?Q?ZQgTGF3nkyUo2lz+7/PbZK8gozYgWgZLRNEqqxA0RoixvKgdaLs/i58fkjPd?=
 =?us-ascii?Q?dMU8YW8eEMPYcxl9Ved7pyBYQXKRJvfOjXZ3LqjpBYu/7Z1Ts1/lQ76z5Pud?=
 =?us-ascii?Q?YZ13KlX9GJo8NKucwonfF2sZkzTM9EPezNQSDbPUmqMLpcWDxMbgc7LM9dr8?=
 =?us-ascii?Q?F+L3sszzrHRtUGZSDC0dN8jccZxDSIZYuTOOxPQQujnoo+B7WoMu+itvuckZ?=
 =?us-ascii?Q?wtjvKr1PFzmOgi9Sy67waJdzQgLEFm/oUWkZ7H+FRKkDD8ShvGLDMpK0wHtD?=
 =?us-ascii?Q?qgIBA1zIAvxr4aC42BzMQmz4XINkE/Ccc0VOw3VvrgjHyO0lPVnREt9TERE5?=
 =?us-ascii?Q?saU5yyK0wInqg9J51zs8Rhnm50PBqs1cZKBvqKYNUrpec0FRvRKHl0/VdY4Z?=
 =?us-ascii?Q?pzX2//uZ2jxYmEJ0qJf4pE6m3ZUc2ZNGJ3WT4KDgkhHiaQ7QJplmr1SoIgmp?=
 =?us-ascii?Q?9tssx2+o6YwgHDv9fr4DmjrLLlIGXcwpwH/eCkhifxcW5QRvwnITC9eCLyaD?=
 =?us-ascii?Q?UsDoJhL6HCK5o3Vzhk5jfdv2BsTiJYytImqfWIohGVl1vareOogAfELaCt+l?=
 =?us-ascii?Q?zfhkdtiKYUZSQSKRbr1+8qMmY6q2C4SnYSlvlhAQgdko2iX4FEmv4tSgrHmI?=
 =?us-ascii?Q?EZbl5CzcBOdQ+eKHPtB42KkvYFqADKLu60Q9y3huOjKFJ8uJ2JTToIR3gwKo?=
 =?us-ascii?Q?Uig9fgRIQys3fJ0Nc41rpJRolTgSLBmpNEpC3vNcHdEqEYXGo6H5BikxOQUY?=
 =?us-ascii?Q?WyK4B237f1gdmw1qdEXFVbz0H/3Pag6A6KBxfRC84DFdWcztGi/RVEnIAv0s?=
 =?us-ascii?Q?Wl0mqNfycHVzwaFYpuW3LGHKP+obKT4JSAJfCLmBjMd1w+g/CR1e+WMyaAD5?=
 =?us-ascii?Q?0hEW/6RnKvIZ4RLTBjCmAqiBsN+ZgbW38Zg35HuTap4MaqbgU+Edg8PsXSjK?=
 =?us-ascii?Q?fbeaP44zCcwN8GvP2BJ7hn5yDvC6WKkBjTgdLA2HX45u7nDsCK04YurvhBTL?=
 =?us-ascii?Q?XIUyyk+UnIloINgQyfmmPnRF8EJx7jkvVwwIW2WPRBS6CZRLFOtKv4rJG1fx?=
 =?us-ascii?Q?/Xp7Wn3XReClkjowAVgNUVVXF6NFLdGUXLSgg3BL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f2eac7-b1dc-4682-7150-08db666cd023
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:02:53.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmodEqUdIRUrOaLMigz+BRJq/A8gieZExXqRRY+f6G8Gy0Ohy15n3RgA4jri49aOhBpYmZhvLHdI/79wGnL4jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998

Add write accesses for all flags of struct mptcp_subflow_context between
map_csum_len and data_avail in .btf_struct_access. The stale flag will
be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ddcd803227d0..19872e587a53 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,6 +51,9 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetofend(struct mptcp_subflow_context, map_csum_len):
+		end = offsetof(struct mptcp_subflow_context, data_avail);
+		break;
 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
-- 
2.35.3

