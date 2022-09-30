Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8825A66
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664553630; x=1696089630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VByxH30YMrFFT03SK19iwWzFpOXOu0TywF/XLaKQObI=;
  b=e/evyVMCmI0LH5ZCOtnIyTfXcnvbf9HzJQjUMGrJMOkNr9qVsCcbICS1
   OGZvZfVzZCRdB5Mm4hTXTfQMF1uYYahaCDPPxOTHwOx4sL8z2EufbxqqB
   PDzGvYV4Vc7iUyo5ykieg/Ega43zvZ30VqAgcVLWI6JtFJfC/OpSJFAqb
   kdFkplWZx94o0IsYRJyFV3hAIGIufu7FCkbjNyHUfIiQNLQqqS5towJce
   6WNyeddzsqXVazOR9jJNtTw0QvK7ExHkJyUid3DpYg7L1jruNWysvHk9f
   Rq83+wiC6ZAswDUgGL6Px5aY3HBZm9JmKfVYdymDmbJdOymXX4wLt0x59
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289383894"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289383894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="655996108"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655996108"
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
Subject: [PATCH net-next 1/4] mptcp: propagate fastclose error
Date: Fri, 30 Sep 2022 08:59:31 -0700
Message-Id: <20220930155934.404466-2-mathew.j.martineau@linux.intel.com>
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

When an mptcp socket is closed due to an incoming FASTCLOSE
option, so specific sk_err is set and later syscall will
fail usually with EPIPE.

Align the current fastclose error handling with TCP reset,
properly setting the socket error according to the current
msk state and propagating such error.

Additionally sendmsg() is currently not handling properly
the sk_err, always returning EPIPE.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 760404b15cd0..cad0346c9281 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1707,7 +1707,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto out;
 		} else if (ret) {
 			release_sock(ssk);
-			goto out;
+			goto do_error;
 		}
 		release_sock(ssk);
 	}
@@ -1717,9 +1717,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-			goto out;
+			goto do_error;
 	}
 
+	ret = -EPIPE;
+	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
+		goto do_error;
+
 	pfrag = sk_page_frag(sk);
 
 	while (msg_data_left(msg)) {
@@ -1728,11 +1732,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		bool dfrag_collapsed;
 		size_t psize, offset;
 
-		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
-			ret = -EPIPE;
-			goto out;
-		}
-
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
 		 */
@@ -1764,7 +1763,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) != psize) {
 			ret = -EFAULT;
-			goto out;
+			goto do_error;
 		}
 
 		/* data successfully copied into the write queue */
@@ -1796,7 +1795,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
-			goto out;
+			goto do_error;
 	}
 
 	if (copied)
@@ -1804,7 +1803,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 out:
 	release_sock(sk);
-	return copied ? : ret;
+	return copied;
+
+do_error:
+	if (copied)
+		goto out;
+
+	copied = sk_stream_error(sk, msg->msg_flags, ret);
+	goto out;
 }
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
@@ -2441,12 +2447,31 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 		unlock_sock_fast(tcp_sk, slow);
 	}
 
+	/* Mirror the tcp_reset() error propagation */
+	switch (sk->sk_state) {
+	case TCP_SYN_SENT:
+		sk->sk_err = ECONNREFUSED;
+		break;
+	case TCP_CLOSE_WAIT:
+		sk->sk_err = EPIPE;
+		break;
+	case TCP_CLOSE:
+		return;
+	default:
+		sk->sk_err = ECONNRESET;
+	}
+
 	inet_sk_state_store(sk, TCP_CLOSE);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
 
-	mptcp_close_wake_up(sk);
+	/* the calling mptcp_worker will properly destroy the socket */
+	if (sock_flag(sk, SOCK_DEAD))
+		return;
+
+	sk->sk_state_change(sk);
+	sk_error_report(sk);
 }
 
 static void __mptcp_retrans(struct sock *sk)
-- 
2.37.3

