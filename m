Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54510E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2x8nTEXDoAUUL+GX3U5Q+kS3ArYGoDwO+PxuYHPj93tpCvoGsxZL4eaxNa6NiiOTthmBAl2eoUNfxISy9IoHKm4RIYGmbqA04qzxDPNbNh8RrC4FIDsvDvNP+HOY6LNJHeAcGyXCtGxtPHV2F+X8TTcjK37zl7q25Z+aR1LSrXFX/6pzYvWBgvRIzpwXZ0x8uTU+53dSx6S0nxyE3NlmpGAbwailq7AOVzBnmjVw+l4aS6vxZFI1EWDspLen3cva8XYFGbMyPfVf3RzSnQl/OHQOHCcDgGZ7lh73Cf1LDFPOk9kLjPLCviSHREjUT4MpBw3y/rLw1vxcTncpto6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr4Vn/kFClppS06CcKDDfNn6JZ3kYVi1Hl0x5Ei07hM=;
 b=I0WDLrzBbueWMsJUNTqd1R10ZWC+rwkyGKYNLHGJ6P5HxOf8uEUW006IhDeDPGdECDYb/kay6jn/SkRT1oxas/SnCYXW5U4fz9kjX3bteLMUmhcNVsixonk0zkT+m2S5/xnCe96TXQZacPye6gZnFN54DagXV6+aUNNxKHe5PAjNdYiH1UumSYvrhFnSvIBaHpZJeb8VyghVBF+yeACB0IxNflZM37zXupdPfnhWZXsrLjxXzz6Q2p5J88rgl8p/4sYv13IsDIgGNkSTr0DCJFeecNGC1vphDuHIMz2Qp4H3lVcYHNH2awKQ9hEvOJeZao/I5Jq6XaYVldfokrucaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr4Vn/kFClppS06CcKDDfNn6JZ3kYVi1Hl0x5Ei07hM=;
 b=j2wfMnoWo4ipJCUAJ1dvWqvTC8fhCRAZs5gdMRWRL68nnNpkyRB1ggd5OBiX8W0UHorYb0+CNDZfdGmnN8bCO3ziYsSF/76CshE73yW64ZxI0vvlYY2xQufkdEQ8EsnOwibjcULmpb1JAwyMgEnBK/rgB1AoiryzDU7cq3J/Gm4ZBxgvTEJrS8Nzk9VLWw/oE66B/Lqe1k087STVfkmQ870/Z0yI57g1jyetiGGnKt0JAamTtQKJCL7iGXmQnxTk4rhMwalDPlYJe6PVrW3Zt2kyiDCSHO85sWDw1CKpAnGHvrsh+qI8F/FGGeqT6ilDGFg2le7PICKrMwhqGdA+7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:01:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:01:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v24 3/5] mptcp: use get_retrans wrapper
