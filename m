Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF816426
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199671; cv=none; b=iLAXqSBId72oEUGImjqcBE0MIVzevWFJho9EZ949FBsPvhfi36H2QIYZ0KQHflPTJa3V2Q1ajIH2e/4BTA3t/7/Y+NfjfryOeM/G4w34a4a1ZRyjrjuCeG4/8ecWWDveyUAi2jxrKzo0/oPi51gp6MfQVnnUtnPoHEQEE4j9K+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199671; c=relaxed/simple;
	bh=/qUkzhhea2ND4cj11E/4c+Hpj3NCR+Lq9nqa/tthADE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OR7B2+6SFWynW5gFhm0wYzcyLkFz20fek79W0uUwSS03BK/S+R78qcCnrYvzW0CLaRYuWmI4Ta4W8vFiEsDOyVKBlC+B6V93++Uw0ePqbU/H+KAqmCTyAZjeFKaJbBYyJufwG7eEMDfWMdJWK3Z3d9h0EnnPVgIu0uxXS5GzxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW3VgxGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW3VgxGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC80EC4CEE0;
	Wed,  5 Mar 2025 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199670;
	bh=/qUkzhhea2ND4cj11E/4c+Hpj3NCR+Lq9nqa/tthADE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GW3VgxGcLBaUS5Yg/GVZBMBcjxzNQ263WdIfsxs6sBtAcvOgcapECXYFWsFGHE2I8
	 CdpA4tDzRqtWyywGBSjWaODkCf8iTgIL9Xmc9B1Yg6O+GdPvYzm89T9lrZFCD9KPe7
	 V9LCSCNbn07W3eLuQGRTf9UkQCMnXZvXHLhlYLid7bZLbi57RH51OiDjqbwpUVQQOB
	 maYNwB7y4zMs2lqdLfwy3OW+rF5R+3ZUlN4DAy1Xt8+BoU9xNLxMpjc06JTuNtnd9a
	 QjKpOh5NGA8K4sIk+6nPyUvJL4KjD8YsA2j1BFq1VwZdNFGuHeoOtL313UuzC8vAbi
	 QM1AfkDIGYHqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Mar 2025 19:34:19 +0100
Subject: [PATCH mptcp-next v2 2/2] tcp: ulp: diag: more info without
 CAP_NET_ADMIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-mptcp-tcp-ulp-diag-cap-v2-2-d53fd80748eb@kernel.org>
References: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
In-Reply-To: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
To: mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>, 
 Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7255; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/qUkzhhea2ND4cj11E/4c+Hpj3NCR+Lq9nqa/tthADE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyJkyy8a8tpTsvIHGK1JgW3iEoZsMacaCHx8SO
 PBAr88rgnyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8iZMgAKCRD2t4JPQmmg
 c2vTD/4pNiJgmZ5wMQS6uvYQh+MgDM/xQ2Mi3B5lgt12myMZ6ftYjzkvBHltIksF2pJI1ulBNGG
 2zzXqfKlRw3EoMBDBqNvUswf7EEhmossrNwvZvrHURq4r2OBpYgURYmFIJ+JzuZfPIMK66MHzgy
 y9QzhJmQp9sLFiapzxrIKN1l8hH2m6SO2C9DcykgAUMBah64sUQ5DJrhMedL3lK2zkRQcAlUt1L
 e+TbFIxP5SXS0BSEj39SYmxZMEqGMz7aNkfPAIr33djmhIAHM6sDCnQ1nOSuvLZWidL6H+hkdA7
 p/tkZov6I7k51fNdpQ5pqwIz30ENi01bXUvEYpSXAesoz01+ChpcvJzWNoBkPB9mo7Igqccy8Qn
 Zvfe+xDItn10YGvsF4DNWSpCdeet5wlX8kiFeHIVLOPlLTkSGYAIqaiMVOtJrRRCDGdrrPVqqN9
 b4jQxYaSDVqiclvJq/kUEiHh7as/gcsYSTrCuUnj0fWM0n8fOfzySxFpHE4Jmwesz+8Qn+10nP3
 dOv6+1xaYOBr+LrkrlnHYdDABkwwTHQfO7KJdu3259cdaH3EI1YywByiav+rGDCE/+4t0A4kpZb
 3C8O8Tf7X1hzWFh3kQL8/xshoKhgCJflSy7iJDzsWnyXn3DIwnQgS3IMCYt7J93CUVl2yCEU6th
 RWz26Dqj/2h9rwA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When introduced in commit 61723b393292 ("tcp: ulp: add functions to dump
ulp-specific information"), the whole ULP diag info has been exported
only if the requester had CAP_NET_ADMIN.

It looks like not everything is sensitive, and some info can be exported
to all users in order to ease the debugging from the userspace side
without requiring additional capabilities. Each layer should then decide
what can be exposed to everybody. The 'net_admin' boolean is then passed
to the different layers.

On kTLS side, it looks like there is nothing sensitive there, only some
metadata about the configuration, no cryptographic information. Then,
everything can be exported to all users.

On MPTCP side, that's different. The MPTCP-related sequence numbers per
subflow should certainly not be exposed to everybody. For example, the
DSS mapping and ssn_offset would give all users on the system access to
narrow ranges of values for the subflow TCP sequence numbers and
MPTCP-level DSNs, and then ease packet injection. The TCP diag interface
doesn't expose the TCP sequence numbers for TCP sockets, so best to do
the same here.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/tcp.h   |  4 ++--
 net/ipv4/tcp_diag.c |  8 ++++----
 net/mptcp/diag.c    | 42 ++++++++++++++++++++++++++----------------
 net/tls/tls_main.c  |  4 ++--
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9bc959fb102fc6697b4a664b3773b47b3309f13..7207c52b1fc9ce3cd9cf2a8580310d0e629f82d6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2598,8 +2598,8 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(struct sock *sk, struct sk_buff *skb);
-	size_t (*get_info_size)(const struct sock *sk);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb, bool net_admin);
+	size_t (*get_info_size)(const struct sock *sk, bool net_admin);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
 		      const gfp_t priority);
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index d8bba37dbffd8c6cc7fab2328a88b6ce6ea3e9f4..45e174b8cd22173b6b8eeffe71df334c45498b15 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -96,8 +96,8 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
 	if (err)
 		goto nla_failure;
 
