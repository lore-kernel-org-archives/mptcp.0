Content-Type: multipart/mixed; boundary="===============3804561589978019696=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/7] mptcp: reduce number of pr_debug() calls.
Date: Wed, 05 Jun 2019 17:36:29 -0700
Message-ID: <20190606003632.2863-5-peter.krystad@linux.intel.com>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1299

--===============3804561589978019696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squash to: Implement MPTCP receive path

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 78ce42b1617a..11b6855cc9ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -747,7 +747,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		pr_debug("token=3D%u", msk->token);
+		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
-- =

2.17.2


--===============3804561589978019696==--
