Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876E370D69
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209967; cv=pass; b=aksrmZ5QhzYnSkrQbZUBUh5PCsnqjU3i5qSAMLyrxrqR9Hc6LbABi8bf7DD2wcSK/v5mfTIa8NHQZ/29M29YJ6fsINWN4HRQwrGfswcI5iHB8dxt9j/pTovTW+URQ62YiX0EgZAEy1ZmqMIUO3NEgraAoAEXuRgQOp+3pfasH38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209967; c=relaxed/simple;
	bh=6Yc1ND9c6OLjJBDQlEafSxzoQSGw9i4UACcXGcfHE3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAzuJI47+9i1MfkMdWecXPFY0LFxMXsHddHHCI4Zsulf0mwCDJ2mkRaoXFVbG689q8vytn5asXQ6kr0g/RI36taiM8SY5aN9CjNc4l9qG142ZK3NhoXouQnb3NUtWwAD/HUBcUon/214ni7X7u6q/n2aMXgtvf4DM7N2rkajL24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=lEJPmUpY reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="lEJPmUpY"
ARC-Seal: i=1; a=rsa-sha256; t=1781209953; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=beI8iza/F5HcC82lqP1OQZU+RCAeGC/lswsWHS8LAnBkx9znVHeMmm2j+KhIrksGytnLudu/oX13XwhRhTSgKHpiOsSmtQEQVcPRC7zQ2khgQiaFHeHRiZZ0HnETDMGJ+0AYP/kzOYE6Fb+sZ5HLomGLzSQHONbgDsHGZt/PCBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781209953; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lhP1+IbM6AT3fJJzLXXlyeJqLT1p2pjl4cosUQJedL8=; 
	b=GtEmFYDa72pGjXn1ZnyN8akMVLnwVXsgoKWIryzcMBX2E+t6WfGXM/tf5ZsWJdgPG6hfOsqxh0DiQvxAjqWCdYIBAbvd5eS+sRU5OYN+vImoCnoYqQdg2xclQ6tc5RPDa6Embm+KJzR4jaDeBuXHviIoEqySllxbNvfEDrtyayY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781209953;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=lhP1+IbM6AT3fJJzLXXlyeJqLT1p2pjl4cosUQJedL8=;
	b=lEJPmUpYTwcDoxQd2vWugvzfWviahezASGQKHkRSxWIFEWhczMVTpsiazJPqX2/1
	Sji1kYk5bm9cILWRPquGzpIicyPn4xqjc4BSBT6zqDsjTBLOtdcHHnUUNJ1s9df8PnG
	4mSXmxo1ewHcRFc/vGcZySNPnv7yugcz6oS3LpAg=
Received: by mx.zohomail.com with SMTPS id 178120995168790.74325441880512;
	Thu, 11 Jun 2026 13:32:31 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	pabeni@redhat.com,
	kalpan.jani@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v4 1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
Date: Fri, 12 Jun 2026 02:02:18 +0530
Message-Id: <20260611203219.3448354-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
References: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
---
 net/mptcp/mib.c      |  7 +++++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/protocol.c |  1 +
 net/mptcp/subflow.c  | 10 ++++++++++
 4 files changed, 25 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d9bd4f4afcc0e..a43893456a2e8 100644
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
index 18f35f7e0a2d4..18bcd8c749adc 100644
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
index a4f7e99b30dbc..3e035f368038a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3976,6 +3976,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
+		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPJOINNOTESTABLISHED);
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb98..6e8932f5c9ed0 100644
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
@@ -568,6 +570,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		u8 hmac[SHA256_DIGEST_SIZE];
 
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPJOINSYNACKNOMPJOIN);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -870,6 +873,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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
@@ -1421,6 +1430,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
 			subflow->reset_reason = status == MAPPING_NODSS ?
 						MPTCP_RST_EMIDDLEBOX :
 						MPTCP_RST_EMPTCP;
-- 
2.34.1

