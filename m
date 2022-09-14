Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A153D61
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155124; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=D40uLlUyunCxlQRm17J3AX23Gvv4TedchZgPeDByEIOhFjB6KSRfdJ6M5P+udmO/s3FuxUmV3F6TVrIGVJjtKGGrVCvspHcjZtiBsWDf2d2I61UKXRo55wuzV8TU9fmsHsu4ua28tnf5ULhlb/2CO5yPKVwVQOvsVOdkMEawzVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155124; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=AnzkHbMeF09gpsHbEaxyjil/yFVNltefJMFJDZ/kuyg=; 
	b=Tx8G7W9l62aq1dXH13tq+Nho4KBSLiwmn839dJ7HiVpvyMiSJFvEUtmxIpT23QWgWdbZbG+wSw5G6KHN6u3Jz6wi1Wq/maFgbKDkexXFXDkFS+qtC/GuIBAej4FeCstWajdB5lE30OD0LWkE9fva4fuekdYQu82cc9hUrgECcyE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155124;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=AnzkHbMeF09gpsHbEaxyjil/yFVNltefJMFJDZ/kuyg=;
	b=cSTVCGiPdkFNv2i9jbfOF6ZfZ6gXN6j9kW0JPPSmKWgJjTcSaXmYaCtv505oyJyS
	fVmrePQa8kN+1u5DO0yS2vO9j45FucacDB/qxr4eAPyek0P18p0QVYLzmk5YVSKYoP+
	hEXSGRtR1ZWshB0hDWezxrjOdlVX0YsSe1kWbvHo=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155121891855.2396479757222; Wed, 14 Sep 2022 13:32:01 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 06/10] This commit introduces mptfo variables for msk and options. Also fixes the infinite retransmissions in the end of second session. Suggestion @palbeni (SEP 1) during the meting to 'look at data_ack'
Date: Wed, 14 Sep 2022 13:31:47 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914113151.9898-1-dmytro@shytyi.net>
References: <20220914113151.9898-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This commit introduces mptfo
variables for msk and options. Also fixes the infinite retransmissions in t=
he
end of second session. Suggestion @palbeni (SEP 1) during the meting to 'lo=
ok
at data_ack'

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 16 ++++++++++++++++
 net/mptcp/options.c  |  3 +++
 net/mptcp/protocol.h |  6 +++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 2633d5148dcb..ea46a4b405db 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -85,3 +85,19 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock =
*msk, sockptr_t optval,
=20
 =09return ret;
 }
+
+void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subf=
low_context *subflow,
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
index 30d289044e71..267a346eb0bb 100644
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
+=09=09mptcp_treat_3d_ack_fastopen(msk, subflow, mp_opt);
+
 =09=09if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
 =09=09    msk->local_key =3D=3D mp_opt.rcvr_key) {
 =09=09=09WRITE_ONCE(msk->rcv_fastclose, true);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef8330d5a9b5..a23f4529827e 100644
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
@@ -843,6 +845,8 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msgh=
dr *msg,
 =09=09=09   size_t *copied);
 int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
 =09=09=09=09      unsigned int optlen);
+void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subf=
low_context *subflow,
+=09=09=09=09 struct mptcp_options_received mp_opt);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
--=20
2.25.1


