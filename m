Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07238E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxmI7e2RWvt3oifijOPYDsUh/dx3lSq/vwwOTD0WDufmyTd1GydToCPoQWAyO9P0Wxy0llUsiohcVJ3g1vjPBTtcnSmc7RVEgv8SI6KOb/hP0qD1SSJdW6qxO4xD9LdmdY4wflIfqQZS3tI2CHK+V3syv3DM7XxIcSmxX9HzsWXJOEMsnUhvli68fBs4zd3JbES4rwrr6PYt/QqA7lSlUCq8QGCFnFhGBqMKCQkeUWKmudqYvn8ZHixZSaDokD3uQVE3z8KmdWA8x0TS2IAFPCSIm4cCATKxm2PFq+Toqu+rx7tkgkDfWEr7MOB9zDaGdymhQtefDApxtkqohylsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuv/Z69i4VUAWYlZsCSDx4o20iUB0Rqhdo4ppXyOqqs=;
 b=m+1RMZqtT1Ini5tou8ptp/gqPQ1QnuOrQeXWIQ5LL1kuY44ZY2qZ6nNhwoHVBTbeo5Lt1amG5f81yoW9jDv9VcsTyAgj2+73FqIlkuhk1acOFPYXi+yqZMN/jjxwHbIu7MssZK8msNSL8uVFMeg9ke2BrCSLhPGdgPx3zcLzeD4BYnumkcGC3ZJjFqlcnOlp+xwmZ3msNtlx2rd8S0bbFyYzW/pwtAvs+UQ9W+6C5hlUxEFWsn0l5mCRk0lSfpinNBy9yfxMjyViqitzP3X6XLn+dtwL6zlF0FXxx92QYJurUEQs2ZdTsjmGVPl9tIxfiZxPrfxwW8U5QMsubFAdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuv/Z69i4VUAWYlZsCSDx4o20iUB0Rqhdo4ppXyOqqs=;
 b=uO57McwIC603TmKlNPcWpDp0l0NZausi6OxC8vSmTns6sHwKGBO+3SiPdtJgXdJO4035T9ueKkmzgboRpfSmhwQZ2+WhOrlGyh32BNNHwcjfZCdoJ+U2t+RXSHnRcp6c9F/3164VXg4xom9P6oxzNt4MN8S4ydtzis8pZaYvDBFmCKJXMdovT6N6ibaVG9r9oDbuXdja+BkeGwQeMiobTZmkW1jh0jJ9l36ABHp4JQBhuzZR/zFensHbM/NvhoV4eZnvrBw5z9iUtK1DpSmBMAaYlz8m873oMVqEeZtdJ0hg9Zq3ldlyVD2+AtdYdC53EYue8nXoCuiZ5OwXSFTxfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:23:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:23:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 14/23] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Wed, 14 Jun 2023 10:21:01 +0800
