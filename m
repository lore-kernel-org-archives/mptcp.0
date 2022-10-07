Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF48468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpxDuZLRCIM4pCRbkdG3fntKmW3lq9djfqynRCkwr0CjPb3v0GcJNSUU2vAGWJpoMNSyRIqxoNk5/ROn9NtjIaVgwvoYTeMsqxsLGVrJOuUhCp10Z8/AFXtXxehN7ba36xOZgPHh0A/Nn1wPK9sMUkh+TKiNIK1EBS7h1I3Sy/gNk1QlSUeq6y9jp4jgsSEXDqEFAb+HsmekLoucBHNXXsuaLwvuD9Vk7MQZcQDS3vfmht9Uuz0zECqlyqFvwE6gft7Aw53SkhdgbNbZ3J+2ihw1wINoVUjcgbW8P55I82M9ZJm2SGK7Hb4QUhu+D08izqJZCaHgIsshCbymGnP0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30U1osd3bNjh6lpo4MPEY/Z2QOyeQNh0RWxy1ieaTQc=;
 b=aWLqbIZavupLKFdN5SspeuWbowXBR+nvl7IuXxKeCO4dhLPPxcGRTgE1UoDRjPAF2WkzWekx+rfLnJbBkGdPhy0Rz+RUKgi9qrzefYKicX7q6pPS0kAZAMNIG2bx14eUuQg0G4v7bAjrzrGi14Fu9CWSFScgJRPldfa1jFyBkgE0ovGkIa5FvJQ3PyLM3AclyYloptR0mpz/RKIiSfsJS3qygnm0Tz30rFT13EyKqZLNaYxZhSTJ4IYjmYmTz7KUXdg9GySWekg5tyYfxwBvon7DqCIEZrEYA7RJDrsiky8fQ0QtRUg1UORCICHJNdjePG9DbgPQprEa9J0zJ35Oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30U1osd3bNjh6lpo4MPEY/Z2QOyeQNh0RWxy1ieaTQc=;
 b=sNwDOYT6rfXpmMZ56DkdDL8wSD3R5gn8Ho1mBpTcEzlwLoMcywDiixA3VAD5iZKqH5YrQYnjOB/3RiHKu8M7osw9qcamvzggrFlPnxrx0FndBlxn+fRiQisLOH7E/Nz4MEBx62RRYbL2elWLWOLzQxGnh3smTdNMKhnu6xzy0jMLPeA/R++EToosHLPm2XEfU0t71i42CI7pcRv/VAuEot2TLHamUl3naWC3FgtNn/pNIzFC4U9lIQ/l3zIvBN6p4hLsCnUwRShNJH7iBuWo7Se9tVubU8h+/UTmaXcFpp6Z7q9bvWRjwJB4UYsbJ7acMbwhSvRPgq2rx3vZl5rJ6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/10] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri,  7 Oct 2022 23:02:30 +0800
