Content-Type: multipart/mixed; boundary="===============1690776818231635779=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/7] Squash-to: "mptcp: Write MPTCP DSS headers to
 outgoing data packets"
Date: Thu, 09 Jan 2020 17:41:35 +0100
Message-ID: <abcb169d5417f652cabc83742c3d37d8ce163007.1578586484.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3330

--===============1690776818231635779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v1 -> v2:
 - completely drop the check, as is_mptcp is already checked by
   the caller (Mat)

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9b5f37db63b..a78f368b189e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -303,9 +303,6 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	unsigned int opt_size =3D 0;
 	bool ret =3D false;
 =

-	if (!mptcp_subflow_ctx(sk)->mp_capable)
-		return false;
-
 	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
-- =

2.21.0

--===============1690776818231635779==--
