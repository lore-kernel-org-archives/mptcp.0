Content-Type: multipart/mixed; boundary="===============1097291285840700647=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 4/7] Squash-to: "mptcp: Write MPTCP DSS headers to
 outgoing data packets"
Date: Wed, 08 Jan 2020 15:47:21 +0100
Message-ID: <cd0f7bfec9008860447b9d26c39bd3442b6bfd50.1578487811.git.pabeni@redhat.com>
In-Reply-To: cover.1578487811.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3293

--===============1097291285840700647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

use 'is_tcp' to check for TCP fallback instead of mp_capable (and later
mp_join).

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9b5f37db63b..25a46420b06d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -303,7 +303,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	unsigned int opt_size =3D 0;
 	bool ret =3D false;
 =

-	if (!mptcp_subflow_ctx(sk)->mp_capable)
+	if (!tcp_sk(sk)->is_mptcp)
 		return false;
 =

 	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
-- =

2.21.0

--===============1097291285840700647==--
