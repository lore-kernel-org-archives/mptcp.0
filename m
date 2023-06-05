Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D165684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZgIVcvAIEd4guIbH/Ha4hJttlXBZK2LxQ8oXLWkPfcRpSs46yn+8OppaBiVBfhNXlrdloKy5HPn/AHDqUf3UVaVyyppsXjrXrGZo6DbZxURf9Xxgp2zg6HQfGyv0DMEaKEuMf2zgYC0sEaYXiV6SnXiSBYy2D4jy5KddToohOC4fASMoXzQ0zrvNJnrqvc6novTl/1qN2DDbToF5TM5OsMw+ildtvIniK3Sq2rJ4+EKlwUoKRYInx5km25D/lDvc1N3qW3ZMR+iR59OdKnDOPKbVvDyfULtabiBKDy2rvzsns1V/UXQM1mBnStbqm9mFWpKiWC0/G9VW4TuuAklyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS8c1EqXR3krYfxygTOEkOTHUBOuEaLcpjUYibQkHjA=;
 b=CHxTmxknNmVc+MJSyRMjeWMa6GmdQDn5WGvnxqNwG+LfoCu9vQvYYs30qn3c5UKaewSJEKwbg+la5lje/09OcqVHIPdVNgTItJ1IzvVvShAhmq3YBG8bFPq1MO791YlTFoM8E+qFkm612n95Gz4HwsWuqfO+GYFRgunA+dOYRJYSc2b16bKl841H5Kh2Ahd91qKeRQeaHecVa6bDwGiahB/NN0zP6MoO1SVjnsgC415WgqtqDuiVcM9nCX1CGhTDwf2iqe3kBVw31d3FAnWr7wY/7H5Cvhs7uQVkM4MmUWDVsmvYDwNrjDlq373/qh37z9ftNyh5BavPmWr07tb3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS8c1EqXR3krYfxygTOEkOTHUBOuEaLcpjUYibQkHjA=;
 b=UPa8iw3/3WhfvB/VBHYOFRw1FUVkKr4dFxLldpdlERc9kROY/a83zSTVy7HZf+OCz8yfyAMJi3yD7riMwUZJsTWpe3LDGPgVLNTvQTrz7OeuwtaEu1Dyr+V3iDBMUWke29cVnLk+9SewCcYrI8/vvSZxOAF7L13vaSmqTIvpYbU7GcAQUlFVUHI/62kE0aKNrzKdjtKC9SltZGvfr9o0GRRwiIrZrh0FqKUDEtXioNisQnz6laRtJi08DvfT+sn1yQfr+h1oXHsusQJvJ77OFpP5oV0W91VXZPuWKzRoNyJnQMm+z2eL1Zp5wSR/15Q4uaRfkFtegrJRu4xxl0lwXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 06/14] mptcp: register default scheduler