Message-Id: <d4bee56348d94bc8f7e36c352d13aea9407b4d4f.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 797505ae-d9d9-4abd-9be2-08db6c7e633e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lOB4+um3H8tkZR/1Z8imFb499LX20ynHsFph/dkqHN6FW526t57c+JZTDAMxPhq3a+NxRPocz0SIG5K0EhbgYC2imv5WRjsQKizdQaP5WzwseFn1269N1bItAwARKPekAGb4pKodxT52V+qpaWzw6byxmb7KupZHe+s/zENVdvBl+c23Z/bU0lkr5ojRNtKnlNSwt+NEuuq42HZS6r69TrYbT4SGG58YYu+uHHRSwVn4dpLNNxgL12L71/XYfxM8tWv2ekN2CMgKY0/0g/Hkz5EK/opPSwS0Nt2KgZ+IprqzBMZeqlOquFZjKgiciOZ0oO/sS8Av6NmWDHsV22sG2qq2gd68wRv0hQmwfTUaHFdbDZmIpAhrjEkjpTMOHUAMVKfD3LE1SyK1hGmJyw0QdxC+eZNvIxKK1NRHyUFXx2GV7xs0eQQ8nznjYWIWEqGwTtZr2sNIHowkuTmU+tm0abyIeX/QGch44xC0Qr/GO7NGoT30BZvAbVQezVWgNvKVgkQzi3JxDZ8NOLt6QJn0zSr4mh5E9gfiimYMDAJg40tsh49nAFgxEzMBL9BQ9Szr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+nEqqe0ADJFfhfMtPEJHYmcgMfYqDwddAv2vJTGl4599A0hXULp8GfrXSM8?=
 =?us-ascii?Q?jF+PmEWiEE62ggLbPJhlSV9t0VzbBUahanLCDCOApiZsEk4fwk72rbsNg8gD?=
 =?us-ascii?Q?iqZ3bHYNJXUZ9dweuJ15FxvuWlpGYBUF+Fktobu6GDAAYL4Z3BFB6/+kdq+N?=
 =?us-ascii?Q?L1RpAMc2r0NqGhfv4FQaJexdwKI5D87G8kkLmJMec4VQ5OthjOTVzdXFYXNF?=
 =?us-ascii?Q?Fp6qSGerWTgtevpeROHBzG1gA6900NsYND0OWtLROi4KTgKauoYik1nSNqmH?=
 =?us-ascii?Q?8PGIUnbLGuDeTuFwt91vmEy+ceySsIgrfaMo72jzavWI7XwYzjW+QlSs+HAx?=
 =?us-ascii?Q?k1QAfZCg2JRTCD3W3jZCp5xF17rsJO5043tRygoYdbtyC98lPLkkO67Z85Z5?=
 =?us-ascii?Q?Vc1G8Vn2gGl4COel7FWcqK1v5iKlRVCcvFAJIdDpSeNCwvDrLzubM9j5u/IQ?=
 =?us-ascii?Q?GfohicG1AlfPltHod3ZeSsxAsWEe8oglQLDaPO4++gcDo4dfzXtN1vo82eRB?=
 =?us-ascii?Q?XoXYl5L2gZmbx0gCJOvWAQm00QwimASeJFSRslkSTOPRjhdvw3qViQPnMR7d?=
 =?us-ascii?Q?hXu+/4YJNQvYq8Rpa8mIfHi27Lo8vpXYu5nTJzQkEYYwwLC2RlPhyhdhEVMy?=
 =?us-ascii?Q?Kjc+d8eTFf//j/WC0oDjEwEFaXj33nQQgiSZtQ3emctyMNn20zrI1mjlI6aX?=
 =?us-ascii?Q?86prBVAWFhBUECIZd1X6ncgzvAMXEfo5qHmFPkxQ8NPEg3FQw/TQkD4JHnZN?=
 =?us-ascii?Q?SLu45Tdw4lEFV46gn/7RD7ZLunXyovWl5acGLu5LY1EWAf5fWBpaCzNLzEpo?=
 =?us-ascii?Q?QGSDu/c5qgLHTTht+jRTy8DMTqmr67Y8KwUjVCDtmgfwNAURaZv5sOby5ETL?=
 =?us-ascii?Q?4RjegZgwkKtWAUyZmdAl5pvkINXI4R4nDKYJOEZr0F9Y0rmZJAwPZC2vUz1b?=
 =?us-ascii?Q?VDUe3PVfaLRTVQ4moVwLlsv03f13KxchU3+ONDd/DW46K19LTnP7IIGXuq/v?=
 =?us-ascii?Q?mwvexL/Cqh5xE71U1VpTVP6wgqMYyCySxHaoi1QBZGDssxs9vozbFnMQxrtW?=
 =?us-ascii?Q?1GQhMt2qWKPIySbKWtflCMmVsH1UFpTgywsoxUcjAiIrverCZJlkBWlHf36v?=
 =?us-ascii?Q?g4dMb51+eaXEl9r9W3hCtw8qHxV8i4plzqpVjuc5sFCfmL6CzX2ywaGBtCxt?=
 =?us-ascii?Q?0OtBm7V0miyeF+2hJnTFt8xma8NG+sg2l0eMH8I9aYbtAsuaFY0GCdXOYqnx?=
 =?us-ascii?Q?iLu8preEyi9l0K1lv9LYKQ54ZEX/j+EPx/iO0RafXtACUvYO+dfuBti4Ogsp?=
 =?us-ascii?Q?JKQru1ftVoNCvMcsFBN+BaW8iZCiLil5TZMb5ajoPxQ+dQn58Sns6fiDSDTD?=
 =?us-ascii?Q?sdqa9znpaI5Uhs/Ai5mpO5hv/Pr23hr1Hqokn63EHgJ6mnY2vijDR36UxcAN?=
 =?us-ascii?Q?emJpR5BFAAMQZyf9sVnXexm+RHk0c+iIPihMDSeBxmAYgAEH2+sDkszUSia2?=
 =?us-ascii?Q?aPG4I2XZJ+U05GS9tEbPQi1t0g5SfrPpjxRND57qLXxzt5jx3lUe1BpVj9Yq?=
 =?us-ascii?Q?nIebUY32GT2IOluDw9b63pvS22q21p5O8tGalORo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797505ae-d9d9-4abd-9be2-08db6c7e633e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:49.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr3UIft6d3HR3bhx2sMDpJM+qMJQzNg9hO8Fahc3q6nXvfKLU64IPpMEIJC55WatWqre2KTtAH21iHWeMkPqAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Use data->last_snd instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    |  7 ++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 14 +++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 60b9ad35112b..07f007eb5cbb 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,6 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	__u8		subflows;
 } __attribute__((preserve_access_index));
@@ -259,7 +260,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_data sched_data;
@@ -272,5 +272,10 @@ extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
 extern struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos) __ksym;
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e101428e5906..7c4c5f3b1134 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -25,14 +25,16 @@ void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!data->last_snd || !subflow)
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+		if (mptcp_subflow_tcp_sock(subflow) == data->last_snd) {
+			if (i + 1 == MPTCP_SUBFLOWS_MAX || !mptcp_subflow_ctx_by_pos(msk, i + 1))
 				break;
 
 			nr = i + 1;
@@ -40,7 +42,9 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	subflow = mptcp_subflow_ctx_by_pos(msk, nr);
+	mptcp_subflow_set_scheduled(subflow, true);
+	data->last_snd = mptcp_subflow_tcp_sock(subflow);
 	return 0;
 }
 
-- 
2.35.3

