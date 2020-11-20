Content-Type: multipart/mixed; boundary="===============7784486379587192759=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: use mptcp release_cb for
 delayed tasks"
Date: Fri, 20 Nov 2020 10:07:03 +0100
Message-ID: <d1c5f67cad16df705f4ac9ab6d830fa02350e0a0.1605863183.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6869

--===============7784486379587192759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix uninitialized local variable usage.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Side notes:
- not sure why gcc did not complain here
- if we will use the usual tags propagation schema will not credit
  the kernel test robot, on the flip side, I'm not sure if a:

Co-developed-by: kernel test robot <lkp(a)intel.com>

  tag is what we want ;)
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c42f92764ec9..69441ea71411 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1488,7 +1488,6 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 	struct mptcp_sendmsg_info info;
 	struct mptcp_data_frag *dfrag;
 	int len, copied =3D 0;
-	u32 sndbuf;
 =

 	info.flags =3D 0;
 	while ((dfrag =3D mptcp_send_head(sk))) {
@@ -1500,8 +1499,8 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 =

 			/* do auto tuning */
 			if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
-			    sndbuf > READ_ONCE(sk->sk_sndbuf))
-				WRITE_ONCE(sk->sk_sndbuf, sndbuf);
+			    ssk->sk_sndbuf > READ_ONCE(sk->sk_sndbuf))
+				WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
 =

 			if (unlikely(mptcp_must_reclaim_memory(sk, ssk))) {
 				__mptcp_update_wmem(sk);
-- =

2.26.2

--===============7784486379587192759==--
