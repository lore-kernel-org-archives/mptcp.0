Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5333AD8B
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302466; cv=none; b=biQiHQjnmaQ79NOdsHsIQ6EeVyVWijoCiISGTylYJcP88YGkv394G3QjQJbo3pSAP5Ts3HhJDEzXGK7q/g6WscnJpOR4CFwHAy6Raw70bq1YCU5rVTadt+j1AVwaaEWjqDfWtNLZhkclYJm6TREc5toONqayW3oHPaAehtHjKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302466; c=relaxed/simple;
	bh=4JbiyHe6rD7jlErnzVitBvCFUyGWix//x7fccH1MyEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUBwJ1kPNNceKO1+piLEOxY2qBY4s5Z5e5+YMbwBR37jDNkPSLL2qml9iosh5/KZHrQGSpPFjZ+Ysv86gvLcNjxZ3yTsIy4Zh/kFjhWlbYyG35Sl3ZEsPXa64kTNvVeAmvxdMTDkWJfqKgHvIauwOnxSfxxybCM/so7ZslBxmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QizAOg8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QizAOg8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB0D1F00893;
	Mon,  1 Jun 2026 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302465;
	bh=rZpbayGfEtgKMVwRB7LuynGVhxt4/xtfCv0TCkDrmvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QizAOg8AY3VMHgs3xfuOhQMTY2CS1T+slqfNL7a9VwD5PbafqiguySevY2MDRtnug
	 VVKpzU5b2vSlbDU2EKe3o+y43mUEt3yBVgui5bMSL+u8K6Lbbn+kzeZKhKiI20FNbR
	 SxcZePNZfU0daXzgZPeuarCRN0jx7G/4BzRpdhSearh8p9GNWAAskmYIMeYVVS/8h3
	 kjHlaocMcyuWuWEZMG5mzTBaXsy1l+nAAgmp6Jot2yWkYnacuyH5NFlHdjGH+8ZWcl
	 DwtsiqMo+kpQYMw7X4yJ6SzqMfqXcRx3XtLP2l/El4FKF3JEcVvRFP+yS5VzxLOmCX
	 Wk5t2UnUvPdjg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 18:27:29 +1000
Subject: [PATCH mptcp-next 2/4] Squash to "tcp: allow mptcp to drop TS for
 some packets"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-2-d7c842e80446@kernel.org>
References: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
In-Reply-To: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4225; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4JbiyHe6rD7jlErnzVitBvCFUyGWix//x7fccH1MyEc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHUJ9FJeaj4+nusIpBvXyePpl2IxhSA9bHXFND
 WR2rbWaSiCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah1CfQAKCRD2t4JPQmmg
 c/8GEACv+IDmHBJsJNMzECL5pZ/oOHF5SH1U93Quum1u0N+tzhT0/gZntDJhsp0GBGlfQ0JGXdW
 DLxwFGVVuwSn6EIhOWhkasPrGRgpz1WlCtErrAI304/tZ7qt63lf0uVkR/ABrFZeE1tQLCcRwUU
 hMKIZaulrED1Xl8MKlxR2oNZ1y2bCsfY6toNIE6vjm+YJHidGbCt5Ooa7ARadAGdIwv6pbuZ0bC
 vhEwbv+rI6+bZ+JFL/tq1smUYVO9K/kZMHnTv1oEjy6LH4Uj/n+rmdCnh9FZE02rYb7V9NdV4Ly
 dEynz5/XszzCiRNStwlwTVTcFogb6c3wO81BnlxzPMn1UnFcoAV0wbMXRnU3H8zr/sMrjhzHMpB
 NzwP0cnJwZUcgY7NibVDjiQ3dOCjJnMqcztzoeV+7RY/m3JBFT63itSyoZvUgAFSks8e/LDhEL5
 i9ra+JtbotPkbMIoY4Fu6fgC8PV/OfQvQSDLRUznzaC2zfS9kQTYmHmMXbDPOqS7T4/L5NeVMXN
 nnPrBDcV+Me9uChuE5anmBfzHpYaIUMLqK2kQjJdSdwQLEE0k61ygCBrlF0eteRcm7KUKeEU1iH
 +aXIonCxGS1YVDebHAxVWIlE77OAOsUHbZ6EMtyS0o6njgWruzMqu4t+HLPUHseQXHtYoFHSNOb
 x0LBiRqpaeXi7Uw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Not to pass another local variables' addresses which forces the compiler
to use a stack canary in this hot function, even for non-MPTCP flows.

See Eric's comment.

Notes:

 - Using a free unused bit in struct mptcp_out_options. A bit "hackish",
   but I didn't see another way to avoid passing a local variable
   address.

 - Still adding a new parameter to mptcp_established_options, clearer.

 - IS_ENABLED(CONFIG_MPTCP) is needed to avoid compilation errors when
   reading/setting opts->mptcp.drop_ts.

Link: https://lore.kernel.org/CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h   |  7 ++++---
 net/ipv4/tcp_output.c | 10 +++++++---
 net/mptcp/options.c   |  3 +--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d1227b71b217..f6074eeff8c3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -68,7 +68,8 @@ struct mptcp_out_options {
 	u8 reset_reason:4,
 	   reset_transient:1,
 	   csum_reqd:1,
-	   allow_join_id0:1;
+	   allow_join_id0:1,
+	   drop_ts:1;
 	union {
 		struct {
 			u64 sndr_key;
@@ -156,7 +157,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       bool *drop_ts, struct mptcp_out_options *opts);
+			       bool has_ts, struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -275,7 +276,7 @@ static inline bool mptcp_established_options(struct sock *sk,
 					     struct sk_buff *skb,
 					     unsigned int *size,
 					     unsigned int remaining,
-					     bool *drop_ts,
+					     bool has_ts,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 53ee4c8f5f8c..dbeb02f8481b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1173,6 +1173,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		size += TCPOLEN_TSTAMP_ALIGNED;
 	}
 
+#if IS_ENABLED(CONFIG_MPTCP)
 	/* MPTCP options have precedence over SACK for the limited TCP
 	 * option space because a MPTCP connection would be forced to
 	 * fall back to regular TCP if a required multipath option is
@@ -1181,18 +1182,21 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		bool drop_ts = opts->options & OPTION_TS;
+		bool has_ts = opts->options & OPTION_TS;
 		unsigned int opt_size = 0;
 
+		opts->mptcp.drop_ts = 0;
+
 		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &drop_ts, &opts->mptcp)) {
+					      has_ts, &opts->mptcp)) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
 
-			if (drop_ts)
+			if (opts->mptcp.drop_ts)
 				opts->options &= ~OPTION_TS;
 		}
 	}
+#endif
 
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 533226205d78..a7785453b5e0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -823,7 +823,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       bool *drop_ts, struct mptcp_out_options *opts)
+			       bool has_ts, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
@@ -833,7 +833,6 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	int opt_size = 0;
 
 	opts->suboptions = 0;
-	*drop_ts = false;
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.

-- 
2.53.0

