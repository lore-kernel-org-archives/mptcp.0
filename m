Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20A32B13E;
	Sun, 20 Sep 2026 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890026; cv=none; b=Xal3SwGwYU7lWL+sppxvQDjFN0RsVNUrRKbBHCsjl9LHbMUon02jgoWdQvXBUl+dE0qX5D6ncfbvz7ou/zTtVV+1u7p2bUpeBMvAEnpNGEKAEaTrCSsFFVa914exSE/6SBTPf9QJbxV7+nRLflp/HgGYB/HiiLcs7mQoPb191yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890026; c=relaxed/simple;
	bh=1iJtUkNZ1IUtO0fBHWo89tJm0/MuHS0kNktEO9X03ME=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DhCVx26VXPBmX6NRziQC3sYoOOKVNpcqbyglOBvuY/MMtXX+b89HRV+Uijj/hSyU4IpTSgt2MAAtAm05sDL2dKmymYFLU4fDIGL03rpyaB30QMFCma271KZoEGDRTDJ/FoUBw1LMSAEmE162D99PvALsiqzbMDElZA0mH+JaH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckUtr4/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckUtr4/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A71F000FF;
	Sun, 20 Sep 2026 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890025;
	bh=YasfAD/IrfcybU/UiK0HiYowl333MdwZy990jPQWjiA=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=ckUtr4/1eJ5Y5dHBzZNpcJNQqoNo8HsUuDvMiC+3y8a75Ch2rQLDMxYu9k2wkRoIT
	 TJfZCcwF1uVKkTFNkwLkM+VivTBAp/C/ZWhUS0fn5xcgxUJQGBHLQ6ceYMbpxO7wq4
	 LDBQBVpfLMkbjsQH0yn7zgkv3twnbHKVDFwOxy2I=
Subject: Patch "mptcp: move the stale logic out of retrans scheduler" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:39 +0200
In-Reply-To: <20260919193948.1927666-7-matttbe@kernel.org>
Message-ID: <2026092039-valley-dainty-2ba2@gregkh>
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

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-move-the-stale-logic-out-of-retrans-scheduler.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338593-greg=kroah.com@vger.kernel.org Sat Sep 19 21:46:16 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:39:50 +0200
Subject: mptcp: move the stale logic out of retrans scheduler
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193948.1927666-7-matttbe@kernel.org>

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
@@ -1021,7 +1021,8 @@ bool mptcp_pm_is_backup(struct mptcp_soc
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void
+mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -1058,22 +1059,34 @@ static void mptcp_pm_subflows_chk_stale(
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
@@ -2372,7 +2372,6 @@ struct sock *mptcp_subflow_get_retrans(s
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
 			continue;
 		}
@@ -2685,9 +2684,10 @@ static void __mptcp_retrans(struct sock
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
@@ -541,12 +541,11 @@ struct mptcp_subflow_context {
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
@@ -565,7 +564,11 @@ struct mptcp_subflow_context {
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
 
@@ -1054,7 +1057,7 @@ int mptcp_pm_parse_entry(struct nlattr *
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.18/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.18/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-6.18/mptcp-pm-reset-retrans_time-when-add_addr-entry-is-reused.patch
queue-6.18/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.18/mptcp-remove-unneeded-read_once-annotation.patch
queue-6.18/mptcp-pm-kernel-drop-pending-add_addr-when-removing-id0.patch
queue-6.18/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.18/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-6.18/mptcp-do-not-reschedule-the-rtx-timer-for-fallback-sockets.patch
queue-6.18/mptcp-pm-userspace-fix-address-id-overflow.patch
queue-6.18/mptcp-move-the-stale-logic-out-of-retrans-scheduler.patch
queue-6.18/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.18/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.18/mptcp-prevent-race-between-disconnect-and-rtx.patch
queue-6.18/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
