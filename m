Content-Type: multipart/mixed; boundary="===============3041093937245657424=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/5] Export tcp_send_ack symbol to fix build issue
 with mptcp_fullmesh module (mptcp_trunk). This commit should make it possible
 to revert 64a80850.
Date: Thu, 29 Nov 2018 17:05:10 -0800
Message-ID: <20181130010514.18251-2-cpaasch@apple.com>
In-Reply-To: 20181130010514.18251-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 852

--===============3041093937245657424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kostas Peletidis <kostas(a)peletidis.net>

(cherry picked from commit 6f1b2a04fed74a7eb82cc2db6563c61bd0896eba)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 63caedf168fd..344fed7b7a5d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3709,6 +3709,7 @@ void tcp_send_ack(struct sock *sk)
 {
 	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
 }
+EXPORT_SYMBOL_GPL(tcp_send_ack);
 =

 /* This routine sends a packet with an out of date sequence
  * number. It assumes the other end will try to ack it.
-- =

2.16.2


--===============3041093937245657424==--
