Content-Type: multipart/mixed; boundary="===============5062981414437464047=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net v2] mptcp: fix pending data accounting
Date: Mon, 14 Dec 2020 16:24:18 +0100
Message-ID: <edd14c0ddd620edf4acb99c0b9ef9012a97e7461.1607959409.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7165

--===============5062981414437464047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When sendmsg() needs to wait for memory, the pending data
is not updated. That causes a drift in forward memory allocation,
leading to stall and/or warnings at socket close time.

This change addresses the above issue moving the pending data
counter update inside the sendmsg() main loop.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - really fix broken accounting
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8ec9e4582d18..b372e4b18092 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1658,6 +1658,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		frag_truesize +=3D psize;
 		pfrag->offset +=3D frag_truesize;
 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
+		msk->tx_pending_data +=3D psize;
 =

 		/* charge data on mptcp pending queue to the msk socket
 		 * Note: we charge such data both to sk and ssk
@@ -1683,10 +1684,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 			goto out;
 	}
 =

-	if (copied) {
-		msk->tx_pending_data +=3D copied;
+	if (copied)
 		mptcp_push_pending(sk, msg->msg_flags);
-	}
 =

 out:
 	release_sock(sk);
-- =

2.26.2

--===============5062981414437464047==--
