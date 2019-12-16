Content-Type: multipart/mixed; boundary="===============1895243585032097475=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Mon, 16 Dec 2019 13:31:06 +0100
Message-ID: <a9ebee974914c23cc68877a188908d1a8fa07a5f.1576499362.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3074

--===============1895243585032097475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

move sk_pacing_shift to a separate field, so we can READ_ONCE() it.

Binary layout of struct sock dose not change (except for the
sk_pacing_shift position)
---
This addresses Eric's upstream feedback on v1
---
 include/net/sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 9dd225f62012..0930f46c600c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -456,8 +456,8 @@ struct sock {
 				sk_no_check_tx : 1,
 				sk_no_check_rx : 1,
 				sk_userlocks : 4,
-				sk_pacing_shift : 8,
 				sk_type      : 16;
+	u8			sk_pacing_shift;
 	u16			sk_protocol;
 	u16			sk_gso_max_segs;
 	unsigned long	        sk_lingertime;
-- =

2.21.0

--===============1895243585032097475==--
