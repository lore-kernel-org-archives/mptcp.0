Content-Type: multipart/mixed; boundary="===============1345798039423103204=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/9] subflow: always init 'rel_write_seq'
Date: Fri, 10 Jul 2020 19:22:10 +0200
Message-ID: <a412198c8004d7c616aa6c0875c42c730fea7f34.1594401165.git.pabeni@redhat.com>
In-Reply-To: cover.1594401165.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4978

--===============1345798039423103204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we do not init the subflow write sequence for
MP_JOIN subflows. This will cause bad mapping being
generated as soon as we will use non backup subflow.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 1 -
 net/mptcp/subflow.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c28b9aed3958..02eb37a3122b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1819,7 +1819,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	ack_seq++;
 	subflow->map_seq =3D ack_seq;
 	subflow->map_subflow_seq =3D 1;
-	subflow->rel_write_seq =3D 1;
 =

 	/* the socket is not connected yet, no msk/subflow ops can access/race
 	 * accessing the field below
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9f7f3772c13c..0bdd57251da4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -200,6 +200,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	if (subflow->conn_finished)
 		return;
 =

+	subflow->rel_write_seq =3D 1;
 	subflow->conn_finished =3D 1;
 	subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=3D%p synack seq=3D%x", subflow, subflow->ssn_offset);
-- =

2.26.2

--===============1345798039423103204==--
