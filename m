Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488193207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTLh0qYAWj8M+g60bkDv/Cyi7Ra1vtMaeAsWLe3pye2bX+g6hgN8ySfQqpc5AOTFIMHMNL17aEdkP3Vio5mJ22s08qqF3M8k4ogHjWHxRb1Q1poWm1Cs6jk3QE6qfsUJ55CHhweLVe/t9pmEtjLY922Q2gQvvEc6tc2kCZkZ/ShO7tyOfkFl/53zuwlyoXVyFU4Ix7NEdcNt6rcQteu/fw0KRRK4ocsXbXlAJwQ+KyOdUQepbDvENCTqfd8sxHQEfNGPGoXL0SsoilXaAf6J7U35Z6lTbsW3EzNcijNh1arNy5pZE6BnhYh35zj5+RhqTp3CoXcBQnlK07kYI6Vd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtSB2AOnwbfoLW2FuQhhbfPDVxG61dziHJglw82O/1Q=;
 b=Vokq6xreLQEIAszHkpY3QscP/cPvdhqBKXBaFKpYkiw4xCbr+zS/0VY5YiQP63UP/9VLRfSl4lEj1P2dnGdG7zuOUeWM7PzDcg822IpNEPcxextr+86dFm15ixyKZlHD6orPnpCNB92OIkah0ACN0bN1VmRl+j4j0PZ+gL0eFpsT9W7va59M8VFKHUXOWuTM4DZeWQEfj4XXqQZlxdq0EhuykgtZkLIechJ3hsJRphMmyJE3zAFzm8u2h625txqJrb1N+GeBq1xz2+0niZCATHzdBa5sZ3IPw6kmQURcImSfDDXqurjYtQLLTip1p/+CAgc6F4GvV29uiRSyR3q+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtSB2AOnwbfoLW2FuQhhbfPDVxG61dziHJglw82O/1Q=;
 b=t4e5vGY0eBVGstWuX0dEiq/I4SJF9fNe+ViKQvxiKxNy3TIA5KogkvNl0Fy8pUtKmSAju3/aE/NtYEH6MoxHGKCuUa+ay8pC209cwWmtxB1PwU4eOi+vigktHLcQTOVHHNF+mymodnuons/fUxnT/5RJErqOBqrht5tJcwdjavGhkLkmfYrA0VHUilMrBI5oNssRGOugTv8MT0MCDkQIMdwy+Oakh8Wt8yom+ikcUTbRE2MuMZP+SXZl5noRPYqDRg5phKYzaakIsGUiNykmCcZEMNmsrAl26bOceeg4c0oqmFo08MhS9pyh4DgQXOPkRS+PEvkuzmbm7g6A8H1CNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:01:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 03/13] mptcp: refactor push_pending logic