Date: Sun, 11 Dec 2022 10:00:54 +0800
Message-Id: <2981f0dd223bbb50273dec430a8dc0e97436131f.1670723836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670723836.git.geliang.tang@suse.com>
References: <cover.1670723836.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc6db9b-b86f-48e8-0e25-08dadb1b9578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kCx+O1raTU090pIzjiIlHZvPtkVBq7plI+DHQ/ySwcHBvT/wBD9WuNQluBoH2EgWuj1pjWyibhWxQPbSPFbfbJ4EHC6J7r9nWL79Lvp5h2odofk8p5woMHy6dW7uzKurEukDfZgakPEtYQc/ZT9uVZtOFgmqz856pum6QpnaTaAA7DCmJ/XfnUkEu4QAgDlyAojhUHFhx1i3qAIdt6MCma8A/3qNGSQgShki5M6pAyCOQ/32uZ7SjtOsCkpLxw29fIR4zDznwriveRePpfH6/z/osD6kXoRhEy+DRL+BtbE6NRoxaDVogbJ2JI5OLAd0ngHki0C3F+pvEIYmU73NnpbLy2dpsDoQEo9Wh9CbDDA2OlgXPYi/zril2A7lUbZzEgKa0foMotyEo5K4KJcwFpRvB5B8qnkt/7mP9tvQppgKbsQRtoOBH66YZY0QGC0vwi7mb5SmOgEzrthWECP/SjKFUS60v4LAduuTTbh4g6WZZHVb3uo+NabKBaQ3iozyaedty/0q266t82GJi20bd/hgbWogTNHNDwu9J7N/qPoq4UTBLk079951c5f8aXLdIh44rNcFPrPfJDUaltS3wWCH6F2bhjMe+/wBmkEaNulYG5y68YnVUdbB+b/xgCMmX+LnLEWM1OvnTD69atW2/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/vU80QH+bAWihRJbeZC51qFWrEdpXAWahSFDab59kQGJr4XGA1wUi598NY2?=
 =?us-ascii?Q?Hee0pivVO5huSvYo43wvuiizAaDtbQOxMsjL7+7XJSr6TuJcS59IAmUVWd3W?=
 =?us-ascii?Q?c98WTb+STQ173ct98ftp9uqaZdqErJiFb5qDym6/R3djWDzTnVps86vUHDiT?=
 =?us-ascii?Q?OfRNjAgSKoPug5Y6EBqloa5K8Z6cHe8qdxn0KBu27D3a/bVMK6QqVppFXKYc?=
 =?us-ascii?Q?/OMRC3PHvWr6XyMllPkWA/PTV2vPjBBMqptO0Jec7jhKGbwQLZqv/1nRXZty?=
 =?us-ascii?Q?0j3/2Y0RND1ZcO9YlAAou1SAL+xi3U2sQXSSJ59Whf/xrM0BzrNneXilkXlO?=
 =?us-ascii?Q?mt3D/nRQ80PVFycwU5MFz8K308SB+N/jMJ5ZN8aRNBu0B1JMTlOJWopie7Y/?=
 =?us-ascii?Q?5PebZVDeWpTDViNHXhCz/07IlEaGa9wLW726PlbIsB/vTjUHM8j1WVjgye30?=
 =?us-ascii?Q?5qLCKdCVEs2JNDLvKWN5tTsy1uYhuNG4ZOtIxkZP+qhAugP4WTYPoOWu2khS?=
 =?us-ascii?Q?7XHPqGuSldS6u22YGkXXzTNx1LdcVdU8CMg/WhY7INm7NacgtjHxtu1PVDJa?=
 =?us-ascii?Q?BLVNTkYqQ+hBYTPAvdsTNy5+fxfux2dSlpnQjH358buYQiP/CClmZMwnXvAx?=
 =?us-ascii?Q?XeWx61Nx0HA8cOz0kIjWlb38/sxMKMn2bpzmH+FFuAtq5LvB3Mdi5HX9vxR1?=
 =?us-ascii?Q?fFOdekk0OjN5m7XIHkUZC/kjxNxl3Zla4yifi3jFG2LJLSQaxEKgHMYcYWMz?=
 =?us-ascii?Q?vs1NibESdvJeq3d+9SZYYSGRId3I3K3t0vCjwtfgn6g4ts97OhWHsY6bYd/R?=
 =?us-ascii?Q?gwvj9YIM0uFjrzCttid8nW8QpWtfVTVF7RwlyVUx+1nHRWW4tdzdd3fmpT1Y?=
 =?us-ascii?Q?kc7FTYgEoX4WbUBRwUFPY03gbBJnEG0a2MBjWbklg+MQ8tJl6wYYtSY0Y5bX?=
 =?us-ascii?Q?Q8pv4MNrNCbbgh7EmVaiLivU6z65uulU4YkXQ25fPb6gozaqibsDMKr/SIe9?=
 =?us-ascii?Q?er+GleArWMhBTrH3eXkCHC9q5XwQR4/sbyS8bQp5D84+a6Z3Ft3N6Tml7Lgc?=
 =?us-ascii?Q?3JNaDj+nyOEmfWX+7JDKqaWB8uS87d61J29Y0eaZzAMl5yHAZzWvrpx7crML?=
 =?us-ascii?Q?MALNfvMgHGVfmhAM622sFkhmZatJMJBfJJ2ZJj5YyrX++4G56Hcgr5+p93XG?=
 =?us-ascii?Q?9hBT53A8hWkvE6UHoYivwlXFQFCVdvsk2yhuv2o1sB8I35QHEDOjHCbskPEE?=
 =?us-ascii?Q?dFRn3w0KSAR9luWI761KusiKJeHAzckxhrbuDLBs3y7/myJSLZBTFo3Gvqwf?=
 =?us-ascii?Q?GgD5f1H+4urRPTX/89fSQfFj3PMdezC0p4k/fNIP/7G4YQtjG+CG4lCqDLML?=
 =?us-ascii?Q?tMbqrxP/mz/OAaCoD/G9nsn3cgJHzW1dIDuwFv/ZI8eZ3u8CcTdlo4crNFAs?=
 =?us-ascii?Q?L4//vD8gxbJ1BDD14QO5wE3+vaHrMJbcS0Ag83ZFUe764vcvh3X+u14VhlGJ?=
 =?us-ascii?Q?7fZQElATx7hdGsLdEbqTtamatbn2QjNnVB9BUGs/utSDDJgQgXnXCEk+m2dt?=
 =?us-ascii?Q?brlIUjhcrUeHCQ0F/D2VBpo286LadWh2zLHvRS2ECu56l7cBjxpwe06fGmeu?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc6db9b-b86f-48e8-0e25-08dadb1b9578
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:01:14.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDUYPfTPnQy7KrDp+3EzbkNy887XTLDNV9E1GvR8bkZt1j27ey/XxTqePmQC9/OwDxD/tePll05DXP5pI4sDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_retrans()
wrapper from mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++++-------------------
 net/mptcp/sched.c    |  6 ++++
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c095fa37b6b..b3e5d30adbe1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2252,11 +2252,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	msk_owned_by_me(msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2526,16 +2521,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2554,31 +2550,45 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			mptcp_subflow_set_scheduled(subflow, false);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			ssk = mptcp_subflow_tcp_sock(subflow);
 
-	release_sock(ssk);
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+
+			msk->last_snd = ssk;
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6428323d8c7f..c7c167e48d72 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -156,6 +156,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	msk_owned_by_me(msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

