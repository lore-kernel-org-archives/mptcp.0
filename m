Content-Type: multipart/mixed; boundary="===============7114191749561329115=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: remove msk->subflow->sk dereference in
 pr_debug statement
Date: Thu, 22 Aug 2019 11:41:10 -0700
Message-ID: <20190822184110.2456-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1679

--===============7114191749561329115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

msk->subflow may be NULL when creation of an mptcp_sock fails due
to the protocol not being enabled.

squashto: Add key generation and token tree

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aaa71b161c1a..a58211d8568c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -702,7 +702,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
+	pr_debug("msk=3D%p", sk);
 =

 	token_destroy(msk->token);
 }
-- =

2.17.2


--===============7114191749561329115==--
