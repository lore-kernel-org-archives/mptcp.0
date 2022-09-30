Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ECB5A79
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664553630; x=1696089630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z66rPEvAFA1BnW04dg1ABSJlUprM6g9uqaqeJgn885M=;
  b=ZLkaKdRElMvFLLuUZ6ORglcm9lnprkTwkLlN4dwJQPhVP49hEnfM0Bb/
   jMFehKtJe6AX31BIs3dFeh4XucMjdSVc5wOGyrqn8KatKznCl0SeeZ1WP
   tcKDrZ30IR/t0sV+eWnb94PkXi2b2hjZtPN0J5wDHIOmoGWMDqEpoNnqZ
   b9Ei0UF5ldQ1KCdJznYynQi5sCf2qt/OW4Zi4mT3XC6Re3ABZc9v4QfZ2
   T9tLE1SvnvarS5hawsSyQleJl/H0VnVjt9Yk/5SDN009e0QURlGvYQGt+
   NCrlLxM/d6tSqWOjj0DuEGTjQHBFaqTu0irvjUJNaJM+4hT8mLT+mSSfm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289383896"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289383896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="655996109"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655996109"
Received: from cmforest-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.22.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:27 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/4] mptcp: use fastclose on more edge scenarios
Date: Fri, 30 Sep 2022 08:59:32 -0700
Message-Id: <20220930155934.404466-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930155934.404466-1-mathew.j.martineau@linux.intel.com>
References: <20220930155934.404466-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Daire reported a user-space application hang-up when the
peer is forcibly closed before the data transfer completion.

The relevant application expects the peer to either
do an application-level clean shutdown or a transport-level
connection reset.

We can accommodate a such user by extending the fastclose
usage: at fd close time, if the msk socket has some unread
data, and at FIN_WAIT timeout.

Note that at MPTCP close time we must ensure that the TCP
subflows will reset: set the linger socket option to a suitable
value.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 63 +++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cad0346c9281..acf44075ba40 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2313,8 +2313,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if (flags & MPTCP_CF_FASTCLOSE)
+	if (flags & MPTCP_CF_FASTCLOSE) {
+		/* be sure to force the tcp_disconnect() path,
+		 * to generate the egress reset
+		 */
+		ssk->sk_lingertime = 0;
+		sock_set_flag(ssk, SOCK_LINGER);
 		subflow->send_fastclose = 1;
+	}
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
@@ -2577,6 +2583,16 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_reset_timeout(msk, 0);
 }
 
+static void mptcp_do_fastclose(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp)
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
+				  subflow, MPTCP_CF_FASTCLOSE);
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
@@ -2605,11 +2621,15 @@ static void mptcp_worker(struct work_struct *work)
 	 * closed, but we need the msk around to reply to incoming DATA_FIN,
 	 * even if it is orphaned and in FIN_WAIT2 state
 	 */
-	if (sock_flag(sk, SOCK_DEAD) &&
-	    (mptcp_check_close_timeout(sk) || sk->sk_state == TCP_CLOSE)) {
-		inet_sk_state_store(sk, TCP_CLOSE);
-		__mptcp_destroy_sock(sk);
-		goto unlock;
+	if (sock_flag(sk, SOCK_DEAD)) {
+		if (mptcp_check_close_timeout(sk)) {
+			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_do_fastclose(sk);
+		}
+		if (sk->sk_state == TCP_CLOSE) {
+			__mptcp_destroy_sock(sk);
+			goto unlock;
+		}
 	}
 
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
@@ -2850,6 +2870,18 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
+static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
+{
+	/* Concurrent splices from sk_receive_queue into receive_queue will
+	 * always show at least one non-empty queue when checked in this order.
+	 */
+	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
+	    skb_queue_empty_lockless(&msk->receive_queue))
+		return 0;
+
+	return EPOLLIN | EPOLLRDNORM;
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2863,8 +2895,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_close_state(sk))
+	if (mptcp_check_readable(msk)) {
+		/* the msk has read data, do the MPTCP equivalent of TCP reset */
+		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_do_fastclose(sk);
+	} else if (mptcp_close_state(sk)) {
 		__mptcp_wr_shutdown(sk);
+	}
 
 	sk_stream_wait_close(sk, timeout);
 
@@ -3681,18 +3718,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
-{
-	/* Concurrent splices from sk_receive_queue into receive_queue will
-	 * always show at least one non-empty queue when checked in this order.
-	 */
-	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
-	    skb_queue_empty_lockless(&msk->receive_queue))
-		return 0;
-
-	return EPOLLIN | EPOLLRDNORM;
-}
-
 static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
-- 
2.37.3