Date: Mon,  5 Jun 2023 18:04:01 +0800
Message-Id: <288dd136623517b207b1a315030bb51ecdd0a829.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4367e1fd-ad33-4184-79e3-08db65ac55fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q3R+CLvVFHBDRz4JrjV1WheNJjOkhsUCqiNTiCXAocneTklH/1MatY57uXLfSUAHo/jMKa1dcbpnD8K7BR5g4gCkUrPgrrUXYJx7/qDTFf4qv0ZGu8DTFNRoE2I/bEIgnSXmPSU1iFjRZBf4tbLz6r84bF9eR/RNni46laOAnEp0Z835iOHaCM6lrX16i0xIqLS8fk5nGcrYzn4LfZFMQryd+cvUHf50cbMybwvNeMxwdq0L9hGLE+wqrBoi54dTZ0cbLfpyW3x8LIoRufGs0mdnS9XweU/b3CmjkEpHEgt4jdIz2Nd8EbqUJYRrT5skOhoBZalOx645lU5rOf1i0g71GzDrlFgtDXUc34YWdsNBA9P3BRM2FiwxUPKZSbkRTHJBOPHA7u38vLlclfKQCAS2kbl3Ky04RrqZo/kmV8NfdfymmJfaugMDhjkCo7z1bk0qaJZdZ1UoXfSunL0v31K21TOWKxXDKtVaUE7taBJn69x1AuEaxtq8YZBozRpCqJ45aktVsA132znTEhRPFiPn+PVeugnWHFgo1fIdqC8EAJsv56vXnC/6WdhLnskM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WOwEQKK5liTQwq5eCmOj/wZ+zzYBpJumLOutnNbN4BGizqYNB3l2IyBseW7m?=
 =?us-ascii?Q?KedewksiIuIc7eZaEy7l3V8U93PjPv5yd/I6KZwXuBtqqYllSb3Z5BHsVU5n?=
 =?us-ascii?Q?7WzpYOxOlHpqDKv/onxRGXc+sij77UH9Nrs5zTXUErvTnjKzHnjy20zkaTWs?=
 =?us-ascii?Q?qXEo+oTn+5IKVV/JTp8DZ63CyewZ8V+noRgm3rQHNbVTtiyhn5BHcUrvReu3?=
 =?us-ascii?Q?I8WlHSxn3WL3rncM7sPJ0IwvlUdLyt4GPN5Iqjs3ed2okvg5UagQzi73ioCE?=
 =?us-ascii?Q?80nWB9IW94qEQHVgHZ4kRjXljLJZahwUX1QQ+k+P2f2a6xTcPRPWVC6b60AJ?=
 =?us-ascii?Q?87ujHx5ETTNWzbIu0dIjWZ1pS3RG4jKm1GWL428l0UOIzr0x7oGcc/fCKvX8?=
 =?us-ascii?Q?1uB6huU79oaiXLRhEed/KM1/R2ecfknr7zxSNV6cUqF+xTRlYF22aLJ8hFFs?=
 =?us-ascii?Q?w9aQu+X5vSyTV4+JszkcH46TI7FNLoO54gfWTKbrR+Adj9wY9GXlFCouFibu?=
 =?us-ascii?Q?MXT8l4vOQoMuIP++KfpQCofFaAXjqGAVMOhhveLWlI5hJfIsbKWPEUcqYqGZ?=
 =?us-ascii?Q?HxX1eTJXxoJAIw4RS+N2vIzAx9pPCwX2Oz6AlCP1ZW7LU6QbppyfXEZVqQNR?=
 =?us-ascii?Q?Ib1pRY+jRxExKZHW5pkxsXAkVv/TXA/uk7qSP25ibVoGQ97xQYboenmvF70u?=
 =?us-ascii?Q?MrLSBNsi51eQjI5ktLlGZo+QlC7Ii9IXGPQCaviJmKg1UrqmSEyPgxN348Z7?=
 =?us-ascii?Q?UcfOTbw7z/qavLcolD32uIq+T1stt0Hb2QL/JeZyXHnsPDY5J5StV1e/ta8y?=
 =?us-ascii?Q?mcQBPWbJqINsbXV44ROqc9wDXrqF2PReo3avihyAsafC+fO/JBeXrOUZuA59?=
 =?us-ascii?Q?vOyUFuH/b2FABCzs9FeuAnXuvSKTv9aeP6rigsla8GxjKGxVT/bhdzYcJXSL?=
 =?us-ascii?Q?rYiiDpFkC2yEqEHq4W8EjgJ20BKdUYT/DwSSyajwyCthk3wNO9LodrC5ONeH?=
 =?us-ascii?Q?wJp6zKxpI53OdMNLcLwnMfNy4zRIXZ7M3DfZ4i9nxtCvfXC/ZpRV/RhigMtu?=
 =?us-ascii?Q?Duoeu/+22edX+GGuRcaFsQuG0xJGEkrW22N0HNaiJqrtQ8undwWiADlHNWl+?=
 =?us-ascii?Q?g6iwtrxDJEqlKM8FGXpDxjnPT2k4+u8oO1L1awEq8+oPGuompFqhWHrOl2QC?=
 =?us-ascii?Q?GObAUhtIUsZaykoSLzCcaX98RVcnccwiON66p0cYrlsxJ3VAGJgrgPtc1Map?=
 =?us-ascii?Q?HvxOCUZ/I8nTlM9J3XWKvQ6GdDaUj/bnhW8wGu5VyWqrScT9qOxouXV3Av5P?=
 =?us-ascii?Q?LAO24UVS1mQ/idNofOjNRSgXbY2QY0LzhUmzLd6zINKc0qZBHWmibVOW2m8G?=
 =?us-ascii?Q?SCV0nOM0q9J1Gdsut1ObBfYJysw7rjT4NHULYBCO1DDDS+mpVgW+/MtN3DdI?=
 =?us-ascii?Q?qP2J6J8GN6bNuDmRHJacvl3H8h7uQ41C6aKsNgGwqv/CDVMkQlKL8wxfS0W5?=
 =?us-ascii?Q?gmgyw3Frl6xPhJkNomHvs5ju74IeATsMDwAeuVfUCpzMPZbhReeh1rdxlf1n?=
 =?us-ascii?Q?sohtz5zmulA1goL1+japW1XCAhBI5DZsyz8ZDFh/Vzy7G0XtPEbdrlhbq5NH?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4367e1fd-ad33-4184-79e3-08db65ac55fb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:05:05.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiFwDrlOZcFP+J+uA3vkCZcMzQZwVBsXqKnBZWwSbSdtc97agJtFcvAa/ejgvwwi9+umi92CqinwV+I7hHKpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/sched.c    | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27feabd92b3e..27407b48f3ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2284,7 +2284,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -4030,6 +4030,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4db0f8f00f4..12c8c95abf52 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -659,6 +659,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp);
@@ -669,7 +670,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a6210ec4ba5f..fdf2459a0fcc 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,33 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	data->snd_burst = 0;
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk, data);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow	= mptcp_sched_default_get_subflow,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,17 +77,25 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -77,7 +112,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

