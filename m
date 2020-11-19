Content-Type: multipart/mixed; boundary="===============8207730898467157435=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 03/10] mptcp: skip to next candidate if
 subflow has unacked data
Date: Thu, 19 Nov 2020 11:45:56 -0800
Message-ID: <20201119194603.103158-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201119194603.103158-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6842

--===============8207730898467157435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

In case a subflow path is blocked, MPTCP-level retransmit may not take
place anymore because such subflow is likely to have unacked data left
in its write queue.

Ignore subflows that have experienced loss and test next candidate.

Fixes: 3b1d6210a95773691 ("mptcp: implement and use MPTCP-level retransmiss=
ion")
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a46a542b1766..806c0658e42f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1725,8 +1725,11 @@ static struct sock *mptcp_subflow_get_retrans(const =
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

2.29.2

--===============8207730898467157435==--
