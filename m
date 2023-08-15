Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96318B0F
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU2ZFBnH3fJirlCNeF+G7UPt/kYnDd82Ey/jGqzBei609zNyYKrmy6Eu9igMNvMIFoNjmBC2oJ+r3VgcUty8JUI0JsaUKFVeSmqV/qlWROkWZwcA8grtRT17ZOWOYCQnOY4J3C6GVyib3kAczZxxN8yaoPjnc49WSStsw8x+DGGdCneFpkygVNWsuD7k8kSz43SRZVR1p26v1wSmXZqRd6k/HFR8x9BRLuIm94SMbN4IcO1K2vTtTDGYfKl+IpwostbusUwdUDNGl0PQYwJz/DRvtLTivYWgYH9Z8N/ozB4a8v1VAAU19poV5Uh1PqGQsblNOeAjqN9sBnTQTd377g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPMM7tCV+kO2nKhrTMllqEDLVrVmUtR+hCkg6hkRlXo=;
 b=m/4gmHMJ9ChOfyciEAMgii3ad+15A6wGwIVdzUwVwqAH1kTmCq/7uZyZnOhjOeME9Ig02yyk5yE/mQkl1eVkT0///bMhYkNcRDsTLSlqJeX+R/40t7Ix31aAtkYI+2RTqrlMW0xYpc9bifW5c76dumCpyfnC60L9abgSS+qwBN7S6Sr/IMlH91H2po7EGU9Vk22W3xG2JHtUU93HeKmjLwl/c+oRkqdQp5Lc2TR+dLV5DGQXpIid5JmkLEsrwSQUwNo0HTYcr02eCgVHayl7Y0Ir9SboeymJUBWQwhMgOrY1BnK2v7IKspLE3Ee3Ph1/tT5RkuMaK1jJ8QY9XYnKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPMM7tCV+kO2nKhrTMllqEDLVrVmUtR+hCkg6hkRlXo=;
 b=5I7cvEehlt1UMGtdFJqYAhny0olCP4H3iExDemRS/bqD0wKfvIySkFwPOgFnSGVigNvLOhAfez29o79qFYNbwrED+NwJUWmyibsvB/rejxyt5BYyc31+3wWNDGAUFgeHyxxEr28nJxFr9XLNwva1PasDXcPe4Tjf//iFYBF/vS7exi4ydwTUv5/iE5eqWNsrThl9e7kMl5tsI5bban0XaAOMf7QfkVUFx3n5haJim4zSjH1VvCQSK6ZuxorSeOUpkOHQyH8maAvZMXIgBDwXmna+KR6guPj+iHsdDnYz4Vw1lRijnTd4TDpmoanDG+lRzYMKT71621aemd8jVqdBFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:30:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:30:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 8/9] Squash to "selftests/bpf: Add bpf_red scheduler"
