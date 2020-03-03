Content-Type: multipart/mixed; boundary="===============7719861354617640189=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: always include dack if possible.
Date: Tue, 03 Mar 2020 17:31:03 +0100
Message-ID: <df54b6101eec13563d9b19ff5bd085446ec25ede.1583253028.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3847

--===============7719861354617640189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently passive MPTCP socket can skip including the DACK
option - if the peer sends data before accept() completes.

The above happens because the msk 'can_ack' flag is set
only after the accept() call.

Such missing DACK option may cause - as per RFC spec -
unwanted fallback to TCP.

This change addresses the issue using the key material
available in the current subflow, if any, to create a suitable
dack option when msk ack seq is not yet available.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 29a8ec2aab8d..f64b3e2e508e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -473,6 +473,8 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	struct mptcp_sock *msk;
 	unsigned int ack_size;
 	bool ret =3D false;
+	bool can_ack;
+	u64 ack_seq;
 	u8 tcp_fin;
 =

 	if (skb) {
@@ -499,9 +501,20 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 		ret =3D true;
 	}
 =

+	/* passive sockets msk will set the 'can_ack' after accept(), even
+	 * if the first subflow may have the already the remote key handy
+	 */
+	can_ack =3D true;
 	opts->ext_copy.use_ack =3D 0;
 	msk =3D mptcp_sk(subflow->conn);
-	if (!msk || !READ_ONCE(msk->can_ack)) {
+	if (likely(msk && READ_ONCE(msk->can_ack)))
+		ack_seq =3D msk->ack_seq;
+	else if (subflow->can_ack)
+		mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
+	else
+		can_ack =3D false;
+
+	if (unlikely(!can_ack)) {
 		*size =3D ALIGN(dss_size, 4);
 		return ret;
 	}
@@ -514,7 +527,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 =

 	dss_size +=3D ack_size;
 =

-	opts->ext_copy.data_ack =3D msk->ack_seq;
+	opts->ext_copy.data_ack =3D ack_seq;
 	opts->ext_copy.ack64 =3D 1;
 	opts->ext_copy.use_ack =3D 1;
 =

-- =

2.21.1

--===============7719861354617640189==--
