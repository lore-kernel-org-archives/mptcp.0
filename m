Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFB33C3
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663764965; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=I4ZfW1+UJRMHeH5hSxKPZ70/9CUDBdBjPc0HZoVCpyuZeM5hEqY0eE2rzSNOSy7A4IISZLCpw+fF4oGMZwRl/QJxN08yOvuevbtf4ERlppefIkWHnPCpxT1ce9XkK4pMmImcY0a68BYvTp6f0rT8RpM83SY/hw++tsgrN/6KT5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663764965; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=0o8v70YzDAVTa15FuMLgMkERQ9BpXL04ZypaIZkxmuw=; 
	b=ahgNcYn+wXIl2m3xJSaumL4HnMW2AUFqWiZmyyHtwSnhCiOTWs3QM7KpogG5Q9B7ne0BShhxFMxj9sPIuFu3+sNbPQaxW0U234FoXVOrIxSzaOoZwm09oN+hvjwUE2bGUol3SA6SKJ0FRNNW5Eh4q6oxx9eIVR43qlnR1CYfauA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663764965;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=0o8v70YzDAVTa15FuMLgMkERQ9BpXL04ZypaIZkxmuw=;
	b=S7h4oL+6vseTjiNgy0Z/rmN0UD/GKBA7mB+lwM3bq8gg6Ltjz7TPzeoPDGZwzY1O
	akYEn6/VJ05NIxtYwxmMnJMSocS9h69b/4I+ZkmmlHoKnzlWyo4xSOGiWnQVTzbYeJR
	ZYPWg7xaWk3dzqTaUwyYmyiUYqvRsSiXM46VPGaI=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663764963358336.34936517135304; Wed, 21 Sep 2022 14:56:03 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220921125558.19483-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v9 4/6] mptcp: fix retrans., add mptfo vars to msk
Date: Wed, 21 Sep 2022 14:55:56 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921125558.19483-1-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

We use mptcp_gen_msk_ackseq_fasopen()
when we know this is the first chunk of data after MPTFO.
Without it I observe infinite retransmissions.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 14 ++++++++++++++
 net/mptcp/options.c  |  5 +++++
 net/mptcp/protocol.h |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 9ef49a2d2ea2..40c3fb8c75e3 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -30,3 +30,17 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock =
*msk, sockptr_t optval,
=20
 =09return ret;
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
index 57596cdfb1f9..b9e251848099 100644
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
@@ -842,6 +843,8 @@ int mptcp_stream_connect(struct socket *sock, struct so=
ckaddr *uaddr, int addr_l
 // Fast Open Mechanism functions begin
 int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
 =09=09=09=09      unsigned int optlen);
+void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
+=09=09=09=09   struct mptcp_options_received mp_opt);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
--=20
2.25.1


