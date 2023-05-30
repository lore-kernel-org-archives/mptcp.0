Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B841DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq2xuQuQCbZUjGcY7A/OsWrPdirvKK4NvQOdNzaqUzb0Ge7QvvGh2RvQcPftDOKjuuh8savVNT2z+jw5P+dCtapbtfH9o57QG/lPQ7xtnYChVr3HgaXjt2SuMKX7bty/pnJBxsaJ06mTtXqLDgR0A6DGuIwLoLTyZIhW+sCz2j3buIAbRuupqG5fhkrsjmA+C6zNjqG2Cw02aAULdjhG/tE1lw2PB9Is2Dfa+Pfm7gbhZvjkpdGPgNsmDQlnUCBiZ2ygpo/39WoSuVGNuHaXe47xxC9nKpvpsMSNFX195dD1XNYIvJLagMf8Si+A0FV/ZQD6aca4RPbB0MbN5xrYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMjghRqusHhFYku5Uioe7EFeb30xfqRlHQ3FzULZxE8=;
 b=kmn/OdTLZR38GtFE1adLMTkzFdQG1mdM0dhWV5V8tLqDAQhZeYqHICYfLVzrivqX3do3aGMDUMZ8S/US0L/iVGlYucyPqkQBFsNiX4sQz59E8842NII5q/T6Jy3+sNuKIASZhVkbEE2m+4eFMKg6Y1gLLBmy23ggx4u4SjC4/S4Y3a8hT3RIiho47ukd/VMnJMwNjY8xLqvszLpkKxcNUGMqDYmfvizd66Y8+I94B75yWQKlrXIOUQ3jA78IRgBH7p02/+czexi2zdt1OmF21jhb0lq8biC2iq2zQGnqvuGLM9psXGXN50P4XeXcRABivwZhNmyVc5muHjW6Owh6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMjghRqusHhFYku5Uioe7EFeb30xfqRlHQ3FzULZxE8=;
 b=IH+1lBNNrqv+o4T44gFMPjrq5GXQgzWcqpLgNFIoDf87JU2wK82rjrSQ+VTOcg8YPztOjS+zSMSotZq5QOONJ538bCn2aTELU7Kcz8grhw5HkeUe/+I5hPTrL9AQ7mx/P4J34xiZ+LWtAkaSb1gEJfQtkiJmZhn7n81n92c+wphrM7O1kJgK0m4znhaI1yGUIyFEFnbFE5UcpbbFVsqDKIgm2hRqWX1yvcbRVikA9xYYAaoy5CBkW2oTO6WfIVmZzDFVkA3t5c8yoXdpi7fqDAsFXDAUXYfN0Zr3zG9vOqdNIHHRz4e+vF5DEdh7nxW9ESXs8XZCmJHrFql4q6hyrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:16:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:16:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 02/15] Squash to "mptcp: add sched in mptcp_sock"
