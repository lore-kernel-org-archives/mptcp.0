Content-Type: multipart/mixed; boundary="===============7143051701384753556=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] squash-to "mptcp: Write MPTCP DSS headers to
 outgoing data packets"
Date: Fri, 22 Nov 2019 15:26:13 +0100
Message-ID: <670301e582611f8472c9b46c4ac3f2e733ea6c82.1574432371.git.pabeni@redhat.com>
In-Reply-To: cover.1574432261.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2664

--===============7143051701384753556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 202514088067..dc1d578f4e08 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -248,8 +248,8 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	if (msk) {
 		opts->ext_copy.data_ack =3D msk->ack_seq;
 	} else {
-		mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
-				      NULL, &opts->ext_copy.data_ack);
+		mptcp_crypto_key_sha(mptcp_subflow_ctx(sk)->remote_key,
+				     NULL, &opts->ext_copy.data_ack);
 		opts->ext_copy.data_ack++;
 	}
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3eaffb8bcc14..4541a0cb11cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -298,7 +298,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

-		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
@@ -426,7 +426,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		msk->token =3D subflow->token;
 		msk->write_seq =3D subflow->idsn + 1;
 		subflow->rel_write_seq =3D 1;
-		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		list_add(&subflow->node, &msk->conn_list);
-- =

2.21.0

--===============7143051701384753556==--
