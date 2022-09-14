Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CB3D7A
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WCpLiyE8ErMQnMlFmhJ2eol00b/sa7JnBLdGArKMWz+Cexit5pm0JyUwCMsQSXfnuJ3EmjO9LHJDEHe/gRlfenl5P6jAqO6xgSg0bjjdYsit/TMSQH/8u4A6A21A/hhM4f5jMQd0qSUYqFK34oLCerk5dlHUS+szLVfjcOueUE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=tXQzcJsaQRvHfHiIz7fRfp+oTNZ3PwuWxcPHG1ShdwM=; 
	b=aEttWlVlOhXWDhR2gFPuIPtETBMkHyd6UhGOAImDscVLjVogWzqwNtY0R/lc2KAfbNtYRQDpqqHAterSt4y7rxeUvdOSILNJrlaw9KBIcNoYJq5feQE1rd/LQ7OzhrilMOHSZ6UJJlO8iubj53itYmwaNTA9xMPBw9oWYuTjgWM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=tXQzcJsaQRvHfHiIz7fRfp+oTNZ3PwuWxcPHG1ShdwM=;
	b=YM1jjsRTTGsr9F+jR9Dp8CxK5Dxxk1scoX5EVkq7dW/FFvMQOK9BQCXQk8zdcwFq
	poTKoqDyUkmtlemEi7RKqMOPjROlNPb/0ODZw02tOXFlsJqNLkU8BdGmVQHS8pHuV61
	XekohGp3dtn/8Fqg0XEfwJrigDIgWBP1VKvEV+QE=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155122325823.7936280773741; Wed, 14 Sep 2022 13:32:02 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-8-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 08/10] This is temporary modification and will be adressed in the new version of the patch: Remove OPTIONS_TS from the options. See disscusion in the mailing list (JAN 18) [PATCH v2] fastopen with @palbeni
Date: Wed, 14 Sep 2022 13:31:49 +0200
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

This is temporary modification and
will be adressed in the new version of the patch: Remove OPTIONS_TS from th=
e
options. See disscusion in the mailing list (JAN 18) [PATCH v2] fastopen wi=
th
@palbeni

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/mptcp.h   | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 net/mptcp/options.c   | 8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..7881b18aecb4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -140,7 +140,7 @@ void mptcp_space(const struct sock *ssk, int *space, in=
t *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 =09=09       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-=09=09=09  struct mptcp_out_options *opts);
+=09=09=09  struct mptcp_out_options *opts, u16 *tcp_options);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 =09=09=09       unsigned int *size, unsigned int remaining,
 =09=09=09       struct mptcp_out_options *opts);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 290019de766d..3900fc57325d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -744,7 +744,7 @@ static void mptcp_set_option_cond(const struct request_=
sock *req,
 =09if (rsk_is_mptcp(req)) {
 =09=09unsigned int size;
=20
-=09=09if (mptcp_synack_options(req, &size, &opts->mptcp)) {
+=09=09if (mptcp_synack_options(req, &size, &opts->mptcp, &opts->options)) =
{
 =09=09=09if (*remaining >=3D size) {
 =09=09=09=09opts->options |=3D OPTION_MPTCP;
 =09=09=09=09*remaining -=3D size;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 267a346eb0bb..e7c3a362bd27 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -889,16 +889,20 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 }
=20
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-=09=09=09  struct mptcp_out_options *opts)
+=09=09=09  struct mptcp_out_options *opts, u16 *tcp_options)
 {
 =09struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(re=
q);
=20
+#define OPTION_TS               BIT(1)
+
+=09*tcp_options ^=3D OPTION_TS;
 =09if (subflow_req->mp_capable) {
 =09=09opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
 =09=09opts->sndr_key =3D subflow_req->local_key;
 =09=09opts->csum_reqd =3D subflow_req->csum_reqd;
 =09=09opts->allow_join_id0 =3D subflow_req->allow_join_id0;
-=09=09*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
+=09=09//*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
+=09=09*size =3D TCPOLEN_MPTCP_MPC_SYNACK - TCPOLEN_TSTAMP_ALIGNED + TCPOLE=
N_SACKPERM_ALIGNED;
 =09=09pr_debug("subflow_req=3D%p, local_key=3D%llu",
 =09=09=09 subflow_req, subflow_req->local_key);
 =09=09return true;
--=20
2.25.1


