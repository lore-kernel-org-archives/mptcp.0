Content-Type: multipart/mixed; boundary="===============5107460842242290015=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix mptcp socket cleanup
Date: Fri, 30 Aug 2019 14:17:33 +0200
Message-ID: <e88e1256082439491fbfb0b92e254a692b32af7f.1567167420.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1767

--===============5107460842242290015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the mptcp proto ->destruct() is never called.
With token accounting this causes a msk refcount leak.
Kmemleak can't detect that, due to msk <-> sk circular
pointer references.

Invoke the distructor via sk_common_release(), and reduce a
bit code duplication.

Additionally we need to acquire a msk refcount when we initialize
the msk token in mptcp_finish_connect(): not the destructor
is correctly called and the client sock will release the msk a
reference to self at close() time.

Fixes: cd2d4eeca99b ("ptcp: Add key generation and token tree")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
I'm ok with squashing this one in the fixes commit
---
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 52376b1fe64b..c862630897a6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -653,8 +653,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 	release_sock(sk);
 =

-	sock_orphan(sk);
-	sock_put(sk);
+	sk_common_release(sk);
 }
 =

 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
@@ -830,9 +829,14 @@ void mptcp_finish_connect(struct sock *sk, int mp_capa=
ble)
 		local_bh_disable();
 		bh_lock_sock_nested(sk);
 =

+		/* when assiging the token to the msk, we need to held
+		 * an additional reference, will be released at msk token
+		 * destruction time
+		 */
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
+		sock_hold(sk);
 		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 		msk->dport =3D ntohs(inet_sk(msk->subflow->sk)->inet_dport);
 =

-- =

2.21.0


--===============5107460842242290015==--
