Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415802C85
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 13:59:32 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mmyzi-0003Tq-EL; Tue, 16 Nov 2021 14:59:30 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 3/4] mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls
Date: Tue, 16 Nov 2021 14:48:03 +0100
Message-Id: <20211116134804.30090-4-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211116134804.30090-1-fw@strlen.de>
References: <20211116134804.30090-1-fw@strlen.de>
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
v3: check for new data unconditionally in SIOCINQ ioctl (Mat Martineau)

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4aaa458d846c..3ab6628ea2b2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -22,6 +22,7 @@
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
+#include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
 
@@ -3261,6 +3262,57 @@ static int mptcp_forward_alloc_get(const struct sock *sk)
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
+	bool slow;
+	int answ;
+
+	switch (cmd) {
+	case SIOCINQ:
+		if (sk->sk_state == TCP_LISTEN)
+			return -EINVAL;
+
+		lock_sock(sk);
+		__mptcp_move_skbs(msk);
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
@@ -3273,6 +3325,7 @@ static struct proto mptcp_prot = {
 	.shutdown	= mptcp_shutdown,
 	.destroy	= mptcp_destroy,
 	.sendmsg	= mptcp_sendmsg,
+	.ioctl		= mptcp_ioctl,
 	.recvmsg	= mptcp_recvmsg,
 	.release_cb	= mptcp_release_cb,
 	.hash		= mptcp_hash,
-- 
2.32.0

