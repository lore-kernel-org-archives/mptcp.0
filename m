Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C86718
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286188; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NoWX8/03wXgQKm9h8Oc1hNclai9zNlZFk5cRtV51TDMYldEskezRHtJsSuTTajudKfIvoWv3ANi7TmS7WUsokNO1gStK80btFgipz26aDmMD17W1r3yqIR3BEfFFwBZbQr9EQ/e0lCim4v9Y4EPrFfMhe+GziSNXeoPxGecBDVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286188; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=BffKtKL+iY7yu11hLHREQ3MEbrwGh7lMWG68utuU7Gw=; 
	b=KGLEfn/EZEPhGRmwKSLyyfURIcJ+MwHVp8ZIdVpkfeUNmehv7plPp9j0zMR0fP+BXWlXIXYYvjWXaGZv0ct8Dyerf12rdf0CMWoBdxT/vbXhRmEdCWNMZ7xc+f1C5mz/whF5Ekb6hKv6FbLDJaMl+NGhJay6B+B+z9Vf/tlvrtw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286188;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=BffKtKL+iY7yu11hLHREQ3MEbrwGh7lMWG68utuU7Gw=;
	b=RraBTiCs+dea2ZL3I69nVkVfFrL0DJ4LlLtUTF7NYd0aVTv9TjgG/H5r6pTU8pxs
	T46oy4aRtOoHewB15/1EoEzxOjOlYNiLbxOGhKBXVuDi5YnZ4BtlXFqye6CpG33fUzq
	/fO10HS3bIR3oL2XA9x6JUa4VhMuC4D+RqlrBcSs=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663286185231612.162719830736; Fri, 16 Sep 2022 01:56:25 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-7-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 6/9] mptfo variables for msk, options. Fix loop retrans
Date: Fri, 16 Sep 2022 01:56:01 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915235604.26018-1-dmytro@shytyi.net>
References: <20220915235604.26018-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Introduce mptfo variables for msk and options.=20
Also fixe the infinite retransmissions in the end of second session.=20
Suggestion @palbeni (SEP 1) during the meting to 'look at data_ack'

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 16 ++++++++++++++++
 net/mptcp/options.c  |  3 +++
 net/mptcp/protocol.h |  6 +++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 436e773d798a..149a4b1d3dac 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -91,3 +91,19 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock =
*msk, sockptr_t optval,
=20
 =09return ret;
 }
+
+void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_=
subflow_context *subflow,
+=09=09=09=09 struct mptcp_options_received mp_opt)
+{
+=09u64 ack_seq;
+
+=09if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.is_mptfo && msk->is=
_mptfo) {
+=09=09msk->can_ack =3D true;
+=09=09msk->remote_key =3D mp_opt.sndr_key;
+=09=09mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+=09=09ack_seq++;
+=09=09WRITE_ONCE(msk->ack_seq, ack_seq);
+=09=09pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, mp_opt.sndr=
_key);
+=09=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
+=09}
+}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..185b069e57f4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 =09=09=09ptr +=3D 8;
 =09=09}
 =09=09if (opsize >=3D TCPOLEN_MPTCP_MPC_ACK) {
+=09=09=09mp_opt->is_mptfo =3D 1;
 =09=09=09mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 =09=09=09ptr +=3D 8;
 =09=09}
@@ -1124,6 +1125,8 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 =09=09return sk->sk_state !=3D TCP_CLOSE;
=20
 =09if (unlikely(mp_opt.suboptions !=3D OPTION_MPTCP_DSS)) {
+=09=09mptcp_treat_hshake_ack_fastopen(msk, subflow, mp_opt);
+
 =09=09if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
 =09=09    msk->local_key =3D=3D mp_opt.rcvr_key) {
 =09=09=09WRITE_ONCE(msk->rcv_fastclose, true);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a4b6dfb6f8f..c364616c2d56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -155,7 +155,8 @@ struct mptcp_options_received {
 =09=09echo:1,
 =09=09backup:1,
 =09=09deny_join_id0:1,
-=09=09__unused:2;
+=09=09is_mptfo:1,
+=09=09__unused:1;
 =09u8=09join_id;
 =09u64=09thmac;
 =09u8=09hmac[MPTCPOPT_HMAC_LEN];
@@ -282,6 +283,7 @@ struct mptcp_sock {
 =09bool=09=09use_64bit_ack; /* Set when we received a 64-bit DSN */
 =09bool=09=09csum_enabled;
 =09bool=09=09allow_infinite_fallback;
+=09bool=09=09is_mptfo;
 =09u8=09=09mpc_endpoint_id;
 =09u8=09=09recvmsg_inq:1,
 =09=09=09cork:1,
@@ -848,6 +850,8 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msgh=
dr *msg,
 =09=09=09   size_t *copied);
 int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
 =09=09=09=09      unsigned int optlen);
+void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_=
subflow_context *subflow,
+=09=09=09=09     struct mptcp_options_received mp_opt);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
--=20
2.25.1


