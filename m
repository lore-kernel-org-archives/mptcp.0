Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA772
	for <mptcp@lists.linux.dev>; Mon,  3 May 2021 10:02:38 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1ldVPL-0004ic-6i; Mon, 03 May 2021 12:02:31 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH] mptcp: fix splat when closing unaccepted socket
Date: Mon,  3 May 2021 12:02:24 +0200
Message-Id: <20210503100224.22433-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

If userspace exits before calling accept() on a listener that had at least
one new connection ready, we get:

   Attempt to release TCP socket in state 8

This happens because the mptcp socket gets cloned when the TCP connection
is ready, but the socket is never exposed to userspace.

The client additionally sends a DATA_FIN, which brings connection into
CLOSE_WAIT state.  This in turn prevents the orphan+state reset fixup
in mptcp_sock_destruct() from doing its job.

Fixes: 3721b9b64676b ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/185
Tested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15620bafc544..01f30f8ea710 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -546,8 +546,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 	 * ESTABLISHED state and will not have the SOCK_DEAD flag.
 	 * Both result in warnings from inet_sock_destruct.
 	 */
-
-	if (sk->sk_state == TCP_ESTABLISHED) {
+	if ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		sk->sk_state = TCP_CLOSE;
 		WARN_ON_ONCE(sk->sk_socket);
 		sock_orphan(sk);
-- 
2.26.3

