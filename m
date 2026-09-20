Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848A32B13E;
	Sun, 20 Sep 2026 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889996; cv=none; b=qUz0ArrFw0zYC+EmfptH0lvD3tF3ARN4+Hv4U2/y+C2mr0IpjtDl6wM+ne++sdwMSoWIr/1k8Y+KlTFGqHPEPYO9pd+xyZY9sfZhfjDW5qYC1w4nLY8Hmi9K8TxTLWOFhhwuHKOVmu8nCWqVwvGmyKYNlQNzysYTKaM4cCgObBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889996; c=relaxed/simple;
	bh=Xx3f6OtK4eBzgEXots8cZU9Xq7mUQ/ezPCCW5N3ZPrc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=SBqYJH7YSMUafI4xGuZgPCVp55/O3iqRFb/iLutcrExKd+5Ibp3Vd8tDyUkx+21wQ784ztVOhmMa51BykFaZ5A4PR/g4JJkQ4ZIYzbB/ItdFSDxaQjPONIuD3LwqhoCt0bqvAc+h8O8JNbVPLUWvo9uhNEauXSA8vYxOxAbz+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjAwCv3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjAwCv3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11921F000FF;
	Sun, 20 Sep 2026 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789889994;
	bh=6NSE5kOcfD2eSathv92Ys2eUtEiGlGLX4HyVdURKWFo=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=jjAwCv3RjrjVCw3j2RpNR47GP8+SxU2Os+Qlj1uYTED6M/a3EgDEejW8rP1JJiHQr
	 8X5VfNk5frNpkuPv6L9hxkGG0Xp2BTDp2snGXiVpTIkqaEfPtwdl1QWi3wS5mtYyVw
	 8eAE7l/MADvzi8Y5rzUe29nRcUe8zReWFni0sFpc=
Subject: Patch "mptcp: avoid unneeded actions on subflow reset" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org,xinyang@anthropic.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:34 +0200
In-Reply-To: <20260919201252.2025112-7-matttbe@kernel.org>
Message-ID: <2026092034-overlay-scanning-1b95@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-unneeded-actions-on-subflow-reset.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338609-greg=kroah.com@vger.kernel.org Sat Sep 19 22:13:16 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:12:55 +0200
Subject: mptcp: avoid unneeded actions on subflow reset
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Xinyang Ge <xinyang@anthropic.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919201252.2025112-7-matttbe@kernel.org>

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
[ Note: conflict in protocol.c, because commit e0ca4057e0ec ("mptcp:
  micro-optimize __mptcp_move_skb()") is not in this version, and is
  part of a consequent rx path refactor. The conflict is in the context,
  and is easy to resolve, "done = true" can be moved along without
  consequences.
  Also a conflict in protocol.h, because __unused is at a different
  number. Decrement the one from this version and add the new flag
  above. The context is also a bit different with data_avail being an
  enum, but that's without consequences here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    6 +++---
 net/mptcp/protocol.h |    3 ++-
 net/mptcp/subflow.c  |   11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -754,13 +754,13 @@ static bool __mptcp_move_skbs_from_subfl
 				mptcp_dss_corruption(msk, ssk);
 			}
 		} else {
+			sk_eat_skb(ssk, skb);
+			done = true;
+
 			if (unlikely(!fin)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				mptcp_dss_corruption(msk, ssk);
 			}
-
-			sk_eat_skb(ssk, skb);
-			done = true;
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -492,7 +492,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 9;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 8;
 	enum mptcp_data_avail data_avail;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -379,6 +379,10 @@ void mptcp_subflow_reset(struct sock *ss
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1710,6 +1714,13 @@ static void subflow_state_change(struct
 
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

queue-6.1/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.1/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.1/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.1/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.1/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.1/mptcp-consolidate-subflow-cleanup.patch
queue-6.1/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
