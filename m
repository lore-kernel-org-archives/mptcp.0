Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3A846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA1s/SVAgeC+ye6GGmFFDVp8OaT8oI6/KcB8DjBwHYnpd2oxIUHjWZdHcJkTh62lVoAh6H9hJLVvibKC+TPF6tW9kOocQCD2yH5VmjGp7NqCWR0yCpf5quEQ6BWqGhYZiqW3A2Udz+lElHr4xbBQJiVSVpARMNkHFXbqKVWRarLJMj9Xx/W7sPBZ9K3pEaXXvbMNO1qS6v9h8Fu3IokVS0OQdIbK1zoDdhE7rZKyHRlOZcglwo7s+Klx6T3rQC7AhgJOGQF0HiIFa1ascF4sLcff75CvqRfDmEC/8h8paxLzKbHaCtjYtnSRONIjYaOIWkby9iTHc6R1Ay2ecKRlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkFoZAs4XVeSkjDTbmMh44Rs/RxJUmQRPJQV+Yl9BRQ=;
 b=ITnSxAXiNAi26dwJOOL3uN5EMigIEtfWutBq+71dG2ZRrDIqNtq/pWDO7dUjzBd72l36zUOMywLsp7ucecCeqawCfGYjGekLsBEGGx4SwK+wbfLw4uxxEaMztjQEsOrXX41p6emOKGgeq+oaGVvRjDe4tRv5Kb0moHMPrrvKC3qKG7TaksNXj2OENKIQJCq0dxSNuyWW5v5iYDuyIf0WSBfBTXEn/OWsWrJRL5jZvX2gTZhA8sQphmR8EGPPejWPdrDvW6lVs7v8mq6Vi8S4Ae9jArFXr0rmG8nYgKqzB82OeNMDmGUT581h4SheFeeWn6lyVejJKE3PE6epJHpO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkFoZAs4XVeSkjDTbmMh44Rs/RxJUmQRPJQV+Yl9BRQ=;
 b=AzusgnF4KobsXpObKaiYcwRQtP9qMbgRUTCWu9tK9yErnBwKI1ildPZv1cWsQ7dLg+hZYhCaAxSrzEcau50UfblViQJyc7Ci7CWJoKQTQt+fDJUSWUg4fnByciXWD7DC627iOMkbScyVUv2s3wEMh7/M88l+ffUsKTJb9e1K3VZu7KjHIbtcq31zsEAiojIRaVzR6nDJUm6p3kuOCnjZHcw6eVDG+dnLJTyiWp379o4ZfYqmnbi8QsMOn94/VIVrG7+J+R3UgSru4EYSQgiW4To5gIt/jhp4BZeLB1zwvrgeKgg4Ba7rzGQ0w4BtcGepXsQTVACMcH4TC+mQWra5yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:27:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:27:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/6] Squash to "mptcp: add sched_data helpers"
