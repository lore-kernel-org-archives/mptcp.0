Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDB2F1FD0
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351636; cv=pass; b=XUHwbOstJKEcooFoRh4IXTiXE0kuHid2uB6Q7TqKfeRyfWM38B6Nmq7oscqX8Dpxf0FQ+JmbRIgvGNivgVbdHO3SNxFj3FRtkG42u4gA/BMBTNOJi0bYxJgDc5ZytkNdvCSF1rDKZILMBkAKB5qrhZbSp59X5HYdm0fcIdRnitc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351636; c=relaxed/simple;
	bh=GJkowdCZp+X+EjEllqKA/U2FWP07CHC+BvPWh5nRQOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bmj+3JuwMqZK+MG/PrX24RryDYmDwtfqKEFsfZeDwlYCgKx4vxRZXeRZy6f47kvakvh0T0dydlZgzMoC5vVBlDCnEbsKGk/JgQRs1RNiCYi5t6/eSXG54Et5a7/pVkxww+Ep+Exzb+aD4Se8OoT+CxJu0+XUrJ3+nZ+mSIzJhjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=k2jaWumV reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="k2jaWumV"
ARC-Seal: i=1; a=rsa-sha256; t=1778351628; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FvmetNXMg47EzMGp8wut1QwTQdE/cUxL1Wb90aMsK1FkDMtfD+ksz6UW+mG64SCzsDNWTZXKPZkl6wMw4at17KDgBOR1q24a7a+FJG7SZJv2KYuZr4oKo10iQ32ni3U1lmddDbL/BwbaF5y3GhZlaD2HEzoq/ARFyZVXxNJoT6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778351628; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e6f76EfLnUloGGIr18qGEHm4jbwW2MQuTrHhZPmwR/Y=; 
	b=bAQvcyUnv3M6pMD7r4LTqySEl6S5hdEA5yKCPrzCmUAQZxbrunKAUtXTfQgJXeKxAfpr+eDDf8U+99lxDEWEpIMFDY29+GTBMcHE/0FMpWrCTOAeFVrut7uDJ1bhSLX+RMs1OidryL81GHzI1GCQYPti0bPSw50mhprxGsHoWQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778351628;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=e6f76EfLnUloGGIr18qGEHm4jbwW2MQuTrHhZPmwR/Y=;
	b=k2jaWumVjvY98wCXCsOsVtOdhte+d0z6B2tJdeAINOsoOpdE+qmkyO3DtbQBjq1G
	XphFeeH4HsZ2FKF2RUoVQIDab5B9I8JEduXnFkew2BzhiGXxIapuDn3mQqat6pTBBzF
	a+zfaLk3GMKKso4aKXAfG4WAemfXoG7bG6hnTb1c=
Received: by mx.zohomail.com with SMTPS id 1778351626419940.4834691271369;
	Sat, 9 May 2026 11:33:46 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v2 1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
Date: Sun, 10 May 2026 00:03:34 +0530
Message-Id: <20260509183335.969018-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
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
  DssReset              data mapping invalid (also fires on
                          MAPPING_NODSS / EMIDDLEBOX path)
  MPJoinNotEstablished  JOIN attempted on a not-fully-established msk

The aggregate MPRstTx/MPRstRx counters are unchanged.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/511
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2:
  - Drop MPRstNoToken (use MPTCP_MIB_JOINNOTOKEN)
  - Drop MPRstHMAC (use MPJoinSynAckHMacFailure; SynAck site
    fixed in c4a99a921949)
  - Rename MPRstMD5SIG -> MD5SigReset
  - Rename MPRstNoMPJ -> MPJoinSynAckNoMPJoin
  - Rename MPRstBadMap -> DssReset; also fire on EMIDDLEBOX branch
  - Split MPRstFatalFallback into MPJoinAckNoMPJoin (fallback)
    and MPJoinAckNoCtx (!ctx)
  - Rename MPRstNotEstablished -> MPJoinNotEstablished
    (mptcp_finish_join is reached from both SYN/ACK and ACK paths)
v1: https://lore.kernel.org/all/20260421095646.3741956-1-shardul.b@mpiricsoftware.com/

 net/mptcp/mib.c      | 6 ++++++
 net/mptcp/mib.h      | 6 ++++++
 net/mptcp/protocol.c | 1 +
 net/mptcp/subflow.c  | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..e44ae95c3e7e 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -71,6 +71,12 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
 	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
+	SNMP_MIB_ITEM("MD5SigReset", MPTCP_MIB_MD5SIGRESET),
+	SNMP_MIB_ITEM("MPJoinSynAckNoMPJoin", MPTCP_MIB_MPJOINSYNACKNOMPJOIN),
+	SNMP_MIB_ITEM("MPJoinAckNoMPJoin", MPTCP_MIB_MPJOINACKNOMPJOIN),
+	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
+	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
+	SNMP_MIB_ITEM("MPJoinNotEstablished", MPTCP_MIB_MPJOINNOTESTABLISHED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..da0b08cfd35f 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -70,6 +70,12 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
 	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
+	MPTCP_MIB_MD5SIGRESET,		/* MP_RST: MD5SIG enabled on listener */
+	MPTCP_MIB_MPJOINSYNACKNOMPJOIN,	/* MP_RST: missing MP_JOIN in SYN/ACK */
+	MPTCP_MIB_MPJOINACKNOMPJOIN,	/* MP_RST: missing MP_JOIN in ACK */
+	MPTCP_MIB_MPJOINACKNOCTX,	/* MP_RST: no subflow context on ACK */
+	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
+	MPTCP_MIB_MPJOINNOTESTABLISHED,	/* MP_RST: JOIN on not-fully-established msk */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 93e7a42fc65c..e788ed45917b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3837,6 +3837,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
+		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPJOINNOTESTABLISHED);
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..6fce3f431667 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -160,6 +160,7 @@ static int subflow_check_req(struct request_sock *req,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MD5SIGRESET);
 		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
 	}
@@ -568,6 +569,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		u8 hmac[SHA256_DIGEST_SIZE];
 
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPJOINSYNACKNOMPJOIN);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -870,6 +872,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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
@@ -1421,6 +1429,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
 			subflow->reset_reason = status == MAPPING_NODSS ?
 						MPTCP_RST_EMIDDLEBOX :
 						MPTCP_RST_EMPTCP;

base-commit: 83b40ddf390d5eb34ca6b966e1428c0cc738b6f5
-- 
2.34.1

