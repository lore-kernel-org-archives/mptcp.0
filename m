Content-Type: multipart/mixed; boundary="===============3816219919111302159=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 13/14] mptcp: Reset tsorted_anchor
 after call to tcp_fragment
Date: Thu, 03 May 2018 14:04:57 -0700
Message-ID: <20180503210458.21524-14-cpaasch@apple.com>
In-Reply-To: 20180503210458.21524-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 613

--===============3816219919111302159==
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
index 12733ba2c1e1..b8c69aa17a55 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -634,6 +634,12 @@ static int mptcp_fragment(struct sock *meta_sk, enum t=
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


--===============3816219919111302159==--
