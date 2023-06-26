Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EA7FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfdFx7BH7PC14WD4jZFhkdIWXILKV1McvGgiq4J6zuVJprouk+41ODJ5KUPVdmE1r7mqk/BgaI2CH6ILAX3uOLSZ0uZzJmvId5XO1XniSSeHpMWhviQ31PGF8a4tl3/DDEPqX4XeLl2djfjxfoqyaAQOOeJxUm82OPoO41bR7fB2kY/LFhkenzOzs35A605A47bAVoKwQp6rMuw04lsYF8pVM9/mL6ivCi9af2vnXrM0f9hzR0dFaRys0ufbTxyZKoDIQDx5MeBqDVNz6JZSXuzfoATWePNx63N7dpKmtc3/GpUU9NDk5b6CbzuUWHA8mvJsOlWbjMUww1UvQmUMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSiHiz/oArmjJUR4Du8FgT4+A/D6PR7hI2CcKcZRsRI=;
 b=I9owc45opf6AefS/UKRUIOrrLqGAmgSMSsePEuvNk5Bk3Kpn+kXW1lKE2QZ+OVjZi5OCdzaiGxWhlxaS0UIdmjPASk1kLBfYJVfFEUxL8JRFvlM7Mn20CmjZngffbDgKBQz1X0F6YBpqSSboxwOQo69ezBZkQUf0JeiDg23IdVYQd6YVRW4cZPbevr05L9R0/piPxkguqHWi2wwnYULtq/5cek9HMgTF1mxb+wEQx0qCZZNG6PDwtCtKhZgx4ZJNOAiu/Smx/OmkjVKl+FZyVuH289xZrKJ6i1iOhoGZ9DCYdRhmR79Pr4ElKsYaTvD4sAKsbL+1zNzw/jrS/W3zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSiHiz/oArmjJUR4Du8FgT4+A/D6PR7hI2CcKcZRsRI=;
 b=rcVwrAoiQlw8g0kfqdo6H8H/4exOYQ2PzE5LxG22ZeKqkCyV2Axytskp7mYGREEFSV6SDpUl8lpNCMKI0Vn4FlmTnkGg5v7duyquJpQZZH2WM/PrzPiJ1+IutjzwOyJCJKUOwyt7gx/eH4+0Cr2gGpoDiM+VEViqkQyLpgNxFMprPlRDjs6GrWkFs8KwcHtz+h3TE9VXxaa0P7PowFEGG7pBqJNJhZHTCr6WxZdmxYZ0vhgrotpN9b6JBa2D4iEet9/P+W4AwZU+nou5W+Up87TzsWlpIx7vzMSzPMvTur0rVJIFviifF+i3Cz89dg316pfr+w6L2RMgquW3sM/MOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 05/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon, 26 Jun 2023 10:23:06 +0800
