Content-Type: multipart/mixed; boundary="===============0852506676618849782=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/9] mptcp: zero token hash at creation time.
Date: Fri, 10 Jul 2020 19:22:13 +0200
Message-ID: <3c2e63b14324b8818437ca52ba661ceecbaa5110.1594401165.git.pabeni@redhat.com>
In-Reply-To: cover.1594401165.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4981

--===============0852506676618849782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the 'chain_len' filed will carry random values,
some token creation calls will fail due to excessive chain
lenght, causing unexpected fallback to TCP.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 7d8106026081..c0130e056c9a 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -356,7 +356,7 @@ void __init mptcp_token_init(void)
 					     sizeof(struct token_bucket),
 					     0,
 					     20,/* one slot per 1MB of memory */
-					     0,
+					     HASH_ZERO,
 					     NULL,
 					     &token_mask,
 					     0,
-- =

2.26.2

--===============0852506676618849782==--
