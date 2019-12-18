Content-Type: multipart/mixed; boundary="===============5793400645217647065=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] Squash-to: "mptcp: Add MPTCP socket stubs"
Date: Wed, 18 Dec 2019 13:22:48 +0100
Message-ID: <22048bea67adf1cece50cb6aac1c736e3ce9d0dd.1576671427.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3135

--===============5793400645217647065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

we will really support MSG_DONTWAIT in sendmsg()
and better set similar constraint on recvmsg() instead of
comments in later patch
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2e0a3266725a..cbd6c1e0fb96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -22,7 +22,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct socket *subflow =3D msk->subflow;
 =

-	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
+	if (msg->msg_flags & ~(MSG_MORE | MSG_NOSIGNAL))
 		return -EOPNOTSUPP;
 =

 	return sock_sendmsg(subflow, msg);
@@ -34,6 +34,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct socket *subflow =3D msk->subflow;
 =

+	if (msg->msg_flags & ~(MSG_MORE | MSG_PEEK))
+		return -EOPNOTSUPP;
+
 	return sock_recvmsg(subflow, msg, flags);
 }
 =

-- =

2.21.0

--===============5793400645217647065==--
