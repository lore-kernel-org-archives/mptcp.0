Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4047B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQSCSJTwCXq7Up05aZFUX0j5kw0nh86S1pr8FPT6p5h67odtmKqX8m9p+oDleQLXcHlfFzwmxM+ExCpv1tln9QLPpoMeRjK8yfC9u7gIoa8HBOAUOdYwmwyyf6CiKu/HSv8KIYTX0WyLY9s1OUohJEpR1dhj4oX8VMJm/f7sBi5AXZROzWbY1TgJQ1xYbN8w1jJ0+U4tUtN4IghvlXtbhRGi4NtVkKLIXo7fjY2yFbGO1d4ksaC9RD+M7IBn25qBN+35yNi4Ox3TgfUP95AQEGGnupYgWVlIwfwlWwNJeQQfMuJDVEleDOuQIIpwawHYToMdVaz+C6e5CNqKzpH7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=E7VNsBwuA1GJWyQY1VvGs+mlZGGXmbC9L3WyZdMVn5d5lAz4Ueehijclspx16LVeZmEFYO5XcxQed3vSjk7pJ/4W5/BOoCjdlDzWnVfMZHK/7mxWGyeusbNeU9ghbT44N8Uv0EuSfCKSHUcKVyxfpGJRgJSYNAQNnLEgofarIW7bOXzRU1eKzZk8pWADxvqw65y2+ZeIJIFGafjPtgUmIcPOZyMasLKxOPvAxcPDLmWP8f/XTspyaQTblOeHyMazoXFOV+4GvRIMMUgX1E9MbvhN9fewRwq42Gskvz/tPwg2x28ey/IKSD7mJvf0Sl87Iivd3rVfulJL3ZuHlQdQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=RJ+Zmrfqc4rn8it8BXZJivbT6f6V6SRhWgf2iWVQiQEbTVsRPur7cLDtt1cGIfCVCcw5IbUsQzuaexKtbrukI6sEkL29pu66cIltsxLW3XPPeunCh1G8/MEvUAsByjk7Kihf5MdyifgpKCZQKLB2OBPDL0nm/6CB8uniJcKfT1W9DBVhvzkhaYnx2DmNAgzH3CjXFaMlzW1Db9Xhp52NiY1PBf0V8F6atp85dMAAecPGmGIjxlx1oatOIkft3mWOJv+mO8O6D2lHz6kPNNrYib6WB85rxaE31F0THH85f2qVgUhJ5W8o0EZcmw18lyBPirlRA8zKEQnaoAtZBeHz4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 09/15] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Wed, 26 Oct 2022 16:04:18 +0800
Message-Id: <9cdf3c612592f40bc5d3f2870f1a5573408fddbb.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5a0ff9-7f1d-4fe5-9b26-08dab728f162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lOaV9xDfjZtOzNWHJF4MdlfylaxPWUVKIRbilbloqCO2ZgC6zCB1xgPn6bIGGWabY1gKIio1r+X87ttkMDdoE+OE+a3uRqikugYJdmEBSUpj75FV+Jv2qdKWoaDuRy+hu2LqEzfA6Y1MEFaLtmdlpOQc36shlzaElZ9nUuVGX4M+pAPhgZRRbpXce+5j0V/4KnwY0fYGnRkIxqJF69l6e3nAXm4OdKPQ07YoNw3RoSnWAGMP0mHNlgulVLzeh9A8qVj44TUwMjaaJDdzhXXXsSIvZIO7VcPy3oietJCkkuQ0a5DqA0dDs7CNSi0fbcXEV0MQcCUbsEWhiwyWR7v+99qI14tzkPLAOOCOiv9HnpRjtqWZv0Dw1UfHvV7KRxxBsf7hdC+/jLsMNXi/WBeswAqQ5IqBsojp+xSMhCrKXn3GwqgVqtIvsNsKwpr+O2Jby2TtFIPOjXlJLecobX1mv03FHwSaQ4k8YQl3u3x2IY5DxG5XpSrJh/sBgouvkXbWl7vEztIzmrtLxcEpMr7rOh27YxwtoDyboojN1wl5SsY+00gnlhI3xrB0MvRRXCH3I1XHpgFe2qIjQBS9xUVvFkPdAFSfEkndgGS7cjoE0NIDhp7ULbYRrOQx8WASz8YOsPf3xNw0aVwLOFrIbW/uw0k2zCgWgZauJIn1m2Y8bd5UhjibbDijm2F3yt54P/uyneJcvk3jWdFfchPAvhJyK3sQ401wnZ7ai9HYv2xjOR6V3fegDOXU9btR2D/x3JiM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0e1EYj9AAFlGIFk0Vm2ZLPKOtoCVoIXFnM7STW4y/NZDQm7hLmI+c3vWl4j?=
 =?us-ascii?Q?5l9xIdUdp6VSV0XiWSwMUJ9aBK7PtzLUBTUmKTOEW3amJL7JrAfEYC0nfJLR?=
 =?us-ascii?Q?bz+kYPMV9sVhv9wozDi6njGNrJjqLLj8Pcf8JwQc4LRwqm0t5cqGZnxTDezJ?=
 =?us-ascii?Q?mGMPXb82tpcze7PaneYGOPpIE7e1Ymp+CvtMtLZ+ceOYWbT890+WHAEttbai?=
 =?us-ascii?Q?T1Jl1u1MOGNtGaf4CIQFF9Z9eIC4CLhcnoTmv1WTDp4XknSGV1L+B3UiddZ/?=
 =?us-ascii?Q?Cd5CvrjUw89TKLHg27MHjpWTVT3fwxsKn9rFq+jIEz/y4ybEmHOAFQhSFcIi?=
 =?us-ascii?Q?CmLVLUw7OLPYlfN1AqEa0NWmw0P8edntDyudDT2ysaV65l7/QFxwTK1e/h2x?=
 =?us-ascii?Q?B1LC4Fw4BvFyY5YGNUC5ZRV2E2+K7FNWDAOEIGxuo1IF5sjVyekxoWJ17woI?=
 =?us-ascii?Q?rs48o37TuDgoDaV5DJwzGuisSOFcTivp0QawBYvS6z1DhazIA0nuAndgn+Cc?=
 =?us-ascii?Q?ads0D8mrtgSqZ7GTuWa/AkvqpK8u4Fi94WvupFBwChvjyFr7K8vyAzszdSlD?=
 =?us-ascii?Q?TaZ9i2V2JNyWewSFN9+KLwPe9DKgX3pJQAUR+6KJfNT/o/EkDXu2xKAKOUWk?=
 =?us-ascii?Q?FZFa8IrbdeHVc3a4N2sq9c5s7/aylkMFZIGW7x9vmbq/wFMdzcH6u5Ab21m8?=
 =?us-ascii?Q?PEPFDaE7/K87A/9Jeu9vnmubOIGx28WYG3YjCyoDPV5i/vf8OjenURrywZyT?=
 =?us-ascii?Q?j8HEvvjqEhZGMYR3aoLKjWPQpkOsTTRDw+g8tqV5BT+aMQC5rXTt5LBByDEe?=
 =?us-ascii?Q?5OWfiHjSGfij0T9thgWy4g6uVctBfsLR+F8h36f5BIdV5FEUtk/nRf1uO+RV?=
 =?us-ascii?Q?2vZTC/dRSj4AhuvlWeTky93ezDMrwpuIOkQ/2Ld0NqleoM9wqCmNzt8fRrm5?=
 =?us-ascii?Q?YjeJhntAuQwPBKRMb+v8kTYqzUzSC+LO9nbTORSqkwdsdd/Nrf0RSfxZf2qb?=
 =?us-ascii?Q?c/mAbgudAhao+4V5QmCUInPTJqbTM5dnQAb38dLPyp2UMnFyEdkqwYgVx57k?=
 =?us-ascii?Q?JVonWrukyd2KD2wcmFZjomr6DVN5vbv0Xqmzn3UCIFf5vrDRaszPZyesPZdb?=
 =?us-ascii?Q?SeH8EU1GXxu1C7NVfE3R/15sbXyXW0KM8+c4D9B/0lTRgAkPKcwTxAS0UBUj?=
 =?us-ascii?Q?kMLMGSRoAVREuea+twns5c7rLigc52bM2yQy9ACy5lS8ZQpH0O140P/xhjpY?=
 =?us-ascii?Q?tHTWjB0f1vMrPgyVFRGiGvEyChXrM9MoC3iLi3UbD/F2GPqveBEuUJyLLNmf?=
 =?us-ascii?Q?2dED+Fnx4qC+VtmA8kQuiQMNGtRAnUMNuMdNFJEoPVPi7aXyZqWEdlyE8nTE?=
 =?us-ascii?Q?llCTDDXW2pOFJEWQP2c7peohOcM+Px3hQ9HBOS0wP6p8KGmt2Hf7bO+eaWbK?=
 =?us-ascii?Q?JVxgmbz99woBgBigWKXdaOKZyl9WNLigNVHM0CRO7ItQf5j4/IW7uqWvVWdi?=
 =?us-ascii?Q?5lmDZwM7/8jqRlgBl+ZSm2NJDHAxLnRv/9pp7yXFJcMhsQJkIA59uA63yj6a?=
 =?us-ascii?Q?yu6MYY1UG16AAf/2KIbKbsKNZY3HCP/OsmjBSujWsdZyfQhtkvjK+gSrTISF?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5a0ff9-7f1d-4fe5-9b26-08dab728f162
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:10.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpiShOzeVtd8fmi2+2XjZngUufFQAAtMsdb4py30RRsTqUpM90sTOe1iZATkKW8Zxm6WOqM67u0Z6ni6nRnBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..e101428e5906 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

