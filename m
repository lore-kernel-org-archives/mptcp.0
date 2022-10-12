Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE717CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPlxlc7EQR6its3WTUrGsjQ3wCoFhyDcZYQIvtpDRnFqL4g4lbggIAUuIfoL+UviuF6KGqagAqmVoRqSdFANc5gdz1y7awv2s9GrmMe7JApTLlqGVcNwnDFu6l5+s8O0j8QSCsRKwd3GtRw/r/+NRY5lUZ98hnm4q5P5IYPR2MOW0e7O6VBNqqmyMe/eSaWQcZqJSBWZwuUGgw918MCbs2IP9vL4ncdZ/LkDB7F/j4fFA8neAZC1e/1leRk1SOxBu+Dhp3BSg/EL8wVPFZQ7awjsR/7erHaikKHm4NSz/pWQ9EIXzKt9BDost65Z/IwpeHmshru6tTA17I1YGBu86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rQsyp0KkFid8EMt0GRM6bBdQFfudT207JfYQ8QLgt8=;
 b=P2HVEw8bq2Ng1qkMyu1/GtUEuiM2/qxltleWpwCSSGPiIvDzPBvcAJFLjrp+eqLMjmnSwlQRCv+d5K5Q9omlt+6BNU8cUWKY3pdSQTm418WpTeWCdnNq9HPCpyctM2lNw4jwl3tVTMI1m9za43pG8JkP7QCR1hGeR1QVJte8H7e7EJUtSCfa6lJSi3gVPfsAs08dYCXCdsIqs8F0PLIYElAOYCe/kA6zgAF6q2XvQOsUrmbT1w3F4Uyb/ECaiUkCgi2NsdChvtoOkdOxVCZpM+aQD9WoEtpu0jdVA1zSHLf0TMKPOU6MJkiGIhIwcIiFfxeFWsVwXmMHTr2y68lKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rQsyp0KkFid8EMt0GRM6bBdQFfudT207JfYQ8QLgt8=;
 b=dpQSuHIlzkv5vkXJyDpxEnMTsDTRUYS+hGdX2JrWjjP8JjMjbGNvy/B0odCNGX/up34c74UBbrvBsY/ONWmF8i4q6uDvr/p32yqCkBLy5lk+EFGXz9c008w2u6lkF5n3+lslURHdfmEUiC4P3nd7uJcxUjEblpBW2RR5ll/1aHa81PJtTXxiZK/LDp+k80gK+dy57N6pjK25bqOvUFmKDUAW8qiHraiJDsjwewIQY6mJTRP9MU9GNQnudFz8oB0LHTpbVwI59UxNu6PhZzLJ6lq7j3CpSJ70Uoz5wDWWZrwm3rzyzm7icO35Npek5gEwYotIB+Z1UETgqhMiQyaBmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:52:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:52:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 12/16] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed, 12 Oct 2022 12:50:33 +0800
