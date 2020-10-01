Content-Type: multipart/mixed; boundary="===============1882047952683427296=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: skip to next candidate if subflow
 has unacked data
Date: Thu, 01 Oct 2020 10:14:06 +0200
Message-ID: <20201001081406.4548-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6126

--===============1882047952683427296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case a subflow path is blocked, MPTCP-level retransmit may not take
place anymore because such subflow is likely to have unacked data left
in its write queue.

Ignore subflows that have experienced loss and test next candidate.

Fixes: 3b1d6210a95773691 ("mptcp: implement and use MPTCP-level retransmiss=
ion")
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7aa52a3bc5e2..0266d8ac24d2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1732,8 +1732,11 @@ static struct sock *mptcp_subflow_get_retrans(const =
struct mptcp_sock *msk)
 			continue;
 =

 		/* still data outstanding at TCP level?  Don't retransmit. */
-		if (!tcp_write_queue_empty(ssk))
+		if (!tcp_write_queue_empty(ssk)) {
+			if (inet_csk(ssk)->icsk_ca_state >=3D TCP_CA_Loss)
+				continue;
 			return NULL;
+		}
 =

 		if (subflow->backup) {
 			if (!backup)
-- =

2.26.2

--===============1882047952683427296==--