Date: Tue, 11 Oct 2022 20:01:27 +0800
Message-Id: <20221011120137.5475-4-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: cea9a2bd-d2da-4910-920e-08daab805542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L7fX97pIsp9G3SqHU+Ly4MZ8fbx8oO4qooDBAH+Pn3GubJoL/DJRMhOGdichpVCUJG4vZv62TvuUMaYXX44jViFJdnDOryO87gUt1/LTF18zeZB9KlxMF1iPFX48Zj4GYBSfCn3xX4a+RwmU+THcX4wK2WD+mpCd+8fxHBc5sYQMNF254XKnL6Lnhd2XgKqNeyL9T5SSnjiKYRZuKyF/afWyvj4c7bozvLlMMxBJW5Ehj8+vUfvtZ+JzN6DdxmC0H8ZOaEK7VnoW8/ALFoO0FD5/zahyBd+t7T4nl/qlAGKPq8knm3bV9WwC84mfPg2NMGf6DYyLeGog5cr1781Y7rF2bVbPDrmX3QslhUpdPqoh+jgJw+QtaU6rEiIrtw1pcJu9KE0PJF+lu0VsBmi4eVbCarYnd/+MPj6KCXGk++Gn4NvXUTnTMdFIRQyWJkUHBzlbLXmGT0pNX9R06ekxQorqT7LWrLonhbDmJKEoJv22ynuvIDAfImGU+THngPRreGQOxFFzsE/eEUwkfMtlGcIBlmm8AiW3yTE97S02JcbyahdY2+Ve/6qBDBdjgw1y7H6uAhwddU0w+Ywg1x+Pw3FX3HqPuR+1+F/DXlauFHQG/tS6k/6S8zmXIa2G+uZ5bBrLsyUvv0Wx9E3RFkG6EX02RVJopRDCkIV2qkK9xodty0hTzMpWgMj/fk8Dw+NCxiiqUEmZqZQWFjlhbMoblHaIvLSnb81OHYwUe51DR/0cpUtUVDtJGZuKYcEkURdR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRL8TTry5w/Qi3pfM2xIeNaQAxjbVJarC+aWDDW0akr5I0vFVe9VzdgPJmZv?=
 =?us-ascii?Q?2+L6UZRoSI4WO99nFhwhehiIYgPF646Kfr1I9NqiiYCt0cxbb5+C3uptyrMc?=
 =?us-ascii?Q?EqfeXn8GZRX+hkuuKodhYpFps3s6DU1C7K+PlxPjxcJbhPOFw3xGlyp5uKV3?=
 =?us-ascii?Q?9be259mtWZMTJ/uQs4G+iiix8sU3FrNw5jSOG7OIG+eu4nWKezOWqNyWBrDT?=
 =?us-ascii?Q?RnsrzrYHH6OodJxso+ctYkrr5TvT7qIQ/1sYe9ZRSUZ3STMW2bn4wTQFgda8?=
 =?us-ascii?Q?s132leYMVzFW+tuZ4NLb4iS6cfznc4ql9RmMd7u4R2evVCDLmb5VlsXx5/Xe?=
 =?us-ascii?Q?PwVpe2NGbziipkr4EqWzADAxuAEYr5ctXgqiGnADPCSGctUkoMwN3dmnrF6i?=
 =?us-ascii?Q?3qS943iF7uEGej6wVpZZTiAVmQOWfp9dlPG6QaSKXMYTTqaY3R9yFUBEK43S?=
 =?us-ascii?Q?PrGkA6uQMbHluflLnkr4bhKU2b+y80+G+E5j3O1qCsh6p0D9+uPTKCFMvFLp?=
 =?us-ascii?Q?eo0me8uzwfC5eTZILzjjGsaWlv1+hWD3jQ0eqbdDpLtgzXFQhl3xm2Mh5nLc?=
 =?us-ascii?Q?dgFQhuyOoRzkEaJh1TfHpyQyYKQjwQERQajDtAfWA04SOxW5WlomL2INBBak?=
 =?us-ascii?Q?X3lNnb3OiMB3JA6agX+OtXphrJPxusfijFHE6gcpduGnO6+1twU2F1UaNenq?=
 =?us-ascii?Q?U8dnvQW5yKb0EAounIBUuxtUTy9g3/Kp18bgkr5yzxZ7HR6Vf38NONgZLTQ6?=
 =?us-ascii?Q?o6C3GdhPicGKBBMzXIfei7xDtVeTC2bk9SnDHyvRtJ1tMEMG0OaRc8KtkCi6?=
 =?us-ascii?Q?7+rcHsGtW0YHeUuvmCWLeWm0PYB0mLRSyEoNOqGzvul/nP/5tiM41FCq1lxk?=
 =?us-ascii?Q?qOUns1VSvAQR7ri24Sbt4aIwlX6bZdTLjFsK7Ftl7pKP01pgNSZXrWsW9snP?=
 =?us-ascii?Q?A9LVhgbQMCCnsuco+njxfdjnNdasceuSjfFGjvDKV1RA842QeTsbWsF6Fu4B?=
 =?us-ascii?Q?HhT1OP+hP3sBw7PhQ6To74LqGUJtdCnPSKckiYwejs2R32jO+gCqbJSgQ/mK?=
 =?us-ascii?Q?yZOiPjlbOCK4wZroN78qXB4IUYOxbjfIFc/mqovp+HnylhywCypoIony4kuZ?=
 =?us-ascii?Q?y09mxB1s219zoqIJKhliFzEzLDQh3ZYy7jf5Sn0DcjKYEXwp26VXtlLHi2Zy?=
 =?us-ascii?Q?6UpAMtNdfSZbgzU3UTjYUhpWPYzcoigsZW6oBlWiyu5x2CfATCJxAnbS4Dd+?=
 =?us-ascii?Q?A3fVILKEp7ZK9/Z9m0XoNJScuA+M8H8Hkh4hwxGDHh6yUBWiTxpYn9285PxO?=
 =?us-ascii?Q?dDXKOgJGwWIZDJfr6c1gyREBFvSZfODbQXIQACwW00lWRANeGyKxR55zab0/?=
 =?us-ascii?Q?poLxXBORHPhEb+3v0u7QBtmyPOf8Y1bn8bFsd7LjUu2Zf5WP/cKXDsL6UwS5?=
 =?us-ascii?Q?JV557Pohgd9GqkynUqz0SgTphvhxmFQoaU9gEaZN7aKaq5xVtmOj1FSUU5tA?=
 =?us-ascii?Q?zutvs4jguakqPZpF0xhwIf+Oe8V8PyWAvVL3V2mrb4gsk8lg5TcqG1khmsiq?=
 =?us-ascii?Q?0eaDpCYKCKkc2mM2pRS5Sa0N7ByGf80nDWmsn8cmbpCr89t3mx/9FCnv2Pi4?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea9a2bd-d2da-4910-920e-08daab805542
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:30.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtOj6POT2/evBtCBNhlL+x5RarUM3Z0w0vUMGrYs2hVudwPW6IbCzPCJoFOoZWbbXDYnFG70CgrVDfRidKPSFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

To support redundant package schedulers more easily, this patch refactors
__mptcp_push_pending() logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Update subflow locks (push/release/acquire as needed)
		Send the dfrag data with mptcp_sendmsg_frag()
		Update already_sent, snd_nxt, snd_burst
	Update msk->first_pending
Push/release on final subflow

->

While the scheduler selects one subflow:
	Lock the subflow
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push and release the subflow

This patch also moves the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
__mptcp_subflow_push_pending() in the inner "for each pending dfrag"
loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0285b21ff912..52ac57fd8c27 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1530,60 +1522,53 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+again:
+	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
+		lock_sock(ssk);
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					mptcp_push_release(ssk, &info);
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+
+				do_check_data_fin = true;
+				info.sent += ret;
+				len -= ret;
+
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 				mptcp_push_release(ssk, &info);
-				goto out;
+				goto again;
 			}
-
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_set_timeout(sk);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
 		mptcp_push_release(ssk, &info);
+	}
 
 out:
 	/* ensure the rtx timer is running */
@@ -1636,6 +1621,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			goto out;
+		}
+		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

