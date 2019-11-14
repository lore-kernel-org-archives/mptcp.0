Content-Type: multipart/mixed; boundary="===============2770570106427102276=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 07/14] subflow: sk_data_ready: make wakeup on tcp sock
 conditional
Date: Thu, 14 Nov 2019 18:32:18 +0100
Message-ID: <20191114173225.21199-8-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2535

--===============2770570106427102276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No need for this unless we don't have a parent or the socket is not
mp capable.

Only the mptcp socket will be waiting for events.  In case the mptcp
socket connected to a tcp-only peer, we're in fallback mode and need
to wakeup the parent too.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ff38d54392cd..976e49349276 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -646,10 +646,13 @@ static void subflow_data_ready(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	subflow->tcp_sk_data_ready(sk);
+	if (!parent || !(subflow->mp_capable || subflow->mp_join)) {
+		subflow->tcp_sk_data_ready(sk);
 =

-	if (!parent || !(subflow->mp_capable || subflow->mp_join))
+		if (parent)
+			parent->sk_data_ready(parent);
 		return;
+	}
 =

 	/* always propagate the EoF */
 	if (mptcp_subflow_data_available(sk) || subflow->rx_eof) {
-- =

2.23.0

--===============2770570106427102276==--
