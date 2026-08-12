Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4346F497;
	Wed, 12 Aug 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546584; cv=none; b=r3aIIjDRAvqomk7FL8MLrnVTjDOndfmMqS1pk3A0WSlfUrdMT55V23Ts1Z6Kl/HqepPLWCUSIxdktfxAhjwHYTw5hYf84NhsvXnTGnwQGxeNf7cDB4E+P6l7yeEYGDkDD+LvZnRJSM+l49s2Qt7IkI29tWq0dj0aIjuJwlnP/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546584; c=relaxed/simple;
	bh=4kSczDUhvB9wLi/CRABdJe2PoFsIOzsbTEk5ItzPShc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWfUNC3OZ4U5NDkcUstnsj/ywzMowiyLtuZzy7hAbmMuCrsf7sP0GZ+K2oqFPEaipFzqa02/BgK/HM70s2n92SvH9exVZX58zyLIEAATBJVxm6euIO/34QjatJeovgJrBKP72q7ug/3RQXXm61Xue7UkpFveVDvkxKnceAFiwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6rkKXv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6rkKXv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C756B1F00ADF;
	Wed, 12 Aug 2026 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546569;
	bh=lMyDW4Svbsmjj2oiSKAYU2dmKW+H0HSJMp0JMFoBmmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W6rkKXv4Jqt2WC9rhNiuyFTszCyQ+NU/CUri4bfVD74l8RW/TytI+4MPgefqCCnYK
	 /KBv+B2+gDIuLLD1mj46SS02Sf55V4ZdXXq8EgXRPbCR3d4nX1mZeziZrqM5KXlf7C
	 f4ZZGEvTjza5TjNtXcmJ2hinmldjQeV9vrd5OyHPEOoY3Z9yo236IeCjFVMKhk+L9L
	 0rI26WUxq7WLJAVqbgPKBOn2Slzr7xdcNZsCjnDAkcWST2rNh99LZsZeQXbI+y0pQJ
	 xW1wGI7y9DYOXOJy71rOakneZxcBqpSdQihlOIbusL0zmIvr8RT/TvCz/EDQECMbCg
	 RsZPA1TevUcRw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:40 +0200
Subject: [PATCH net-next 05/11] mptcp: add per-event MIB counters for
 MPTCP_RST_EMPTCP resets
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-5-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8430; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oYBRE8x4vk82CdDziw0Cszl4jI9sHyflRIR5mdcApcU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOkv3prCqfgt25uvPFv8ufEQ37P28i/cfHTrz7A9nV
 tfmX7/FOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyV4fhn5Xiu8Nd9x7ZnEqf
 vv2QOE/Fa56Lj/euOnc25831mDAF6xSGP7z7ZmtUMKxU2RZvtOnlxqe3Sy/1s/tzchu43uRoilr
 myQ4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

MPTCP_RST_EMPTCP (reset reason 1) is used as a catch-all for several
distinct error conditions across subflow setup, authentication, and
data-path validation.  The existing MPRstTx/MPRstRx counters only
track aggregate reset volume, making it difficult to diagnose which
code path is triggering subflow resets in production.

Add per-event MIB counters covering each MPTCP_RST_EMPTCP use site
that is not already covered by an existing counter, named after the
underlying event or condition rather than the reset action:

  MD5SigReset           MD5SIG enabled on listener (incompatible)
  MPJoinSynAckNoMPJoin  SYN/ACK missing MP_JOIN option
  MPJoinAckNoMPJoin     server-side ACK missing MP_JOIN option
                          (fallback path, MPJoin required)
  MPJoinAckNoCtx        server-side ACK with no subflow context
  MPJoinNoIdFound       MP_JOIN with a valid token but no PM local ID
  DssReset              data mapping invalid (also fires on
                          MAPPING_NODSS / EMIDDLEBOX path)
  MPJoinNotEstablished  JOIN attempted on a not-fully-established msk

MPJoinNoIdFound covers the second half of the no-msk MP_JOIN reset:
the existing MPJoinNoTokenFound (MPTCP_MIB_JOINNOTOKEN) only counts the
missing-token case in subflow_token_join_request(), while a JOIN that
carries a valid token but for which the path manager returns no local
id reaches the same MPTCP_RST_EMPTCP in subflow_check_req() uncounted.

The aggregate MPRstTx/MPRstRx counters are unchanged.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/511
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      |  7 +++++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/protocol.c |  1 +
 net/mptcp/subflow.c  | 10 ++++++++++
 4 files changed, 25 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 2569385bab7c..608cb568897c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -21,14 +21,19 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
+	SNMP_MIB_ITEM("MPJoinNoIdFound", MPTCP_MIB_MPJOINNOIDFOUND),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
 	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
 	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
+	SNMP_MIB_ITEM("MPJoinSynAckNoMPJoin", MPTCP_MIB_MPJOINSYNACKNOMPJOIN),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinAckNoMPJoin", MPTCP_MIB_MPJOINACKNOMPJOIN),
+	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
 	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
+	SNMP_MIB_ITEM("MPJoinNotEstablished", MPTCP_MIB_MPJOINNOTESTABLISHED),
 	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
 	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
 	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
@@ -81,7 +86,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
 	SNMP_MIB_ITEM("MPCapableDataFallback", MPTCP_MIB_MPCAPABLEDATAFALLBACK),
 	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
+	SNMP_MIB_ITEM("MD5SigReset", MPTCP_MIB_MD5SIGRESET),
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
+	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 3a3425e258a7..1ebdb55e9534 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -16,14 +16,19 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
+	MPTCP_MIB_MPJOINNOIDFOUND,	/* Received MP_JOIN but no local ID was found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
+	MPTCP_MIB_MPJOINSYNACKNOMPJOIN,	/* MP_RST: missing MP_JOIN in SYN/ACK */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_MPJOINACKNOMPJOIN,	/* MP_RST: missing MP_JOIN in ACK */
+	MPTCP_MIB_MPJOINACKNOCTX,	/* MP_RST: no subflow context on ACK */
 	MPTCP_MIB_JOINREJECTED,		/* The PM rejected the JOIN request */
+	MPTCP_MIB_MPJOINNOTESTABLISHED,	/* MP_RST: JOIN on not-fully-established msk */
 	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
@@ -84,7 +89,9 @@ enum linux_mptcp_mib_field {
 					 * established packet
 					 */
 	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
+	MPTCP_MIB_MD5SIGRESET,		/* MP_RST: MD5SIG enabled on listener */
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
+	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f074d757743..b474d03620a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4002,6 +4002,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
+		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPJOINNOTESTABLISHED);
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1f20ff8fdb4..af81ad5e699d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -96,6 +96,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 
 	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
 	if (local_id < 0) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -160,6 +161,7 @@ static int subflow_check_req(struct request_sock *req,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MD5SIGRESET);
 		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
 	}
@@ -563,6 +565,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		u8 hmac[SHA256_DIGEST_SIZE];
 
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPJOINSYNACKNOMPJOIN);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -865,6 +868,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal) {
+				if (!ctx)
+					MPTCP_INC_STATS(sock_net(sk),
+							MPTCP_MIB_MPJOINACKNOCTX);
+				else
+					MPTCP_INC_STATS(sock_net(sk),
+							MPTCP_MIB_MPJOINACKNOMPJOIN);
 				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
@@ -1416,6 +1425,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
 			subflow->reset_reason = status == MAPPING_NODSS ?
 						MPTCP_RST_EMIDDLEBOX :
 						MPTCP_RST_EMPTCP;

-- 
2.53.0

