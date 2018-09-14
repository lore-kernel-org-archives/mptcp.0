Content-Type: multipart/mixed; boundary="===============0924148013105870063=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 13/20] mptcp: Reset tsorted_anchor after call to
 tcp_fragment
Date: Fri, 14 Sep 2018 10:25:17 -0700
Message-ID: <20180914172524.67961-16-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 746

--===============0924148013105870063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The reinject-queue is special in the sense that its segments get kfree'd
right after sending. We need to make sure that the dst-pointer is NULL
as otherwise during the freeing we will access garbage.

Fixes: 8a1051d977cf ("Merge tag 'v4.15' into mptcp_trunk")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit e4eeb8266879fd69407381751ddcd232d266d0b8)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_output.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index c4e204f5ad72..c0b2c9ff8ca2 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -637,6 +637,12 @@ static int mptcp_fragment(struct sock *meta_sk, enum t=
cp_queue tcp_queue,
 			if (undo)
 				tcp_adjust_pcount(meta_sk, skb, -undo);
 		}
+
+		/* tcp_fragment's call to sk_stream_alloc_skb initializes the
+		 * tcp_tsorted_anchor. We need to revert this as it clashes
+		 * with the refdst pointer.
+		 */
+		tcp_skb_tsorted_anchor_cleanup(buff);
 	}
 =

 	return 0;
-- =

2.16.2


--===============0924148013105870063==--
