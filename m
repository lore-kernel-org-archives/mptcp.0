Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7730C361;
	Fri,  7 Aug 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110636; cv=none; b=cb6Win0eaNzhqAed3kWzItcNtVnNo5X53NyyEuM4xOSLaho6G+2zkz0fRBPVjLm1K4gx/EDfH2aAvSR12pfQRUBwK81/hNqmvfZp2gVUa+hWht1AHJ01fCg5CNWTIVOxXilSRt8WMyF90hssiFhpIbBuqGX4LT0GSI/v64c9xkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110636; c=relaxed/simple;
	bh=M2/xXFhSck3zpMfTAf/pdsHgWlGGCN4mOSI5yWc8T9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLjbnOH1H98uvWSlQ2h9CB+tELl9i8gPNCeFBWCq5VHrlosMrQIPX4rU3Z9jWB/KI6CzjOs2OTqtMq2EH2aE+A6o08r2UYqYIkxPL7TJpYj5y7AwnpG//MzDvxhd7dadlbYL3uhrfOR4pBoacQkVqACGg8KzE+RhfQATGkLX6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnx/WHm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnx/WHm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D3C1F00ACF;
	Fri,  7 Aug 2026 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110630;
	bh=5zq4q3uMOzNcIPWzdwEPiuJjkkUoTqIJKHTpTDR/5Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lnx/WHm6HZ66IqDf8PkQg1eRrUYssW2EG30Y5VaEelIkZuJ8/SRO3YURho0HCQY2y
	 4nB+hjjJ2gDZibbpSLzUjEXIPjD6aZ9ImURPujuwXPenpmajN5vc2DH3BMz6joYDMs
	 EU8ETgOCcfaB0Nnj9Qtqgqxj8j5yzLgsk1hgiEgX+p4s1WR/DS7fc6LYQTGWo4iMCU
	 SFINgDjClyT7u6YvjVwUcXMFB8OWSyanEgcuSVq2O5rkdNz6DLzF5gxUcdGFL3yeyq
	 DC5k+EXPZgnLEuxTAVuotr5bNZrqPi1Yid9FnZZ31KGJvDiL+G52x4FDQZIwwFdKPO
	 j3QeMSnH9wFPQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 15:49:02 +0200
Subject: [PATCH net-next v3 2/7] mptcp: move the stale logic out of retrans
 scheduler
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-net-next-mptcp-oooq-pruning-v3-2-dbc1eb853cc3@kernel.org>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5969; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3Nq+TArMeCH5AiTwTu2VJ+qfvcmkzXJJf9dbYOKdvHk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKH83e4vCr/9Ppvza2X22LOp0tHW5v3vqkiWXnb1OFl
 5/ENkev6ChhYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIm3cMP06ILf77ieOHf6/Z
 ggkv/BP+PVLlXRRQoLxf7yFvjNCmVYwMPZFutT90d8lMae5PS1p44EnXy4nH9+Wdy9wQHj+9sOQ
 TNwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

This allow separating the stale logic invocation and the retrans
scheduler, and will simplify the next patch.

It's also a cleaner design as the retrans scheduler has currently
too many side effects. As a possible downside, the retrans work will
now traverse the subflows list additional times; that does not matter
much, as this is slowpath.

While at it, pick more accurate names for the involved helpers and
explicitly note that the per subflow stale data is under msk socket
lock protection.

The scheduler and the stale logic may observe different subflow
statues, as no subflow lock is acquired. This is intentional and not
harmful, worst case leading to slower retransmissions.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new
---
 net/mptcp/pm.c       | 41 +++++++++++++++++++++++++++--------------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h | 11 +++++++----
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 64a1236aabee..d1f73c3e39fa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1065,7 +1065,8 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void
+mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -1102,22 +1103,34 @@ static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct soc
 	}
 }
 
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	u32 rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
+	struct mptcp_subflow_context *subflow;
 
-	/* keep track of rtx periods with no progress */
-	if (!subflow->stale_count) {
-		subflow->stale_rcv_tstamp = rcv_tstamp;
-		subflow->stale_count++;
-	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
-		if (subflow->stale_count < U8_MAX)
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		u32 rcv_tstamp;
+
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		/* No data outstanding at TCP level? not stale */
+		if (tcp_rtx_and_write_queues_empty(ssk))
+			continue;
+
+		/* keep track of rtx periods with no progress */
+		rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
+		if (!subflow->stale_count) {
+			subflow->stale_rcv_tstamp = rcv_tstamp;
 			subflow->stale_count++;
-		mptcp_pm_subflows_chk_stale(msk, ssk);
-	} else {
-		subflow->stale_count = 0;
-		mptcp_subflow_set_active(subflow);
+		} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
+			if (subflow->stale_count < U8_MAX)
+				subflow->stale_count++;
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+		} else {
+			subflow->stale_count = 0;
+			mptcp_subflow_set_active(subflow);
+		}
 	}
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a21b10a8c5d3..88167edc6598 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2469,7 +2469,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
 			continue;
 		}
@@ -2859,9 +2858,10 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_data_frag *dfrag;
 	int err, len;
 
+	mptcp_pm_chk_stale(msk);
+
 	mptcp_clean_una_wakeup(sk);
 
-	/* first check ssk: need to kick "stale" logic */
 	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1b80f2d6ec5a..b3af3462bdd1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -580,12 +580,11 @@ struct mptcp_subflow_context {
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		closing : 1,	    /* must not pass rx data to msk anymore */
-		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -604,7 +603,11 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
-	u8	stale_count;
+	u8	stale_count;	    /* Protected by the msk socket lock */
+	u8	stale;		    /* Protected by the msk socket lock,
+				     * if set the subflow is unable to snd/rcv
+				     * data, the schedule should skip it
+				     */
 
 	u32	subflow_id;
 
@@ -1103,7 +1106,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);

-- 
2.53.0

