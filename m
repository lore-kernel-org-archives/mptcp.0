Content-Type: multipart/mixed; boundary="===============8717526780857554662=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 14/25] tcp_extra_options: Check static branch
 before _parse
Date: Mon, 27 Nov 2017 21:57:15 -0800
Message-ID: <20171128055726.430-15-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 189

--===============8717526780857554662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_input.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4e84f299c96f..7acc1f46641c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3799,9 +3799,11 @@ void tcp_parse_options(const struct net *net,
 				break;
 =

 			default:
-				tcp_extra_options_parse(opcode, opsize, ptr,
-							skb, opt_rx,
-							tcp_to_sk(tp));
+				if (static_branch_unlikely(&tcp_extra_options_enabled))
+					tcp_extra_options_parse(opcode, opsize,
+								ptr, skb,
+								opt_rx,
+								tcp_to_sk(tp));
 				break;
 =

 			}
-- =

2.15.0


--===============8717526780857554662==--
