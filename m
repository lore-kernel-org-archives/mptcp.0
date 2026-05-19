Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698B2D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169883; cv=none; b=jW/GFdPA/he2UKtfVTghbeH+fUu4u9VoQW346GROIKBLS4Bsa+3kNPMrYruCCQl+BDx0aN77g8F73rJf0RsAkko7hy9+xNuk7C7vK+imlNBbkdxABXhtGZsicj+Z/5Lt+QtVrvbtRYy0Z3ne/IxsRIFLpFfSIP29BEE/PZjyyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169883; c=relaxed/simple;
	bh=cZ5cBcTJwHjrp4DCzMPwlvilxKz8vNvwH0IKzxgXWS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP0H+jLWJkoKYKKk/dNpFTMWCaypqQ2uuhRW58ObjQsWir6t/zLn0RFVsC0FjSpLoEBSyv/OnnB7vdW0UBS2GAfAAlj4MRQkkL0Pc9vHlBpXXc22cJsizYIyTs3q//fqOLAo8xm9WvnRI32AuVAchjk4jGBkf/bARnigcLh6RjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7KZOTu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7KZOTu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D7CC2BCB3;
	Tue, 19 May 2026 05:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169882;
	bh=cZ5cBcTJwHjrp4DCzMPwlvilxKz8vNvwH0IKzxgXWS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S7KZOTu7cRGYmdkx7xT7fqPGvJboDRjQYrY4aQjwC4v7fcGUeu/EFo1g4Jpv3NPzl
	 3nTasNre9SJAaKBMtKKuDTGVHalo0FDxKlW9o3lg/19WyciE1fED8E48ZD9oY7i4rf
	 PTfuUlZfUQGPilM6ztjnGljsOI0QK7FWCdYlbtNWBvJf3CBlczUKe71NuhlfatGbSi
	 YgL7OapVOoeDaiXeKIbFk0Ys/MJukT74a7er5Wfz7tqVya11EbB3lnlw3yspON6USC
	 pLXWSd/ox8y2NPeF4EFa2Jf6VgFGe/94E9v996D8x6m9Ha4WJHoyHFLvpdLRPBgyB6
	 IRIMfP+2Cj2CQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:15 +1000
Subject: [PATCH mptcp-next v2 06/15] mptcp: pm: drop TCP TS with ADD_ADDRv6
 + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-6-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7289; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cZ5cBcTJwHjrp4DCzMPwlvilxKz8vNvwH0IKzxgXWS8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pS2Avm/n5TLt5UZPly7nbalPNytNQqKncem
 IhQ5MfODH+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c9dxD/9FkX7z+uptKd3O1MP5vMR4a1n6OqEbhZKrgfG7yZnIgQTWRDGCTZf30iamV2ZkvL4v6/Z
 W8pA+DXrEyXrVUXEf6U0SsYbvyvtpgdDvlLFl550x8UxEoHxdmKtuVtZNRPL09mwyfHHLLaWGze
 qfEcB6IeggjbSlZZO+TyMwLjESI7VCAt9QhVU0v7MeWb4QqY06sCVYvfbjrOXreoQEsCJWgPT7T
 TMiUV8QTojZuZn6DVpPpCWDHaMzRQFNKFzfLkGd8eOW0WhcIA1X1HTQ7CG/e9TmR8HN0ufMr5sd
 oauLVn+Vl1DV5pyQojhTIqNnSnFi3zGjoRBhYFpFrEa3+huWQgd1/13EyqEFw0huQjsUJCjXSFK
 fYEy+CPrizzp/YqEuxwyuL/8vbMEcZT5J+ss12PvBmJN7+sSEnrx3eOnuLeJbFJ77nlPp1dhFsz
 cP5A6hkrthnSmczdGNBzdNxaWAELiflmJTbR6XDHoHmwx/b6uYfe5LAiSFQXOTSM61hRoeFE5IJ
 KQwKvfgX1BDAcQOySLUhcK+Ek8nEmRUVvRYl7vzFG1npwsBQF3BxtDs6SGkE4QL0vvgRmWQC/2Y
 4Kj0V48y4cJZD0lmTz0MpQ3U8LEy/DFtM8lUFaF2BmFzXnqY8+79lg3zuA4xEQWhJ5sFV7qCG8M
 0OciHlmV0LLk8Bg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the signal.

To be able to send this ADD_ADDR, the TCP timestamps option can now be
dropped. A new parameter is passed from tcp_established_options to the
MPTCP side to indicate if the TCP TS option is used, and if it should be
dropped. This is controlled by a new net.mptcp.add_addr_v6_port_drop_ts
sysctl knob, enabled by default.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature can be
controlled by a sysctl knob.

Note that it would be technically possible to squeeze both options into
the header if the ADD_ADDR is first written, and then the TCP timestamps
without the NOPs preceding it. But this means more modifications on TCP
side, plus some middleboxes could still be disrupted by that.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/448
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: split + fix reverse Xmas tree order + change label (Paolo)
---
 include/net/mptcp.h   |  3 ++-
 net/ipv4/tcp_output.c |  6 +++++-
 net/mptcp/options.c   | 11 ++++++++---
 net/mptcp/pm.c        | 12 +++++++++++-
 net/mptcp/protocol.h  |  2 +-
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..b14e98b60958 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -157,7 +157,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+			       bool *drop_ts, struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -276,6 +276,7 @@ static inline bool mptcp_established_options(struct sock *sk,
 					     struct sk_buff *skb,
 					     unsigned int *size,
 					     unsigned int remaining,
+					     bool *drop_ts,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 47647a99e324..f5552928303b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1181,12 +1181,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+		bool drop_ts = opts->options & OPTION_TS;
 		unsigned int opt_size = 0;
 
 		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &opts->mptcp)) {
+					      &drop_ts, &opts->mptcp)) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
+
+			if (drop_ts)
+				opts->options &= ~OPTION_TS;
 		}
 	}
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c6d57997110d..a0e675cac4e5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -654,6 +654,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk,
 					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
+					       bool *drop_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -668,7 +669,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
-				      &drop_other_suboptions))
+				      &drop_other_suboptions, drop_ts))
 		return false;
 
 	/*
@@ -821,15 +822,17 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+			       bool *drop_ts, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	bool has_ts = *drop_ts;
 	bool snd_data_fin;
 	bool ret = false;
 	int opt_size = 0;
 
 	opts->suboptions = 0;
+	*drop_ts = false;
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.
@@ -874,10 +877,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
-	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
+					       &has_ts, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
+		*drop_ts = has_ts;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index dac76113f79b..5e6a32fc583b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -906,7 +906,7 @@ static unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions)
+			      bool *drop_other_suboptions, bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	bool ret = false;
@@ -950,6 +950,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		if (!*drop_other_suboptions)
 			goto out_unlock;
 
+		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
+			/* OK without TCP Timestamps? */
+			len -= TCPOLEN_TSTAMP_ALIGNED;
+			if (len <= remaining)
+				goto enough_space;
+		}
+
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
@@ -959,6 +966,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		goto drop_signal_mark;
 	}
 
+	*drop_ts = false;
+
+enough_space:
 	ret = true;
 	*size = len;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d6c8b1829cd..6323b5195b3f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1213,7 +1213,7 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions);
+			      bool *drop_other_suboptions, bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, unsigned int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0

