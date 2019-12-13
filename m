Content-Type: multipart/mixed; boundary="===============1083294667279815050=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: "mptcp: Handle MPTCP TCP options"
Date: Fri, 13 Dec 2019 17:05:58 +0100
Message-ID: <5c5db07440151ba4d26bbbda2a49290e5a8fe9f9.1576252967.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2947

--===============1083294667279815050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch fixes

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 include/linux/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e5859d671111..52798ab00394 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -118,7 +118,8 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 	rx_opt->smc_ok =3D 0;
 #endif
 #if IS_ENABLED(CONFIG_MPTCP)
-	rx_opt->mptcp.mp_capable =3D rx_opt->mptcp.mp_join =3D 0;
+	rx_opt->mptcp.mp_capable =3D 0;
+	rx_opt->mptcp.mp_join =3D 0;
 	rx_opt->mptcp.dss =3D 0;
 #endif
 }
-- =

2.23.0

--===============1083294667279815050==--
