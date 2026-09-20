Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AC32B13E;
	Sun, 20 Sep 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890042; cv=none; b=SBO3i/aehRshkQ6qhlxVJYqw4W+TSbzEGn1psGPBw9Ch5TqqGQoAZdMTxmGPYp6QmFkwPCFt0CgJd9tCPRUPKouPoQu5XMrEr38PADm5xwk0eO4y8uL6gQ446Lgym3yPMAqGOus33Qhv2m3x8Ut8tXCgq0ZBgkEOVx9YCzlAHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890042; c=relaxed/simple;
	bh=9nktXTz5p28OKmBhPkGwTWs8rc2x0B8xONVcANXC4Qk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OSG+x/bqoTxqEtUaj9rDbgbs0wcfIBYhT9UJLiyghn9XFtQphZ4HcC5oE6zo5LMwfxgjoYammdNHjeRA0YCNwHKyKtBTBdvJ1VHzCm+yi1LWZHdCn7pZ3PkEjo2LBNyhyqAOGhZOit0xlFrzSUyWWGPIvZEH0PaC4r3D/ghlHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhT/BWOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhT/BWOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ECD1F000FF;
	Sun, 20 Sep 2026 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890040;
	bh=Jp0/UbWxcqd1lbcf6IZfTpBzAl4qwQziQlD/qTR9oXQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=MhT/BWOuUbbHA4sqjfUMQwZ2xnd+Wz5kmbnqx2Y2gW1nukqbKKYjdKHZbuf7hVrMo
	 NTxKVVNpxMKkgEJLEQ0qZXPNLoBvwyHidhdr/sD6kAWrwrJ+6wA9/9XvnWsTZkUCCC
	 fwtJUwThhRWPIqpiAr3R47y3c+X54BDZ4Ggyzebc=
Subject: Patch "mptcp: move the stale logic out of retrans scheduler" has been added to the 7.2-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:41 +0200
In-Reply-To: <20260919193541.1915297-7-matttbe@kernel.org>
Message-ID: <2026092040-glue-fruit-b53f@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    mptcp: move the stale logic out of retrans scheduler

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-move-the-stale-logic-out-of-retrans-scheduler.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338588-greg=kroah.com@vger.kernel.org Sat Sep 19 21:36:15 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:35:43 +0200
Subject: mptcp: move the stale logic out of retrans scheduler
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193541.1915297-7-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 6cafe51e0f98fe60a106783d30b2f4c4b6039f4c upstream.

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
Link: https://patch.msgid.link/20260807-net-next-mptcp-oooq-pruning-v3-2-dbc1eb853cc3@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c       |   41 +++++++++++++++++++++++++++--------------
 net/mptcp/protocol.c |    4 ++--
 net/mptcp/protocol.h |   11 +++++++----
 3 files changed, 36 insertions(+), 20 deletions(-)

--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1065,7 +1065,8 @@ bool mptcp_pm_is_backup(struct mptcp_soc
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void
+mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -1102,22 +1103,34 @@ static void mptcp_pm_subflows_chk_stale(
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
 
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2471,7 +2471,6 @@ struct sock *mptcp_subflow_get_retrans(s
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
 			continue;
 		}
@@ -2803,9 +2802,10 @@ static void __mptcp_retrans(struct sock
 	int ret, err;
 	u16 len = 0;
 
+	mptcp_pm_chk_stale(msk);
+
 	mptcp_clean_una_wakeup(sk);
 
-	/* first check ssk: need to kick "stale" logic */
 	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -581,12 +581,11 @@ struct mptcp_subflow_context {
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
@@ -605,7 +604,11 @@ struct mptcp_subflow_context {
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
 
@@ -1104,7 +1107,7 @@ int mptcp_pm_parse_entry(struct nlattr *
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-7.2/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-7.2/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-7.2/mptcp-pm-reset-retrans_time-when-add_addr-entry-is-reused.patch
queue-7.2/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-7.2/mptcp-remove-unneeded-read_once-annotation.patch
queue-7.2/mptcp-options-fix-uninit-value-in-mptcp_write_data_fin.patch
queue-7.2/mptcp-pm-kernel-drop-pending-add_addr-when-removing-id0.patch
queue-7.2/mptcp-close-race-between-scheduler-and-state-change.patch
queue-7.2/selftests-mptcp-lib-get-counters-for-the-right-test.patch
queue-7.2/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-7.2/mptcp-do-not-reschedule-the-rtx-timer-for-fallback-sockets.patch
queue-7.2/mptcp-pm-userspace-fix-address-id-overflow.patch
queue-7.2/mptcp-move-the-stale-logic-out-of-retrans-scheduler.patch
queue-7.2/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-7.2/selftests-mptcp-lib-dump-nstat-for-the-right-test.patch
queue-7.2/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-7.2/mptcp-prevent-race-between-disconnect-and-rtx.patch
queue-7.2/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
