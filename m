Content-Type: multipart/mixed; boundary="===============8795617640466799767=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 2/5] Squash-to: "mptcp: Add path manager interface"
Date: Fri, 20 Mar 2020 19:34:40 +0100
Message-ID: <5d4aa2018c7b6049e83c71c7f89adcf1e404a6c2.1584728932.git.pabeni@redhat.com>
In-Reply-To: cover.1584728931.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4028

--===============8795617640466799767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Same as previous patch

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fdab1869bf10..b21ea3147b91 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -692,8 +692,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 =

 	mpext->data_fin =3D mp_opt->data_fin;
 =

-	if (msk)
-		mptcp_pm_fully_established(msk);
+	mptcp_pm_fully_established(msk);
 }
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
-- =

2.21.1

--===============8795617640466799767==--
