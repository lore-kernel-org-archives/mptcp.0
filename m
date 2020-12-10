Content-Type: multipart/mixed; boundary="===============2091182436385275763=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/9] mptcp: use MPTCPOPT_HMAC_LEN macro
Date: Thu, 10 Dec 2020 14:25:01 -0800
Message-ID: <20201210222506.222251-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201210222506.222251-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7131

--===============2091182436385275763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

Use the macro MPTCPOPT_HMAC_LEN instead of a constant in struct
mptcp_options_received.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f6c3c686a34a..a5bc9599ae5c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -119,7 +119,7 @@ struct mptcp_options_received {
 	u32	token;
 	u32	nonce;
 	u64	thmac;
-	u8	hmac[20];
+	u8	hmac[MPTCPOPT_HMAC_LEN];
 	u8	join_id;
 	u8	use_map:1,
 		dsn64:1,
-- =

2.29.2

--===============2091182436385275763==--