-	if (net_admin && ulp_ops->get_info)
-		err = ulp_ops->get_info(sk, skb);
+	if (ulp_ops->get_info)
+		err = ulp_ops->get_info(sk, skb, net_admin);
 	if (err)
 		goto nla_failure;
 
@@ -170,8 +170,8 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 		if (ulp_ops) {
 			size += nla_total_size(0) +
 				nla_total_size(TCP_ULP_NAME_MAX);
-			if (net_admin && ulp_ops->get_info_size)
-				size += ulp_ops->get_info_size(sk);
+			if (ulp_ops->get_info_size)
+				size += ulp_ops->get_info_size(sk, net_admin);
 		}
 	}
 	return size;
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 02205f7994d752cc505991efdf7aa0bbbfd830db..70cf9ebce8338bde3b0bb10fc8620905b15f5190 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -12,7 +12,7 @@
 #include <net/netlink.h>
 #include "protocol.h"
 
-static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
@@ -56,15 +56,6 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 
 	if (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_REM, sf->remote_token) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_LOC, sf->token) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
-			sf->rel_write_seq) ||
-	    nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
-			      MPTCP_SUBFLOW_ATTR_PAD) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
-			sf->map_subflow_seq) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
-	    nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
-			sf->map_data_len) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, subflow_get_local_id(sf))) {
@@ -72,6 +63,21 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 		goto nla_failure;
 	}
 
+	/* Only export seq related counters to user with CAP_NET_ADMIN */
+	if (net_admin &&
+	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+			 sf->rel_write_seq) ||
+	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
+			       MPTCP_SUBFLOW_ATTR_PAD) ||
+	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+			 sf->map_subflow_seq) ||
+	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
+	     nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+			 sf->map_data_len))) {
+		err = -EMSGSIZE;
+		goto nla_failure;
+	}
+
 	rcu_read_unlock();
 	unlock_sock_fast(sk, slow);
 	nla_nest_end(skb, start);
@@ -84,22 +90,26 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static size_t subflow_get_info_size(const struct sock *sk)
+static size_t subflow_get_info_size(const struct sock *sk, bool net_admin)
 {
 	size_t size = 0;
 
 	size += nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
-		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_LOC */
 		0;
+
+	if (net_admin)
+		size += nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
+			nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
+			nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
+			nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+			nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
+			0;
+
 	return size;
 }
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 99ca4465f70216c5a44e4ca7477df0e93df6b76d..cb86b0bf9a53e1ff060d8e69eddbd6acfbee5194 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1057,7 +1057,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
 	return 0;
 }
 
-static int tls_get_info(struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;
@@ -1115,7 +1115,7 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static size_t tls_get_info_size(const struct sock *sk)
+static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 {
 	size_t size = 0;
 

-- 
2.47.1

