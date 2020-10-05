Content-Type: multipart/mixed; boundary="===============3533518176861471619=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash-to: mptcp: keep track of advertised
 windows right edge
Date: Mon, 05 Oct 2020 12:00:40 +0200
Message-ID: <20201005100040.1903854-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6195

--===============3533518176861471619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move oow messages to debug: I guess we don't want to have this in
pr_info() :)
But maybe we don't want these info at all?

My CI saw a few of these messages.

Fixes: 54b7d45eba95 ("mptcp: keep track of advertised windows right edge")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b5a8f8d2175..7d81e9444dd3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -180,7 +180,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk=
, struct sk_buff *skb)
 	if (after64(seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
-		pr_info("oow by %ld\n", (unsigned long)seq - (unsigned long)max_seq);
+		pr_debug("oow by %ld", (unsigned long)seq - (unsigned long)max_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
-- =

2.27.0

--===============3533518176861471619==--
