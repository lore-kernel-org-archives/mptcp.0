Content-Type: multipart/mixed; boundary="===============7853382203338576022=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 11/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:54 +0200
Message-ID: <20190615105259.15151-12-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1396

--===============7853382203338576022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - Missing a blank line after declarations

What has not been fixed:

 - /

Fixes: 9d7d4a7af7b2 (mptcp: add and use mptcp_subflow_hold)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 503cd796595c..91a6f428fac3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -846,7 +846,7 @@ static int mptcp_stream_accept(struct socket *sock, str=
uct socket *newsock,
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
-	struct subflow_context *subflow, *tmp;
+	struct subflow_context *subflow;
 	const struct mptcp_sock *msk;
 	struct sock *sk =3D sock->sk;
 	__poll_t ret =3D 0;
@@ -858,8 +858,8 @@ static __poll_t mptcp_poll(struct file *file, struct so=
cket *sock,
 =

 	i =3D 0;
 	for (;;) {
+		struct subflow_context *tmp =3D NULL;
 		int j =3D 0;
-		tmp =3D NULL;
 =

 		rcu_read_lock();
 		mptcp_for_each_subflow(msk, subflow) {
-- =

2.20.1


--===============7853382203338576022==--