Message-Id: <eb70552847fc2526a12abbdb001adb47deb381fc.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 360ee869-c5ef-47bd-6e8e-08db75ec5fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wv3mubGXlbr8XXbPcD35U5FnG46SV/xmr0tp3BSoWm71irGmLfeggtzjWwvkNjP3lDEqqeFiAPfvBMmkwTl0rCsEqwJqqI87fcyceIgP1bkl6dWE0jOadmLWAceprVl+pZu2/NBv+/8rK9gxctb4VzM7ru/4LGuD+/+/TbK5yS/aqpLtZt/LHeicZ8MfPZrqRiy5rIQ3ceeAe9ffDlfpoW/Ci1jcV0XQPtel7HHKI5Z1jX44UjjbFzo94R8HE9BxF91dxVArWHGBhTHVqrXzno4rr8a7TRLuOlBeRwm2GbxFfR73c5Msmy0qHTuHSNxAWs1ilXNrCvry1ifCtU/SQbYnmN8w5DlP8xSt+ALCOWOthL/AUxOGbEqzKB0Nf7Lm4HCWLyv6B36k+I0UBoF26V3SAV7UqCjVmu3oSixlfQPyZluspDq4Vsie2+K6l5a4cQtrNPKJSdi74gsQ/Awn0zSKhqdefOvgZb+J1DlcFydGJ/nAxshHGDp1QR7W1G+kduZnQ9UsCPnNpqeteon0AHlilm6mP8VIV1OhIZqPn/UtprJej9W44zowDVV9LoO2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffs7QbGJAFlQb5vF9p7iNcQaC+DUwYvwaYhVnXza5NTpqbeCgEcgW4OkwNjZ?=
 =?us-ascii?Q?mdlfn6jqrjlEt99e3tVVmRm85nGwH92CZO0lruBPJ8VCBUQYj6lWj7fJvAgz?=
 =?us-ascii?Q?5UCbNC9Skqt2SU3yyYG0/ur2IdCka9eq7hsvR31TE30QmMnFCEEccF9qBVzr?=
 =?us-ascii?Q?bgpPjR1IWQt4PKYL8/lv256bgt9Y7QwPLWwlCawtv2eQFDdnuaN+ABuGBnP1?=
 =?us-ascii?Q?8V2olN1fYOcbnezuLiEHmWc+20o6Amx6Ui6VKyJG7n6Jca8NEJsUz7t2+05B?=
 =?us-ascii?Q?CXJRmd4HzySbeuzEzdI4cCSKB2zAGDtKjDFsTwbmeSGIstoOuR9z25+FgXGh?=
 =?us-ascii?Q?vgCTXYz00nTHml0cKnweM7jX8V2rntZahuyM9IRw3aj0AXFa/ou2DhCtXE/d?=
 =?us-ascii?Q?xi/DcSQOvqxHG56A+L7atQ76D9lenNAnGu/zy1eicrFkdsBWOIU8SaUxauyK?=
 =?us-ascii?Q?X5PpAritUzOb4DjZGFTqEnjFnN0WgwLVavmSWYXxpUskj1k6JXCl0zmUN29p?=
 =?us-ascii?Q?evESuddULFNVh+beY7FRHJdOtGJtQqRF4etR0rpmI2jCRMK/1V2dWie2GBgV?=
 =?us-ascii?Q?8tkqaBPDTBMKmEXXJ3fjzOzsmf39M/HX1uMBjqpzuXZprd/aRNQRggctyDi2?=
 =?us-ascii?Q?2yOVy9sNLR+X9hS6zKvM0DfTm0Pm/jvmNluUAEYQOHerVOvinWHaVQZMd1NT?=
 =?us-ascii?Q?oLhOhLEGHdJyOCnVhYsbSmODqBImKQnoyRysJIRmLXhnQiQxvcvAtQ+o6O6b?=
 =?us-ascii?Q?VHEDPvVaT8ax7/dCDr4wwpuTBjDCGDX3lWG1phwhV3J3pXkN8GuyDZ/Fnfom?=
 =?us-ascii?Q?5gYKIpszUBdnVi0KPs1IdQvF8TGzOCPPKBZk7pDElUpNhAEwwXQUok2Yymvl?=
 =?us-ascii?Q?cAi7MTjy+iKhDuRZYWn9qBI7fX72GetxGC5YhktI+YBXsdc/LvSYH5GSSNQI?=
 =?us-ascii?Q?K279EY2NEiW4rjtBmiOclxTpAECC6UkVGwkwTsPDdVe0w76IT2xYUpDp1MmP?=
 =?us-ascii?Q?or9FdJYqLGibnobDNikv1mnNGIbcoB/SNuBO/aF9DgyWwQbG6UBN4JwAG9EG?=
 =?us-ascii?Q?164rDZke/xNErh5Vddyq/BSrx54oIyKgIAKMJTyXJ5w3ckWq99wBdwASgYNc?=
 =?us-ascii?Q?lEG6ydlHAhbmSQzyEWE5jUgPZX1WnXNdwnRhPyRtV18DOa+qdCpgOzoAIzLq?=
 =?us-ascii?Q?rk727SKAyNOs0JOScdbo/RtlcDEM5DMOayZ8ZiDNO9jOkGIg8bP4qpNVb6WC?=
 =?us-ascii?Q?Jfbr3oZy2oK9NLoSjk/lj+Qtxj3jEH95GKtQ9ZXxyEEtGxsoYJ4i+qkxG7DW?=
 =?us-ascii?Q?XMZoL3gaUDg5IQGh23f+gqQqQ6pdJix1w8Cq8t8XwIC0eMhReu3uGg5WzGR7?=
 =?us-ascii?Q?z5gqdNJ26Cwvi8+oEu/lYPSrAYaBfeLl0b+hFucpOLMW0mf9YZf7NgnECzdl?=
 =?us-ascii?Q?0T8qZgIxbvrrI/9iRzfyk4F06KfFWALB9BGMzwGwzNNU+sX5BwrdBSpirfui?=
 =?us-ascii?Q?2y4E5lrGORhOrG9ypKgN+O6JuafVlLh7LiSgqglEE5BNo7GRz2RxPVvWlPCg?=
 =?us-ascii?Q?Xqroe8dZFt6CVdUW/yqI7a9flz8feVaRy300mMcj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ee869-c5ef-47bd-6e8e-08db75ec5fc5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:48.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQH36iaTZWVUKB/AXstlFF/JA/KVtze3Lgq2rMMU9jv3YHJOR1VWYVA9wl0MWbajAvvvJtSIK/BNaZlfSdrVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context
in .btf_struct_access. They will be used in the bpf_burst selftests.

Add write accesses for all bit flags of struct mptcp_subflow_context
between map_csum_len and data_avail in .btf_struct_access. The stale
flag will be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..b9fbee8d7bac 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -50,6 +50,12 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetofend(struct mptcp_subflow_context, map_csum_len):
+		end = offsetof(struct mptcp_subflow_context, data_avail);
+		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
 	default:
 		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
 		return -EACCES;
-- 
2.35.3

