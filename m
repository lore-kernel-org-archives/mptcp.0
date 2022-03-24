Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABE1FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:58:23 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nXNyo-00070P-6F; Thu, 24 Mar 2022 14:58:22 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 4/4] mptcp: let mptcp listen dump show listen backlog size
Date: Thu, 24 Mar 2022 14:57:53 +0100
Message-Id: <20220324135753.25182-5-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324135753.25182-1-fw@strlen.de>
References: <20220324135753.25182-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before:
State   Recv-Q Send-Q  ..
LISTEN       0      0

After:
LISTEN       0     20

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/mptcp_diag.c | 10 ++++++++--
 net/mptcp/protocol.c   |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 6a6dfc7eac33..e1babab45e86 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -189,8 +189,14 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_info *info = _info;
 
-	r->idiag_rqueue = sk_rmem_alloc_get(sk);
-	r->idiag_wqueue = sk_wmem_alloc_get(sk);
+	if (inet_sk_state_load(sk) == TCP_LISTEN) {
+		r->idiag_rqueue = READ_ONCE(sk->sk_ack_backlog);
+		r->idiag_wqueue = READ_ONCE(sk->sk_max_ack_backlog);
+	} else {
+		r->idiag_rqueue = sk_rmem_alloc_get(sk);
+		r->idiag_wqueue = sk_wmem_alloc_get(sk);
+	}
+
 	if (!info)
 		return;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d3887f628b54..a29cfc4c44a1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3589,8 +3589,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	err = ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-	if (!err)
+	if (!err) {
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		WRITE_ONCE(sock->sk->sk_max_ack_backlog,
+			   READ_ONCE(ssock->sk->sk_max_ack_backlog));
+	}
 
 unlock:
 	release_sock(sock->sk);
-- 
2.34.1

