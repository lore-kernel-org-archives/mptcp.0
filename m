Content-Type: multipart/mixed; boundary="===============3073082669046136228=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: avoid removing useful skbs from the
 reinject queue.
Date: Fri, 14 Sep 2018 10:25:04 -0700
Message-ID: <20180914172524.67961-3-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 725

--===============3073082669046136228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Patrick Havelange <patrick.havelange(a)tessares.net>

After inserting the skbs in the reinject queue, the code was checking
if it could remove potentially existing segments that are now no
longer necessary. One condition for being able to remove such skbs
was missing, resulting in potentially useful skbs being removed
(i.e. they were NON redundant by others skbs !) from the reinject queue.
In fact this logic is similar to the one in tcp_data_queue_ofo().

Fixes: Zero-day-bug
Signed-off-by: Patrick Havelange <patrick.havelange(a)tessares.net>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
(cherry picked from commit 877fa7d1f02ac68ba74fc918c4ae214413f33466)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 3dd4c17c7681..293999037f4c 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -277,6 +277,9 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
 			break;
 =

+		if (before(end_seq, TCP_SKB_CB(skb1)->end_seq))
+			break;
+
 		__skb_unlink(skb1, &mpcb->reinject_queue);
 		__kfree_skb(skb1);
 	}
-- =

2.16.2


--===============3073082669046136228==--
