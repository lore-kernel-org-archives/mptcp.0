Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7D37FF60
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765412; cv=none; b=DUOSrtozOzVA6Wxw8QiKDjsbDjk0omP1z0iWwsLt+WyI19kCgCM6z/Z0KtTFczMdEiHcU8l71/AweR6CSVp/07ALBoDgmtH7V0scyyFv4xsC1BcWRVu88N5ty3Sjx/2+i366WDxAYqg/IrIL3g3EstC+GOktzkZwl4KLuzy2dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765412; c=relaxed/simple;
	bh=3BUnvxyuGd1DgomwnEK0E0FhgwItQGQvkyS6mj6Ii+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBIB67pGq8W9nBrNGMEmUeynrg81R4O6L0RjF/TOy30/EHKVFO8boLPt+eQDaAQEvSA2J+ckuYnoWcnOrg7fRop5PQiYSWfl4pMA7OvVTIK1Fs6/JxhSTJSQtgGiktJE5r+Jv8A1DhrgQe8LL/1EltYK4ycloZ4FpYAho0mheJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVkDNytn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVkDNytn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso25633875ad.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776765410; x=1777370210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKZpSpV9EOuGvsbHlyyvc1vofUH1wihyDABD3Zf9nCg=;
        b=SVkDNytnV5erwkNAb2YIw3HROBOjRem1YvW6uoru9GoMM5Z9A1U1zOxv4nSQbrTJpe
         X03fC/8KBWHAt1Cc/0gJiWjxBXLCP2Zhy5u9ClTVq1yBDWTE5pkXFm4lvBdpMOs1BgYW
         m7JgYdqvUHfJcjqBsCNHtcAjx0FBBXTBr4j3mAYVSOg8FlptJ3Ini5XD+46cuZWJjqJ7
         vV11353QyHoQtcRar4Ykxz5/6v9yK1+VwzLOUXTt4Rg+aihXhU7rfcoxgGocrKlnrYYk
         onHCFP6zpTvdnOSXXl+zMR3DlRiAi4dDkm6MDPPno6iEygBkJIRXPxtGKe5op+Fn6kKX
         1mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765410; x=1777370210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKZpSpV9EOuGvsbHlyyvc1vofUH1wihyDABD3Zf9nCg=;
        b=sK1rlxCtDj1AK1pXeNw4u3dcz3paaFHGAaaq0rWsEzueBbC2qmwlu82cwbevh06Q3/
         kl/g0LxIJZw8bvrOKs3nlt0VzPqDqZ/mh76iUgTIwg52OrTWXI2hFjKEwdobchLfI6a9
         WWh7tB5SimS+02C8a0Ku6Bhz5XSNkYbqVxzPhm3jMCbjWaikYnkGRYXEkxspJRLA6NBX
         plra7n8fvWb7AEAmTzgQc1GbmfjKnaeBTSaCZarxO747S8jFd06W2huRmYh/oAiK5nVu
         P7+0gC9FU40911kYp0UxXELcP4mJ5tF9ChK9gaKf9eV+g/WkDypNnywJAXn+QHaEA1o4
         /oCw==
X-Forwarded-Encrypted: i=1; AFNElJ+lAk4Rrsdo3Yp97t+odhcPzwCRCi/AiIfHQFQj64LNCdHagQBPXneooVVVSJZPVAZODUg2rg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywee39JvwxRfFMgLz/KMBHhQGo0r99CJe4H3DhTyZ1kh1DJZyrI
	jShyhrB3Hnc9rP9/f81JXp6nwpO7GkrNZep7lLZf52Dz0G78I1Us1YGJ
X-Gm-Gg: AeBDiesdBqdUIrrAqkR2svlrh03F8zAexOw0M6ZxnKzWnjZaVFKT0ho7awTatJSVZnT
	4WLNoOmveOxOB0G4EOdSUTr/IKpRw40jLy0EYBcU3EqwB6cPr8HrjxXH1+QO14WL+OexyqDq9En
	Lruuqmh4emD3WaX34GX4IlL48bUpj7u57nDTSOkAi0T2dMvZCapu1edlPF+5HeFeJbuufrefKzf
	7CL1VmEZm7Oq31kIoWmnPbKEOuVkeiT22TX6lyHvb6fma9ZNlsIKhiQYWGkyrPqnjVULWOfLzAQ
	PbUI+7JRkhu3hROpZRya0pcMdkegzVo+I7sPrvIHXWGazPMJSx2GKQkNPwcREh6m62KkeZ5gmZz
	mV3m8pMLaiMJvVT3AQ7qoBx6bQWKySK9nt5CXfnIfoafq0nQ3DORMqBWpFSsECDEJCHK2TsPLrQ
	UxkfDKGMYfIKNGumdkPBxGmITwZYihm+0zKWhYSpr4JA==
