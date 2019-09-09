Content-Type: multipart/mixed; boundary="===============1773047030473642033=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 6/6] mptcp: use __tcp_poll instead of tcp_poll
Date: Mon, 09 Sep 2019 17:53:18 +0200
Message-ID: <20190909155317.31119-7-fw@strlen.de>
In-Reply-To: 20190909155317.31119-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1805

--===============1773047030473642033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_poll places current task on a wait queue.  This can cause us to block
forever -- some subflows might be backup/failover and never receive any
data.

Use __tcp_poll instead to avoid blocking current task again after parent
mptcp socket has been woken up from the subflow layer.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a91fff1f385..533fe2c50d3a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1182,7 +1182,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 		struct socket *tcp_sock;
 =

 		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
-		ret |=3D tcp_poll(file, tcp_sock, wait);
+		ret |=3D __tcp_poll(tcp_sock->sk);
 	}
 	release_sock(sk);
 =

-- =

2.21.0


--===============1773047030473642033==--
