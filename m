Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939A32B13E;
	Sun, 20 Sep 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889992; cv=none; b=bLkSQeawOjjtDVWOO9yIm2+HQ8rWPqNBpRG/PAouBt6VvIdnWSsJk6Yasb6Gq/B53q22/5h2dRxqpSr7nwyKDM+JjjEH8JyWl4NEnN1X0Xo7D4tNTB4rJxBVbPYw4bysJPUHmIyn5w1+uu0nWZGHjp7045Rey0bnw/ks7egVIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889992; c=relaxed/simple;
	bh=F2AX/U1EOy2Bg7CMcmDcsZB0smZ0n6EUsnG7EwPbTTw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=YPx/Ww1oK7K1IG2JZnT4255HzbN6eHLesZhzqHua5AqhdJsZ9lsUSJa1eekV4oTRvMRdNEpJ0ZMAMnJ1gVDMSm8S8q+dSkzlb+6DoEz97GZRCZ0eXo2uA+Kz52UOw50UJ1YHRhRbAIugAF6jzHdjJ3vkU1si2zGOM8PXARgmXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhKDIXa4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhKDIXa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDD41F000FF;
	Sun, 20 Sep 2026 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789889991;
	bh=4b5NPxHiYQHuwAKz3fd8O4JCGZyFESQI2oF7PN/RanU=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=UhKDIXa4e5D2Baj11NYscn841XPssu6JdSsjPwXQV3kR7Pi6R6PaEEbyAK+EBKXzt
	 84ktCXqC6+7sqLHxh5v74GlIm2wlz64SYOpdvW1uGqW9dBnhbzANlFIIsshk3REA2g
	 a4vuYyOkSSd93Q0vSipxR09nJreRObhTLdpC5XFo=
Subject: Patch "mptcp: consolidate subflow cleanup" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:34 +0200
In-Reply-To: <20260919201252.2025112-6-matttbe@kernel.org>
Message-ID: <2026092034-agreeably-parachute-6afb@gregkh>
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

    mptcp: consolidate subflow cleanup

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-consolidate-subflow-cleanup.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338608-greg=kroah.com@vger.kernel.org Sat Sep 19 22:13:14 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:12:54 +0200
Subject: mptcp: consolidate subflow cleanup
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919201252.2025112-6-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit c3349a22c2002947d29a98a77bfb36d97cfbfac1 upstream.

Consolidate all the cleanup actions requiring the worker in a single
helper and ensure the dummy data fin creation for fallback socket is
performed only when the tcp rx queue is empty.

There are no functional changes intended, but this will simplify the
next patch, when the tcp rx queue spooling could be delayed at release_cb
time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-1-4a47d90d7998@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
[ Note: also remove struct mptcp_sock *msk from subflow_state_change: it
  is no longer used after this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1159,7 +1159,12 @@ out:
 		subflow->map_valid = 0;
 }
 
-/* sched mptcp worker to remove the subflow if no more data is pending */
+static bool subflow_is_done(const struct sock *sk)
+{
+	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
+}
+
+/* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -1169,8 +1174,18 @@ static void subflow_sched_work_if_closed
 		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
-	if (skb_queue_empty(&ssk->sk_receive_queue) &&
-	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+	if (!skb_queue_empty(&ssk->sk_receive_queue))
+		return;
+
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		mptcp_schedule_work(sk);
+
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
+	    msk->first == ssk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
 		mptcp_schedule_work(sk);
 }
 
@@ -1688,20 +1703,13 @@ static void __subflow_state_change(struc
 	rcu_read_unlock();
 }
 
-static bool subflow_is_done(const struct sock *sk)
-{
-	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
-}
-
 static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
-	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
-	msk = mptcp_sk(parent);
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
@@ -1712,13 +1720,6 @@ static void subflow_state_change(struct
 		subflow_error_report(sk);
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
-
-	/* when the fallback subflow closes the rx side, trigger a 'dummy'
-	 * ingress data fin, so that the msk state will follow along
-	 */
-	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
-		mptcp_schedule_work(parent);
 }
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.1/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.1/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.1/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.1/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.1/mptcp-consolidate-subflow-cleanup.patch
queue-6.1/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
