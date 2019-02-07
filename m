Content-Type: multipart/mixed; boundary="===============7532572559357093473=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 2/4] mptcp: don't call mptcp_finish_connect
 with NULL subflow->conn
Date: Thu, 07 Feb 2019 15:27:09 +0100
Message-ID: <20190207142711.3475-3-fw@strlen.de>
In-Reply-To: 20190207142711.3475-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 991

--===============7532572559357093473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

else, mptcp_connect.c gives:

BUG: KASAN: null-ptr-deref in mptcp_finish_connect+0x6d/0x310
Read of size 8 at addr 00000000000007b0 by task mptcp_connect/2095
Call Trace:
 mptcp_finish_connect+0x6d/0x310
 subflow_finish_connect+0x92/0x180
 tcp_finish_connect+0x79/0x210
 tcp_rcv_state_process+0x4e1/0x1f90
 tcp_v4_do_rcv+0x2ac/0x3d0

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3c9dca4be26a..e581eaf198ec 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -124,8 +124,10 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 =

 	if (!subflow->conn_finished) {
 		pr_debug("remote_key=3D%llu", subflow->remote_key);
-		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
-		subflow->conn_finished =3D 1;
+		if (subflow->conn) {
+			mptcp_finish_connect(subflow->conn, subflow->mp_capable);
+			subflow->conn_finished =3D 1;
+		}
 =

 		if (skb) {
 			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
-- =

2.19.2


--===============7532572559357093473==--
