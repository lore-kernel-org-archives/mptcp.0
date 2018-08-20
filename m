Content-Type: multipart/mixed; boundary="===============6535758238566801928=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp:minisocks: fix refcnt when adding to backlog
Date: Mon, 20 Aug 2018 08:52:19 -0700
Message-ID: <20180820155219.16681-3-cpaasch@apple.com>
In-Reply-To: 20180820155219.16681-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 704

--===============6535758238566801928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

It is the same as what we did in the parent commit: if the sock is hold
by user we copy the sk inside the skb before putting the skb inside the
backlog, the sk will be used after from mptcp_backlog_rcv. If the sk
refcnt is not done properly the sk read from mptcp_backlog_rcv could
point to another sk because it may have been freed and reused in the
mean time.

It seems to be very unlikely to arrive in this situation but in theory
it is.

Fixes: 952bd28cc5be (mptcp: correct refcnt for sk in tcp_v{4,6}_rcv)
CC: Gregory Detal <gregory.detal(a)tessares.net>
CC: Benjamin Hesmans <benjamin.hesmans(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
(cherry picked from commit 98209f874fd93e95fd73e03e68be93ee157306dd)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index fafa4479d45f..781c68848f6e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -913,7 +913,7 @@ int tcp_child_process(struct sock *parent, struct sock =
*child,
 		 * socket does not protect us more.
 		 */
 		if (mptcp(tcp_sk(child)))
-			skb->sk =3D child;
+			mptcp_prepare_for_backlog(child, skb);
 		__sk_add_backlog(meta_sk, skb);
 	}
 =

-- =

2.16.2


--===============6535758238566801928==--
