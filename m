Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9841C26
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 12:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663678372; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GpjvZp8eG1XMhnszfU9t3B7yfm1tgPHQdks2c+qkZH2EjOiBESiVy6f+mHxACwAJzKyJ+QPDvAicdbBy9r2EUonh6R6kYih8N1ZUnex+coSPBH99hXf7pJJYQW6fKBw2FjGjFP2+Yp3PqkBnZC+ENMVDAJWs8YL6hOJYn8CxyQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663678372; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=BomVV4olj5Ja7EIR4z671e78rwD9YQdbHSUxTR3sNYc=; 
	b=LpSiXIvbApgb3DniXIe1Eq0c1r4Pr3pYbqdIX+1EZbMNajOyyhAJFO/uQzKT8u7KwHY3cJEIEY0+RX7uTuvopxspzJGY/YbjUyfmg3VT9v1a/UdN6N/koeMiI1XWYYLX3t6aXRfiqUZC+gYhG+2rdbTs1Hx0EKD1aWKONzk/NZE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663678372;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=BomVV4olj5Ja7EIR4z671e78rwD9YQdbHSUxTR3sNYc=;
	b=SDTk3pZMASub7xQ+9nZKJ9oU32C8N9uZ5tC0nGGc9JgU4QVFmKkpk+eAYdMVFT+w
	fuDQBXEgskH/396zi7ygwR8ziGHzSgSWDpTWgYT8s4qrYuaWw04NaU/QceKOpYbnZXL
	DOKlIoXEVVaaBCPdIpokst3iFhaUvsvzsxm7TvNg=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663678369292962.0724831824473; Tue, 20 Sep 2022 14:52:49 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220920125243.2880-5-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v8 4/7] mptfo variables for msk, options. Fix loop retrans
Date: Tue, 20 Sep 2022 14:52:40 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125243.2880-1-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Introduce mptfo variables for msk and options.
Also fix the infinite retransmissions in the end of second session.

The variable 2nd ack received in struct mptcp_options_received identifies t=
he
received ack on the listener side during 3way handshake in mptfo context
and miningless alone if used alone. It is further used(checked)
in conjunction in the same "if" statement with variable is_mptfo
from struct mptcp_sock.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 14 ++++++++++++++
 net/mptcp/options.c  |  4 ++++
 net/mptcp/protocol.h |  6 +++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 9ef49a2d2ea2..92885e459f93 100644
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
+=09msk->can_ack =3D true;
+=09msk->remote_key =3D mp_opt.sndr_key;
+=09mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+=09ack_seq++;
+=09WRITE_ONCE(msk->ack_seq, ack_seq);
+=09pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, mp_opt.sndr_ke=
y);
+=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
+}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..8852a13cfe62 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 =09=09=09ptr +=3D 8;
 =09=09}
 =09=09if (opsize >=3D TCPOLEN_MPTCP_MPC_ACK) {
+=09=09=09mp_opt->hns_2nd_ack_rcvd =3D 1;
 =09=09=09mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 =09=09=09ptr +=3D 8;
 =09=09}
@@ -1124,6 +1125,9 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 =09=09return sk->sk_state !=3D TCP_CLOSE;
=20
 =09if (unlikely(mp_opt.suboptions !=3D OPTION_MPTCP_DSS)) {
+=09=09if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.hns_2nd_ack_rcvd=
 && msk->is_mptfo)
+=09=09=09mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
+
 =09=09if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
 =09=09    msk->local_key =3D=3D mp_opt.rcvr_key) {
 =09=09=09WRITE_ONCE(msk->rcv_fastclose, true);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 57596cdfb1f9..3b9a349a7080 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -155,7 +155,8 @@ struct mptcp_options_received {
 =09=09echo:1,
 =09=09backup:1,
 =09=09deny_join_id0:1,
-=09=09__unused:2;
+=09=09__unused:1;
+=09u8=09hns_2nd_ack_rcvd:1;
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
@@ -842,6 +844,8 @@ int mptcp_stream_connect(struct socket *sock, struct so=
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


