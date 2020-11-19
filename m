Content-Type: multipart/mixed; boundary="===============1765491052304916912=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: protect the rx path with
 the msk socket spinlock"
Date: Thu, 19 Nov 2020 22:57:32 +0100
Message-ID: <b1ff505e3dcff29eda4a2f3354c3a9d1223e4390.1605823023.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6851

--===============1765491052304916912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

drop left-over splicing from the join list, we don't need
it anymore there.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f55dc414c403..7c3508dae1c8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1698,7 +1698,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 =

 	len =3D min_t(size_t, len, INT_MAX);
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
-	__mptcp_flush_join_list(msk);
 =

 	for (;;) {
 		int bytes_read, old_space;
-- =

2.26.2

--===============1765491052304916912==--
