Content-Type: multipart/mixed; boundary="===============3558999971646710629=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: "mptcp: Write MPTCP DSS headers to
 outgoing data packets"
Date: Fri, 13 Dec 2019 17:06:00 +0100
Message-ID: <b9c0b3366d312b75cdc4f840dab49f8ab21d71fc.1576252967.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2951

--===============3558999971646710629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch fixes

Signed-off-by_ Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 672f7f1288f8..c9b5f37db63b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -309,7 +309,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
-						 opts))
+					       opts))
 		ret =3D true;
 =

 	/* we reserved enough space for the above options, and exceeding the
-- =

2.23.0

--===============3558999971646710629==--
