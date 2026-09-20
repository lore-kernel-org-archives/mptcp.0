Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D763E274C;
	Sun, 20 Sep 2026 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890030; cv=none; b=r+4dXwZGcEllH48700KBEtad8dKit5U8ptoRmpvrJUHV2H/jjq2jfikZMTLqWIT1IFlz0/6Bjh8TPeu2s2MKl7+j+MpDJEWIBYZupTy5rIpMS12X4hVWQLxL7Ui/RgjrP3XZEEhP22/bHm48jloQaBlTpqktskf7OEsbiNfNjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890030; c=relaxed/simple;
	bh=3tfjFClNGbfb+q5+kiTD4mH+QF4Vw+kYtvctcxDdBGQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=GqkqD+7jpd1O4LboY3xE1kyceXd3e1sNNJoHg1OcmD2+cPRNEMCnaKr/TmA+7kYiwuZnnVDLKV1j9ThPmkrZ19joXAUymw+TeamWGPZ+Qn4DnbNbsRSmM2QIyG14P9qDKiUpSAt9kz1kXCULQLFedPHTQDPsim0lVaHN9PO/R5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J/a/Y0Jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/a/Y0Jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373AE1F000FF;
	Sun, 20 Sep 2026 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890028;
	bh=bhrHwQxbVpGhBZ2NB2hM5S9OeJtJ7JTwB58eQkNl9JE=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=J/a/Y0JlbkeDmHfMfrHqWLf4xJG4vfOYDPM/RvkhLEL7Slm8bsz3mmsEbWnbbs61L
	 OJBX7zLvavOQDG+XduKlNT50nnKTLu8Igt95x4dVtneWG2tls1uzPhaKGOyAkfVlEP
	 Zzwb+DC8ZWYnP1bILleOqB/+tlRaAmPOozAxdY+8=
Subject: Patch "mptcp: avoid unneeded actions on subflow reset" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:39 +0200
In-Reply-To: <20260919193948.1927666-8-matttbe@kernel.org>
Message-ID: <2026092038-stamina-selected-f654@gregkh>
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

    mptcp: avoid unneeded actions on subflow reset

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-unneeded-actions-on-subflow-reset.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Sep 19 21:46:11 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:39:51 +0200
Subject: mptcp: avoid unneeded actions on subflow reset
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193948.1927666-8-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 2b0f561f21b27c40c91ea4975268a06092bd7e9c upstream.

Once in a blue moon, the mptcp receive path can recursively call
mptcp_data_ready() via state change under unlucky error conditions, and
then try to hold the data lock again.

Break the recursion loop explicitly checking for the exceptional
condition.

Add a new flag instead of using an existing one like 'closing', to exit
early in subflow_state_change(), and explicitly flush the RX queue at
reset time.

This avoids unneeded processing to check for available data -- calling
get_mapping_status() and more on a dying subflow -- but also in error
reporting and worker scheduling.

Note that we must consume the currently peeked skb before invoking
mptcp_dss_corruption to avoid consuming it again after the eventual
reset has freed it.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-1-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    4 ++--
 net/mptcp/protocol.h |    3 ++-
 net/mptcp/subflow.c  |   11 +++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -727,12 +727,12 @@ static bool __mptcp_move_skbs_from_subfl
 				mptcp_dss_corruption(msk, ssk);
 			}
 		} else {
+			sk_eat_skb(ssk, skb);
+
 			if (unlikely(!fin)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				mptcp_dss_corruption(msk, ssk);
 			}
-
-			sk_eat_skb(ssk, skb);
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -545,7 +545,8 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 9;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -441,6 +441,10 @@ void mptcp_subflow_reset(struct sock *ss
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1864,6 +1868,13 @@ static void subflow_state_change(struct
 
 	__subflow_state_change(sk);
 
+	/* Rx queue processing is unneeded, error reporting will take place at
+	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
+	 * fallback: subflow_sched_work_if_closed() would be a no-op.
+	 */
+	if (subflow->resetting)
+		return;
+
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.


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