Date: Thu,  3 Aug 2023 12:27:17 +0800
Message-Id: <c5fabbf0010db69bbe7ed2824a8285f9401df09c.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
References: <cover.1691036765.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0086.apcprd02.prod.outlook.com
 (2603:1096:4:90::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c165bd6-496e-4b55-9651-08db93d9f339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BTh00uz/O7ze6uUBVGE9QrTU5B90Xdlswb+CRbu0DnSWjso9wdLLUa/yrdw7/mSmhqY4230SUSdbnMF0lKam+2+Te4MHnV6TthI7euXh0kMOrMfXLum/VvISse5bOPwkpb5mQnXrouSbmeDgv8Hj3EMNi+pC7o8bUL9odpKWM8iX9ggw6TyNA13MTT+NooDsqW4WCIFDbTU45c/BChE3/DrGt+lPMeyoLT7Xx83b/oH7mDGt5/VK2tP2ne9bqnT0MGhZwloD1HLpSF9KSAfnMHVR5BW0rLUYpM6oBJJs64cvCHdt8WgTgs5d8PQdZcsRzpk5yvnEn8T0srWeqUIFu3JqzuRqUK+Ko4CzUm4f9VPk+dYwEriQ98gkE865pSLj+21/whZ3DrPRQGPybZwRGYiHfrhgp6Mc/NZzXm9/recORQUW7Dd37z9peo9fWuF1OqF+UhM85fvJwkTR8mPNBaFKxSbNemU89n9Y+OrZDcSdHw9dCc5Pn4qYNGhiMWOrKAIofbNW1jz0S7/vNN07sUivXdxHnHtn4LmK8c/XahOne/c3Gz42upZ3IEnjJRjw3jemahOx9ziUASPNpjho5oXlY+GLNKQV3IZaGk9rlmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFyMCzKVx2DvbgKDwGeZTqQelhhZo7Ly78GRTwJzExoQTvgRFeoP8cVZFMrO?=
 =?us-ascii?Q?Gl8yVIpYTZdaQ3NSqSW6r7CYYbemOzjjsKcLb09OebJ5JiwQ7x+zBkPYl125?=
 =?us-ascii?Q?jKUwwRxQ+kXZZbsX/raUuspNYOUqfoIUtFLU3Us6vY5BDRisqewToJGX13Ae?=
 =?us-ascii?Q?mx0br49AuFcbIFVHEsJZGrfZgZLAAiySvPsgwkSecBNpYqdAY2/B4FjvM+k4?=
 =?us-ascii?Q?mHi8H6d6hNqqQftXd05P4pMisrLyYxp6uF01Ljyr6SE6W+fRyiJxmRImiJfV?=
 =?us-ascii?Q?Ip89K3Q80KEbxXRw49+IPhvxGU6YaoUOhMYJYisp86bySKcM8PJ+vSsPKGXs?=
 =?us-ascii?Q?JIva8IvJBXjxg/I3qJ6+WZr/czk73naay4Q0tnbipYJNm5hGCon3krHWax2r?=
 =?us-ascii?Q?a+aexUqTs7BxGYpx6dktJgMW8/xP3Xysjq6lrHdpLAaP3gfaj+cPN3f5Qr7p?=
 =?us-ascii?Q?OHzpXsH7zO38gAal3wHX1Fu0TvKikXxy10+sGYjAGhiLTqpyUYHD4OU3vZwP?=
 =?us-ascii?Q?B9Tb6Feskdox0vU/d3WpS4sW4rHJkIVUeCBU8x1G+pUQQkz8jYpOKxBZ5Mr+?=
 =?us-ascii?Q?KhU6S6WXGdRlyvWNF7v9pt65jhyYBS9ZDJ232tvKfMgZ9tvj/TlNjfpA2Yr2?=
 =?us-ascii?Q?E7R3ehf2RspEZyS9CLGpg0rzrv2W5UMbuVgoF6ApA2nNKFogn11MH+AofwQn?=
 =?us-ascii?Q?vaQeLiKcke+Luov+91+TdmRVEv7vxooSaPk3sU1uNYIwAgNAixmmRciHPQZr?=
 =?us-ascii?Q?H5eK8Yh047Ms0DwdDvCcNP5oipuzvF+mMPGaW6wFo84bdXluQCAotOR27WFK?=
 =?us-ascii?Q?NA9QuMWpNDSfdwDFrmPH06yJP9o9zmxmcvi3AWpZvzoAuFoSzFZUziDBwMfP?=
 =?us-ascii?Q?VEyX73sjXhHvizA/e+6gwqsiXDRYagqMJSEAs2brgoyAeVMJRVopSciEBeIM?=
 =?us-ascii?Q?AfAlpZ3Soo8oiCosJTf4VDChAYMB0Vsac9gGxFGWij0A+VKgZcTisY6O6bV/?=
 =?us-ascii?Q?7p3ttuEpaWvI0nQCBhQwstFoJ5SKcrS2pnjbM5+FyQewP+wAHFW9YKIxEJq4?=
 =?us-ascii?Q?4XRJSSP/bFP+5SfqcM284B1K9QyMKVDZZfl7jt/jao/O+9f6mfC0T7CGtQvp?=
 =?us-ascii?Q?b53pyfNgJeBum45eloYLqAOlX3TvY3VJmK/PW4V3oUdUnIxKpab24vildqsx?=
 =?us-ascii?Q?OaCK5siw0AQeDkBtUEcUEa0BOHdULkusrTlXgY74aYj9FCrxe5SJf6dyEr19?=
 =?us-ascii?Q?OF441mtciifDzmOJxzWYfMjG3lvhM3+Z2Vvi7ixlBzfDJi4meuujbol0tQCf?=
 =?us-ascii?Q?SWiKdF7HXEv9KuEWbsxlcTG7Q6B52i/zydNEjId1F1vKfIzGV/9zs5O3M6EF?=
 =?us-ascii?Q?2Kj6p2X4sq3A+kOOLtfJovAH6RsPn0rx77kglM8M1TU88yA7mNCmAUEvMmYs?=
 =?us-ascii?Q?A2vqsaLEI9YsQVpdfCerFA4fBaQLfg4np1pLmS7MGSpgFpELFLrcl85lpuct?=
 =?us-ascii?Q?U+8eJsKUSbPYg/XcIhHG7Bopw+MxlMlk7WkQN3ZejcbffUwQqhSI0y3OaFBa?=
 =?us-ascii?Q?J/ROwtENCQFhq+jSzkQD7pyfCVeyK2MnFnYz8HAYEehicHpxKa2+pETUUTWH?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c165bd6-496e-4b55-9651-08db93d9f339
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:27:30.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2oD1K42x34jsr1M4cC3l1XHgOPrU9VtEDlILyrmem0996CmtGM8mpwDp056/hMBxuyXYi7QuBltzcPIYlFLDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Add "ignore -Wmissing-prototypes" for mptcp_sched_data_set_contexts()
and mptcp_subflow_ctx_by_pos(). Then the declarations of these functions
in protocol.h can be dropped.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 4 ----
 net/mptcp/sched.c    | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eb0dc1027bab..ba6a63e6d39c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -671,10 +671,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-				   struct mptcp_sched_data *data);
-struct mptcp_subflow_context *
-mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a80cf0481edf..5d78efc9c96c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,6 +127,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data)
 {
@@ -155,6 +159,8 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 	return data->contexts[pos];
 }
 
+__diag_pop();
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.35.3

