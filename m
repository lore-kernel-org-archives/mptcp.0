Content-Type: multipart/mixed; boundary="===============7961110729177875371=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 6/7] mptcp: reverse order of sk_state_change and
 is_mptcp check
Date: Wed, 15 Apr 2020 19:19:53 +0200
Message-ID: <20200415171954.15321-7-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4185

--===============7961110729177875371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a small race where we can end up in subflow_finish_connect() with
tp->is_mptcp =3D=3D 0 and parent =3D=3D NULL, resulting in a crash.

Just move the is_mptcp check to avoid this.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8b17f8ad8aeb..7ad9413cf9d9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -255,14 +255,14 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

+	if (subflow->conn_finished || !tcp_sk(sk)->is_mptcp)
+		return;
+
 	if (inet_sk_state_load(parent) !=3D TCP_ESTABLISHED) {
 		inet_sk_state_store(parent, TCP_ESTABLISHED);
 		parent->sk_state_change(parent);
 	}
 =

-	if (subflow->conn_finished || !tcp_sk(sk)->is_mptcp)
-		return;
-
 	if (subflow->mp_capable) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
-- =

2.24.1

--===============7961110729177875371==--
