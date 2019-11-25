Content-Type: multipart/mixed; boundary="===============3265586395831365149=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/7] mptcp: must drop reqsk as well
Date: Mon, 25 Nov 2019 03:15:03 +0100
Message-ID: <20191125021508.29153-3-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2674

--===============3265586395831365149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Add handling of incoming MP_JOIN requests

For incoming join requests we need to also drop the request socket,
it holds a reference on the listener sk.

Without this, each sucessful join causes a refcount leak on
mptcp->subflow listener socket.
---
 net/ipv4/tcp_minisocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index c2d9a47da9c2..65c41894f3dd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -773,8 +773,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 		goto listen_overflow;
 =

 	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
-		inet_csk_reqsk_queue_drop(sk, req);
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
+		inet_csk_reqsk_queue_drop_and_put(sk, req);
 		return child;
 	}
 =

-- =

2.23.0

--===============3265586395831365149==--