Date: Tue, 30 May 2023 21:15:10 +0800
Message-Id: <513e4ab9e97a6afe564fcb31ddb8af37371d9547.1685452367.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452367.git.geliang.tang@suse.com>
References: <cover.1685452367.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:405:1::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 8894b72f-1cd1-465a-c8cf-08db6110056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yR+D1d23Xt+lX7K2I4QkYDSaAJNEV44kp92f5jRE7vEQ5LSdFGzmAGWbVrSpNsXCixt2r8IMrAM5Ud527gqULzO5s28Ze6MmY2Ew+y6EpmVttZK9uK6vfX22Ktju+g2vqRrmWqXeujxvxWjR2ZArhu2eH78Z/lsyNEzMyPFio8Svy9TvyOMnqhGPViTmPLZQGM6VPrzMhy2IogstbYqlBXQh42rrvCZqBL+EXqgokur76z9M0Vv7/x0GcMdATNS1ldaP6xiRhk3V4Rw4ayziNv1PemISXicCPuR6kimZv+RSoxx9wO6lTOXLbgkokWqN+qXGCgDbo7yrhMHkfMncCINiTJ5+EZj4N54z7Lzfo9Xza1zyh6DA0sKZkDUxClNQkXoXMr+KejyqWj0HgMkaG7Y4E2TJ/n7t71WLiDptFZGLfl4Ntxa0X6CNNaSrgXzy78m6YXOEZ3V8e+kr4CNVSu3UdXaPaTgGe1iKfTsrvK77ODArhxlHX8vo7f+Z5Zr41milQTnzMn8t9n/HFcWoJWH1EBOCXuRzkN8dY0skTN3nVU+byrANoEcqP/9kFxK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jTsdX7ea2LQYCWT8Df9J9p0OmGyry0d6DPtD04Kj1zlRIKkYmEkPvX2JHke3?=
 =?us-ascii?Q?5e5cIX+SczAQBUtNkTkQvIqJnE20D98of1BAo18nbgf9azDh/SiS4Mbl02G3?=
 =?us-ascii?Q?kfheebwI/uaimjSFM/w3EIDtoiY3RjNT4XiBdHWB6aoEpqeJ0b51LO5X+lXm?=
 =?us-ascii?Q?/BzNHeERd+1Bp52ym85RSjRnGWFjxYeir5iRqeGbPpIs+uckLBO4mgG8XtxA?=
 =?us-ascii?Q?XlEZg06GkBnG197kZ0DBbc1bAMC1ULHUck22ilh3VemyHX42OPb8dSYNxxy2?=
 =?us-ascii?Q?mR08Cg+CAfS4siFBwUZbZHcYBvbR1cdOoFOhQchqbxCZGkUyURxFOeqLACay?=
 =?us-ascii?Q?d+QJ+IoT5P9CsvjE/oQyg2eaJCEt88nNTQrl9Gq2gBKfK/I5TQ0qDrcYYyxl?=
 =?us-ascii?Q?WldtKb/TOATFH4STweRyl+m44CHFkroybLUrF20COO9ynuQUIVTXVouiU6Ai?=
 =?us-ascii?Q?k4mb0GkjnXWCh4dK1M40d+Ne5uN/3zliqg7xHIRPTvQpWLK22tS+EnuS9Bqn?=
 =?us-ascii?Q?6t1wN5A7QXZDntaJUbooWqK0iGbbuCn5HCRc6MIs4SA2UNr7BpdrTcySmgdi?=
 =?us-ascii?Q?GnOd77UK8CDe/2JYXwbtWtlHRcIozrWsp95q82YX9hiMPp9Sje2+3k11U1RA?=
 =?us-ascii?Q?48tarPP96rSe+va3HBma92Inja+zyFAZwfTO4k+QRWmuJanBiFiy48v4lNrH?=
 =?us-ascii?Q?i3FETu9Jru9ST4vwfo7wLPIFicoK3mx9RCV6YT26XLfqTlx1DBfSO7mQhp1d?=
 =?us-ascii?Q?TQ5I4f9kcNMrrpokG9QxXBmPD80rbdqXqp4DDVpyZ6AGVnpWM4bNKJ4K8eB3?=
 =?us-ascii?Q?oetrZq1JUCTFudBeckpPClwwEACKYakTbdhW6/soIcwREY1gglH3ew/JBN+p?=
 =?us-ascii?Q?YDQt11iMz5xhCW6+JSmDHXeszbZCyuzaKmVnhYie9vrt31Cl90NWzFbYQKp6?=
 =?us-ascii?Q?gXOXCsa+gcDMEl9ugwHgijeCpoTaeuX8dSlrpCos3MWj74aicHpIQC8TSURt?=
 =?us-ascii?Q?4hkm3fcsHaquU1LS6Fpc18IH4j298b4vDPN02cjn8JBUcTn4wdWVnwO7EeZ4?=
 =?us-ascii?Q?gWcct9e62NYyE8Ntm41Es+nPVzmHII4gRdGnl0Kp/dZ1YIX9LA8CbKctgz35?=
 =?us-ascii?Q?K+b6j9+S5oCoFSJ8y/6xisdzlC2j0uHwADEVobqHRpbROmfRLQBsulzEoHTe?=
 =?us-ascii?Q?5pJUUcAv1Ti2nEC4TWJzy7Ws3WKzJ1bJ9rhlYnEPg9YZFSTqmWRMqexGsesA?=
 =?us-ascii?Q?Jn0HqTYHdK0FC2kt47QKygnwIuRp5+NrZeTIxjGRP0bsg6xndN+AtDIqlFW9?=
 =?us-ascii?Q?2cTtAkG+rsOFJuRmbuZjoVXsYtak238SJB95UMi+xJAto8zIDmy5HuuSKtxW?=
 =?us-ascii?Q?x+zTn9BrSpqddf6gRNG24GNoH68BuvMfYrZLwljgqUc1EuzoM1yWeW+0EEpl?=
 =?us-ascii?Q?GDvgOqTiR4WqYHTbSeP0n514tYGqSeEkCa/aIxCZaBRpq6kTXqbDs8cGICaE?=
 =?us-ascii?Q?czQy1q2+OH5kaZjNBpViF0rpIhxNgDtfB+K8yAOl94uQebkKprYHMh8/hIWj?=
 =?us-ascii?Q?Vhs9MBUSrJdVAPEq42A9RtZPkbTChIeamlSBJwhv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8894b72f-1cd1-465a-c8cf-08db6110056c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:16:04.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCPYabnSBhdB5anq6pmx/jg/60WSKCX7x1NY+n6TilK2NhfpnCKIqOIDGsEppNAgrun6lSf8d6h03S4Dd0Fv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/sched.c    | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 763f709fd5f5..a2560813bfb5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2813,7 +2813,8 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+			       mptcp_sched_find(mptcp_get_scheduler(net)),
+			       GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -3204,7 +3205,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
-	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched, GFP_ATOMIC);
 
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd3771c7d79d..88469590eb32 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -311,6 +311,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
@@ -653,7 +654,8 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
-		     struct mptcp_sched_ops *sched);
+		     struct mptcp_sched_ops *sched,
+		     gfp_t gfp);
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..a053a9504dfd 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -56,7 +56,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 }
 
 int mptcp_init_sched(struct mptcp_sock *msk,
-		     struct mptcp_sched_ops *sched)
+		     struct mptcp_sched_ops *sched,
+		     gfp_t gfp)
 {
 	if (!sched)
 		goto out;
@@ -64,6 +65,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
 
+	msk->sched_data = kzalloc(sizeof(struct mptcp_sched_data), gfp);
+	if (!msk->sched_data) {
+		bpf_module_put(sched, sched->owner);
+		return -ENOMEM;
+	}
+
 	msk->sched = sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
@@ -81,6 +88,10 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->sched_data) {
+		kfree(msk->sched_data);
+		msk->sched_data = NULL;
+	}
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