Message-Id: <6a221174bc73a6ef0488dc2096f5ad92d3433e51.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a5adbf-91e4-4a7a-1a98-08daa874f71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i4rVTKgunWQnL+W8wD+RpBtx+FsfH2S8fdQ+BaBBk2YSZzUvsq0WTt+5Qd8cfNtiBAWjWlMqT0+95hlNm4zgOHDlWflXqsQCF3nFZ7eqT1iL+w6P82buOAQ4ila7ACDuxkTPxB84rUrMnRrV215NzAzqcUs98D5N8oaWTR5f8udRGf/ovtqbJf1WTued8K9KH5+5kIa5OIpWvoYSePIPfU9tlSrUAqaBar34OQIBJxFQiodWTMsSMiZk5QCcldBRVboD2vMRAppEhWDNJFo0TAFBSN2tvYXlGoBa31yU60vB3tcouwskQT90/SLJMfIZ/tk2WcusHlmEIM8ritqgI/oW7BbsEFgeDBHmjclLaOLkEtJwQJSSozudeXL5LhtrtsSbCvMSPCpfOWkXn4CqPVVvRvyMf18HUecokytammtCMmYkHwg05e8exxXz77e64R4ttN5nSdv8w3j9sOXfePYvIu+GnUIcR2QzUK2XAVKQeUyj4cXxQV/R7rqvidmwoh/jqpQ8HS1PqVq0LJLsLl4CdOs1KiI8k8rBmfLgC//zEPLTuo9HgkhPq0S1EPsbITp/P8RagxopCNzQirtH/YY2GKUyHz1Xvz/vXuVQEZ5mlzasRpDrGxxC8RFJc4IznCF8NwQX3946DQc7Lq9X/sTattvmM2G+ZwL6oux2q5e9qMCknkFMeNNHWunkU0pUgPiRSFfyyeJniuDla5zhIcTA65Zo6peyIUY8K6K46D9UOKet3Tu4O6dgtRJSXB7o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPlgEcM2ZiNWU4xcPaiIfKvNAuyKsSoJKySP9Av0qx3vaT1teu8KWxWxyy0+?=
 =?us-ascii?Q?0ekmhknej0LAhjN/saquTG1qvqYuVF+kcVjdlGp4k9IRQnK9tT7BoXrKHt0s?=
 =?us-ascii?Q?hyX/yFFIUKvNifsmIxNR/yCs/wNuy3rKZ38xOFHCwBF74XlA1hO1xqmh8Lv4?=
 =?us-ascii?Q?IbmXE06AyjLqosb69T1fjb5xe4JW3WqYKTtP9m0CooDby6m5LdISw326Yif4?=
 =?us-ascii?Q?USTfCn2kRsV0VFId3n/Shso9nxEAeVRklyBqjG0lEB34gos5UxdBLlVP2sOr?=
 =?us-ascii?Q?siz462/qW/KtbpaQRwy16AQ20s4ncKPqwpSgGYV5qwr7Z91Jpn/XwZAjogLc?=
 =?us-ascii?Q?QBYM0xlD4vf7m3sPceE9LA1VIfUxZkrptUj5QAlx0o5QfPnmM93keSuzdTDh?=
 =?us-ascii?Q?fQE7D5Y2YRt2y0vNKWQ1OIzEGnmOEu8kjEGrufoAoO77/PklHRxQXtTNvxWn?=
 =?us-ascii?Q?9mZjgrCAvA0mlWNLk6MSDayUOzTtovCv4t/VG2r7F8aWGHZB8SHr6xhFzyXY?=
 =?us-ascii?Q?xGIxWxk473f3tgj/OXhBfzdos30M2l/oK8NOM2e/o5pUa4xhfNT5pfsbtiP5?=
 =?us-ascii?Q?XHrkxeMdjWMpkOFgncR45jpAHqKiflWbg28cfurTB23LEudZVXvJC0DbkJNf?=
 =?us-ascii?Q?q0XS3ATZfEiST36RYvLuQ+r8TXajJs+QhAhvfrY4DPh0dhYr9S4PQrrkmXk8?=
 =?us-ascii?Q?N0fJbZz+DMpTXRvw/k0vh7CVv8t0BipcLb3JaENSBMyufD2CtfoF/3utirL3?=
 =?us-ascii?Q?tXcpuvbHOI/PMOi7rBFUUbRCdyHDMbNSFpnKU7KfWeowmcheWSwJ0bIURpHv?=
 =?us-ascii?Q?374RPXz6NScZiM1hB/Z/BJM5VuPMXOheNA5JnpcTCfWLFaE1dEBbirrY0HZQ?=
 =?us-ascii?Q?XRiLL0TjFjZQoWh5ICPsyfLtcKLnkn3njjh25LdJ7QDOxHdhWOhR/9uK10ua?=
 =?us-ascii?Q?bXYh7cfJuaN3Z1npdW2FqpDzh/6JeuU2bBtDucYGNkDtnb/qgQJctCmRfQ5N?=
 =?us-ascii?Q?sIALtFrN47UpcKZpncgMYTxfyPA9RJW+oS/1mJdnQMUY/XtSjGyzxBcn32le?=
 =?us-ascii?Q?e/cwk1be73qhiiGDsWnrA0vuuE37mo3CSj+hRysIMRFYmStaiklJDM0jbcZP?=
 =?us-ascii?Q?rdMJs1Wdyd133KyriiTwLpIs1B7qIg7DN8FVBhOutgzqH547dQXMrHSdqmff?=
 =?us-ascii?Q?GpZNlCH8f564JJBN9eWnSbZNzGu4XTHiJyyggEB4WnKrxDmysS/Bxkh+OfQA?=
 =?us-ascii?Q?ZWLg6d23mO/zCPvi1NHKJ+ToC85yBJw5d4JAalEvcnDlKbVznvSJ8Zp4/Cbx?=
 =?us-ascii?Q?7PpMKPxaCXJrqSwMFPZRx/LFxfjB6OpefA0i0t/HsY69AQun6/RPDKBlIER8?=
 =?us-ascii?Q?IYnW8nOfo/UYpYM0+Yit+TPpQKfxQrhBBwy5WSTB3VddUCA3oIxoNIu7CHI8?=
 =?us-ascii?Q?YaIO0sNRNxV/4o4d3qvJtxXpNUIU7sD0hTUHsZBGQYED0tXKEZQXI5NuB38z?=
 =?us-ascii?Q?+U9Jjp7S3sm7vkxO78F8TvNCDLGqfU8T7xNt9mVH6gQQ2j4evlYnu0i17/LX?=
 =?us-ascii?Q?Ma7g2XE+mQGESrdIshwLswXp6Ci8m/URAAzjcBEDNj4yYbLvUhUE2mQRsal/?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a5adbf-91e4-4a7a-1a98-08daa874f71a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:34.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UHcoW9LJQTup5DxQdLIKFnKi/aYvDI3TQmui9gdyn8qvEdBAgTAZbbk3QcNh/m4vBd7dOBaYhrNgcqtOpauSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..701cc31359d3 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -240,6 +240,7 @@ struct mptcp_subflow_context {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	int	snd_burst;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
@@ -249,8 +250,10 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -265,5 +268,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

