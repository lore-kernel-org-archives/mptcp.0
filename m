Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5C3E2771;
	Sun, 20 Sep 2026 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890039; cv=none; b=Ej9WfdA/N/hLgzINSHWvQIpJfLE1RUPp14ffEcQwYrU4YlexNISUfshh9X14/9EbyvV2hij2molpq79JsVOTtbfmed0FiOETzW1GEyxaU+l5K4ealGJoF7uUYqS/ftO3cOVEIntBpTfLs/zcm9oQTnoFodvvE+Y5Lby17shm0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890039; c=relaxed/simple;
	bh=G8h0wxb/qocCL06l1HhrIo3C+GogIrKspR3452Easgo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=HQ+Yrxa7FJ5etT03CWLj9xictKmpnxNTQQ/piZznkL//yi+g0lq6Fp/uPScSfcm6VXmAhApTD6l7lh64Cw52HMRqXIyYXSunt/ADyovS1ZUXGGIzrsTWRDa4fQVsnDqlvq0RGKtThNTbMN3ds+yIX0ZfMAnWOQ5J/THCJqL0MEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sV8L8lvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sV8L8lvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBBC1F000FF;
	Sun, 20 Sep 2026 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890037;
	bh=WnM8WozgSkzWIH/5X+yRz8T8ifA+YlwR82SXOW83P24=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=sV8L8lvIJvKLPvFQH0sLTgH+1l4xr+uTrfgXWkp4jvY/CwK8XMkIMFvQjMJ/R82xz
	 ktsh6sDPOyqrZC/8Q8smRIDAHU7dMutqmfGV0Qq2rsy21jJtiMDN/B6fEKSTyhYxYy
	 GUOpm975CT9mJj5m/ZZacWWZufyqP57LqA7LKyoc=
Subject: Patch "mptcp: avoid unneeded actions on subflow reset" has been added to the 7.2-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:40 +0200
In-Reply-To: <20260919193541.1915297-8-matttbe@kernel.org>
Message-ID: <2026092040-mooned-safeness-9f66@gregkh>
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

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-unneeded-actions-on-subflow-reset.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338589-greg=kroah.com@vger.kernel.org Sat Sep 19 21:36:20 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:35:44 +0200
Subject: mptcp: avoid unneeded actions on subflow reset
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919193541.1915297-8-matttbe@kernel.org>

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
@@ -773,12 +773,12 @@ static bool __mptcp_move_skbs_from_subfl
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
@@ -585,7 +585,8 @@ struct mptcp_subflow_context {
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
@@ -436,6 +436,10 @@ void mptcp_subflow_reset(struct sock *ss
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1873,6 +1877,13 @@ static void subflow_state_change(struct
 
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
