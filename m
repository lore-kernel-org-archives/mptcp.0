Content-Type: multipart/mixed; boundary="===============7481530748494449120=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/6] options: ack pending sequence
Date: Fri, 08 Nov 2019 23:09:51 +0100
Message-ID: <20191108220953.30904-5-fw@strlen.de>
In-Reply-To: 20191108220953.30904-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2453

--===============7481530748494449120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows us to include some of the bytes already pending on the subflow
in the DSS ack instead of having to wait for the next recv (which
updates msk->ack_seq value).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 80dbe7662cea..b488bf07ada5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -418,13 +418,20 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 		ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
 =

 	if (ack_size <=3D remaining) {
+		const struct mptcp_subflow_context *subflow;
 		struct mptcp_sock *msk;
 =

 		dss_size +=3D ack_size;
 =

-		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+		subflow =3D mptcp_subflow_ctx(sk);
+		msk =3D mptcp_sk(subflow->conn);
 		if (msk) {
-			opts->ext_copy.data_ack =3D msk->ack_seq;
+			u64 ack_seq =3D READ_ONCE(msk->ack_seq);
+
+			if (subflow->map_valid)
+				ack_seq +=3D subflow->data_avail;
+
+			opts->ext_copy.data_ack =3D ack_seq;
 		} else {
 			mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
 					      NULL, &opts->ext_copy.data_ack);
-- =

2.23.0

--===============7481530748494449120==--
