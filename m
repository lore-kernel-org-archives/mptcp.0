Content-Type: multipart/mixed; boundary="===============0965442602153166222=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: Add MPTCP to skb extensions"
Date: Fri, 20 Dec 2019 17:35:41 +0100
Message-ID: <dbcd71e92d92e8274b19057ec94d300d6b374549.1576859688.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3229

--===============0965442602153166222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

address upstream feedback

rebased tree available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v5

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/mptcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f9f668ac4339..326043c29c0a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -21,7 +21,8 @@ struct mptcp_ext {
 			data_fin:1,
 			use_ack:1,
 			ack64:1,
-			__unused:2;
+			__unused:3;
+	/* one byte hole */
 };
 =

 #endif /* __NET_MPTCP_H */
-- =

2.21.0

--===============0965442602153166222==--
