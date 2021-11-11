Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB82C81
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 15:14:37 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mlBme-0000N6-7d; Thu, 11 Nov 2021 16:14:36 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 mptcp-next 3/4] mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls
Date: Thu, 11 Nov 2021 16:14:17 +0100
Message-Id: <20211111151418.17276-4-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211111151418.17276-1-fw@strlen.de>
References: <20211111151418.17276-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows to query in-sequence data ready for read(), total bytes in
write queue and total bytes in write queue that have not yet been sent.

v2: remove unneeded READ_ONCE() (Paolo Abeni)

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 61047d04e849..1c4604283b00 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -22,6 +22,7 @@
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
+#include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
 
@@ -3260,6 +3261,58 @@ static int mptcp_forward_alloc_get(const struct sock *sk)
 	return sk->sk_forward_alloc + mptcp_sk(sk)->rmem_fwd_alloc;
 }
 
+static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
+{
+	const struct sock *sk = (void *)msk;
+	u64 delta;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -EINVAL;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	delta = msk->write_seq - v;
+	if (delta > INT_MAX)
+		delta = INT_MAX;
+
+	return (int)delta;
+}
+
+static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int answ;
+	bool slow;
+
+	switch (cmd) {
+	case SIOCINQ:
+		if (sk->sk_state == TCP_LISTEN)
+			return -EINVAL;
+
+		lock_sock(sk);
+		if (skb_queue_empty(&msk->receive_queue))
+			__mptcp_move_skbs(msk);
+		answ = mptcp_inq_hint(sk);
+		release_sock(sk);
+		break;
+	case SIOCOUTQ:
+		slow = lock_sock_fast(sk);
+		answ = mptcp_ioctl_outq(msk, READ_ONCE(msk->snd_una));
+		unlock_sock_fast(sk, slow);
+		break;
+	case SIOCOUTQNSD:
+		slow = lock_sock_fast(sk);
+		answ = mptcp_ioctl_outq(msk, msk->snd_nxt);
+		unlock_sock_fast(sk, slow);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return put_user(answ, (int __user *)arg);
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -3272,6 +3325,7 @@ static struct proto mptcp_prot = {
 	.shutdown	= mptcp_shutdown,
 	.destroy	= mptcp_destroy,
 	.sendmsg	= mptcp_sendmsg,
+	.ioctl		= mptcp_ioctl,
 	.recvmsg	= mptcp_recvmsg,
 	.release_cb	= mptcp_release_cb,
 	.hash		= mptcp_hash,
-- 
2.32.0

