Content-Type: multipart/mixed; boundary="===============8643981134083607161=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: Add MPTCP socket stubs"
Date: Wed, 18 Dec 2019 17:11:27 +0100
Message-ID: <3e4ffcf745e9f34ad46a21bff91f199c882ef740.1576685173.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3141

--===============8643981134083607161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

whoops, bad bitmask in previous commit - we must enumerate
the supported {recv,send}msg flags.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cbd6c1e0fb96..5e24e7cf7d70 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -22,7 +22,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct socket *subflow =3D msk->subflow;
 =

-	if (msg->msg_flags & ~(MSG_MORE | MSG_NOSIGNAL))
+	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
 		return -EOPNOTSUPP;
 =

 	return sock_sendmsg(subflow, msg);
@@ -34,7 +34,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct socket *subflow =3D msk->subflow;
 =

-	if (msg->msg_flags & ~(MSG_MORE | MSG_PEEK))
+	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 =

 	return sock_recvmsg(subflow, msg, flags);
-- =

2.21.0

--===============8643981134083607161==--
