Content-Type: multipart/mixed; boundary="===============4844206296762370730=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: zero token hash at creation time.
Date: Wed, 22 Jul 2020 17:20:50 +0200
Message-ID: <9c1619337f0fa54112c0fe6f0e0100ded392ac3e.1595431172.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5178

--===============4844206296762370730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the 'chain_len' filed will carry random values,
some token creation calls will fail due to excessive chain
length, causing unexpected fallback to TCP.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index b25b390dbbff..97cfc45bcc4f 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -368,7 +368,7 @@ void __init mptcp_token_init(void)
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

--===============4844206296762370730==--