X-Received: by 2002:a17:902:9044:b0:2ae:d09c:5241 with SMTP id d9443c01a7336-2b5f9e7a9b6mr126550535ad.2.1776765410430;
        Tue, 21 Apr 2026 02:56:50 -0700 (PDT)
Received: from localhost ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa32ad8sm134467025ad.31.2026.04.21.02.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:56:49 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] mptcp: add per-reason MIB counters for MPTCP_RST_EMPTCP resets
Date: Tue, 21 Apr 2026 15:26:46 +0530
Message-Id: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP_RST_EMPTCP (reset reason 1) is used as a catch-all for seven
distinct error conditions across subflow setup, authentication, and
data path validation.  The existing MPRstTx/MPRstRx counters only
track aggregate reset volume, making it difficult to diagnose which
code path is triggering subflow resets in production.

Add per-reason MIB counters for each MPTCP_RST_EMPTCP use site:

  MPRstMD5SIG         - MD5SIG on listener, incompatible with MPTCP
  MPRstNoToken        - JOIN token lookup failed, no matching conn
  MPRstNoMPJ          - SYN/ACK missing MP_JOIN option
  MPRstHMAC           - HMAC validation failed during subflow join
  MPRstFatalFallback  - fatal fallback during child socket creation
  MPRstBadMap         - invalid data mapping on established subflow
  MPRstNotEstablished - JOIN on not-fully-established msk

These counters are incremented alongside the existing reset_reason
assignment and are visible via nstat as MPTcpExtMPRst*.  The
aggregate MPRstTx/MPRstRx counters remain unchanged.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/511
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/mib.c      |  7 +++++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/protocol.c |  1 +
 net/mptcp/subflow.c  | 14 +++++++++++---
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..ec42583c59cf 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -71,6 +71,13 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
 	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
+	SNMP_MIB_ITEM("MPRstMD5SIG", MPTCP_MIB_MPRSTMD5SIG),
+	SNMP_MIB_ITEM("MPRstNoToken", MPTCP_MIB_MPRSTNOTOKEN),
+	SNMP_MIB_ITEM("MPRstNoMPJ", MPTCP_MIB_MPRSTNOMPJ),
+	SNMP_MIB_ITEM("MPRstHMAC", MPTCP_MIB_MPRSTHMAC),
+	SNMP_MIB_ITEM("MPRstFatalFallback", MPTCP_MIB_MPRSTFATALFALLBACK),
+	SNMP_MIB_ITEM("MPRstBadMap", MPTCP_MIB_MPRSTBADMAP),
+	SNMP_MIB_ITEM("MPRstNotEstablished", MPTCP_MIB_MPRSTNOTESTABLISHED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..0ac109b52d35 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -70,6 +70,13 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
 	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
+	MPTCP_MIB_MPRSTMD5SIG,		/* MP_RST: MD5SIG enabled on listener */
+	MPTCP_MIB_MPRSTNOTOKEN,		/* MP_RST: JOIN token not found */
+	MPTCP_MIB_MPRSTNOMPJ,		/* MP_RST: missing MPJ in SYN/ACK */
+	MPTCP_MIB_MPRSTHMAC,		/* MP_RST: HMAC validation failed */
+	MPTCP_MIB_MPRSTFATALFALLBACK,	/* MP_RST: fatal fallback on child */
+	MPTCP_MIB_MPRSTBADMAP,		/* MP_RST: bad data mapping */
+	MPTCP_MIB_MPRSTNOTESTABLISHED,	/* MP_RST: JOIN on not-established msk */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..b06cbcf983f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3836,6 +3836,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
+		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPRSTNOTESTABLISHED);
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e2cb9d23e4a0..71bffcda0138 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -160,6 +160,7 @@ static int subflow_check_req(struct request_sock *req,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MPRSTMD5SIG);
 		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
 	}
@@ -227,6 +228,7 @@ static int subflow_check_req(struct request_sock *req,
 
 		/* Can't fall back to TCP in this case. */
 		if (!subflow_req->msk) {
+			MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MPRSTNOTOKEN);
 			subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 			return -EPERM;
 		}
@@ -568,6 +570,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		u8 hmac[SHA256_DIGEST_SIZE];
 
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTNOMPJ);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -582,6 +585,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 		if (!subflow_thmac_valid(subflow)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTHMAC);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -870,6 +874,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal) {
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTFATALFALLBACK);
 				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
@@ -1421,9 +1426,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
-			subflow->reset_reason = status == MAPPING_NODSS ?
-						MPTCP_RST_EMIDDLEBOX :
-						MPTCP_RST_EMPTCP;
+			if (status == MAPPING_NODSS) {
+				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			} else {
+				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPRSTBADMAP);
+				subflow->reset_reason = MPTCP_RST_EMPTCP;
+			}
 
 reset:
 			WRITE_ONCE(ssk->sk_err, EBADMSG);
-- 
2.34.1

