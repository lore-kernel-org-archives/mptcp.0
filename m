Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC771
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 00:16:46 +0000 (UTC)
IronPort-SDR: xJcsM3wRuUGdkIb7yE2kFbYcUNfOZZZzPiV17tzkXPRTCmvYPhXdShvHbos+3njOMgU3U9hVpe
 AmEIvmb1ryjA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="195494646"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="195494646"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 17:16:44 -0700
IronPort-SDR: Cmje+R+0xIyzi/0fLQnmPLZ2EZzjoWZxJLCqI9Z2I6ENWIcSnW5T0H1eQhpAQLPLFMvyqEehwB
 BuTvC90JgwSA==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="434644838"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.15.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 17:16:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net] mptcp: fix splat when closing unaccepted socket
Date: Thu,  6 May 2021 17:16:38 -0700
Message-Id: <20210507001638.225468-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 82e91b00ad39..a5ede357cfbc 100644
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

base-commit: 8621436671f3a4bba5db57482e1ee604708bf1eb
-- 
2.31.1