Message-Id: <eeb382e261dfc177ba0c326a421e6c302025c213.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: c72f48b7-4620-4a1f-1c97-08daac0d81fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QVmBTfjB6wmjG1iBmuhR55pcCMoPi726kpqRg/XL2gLl8C6b8UVXK7gFIB70zjz0X56gnjBYsN6GITH0J0nIkUn74qi2+bTrN4NX6DjgS+WExxiENWiLStGrR7eK6FWpQtaEowQWsVWKslowWUUWd9uIfRyoTQQEVLoGF6Z7g1xZ+PFrkxse8EFeZAu6MVThyXig0Gpkb3uRjwlPccQtvzQ2H7dPTsIIJNxJlvojp5lklvvzWdkOhTgLMJzj2XUSHNkaQdv0GnjKm7DgbreKCU0lKROS171w5LlzvYuQ1NRYXh3uoODd5NJPK0/eCBcFEur3fqI61LU2W5t+zYsA5qgU0SVLVrmOqtw06/+Oyuam3Oz86YSN8c8GyqSnuGddTB1Desb00QYWYhg6T0OTatUkYMCgbXNC924vQBAKqNlgTHw5t5byF2NgzYvZhtzIDRAy9wlzE7PRV6Tk+ir0TIGhydsM9QjtS6bs1aNW1JKMA0qKm/v54EhhnRbW5p0licTFj87GcsLy12s/LiklJ6IY+Tyt7AIoBUnOASY71K3ChvMUSbID52NPu5MlpnBjfO5OOrIezH5Z+XmhviCFEkVwkueFq9VxMEp8ET1762JBP4PhHeZGYiX8DGbSwGC3UJZBmMzlI8Cc+t9IzL9bGWwiSzaxAZR0s95oeXp47qgOUJawRxdSPI11FKW0XR+iv6y75unpxwRco0ASlU2qOZAjfn1U+mzbifw/1xoGSHZH135MzMUoSvjrcgPiNY2o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E60z1F7MNTSx8moGQeLmC2Rpe5vDzLzG7tbai+O8hBobkUn6gn9tdP4rruo0?=
 =?us-ascii?Q?CcLuVdmkG3lLidKQZ6LL1jvbjxEuQnHbAOrb2IKrtAtPWetPC171as8Y9Wzo?=
 =?us-ascii?Q?KO+0fWLmXyBQBlXcnrxalIaogYndcFVPCsFOoPm6RvfZjo0//qretWxOKI21?=
 =?us-ascii?Q?SijwvhaMl+/UhdlkoVyWJMX2sglD1EicApG262+V95zxjFJSoRR1yqLEmjTW?=
 =?us-ascii?Q?jK5+1kfmUKbCM4Bd1gHL20EXssCoYYMXsMovdKpUtcNrhG9+qN0lHqgJPMEu?=
 =?us-ascii?Q?wIK5133/lQit5hcjP4H9sgNwJ5IjkriKWChr/Pgiw81ebzCltGbGR5Lj116f?=
 =?us-ascii?Q?+TpLxLUQ0+p86oXcu+CaIDpnqJQtiNB0xITmiusYFdRfVbtJsCKmPaOlr1vj?=
 =?us-ascii?Q?WjP7lULRcYVD+LwT9cZBxSbfZ+OmweGe8FqXnMcbQY7rF9z73PO9qs2iBeoL?=
 =?us-ascii?Q?v6TJprznhpBijeNjPsK0kXJWagFpFuTF1+gtVSgD+UYDojSjRsHBVJ1r+avr?=
 =?us-ascii?Q?LzBLKoHaBXneWvo708CWT6IiLmwIijAwpX5rmuNz/kKd6Bdmj0Pb0ovHd89C?=
 =?us-ascii?Q?fLQ/jYG9kqud9/3MruBj1p/06uB8k6BKEE6oGAvwYdORu/aYtgjrG/PjzAla?=
 =?us-ascii?Q?Z5q8nQVXmqX2xfgXZ1zuEBP4vzVgCpstRuL+eyPZox2FH+nohm3wwp3I4a6l?=
 =?us-ascii?Q?IUYT+cvFxaKTH5OV/8cBg7LebHRdvwTIfXuoAlzyNFHnL7+ehES42g3/Yx2t?=
 =?us-ascii?Q?jqc7wmHxwTe81faHILw+3S+clN2iC7v80h7cMxJEMrrUj0Pczvteg2Aax5Lj?=
 =?us-ascii?Q?gWGxTxpaDK7Ts42drNa1sM3pcNgzo6AIFiltJxirIsZ+p+TdqeXprAlWPVmm?=
 =?us-ascii?Q?mWNr7xDc3e9jvhU6eTkduMHZ7gwHP8ST58Z8Kf1nLRB71THM31RwWsQKSY5M?=
 =?us-ascii?Q?XbD7p0HxHxo9NvyBngTEqHWH3xHkBBUmAZ5Lfn2zzHTqY/0rhz8g+DoltXEw?=
 =?us-ascii?Q?cY5DYkXqmRbiWFwN6TdUoaLAe9DcPB3pL+RqjUv5aTnC5eYk2cFsPL+g8pC+?=
 =?us-ascii?Q?owlSucAFNcLvwp6TPtM9Ms2fV4/ufcelyOJSpObvAFZQBOOngAZ7Nzt8W5K2?=
 =?us-ascii?Q?SOXI7ytwtR6pM0IuWwsLO3oTGu3ctxTBNbst04JsnfUOhpG1ONLTFRHL0BsW?=
 =?us-ascii?Q?Nx5QObQkzYqkMpkiO6uX87HzZF3ddyKGR6G0YhMLy3KtG8LS0G6ONZJjq7tD?=
 =?us-ascii?Q?qgmz0Gpn1LgKEJUBy9stkmzHaOiH/PhJy+8JMZvfjHG4gcvM3Xc4uZW2cjlk?=
 =?us-ascii?Q?KNt4EujZLDaOeNVOPRmVfSHCJUp392Xf2tropzhQZQAFjKwH0tawyEwKoTXd?=
 =?us-ascii?Q?fKgEeDDLtDPeuIHEpnANIkqaQ6bxPNwoMGq6KU9Rw34Z/vwykpM61CmpTCEG?=
 =?us-ascii?Q?JjWwGJnwjvdiYwW/v4dYrax3kW8+H4sCTQweVLcklsBjK2goQBSLgSa/TUtj?=
 =?us-ascii?Q?B75YviuG1kJkD2rsxFdvcR7+Dp33RJPMD6ih+aZoqytXPbdMRWZgyt54eTrE?=
 =?us-ascii?Q?+fMWqoQuRSJjjEZ0CqNAqBl8Hdb7JkH5J3ddGy+sa4H+8Dnwpm+9HonDuWne?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72f48b7-4620-4a1f-1c97-08daac0d81fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:52:04.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6cm7pHIHUThM3npcbURywc/yaxe3B48cUFikCVboOeJK/kwzg7lUDAKNieGIITCQFQLAsTxwGacOQo+lt+9bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c8792e6f125a..ee64b29bf9bb 100644
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
 
@@ -264,5 +267,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

