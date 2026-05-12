Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089B349CFF
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582027; cv=none; b=BiAi0pOtmuO6+whSNwAvN97PhHmaJ1iL7UOh0fR2OR2YyFXL2tHYTm+AMaWVe2DqHOIU24/3Q3liIEBNhXF48nj3AdiMFP0qHnODkROEYPRgCv/c4HM2sWEqA8FuHcn5pmj8zhmYJMKt5YJYkaelKqp1VLLlAunFPf35oVAUXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582027; c=relaxed/simple;
	bh=ittRDhTs1/dJZkCbwBV6TJ3OyAgLJzwx1iFNt3AXu3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDXQECE1SUxUAP2LcgddIpbF45A2439yv8m5zbYofBOWu31WgyYzVl312ceobZ03NtG8rzSdk8yH1l9FGxCxy0qzGvp7CnHzsIlGMWePp3UjVzoSPTAYTDyu2uoRw8ber8rDTsFzaB3wn0JwNxrEWomvH2v7/MjgsDgvn+Smbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvO8VL/F; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvO8VL/F"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-366375c43c2so3054077a91.2
        for <mptcp@lists.linux.dev>; Tue, 12 May 2026 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582025; x=1779186825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOEowNA7UQKPG1h+lIpNmpcHsMs6cLsrL9MqWSpDvkU=;
        b=ZvO8VL/FyOg8V00SB0SVCL5rCfc98voUV6Ksli2UIiPX4TcByCXTQcfIBhN1STpwxa
         tBe3a2yY4rVjpXkKt+PqxEqbu4S1LgATrtTNM8+Sai/vYMaVb685fHmfy8o9yQshnVao
         PBAZqL7oop6z9rlAtUrnpIp9OE11Jhl1Tc9PtkLoKpCwSe0CN8QiMUb9G0xH8z6RWznV
         xpyozIERcadrsi806MhGX6LpTORjPiWDSztKgrIgBUibXa6p/pmUmRep/M/NSfCbejqT
         QUdSPVWfc65J/R7k6L4jHjVKcmh3Ti7Fjsu8M5ttAgV0VLpyg9bQro+2A2aWdHk2IJsU
         KZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582025; x=1779186825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOEowNA7UQKPG1h+lIpNmpcHsMs6cLsrL9MqWSpDvkU=;
        b=s2DoiCL7Sl+gA8SIwc0hqyr9Iry5CdS8Pu5eVGrYq0HrlDYKfZz5WPW1bIddca7mu1
         j6scCAN1xkV27JJ4gQ9UZLVpwffG20uYia+NrrfLjmXqMM/G17lONXedIic3fHpUlV09
         SMRD8sKx8pXh1bar9eazNObR0XffrLUCXSigrvsCcFfkjS0rFlx/+iAUYBkW4H7naODB
         WGxo/lPADRIkuKhgfi5E16g02SxpMy9YMC64m4XCqRZdeyKp6LfgOCfPIzI4Pq1GNAt2
         yzuZxyrvNthgTYUE0rJ3WJgO3hcIPdfDWvwFOA+mLa0zM9JD1eW5KEYXvsysh4HndAkX
         ULrg==
X-Gm-Message-State: AOJu0YwJNqg8moqo5Uo4bVRCV/y4vBsrJrPQGAtKLqL0JZidQVlnDz4j
	0wN9SKdAT4WnFHzp3cdMjdHeZdfn+55p0XXzlWGoQm+P/rPZ7mjBLGTOFdPAf5E+
X-Gm-Gg: Acq92OEKIRcmzWJ9wFgTThzXRyXjVdYvPQ7r971KgcjG/hdrbZIgUlezpleHFkBo7Sk
	0/Y2ncsduSyb9oY2rcjFzwqdPS7ecEwTJx+1m3dA9JvSxxBrLyQD0uj38mLI79cHaYDzEcaFGGW
	BAk3rOLawZdpDFb5Nb7i/iY11ldNuBQ1PcLqgpW2RfvxFToY0H2W2Z5jyUFWTMqdKeQdk1SRg9s
	w+kX6w32stQ7w5caSGWB3FH+NrieA1CYpTeFbGdoyOCYMZeAU+ArCRLuRwAtGdH0fAXGek8Y9jg
	JWw4HpFtnDvRnPPfLgtDn0a9BlzhMjlUglou7FBkyhf///C/UNopAdZ5hikNZksj0saYVKJLTSH
	5mdLefj/vg/iesmzAZXO+A5l1fIGKBueOioqVGsy8M/rAvNc6p7J8Ug6nv5OUX4GPyXU8lk2h0N
	bkt31rTpCUkRnKqc8ZZmeq2g==
X-Received: by 2002:a17:90b:2fcf:b0:366:755:6fee with SMTP id 98e67ed59e1d1-3664ca30f53mr18580341a91.12.1778582024558;
        Tue, 12 May 2026 03:33:44 -0700 (PDT)
Received: from localhost ([223.185.43.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d63e03f6sm11320905a91.12.2026.05.12.03.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:33:44 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v3 1/2] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
Date: Tue, 12 May 2026 16:03:30 +0530
Message-Id: <20260512103331.1934343-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
References: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3:
  - Move new SNMP_MIB_ITEM entries and enum values next to their
    semantic neighbors (e.g. MD5SigReset after MD5SigFallback,
    MPJoinSynAckNoMPJoin after the MPJoinSynAck* group) instead of
    appending them in a single block after MPRst*.  No functional
    change.
v2: https://lore.kernel.org/all/20260509183335.969018-1-shardul.b@mpiricsoftware.com/
v1: https://lore.kernel.org/all/20260421095646.3741956-1-shardul.b@mpiricsoftware.com/

 net/mptcp/mib.c      | 6 ++++++
 net/mptcp/mib.h      | 6 ++++++
 net/mptcp/protocol.c | 1 +
 net/mptcp/subflow.c  | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a72..ca1da14d30b08 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -26,9 +26,13 @@ static const struct snmp_mib mptcp_snmp_list[] = {
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
@@ -81,7 +85,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
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
index 812218b5ed2bf..27fc53367d18f 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -21,9 +21,13 @@ enum linux_mptcp_mib_field {
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
@@ -84,7 +88,9 @@ enum linux_mptcp_mib_field {
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
index ce8372fb3c6af..3b5041fb2588a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3851,6 +3851,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
+		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPJOINNOTESTABLISHED);
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f6..6fce3f431667c 100644
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
-- 
2.34.1

