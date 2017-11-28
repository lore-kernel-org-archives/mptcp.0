Content-Type: multipart/mixed; boundary="===============4047668267681752440=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 12/25] tcp_extra_options: Export module fixes
Date: Mon, 27 Nov 2017 21:57:13 -0800
Message-ID: <20171128055726.430-13-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 187

--===============4047668267681752440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise compiling v6 in a module does not work and remove some
export_symbol's that were not needed.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 01e646873613..1afd56638854 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -309,6 +309,7 @@ EXPORT_SYMBOL(tcp_sockets_allocated);
  * Optional TCP option handlers
  */
 DEFINE_STATIC_KEY_FALSE(tcp_extra_options_enabled);
+EXPORT_SYMBOL_GPL(tcp_extra_options_enabled);
 =

 /*
  * TCP splice context
@@ -3518,7 +3519,6 @@ void tcp_extra_options_parse(int opcode, int opsize, =
const unsigned char *opptr,
 	if (entry && entry->ops->parse)
 		entry->ops->parse(opsize, opptr, skb, opt_rx, sk, entry);
 }
-EXPORT_SYMBOL_GPL(tcp_extra_options_parse);
 =

 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
-- =

2.15.0


--===============4047668267681752440==--
