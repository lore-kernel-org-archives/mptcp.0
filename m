Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E409D1FD0
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594118; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MRMBU3t4L+0jP/ddlv+JSSfHmwRf2kor6iLwcF0etvNF5FfoVS8WgSj4pJF+QqpRWbx/RtPVb1K7qrwYZ8jtB9Tj8QS97xKtu0FEtaTf5W58Aa8dKSzsPC+/nzfLpHKLLEyMaQOIzH9sSvYLjOZXc9LDnCvYajqh6+JpfC3TMCA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594118; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Hi4QhVmL8wZ0IbjMprv/QbjCNPeY+zLZLwhk/ED7cdI=; 
	b=N14effCzYIjSchP3jk1xx0BDMdn+4RQeRdWZUYu0ABEIYeQXF7YrFk0CLyg+psz22LjhF7E2Gi6lit4g/NU7GHNss4J6mJeMZpZGOQAFXukTaNXFpM3BEaP7/z77QLAO+kSEazUhzggCyyREnGCbq8L4YRY0NaShVF+Qf1P5ANA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594118;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Hi4QhVmL8wZ0IbjMprv/QbjCNPeY+zLZLwhk/ED7cdI=;
	b=bKTOEArXM/4YsPBFQgIkjPb3DcGi9onY4v36PwqcTpOH+WoqJl4qP5ZTXso5ugop
	fGoGLAu68V5gAD/9yrNc9E6PF9U8XgobVO+SIvuyNSKkRbm2hbTEmvqR+hkkLJCB9AH
	Y/lgDDt1DFGCVf8IbewLu3U2ziR8HhAInoQL7zR8=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594116580721.4774999567363; Sat, 1 Oct 2022 05:15:16 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221001031502.29152-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 4/7] mptcp: implement delayed seq generation for passive fastopen
Date: Sat,  1 Oct 2022 03:14:59 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221001031502.29152-1-dmytro@shytyi.net>
References: <20221001031502.29152-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

With fastopen in place the first subflow socket is created
before the MPC handshake completes, and we need to properly initialize
the sequence numbers at MPC ACK reception.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 14 ++++++++++++++
 net/mptcp/options.c  |  5 +++++
 net/mptcp/protocol.h |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 65a6a87c0079..dca736c61815 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -25,3 +25,17 @@ void __mptcp_pre_connect(struct mptcp_sock *msk, struct =
sock *ssk,
=20
 =09release_sock(ssk);
 }
+
+void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
+=09=09=09=09   struct mptcp_options_received mp_opt)
+{
+=09u64 ack_seq;
+
+=09WRITE_ONCE(msk->can_ack, true);
+=09WRITE_ONCE(msk->remote_key, mp_opt.sndr_key);
+=09mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+=09ack_seq++;
+=09WRITE_ONCE(msk->ack_seq, ack_seq);
+=09pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, mp_opt.sndr_ke=
y);
+=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
+}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..0b6c4535750c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1208,6 +1208,11 @@ bool mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
 =09=09=09mpext->dsn64 =3D 1;
 =09=09=09mpext->mpc_map =3D 1;
 =09=09=09mpext->data_fin =3D 0;
+
+=09=09=09if (msk->is_mptfo) {
+=09=09=09=09mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
+=09=09=09=09mpext->data_seq =3D READ_ONCE(msk->ack_seq);
+=09=09=09}
 =09=09} else {
 =09=09=09mpext->data_seq =3D mp_opt.data_seq;
 =09=09=09mpext->subflow_seq =3D mp_opt.subflow_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e596f45763fd..c356c993597c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -282,6 +282,7 @@ struct mptcp_sock {
 =09bool=09=09use_64bit_ack; /* Set when we received a 64-bit DSN */
 =09bool=09=09csum_enabled;
 =09bool=09=09allow_infinite_fallback;
+=09bool=09=09is_mptfo;
 =09u8=09=09mpc_endpoint_id;
 =09u8=09=09recvmsg_inq:1,
 =09=09=09cork:1,
@@ -843,6 +844,8 @@ int __mptcp_stream_connect(struct socket *sock, struct =
sockaddr *uaddr,
 // Fast Open Mechanism functions begin
 void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
 =09=09=09 struct msghdr *msg, size_t len);
+void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
+=09=09=09=09   struct mptcp_options_received mp_opt);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
--=20
2.34.1


