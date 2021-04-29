Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6972
	for <mptcp@lists.linux.dev>; Thu, 29 Apr 2021 12:01:07 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lc5Ln-0001o7-1J; Thu, 29 Apr 2021 14:00:59 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp] mptcp: fix close of larval mptcp sockets
Date: Thu, 29 Apr 2021 14:00:49 +0200
Message-Id: <20210429120049.8703-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If userspace exits before calling accept() on a listener that had at
least one new connection ready, we get:

  Attempt to release TCP socket in state 8

This happens because the mptcp socket gets cloned when the TCP
connection is ready, but the socket is never exposed to userspace.

Tag the cloned socket until userspace calls accept().

In case a subflow context is destroyed, check the associated mptcp
socket.  If its still in larval state, it has not been exposed to
userspace, so it needs the DEAD flag and its state set to TCP_CLOSE.

Fixes: 58b09919626bf ("mptcp: create msk early")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/185
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Please don't apply, this needs to be reviewd by Paolo.
 The extra release hack/check in subflow_ulp_release gives
 me unpleasant headache, i.e. I have no idea what I am doing.

 net/mptcp/protocol.c                          |  1 +
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/subflow.c                           |  5 ++++
 .../net/mptcp/regressions/exit_unaccept.c     | 29 +++++++++++++++++++
 4 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/regressions/exit_unaccept.c

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aec8e77b18e4..69a64401ecef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2832,6 +2832,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		/* acquire the 2nd reference for the owning socket */
 		sock_hold(new_mptcp_sock);
 		newsk = new_mptcp_sock;
+		mptcp_sk(newsk)->is_larval = 0;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 	} else {
 		MPTCP_INC_STATS(sock_net(sk),
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d230a75af631..839837b5957b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,6 +257,7 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 
+	u8 is_larval:1;		/* incoming mptcp sk cloned but not yet acccepted */
 	u32 setsockopt_seq;
 };
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15620bafc544..00264c6f6479 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -649,6 +649,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
 		if (!new_msk)
 			fallback = true;
+		mptcp_sk(new_msk)->is_larval = 1;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
 		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
@@ -1570,6 +1571,10 @@ static void subflow_ulp_release(struct sock *ssk)
 		 * when the subflow is still unaccepted
 		 */
 		release = ctx->disposable || list_empty(&ctx->node);
+		if (mptcp_sk(sk)->is_larval) {
+			sk->sk_state = TCP_CLOSE;
+			sock_orphan(sk);
+		}
 		sock_put(sk);
 	}
 