Date: Tue, 15 Aug 2023 14:29:28 +0800
Message-Id: <9c9b72701b399baa03ada1781eef64411245fd8e.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
References: <cover.1692080803.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d1e931-e374-4fe2-5a75-08db9d592a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jIS8H/tEWz4rdNZIUMR+4V6pVgPxV17xzV7qkw2CkMDZzi798qiRvlXEYCEeOx/PhUg6e+XAnEDqEalrgxYw1/UMg1YtJ6VjdKCgz8auip9H9E61lbOapggSyNAkBNjU74rMclL3Og/OJ+Z/dqs+dfL8I67ppykLIIVwIcHUyBZ0vGOSkrxm0UUTnBiT7SnlTY6uTjYB7f8XbI59LV8qYamHL/Nx0qmwqq3owkxogWjDQe1E54RJQ9s/KPqGzv3cAVXbfXfWP/GsPbe2lnr1aE85RhsnEYpSJYArbJwrHXTKOBwvyy0nkReneTesKDJI39pZYzAzVaDFWoyEV3FsBY83v8J+ooiwemuOT/TrIpLgGQcUN/CEuUsDLVLyzSjCjYl9qyaOEqVOZC4tqYcQaDOGKw6kil9wzNaLRXyeiZg7JYB4KR62bTFU7GdYTQwCuOemsJAC1xOpU6kryqNnInqjrazgCyJz37Xoz24IyMWKHks1faYIVrwSut4aP/bRK8GY9sEfPedVLyIdYEncvIyDaIf4I2hj3CNVIYt4hc+nIXM68AL+GJP1vJVbk5MYECxStRSYr+e3cc+HuJX+odvpyHCCohynuOoRYaMAK34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799006)(26005)(107886003)(6512007)(2616005)(83380400001)(6506007)(41300700001)(66476007)(66556008)(66946007)(6916009)(2906002)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6666004)(6486002)(86362001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGi2BxJQosniSNkvSM/gl3b04W+//EhKhR8EXSlLcD70Dnsgp0y+lta3B5Oo?=
 =?us-ascii?Q?WL8QMJlVHgD0hxIcHMwxI7aJMm1G81HVJo/S3ADQexNlhuTY51/ZiM/wqLbY?=
 =?us-ascii?Q?fTRlCgiRr2VuIdOkdyARterCUMUy1gQ8zWRd2j2xv6C+OMTKtsvM4qF+fmhF?=
 =?us-ascii?Q?jvqwMO2dELysbuSRSuUbugqOgDOFMqVDuE3eO29xZ5JHr1Nbgb6fhPlrhpDW?=
 =?us-ascii?Q?12cGIAw5y7KKCrPcees/mZ8wT07Q0OJxoWrl/uivGQY9qZmcxBfbvTlFbwrc?=
 =?us-ascii?Q?kj1sXGJBFzvqWoiDn2X0y95UDo4+uks1zWBopPHVqfHIYLdUtVgCYWtG3Z07?=
 =?us-ascii?Q?mEwy2k/Wmsv8nKP1QN4f28zfNL4a3yPx2/LcJSAqvWcc+yup+Pi37Ifezraf?=
 =?us-ascii?Q?f3EgJOrhhaaKrlOalycWKeRbjqJSRXJKxtTc6gAXCnlxMPXyHnL66a2sZv0K?=
 =?us-ascii?Q?B/tSkBo++0gENu7PXm0pcOnMwh2HvCW77cPhUB6UOKvWEkHUZ5QeL9+0Wrxl?=
 =?us-ascii?Q?zXR8BgcAHrT4etqVgsgHlGo8ztPNMUpGPHXaqYmkJxkIjiuXrKyOzEREfsA0?=
 =?us-ascii?Q?/RZX4/bFbO8O6K9itIhH1G30jckVVjKxg/ZL7SU4E6o9EIIhIM3s5IHAjk+J?=
 =?us-ascii?Q?cC7CGJcry1HAJQmQAcQjBgsgdR5SCnWx7nlhADaLY1VocE49llJUpt4IarhQ?=
 =?us-ascii?Q?/8WBHFIuw6gUsnAmpPXK4ssjxJ8P5iZQtkDVV8vEbkDKFq4QYZ6nJhdVzvte?=
 =?us-ascii?Q?dNoSFRqk33vnFJo+/oV2gZfJBKu7ypq/GMkWz2o98F4IVG5/qhNrGA6GuovC?=
 =?us-ascii?Q?ku59cruTCfBvKfKPSoGGwzFrlzkpi0fHRYU7mzX7I2s3VV6b11xjHGfih+G2?=
 =?us-ascii?Q?/731RbB0bxxDmMxLuUzHmIg6vgbVABnjcIEvWGigtBvi9XVBGvWg+uXYoZwo?=
 =?us-ascii?Q?5KZIZ+mQFPy64PfVW9Sh69sBDT6NpRVkq/9lY6TPfF9NMOzpAFsRRuwfuz7k?=
 =?us-ascii?Q?Cn9GJxIH4Wcg0ZJWDeCYe6VZWd3yMyR0BfVW/XgV9CsH/Mcv68+wBSvH32ud?=
 =?us-ascii?Q?sMYy7EhYXJNAgOCnUeZT1eYHZj6inNmLAGXZCw0RE0Z5cFk7ytL9LnYLNu7l?=
 =?us-ascii?Q?hY4g6iwkNDmYgFMHbvnjNWJbbOIA0slPcv8ySK5O5WxN+ujzReBpHwZZyHEL?=
 =?us-ascii?Q?hhP66HjohG45pAkMywUCP2ZGwiWMOix6flwrViN3sdjRh5JRUOVR0W/+88Yh?=
 =?us-ascii?Q?mn1xE7mvV2p8FCC+51BTwwDhseCBHE2vrQgXVGdrwIuwKEU33vj2tBStmMq6?=
 =?us-ascii?Q?FUgwF77nswRYzI4tFGh9IL2+Lbuyk7mTv8NP4/tIv8887HBPAxQ4ht6g2fpW?=
 =?us-ascii?Q?4f2Gp4fOpwzb+OXCBtzfRcMklikuREyPYb8a0Shjlv5kXvaQrZzcY6RD+XjV?=
 =?us-ascii?Q?6+YJ4ScU/Yz4t9+mjZENVbC+o0anfNQZHU1sSvBjGfHJd+aMxvxvXjz3i3r6?=
 =?us-ascii?Q?5gpig3isoxKpEpwTnDXzz/57dyzIH33C5cTEb3I93hQ4fzBDVzGr0mHMTt/v?=
 =?us-ascii?Q?Wl72AF8vIXy9zvuZBsKLchRqax9FOMZvRQLwXlaY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d1e931-e374-4fe2-5a75-08db9d592a59
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:30:49.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr/Bik/3cNfMQ3iIBCq5jCsap5p1G3zFZ+eoY22KXzEk+aQcXUnAo4VmIi+cl3pMDcNRrxFS9dbrXQTGmjltiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

Drop data_init interface.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 576e4acd1fa0..eeeec6250f64 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -16,15 +16,11 @@ void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_red_data_init, struct mptcp_sock *msk,
-		    struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_red_get_subflow, struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
-}
 
-int BPF_STRUCT_OPS(bpf_red_get_subflow, struct mptcp_sock *msk,
-		   const struct mptcp_sched_data *data)
-{
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		if (!mptcp_subflow_ctx_by_pos(data, i))
 			break;
@@ -39,7 +35,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops red = {
 	.init		= (void *)mptcp_sched_red_init,
 	.release	= (void *)mptcp_sched_red_release,
-	.data_init	= (void *)bpf_red_data_init,
 	.get_subflow	= (void *)bpf_red_get_subflow,
 	.name		= "bpf_red",
 };
-- 
2.35.3

