Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8D36C5A9
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024930; cv=none; b=s4jtrOpWPLBnK4IveMH6la7MjlLnlvq6LASs5kpbNd9QZYiWeNcNNL9WWdOM6eHaMR7liRlW+lDedWneA11q7tQ1aOJkmTNX6XgMT0ccV2cGENCO+0fYXVEvezV0LOSjeB/gQdeU7feePCpF7oCDyXQ6uVxZ46fOQK3zoddFUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024930; c=relaxed/simple;
	bh=sC5TB5TRy4dy0oiuZvSxQSlfvKiIDoOWhZcz0dsX208=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHXrBJT7cZ1hB2FyDoaTNIpy1exvPWsqXcq1WoQnZBE18nFhC/JEhCduqBhmsb0hPB6wVmRRzhSMH7uoFlBq6BI4/ck5tzrHX5pTvwx3wJSKHisF58IGNP5I0zVg3QyFkpki4DazZY3tZiqoDnPFgtxkFKaf5Ya670aIOYGiyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsCKuQvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsCKuQvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7621F00A3C;
	Fri, 29 May 2026 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024927;
	bh=ZDIrS5/A9M7SYi/ShQKavE18hc6ufNphJhIJlVT46d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XsCKuQvsZRHWX+OSLFNfZjCWhMOJZwEi60HxKd0OchGs2LyJZZRURDYinT27Hxy1d
	 3lwAcyLzrf6QbSYW1UgbYVV71FO37eLv3afOW9bVVuv6d/GOAgwx992+UqR0gFhkcW
	 imOgEqiP31tzGnwWLJaB3JJeXHZX/NPOj68Kw4WJQMIljQIPQJLrqLL5H4DFUbtfkd
	 gWScUuy7lXKFd8Y6RtUJcdF7nr2uOf+Ifhl5vmRetUpdULNO3ZHKfWsgYGsHeYibrU
	 xuQIsgaPqU0TuBZV5rtWM/7ZuxwT8GvL6cIU3WLwl3O28fNDk3M8KbCICBAqFc54BL
	 Jm9jBs0E8st6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:44 +1000
Subject: [PATCH mptcp-next v4 06/15] tcp: allow mptcp to drop TS for some
 packets
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-6-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4943; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sC5TB5TRy4dy0oiuZvSxQSlfvKiIDoOWhZcz0dsX208=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWcS0Syy1D3TCrXmfrZ9poYHGriIUWXoWQ2
 nCLRuib7ESJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 czGmEADVvndEtuk7GZjfl5vTsIuKnce+rbO+2gM7ywvqcyFFr7wuPzPpt696kWC7pLSNisdl1T9
 nyPNMz6d7chAzPmJBfijSXJc1FSxHyIcdB7PS+xsHn/QAKOu0orTHyopXgXdXfgZLCowMwOHCTy
 KeG1cg11M+cfbSap6XlqWN3JcKvJc+ubGeCv3tAL9qIIVeY59N61j0pnBxRM7tWKtOBm87Htq/Q
 6gxwvYf/YY9KXWA0aGh71TgcJT3yvuGc1ow2MwrMsme2A3+T8XYWFVOsMBs7S1lFkgnhn1A7OES
 BBqE/7KDpAyb3Im49XNZ8KXgcD+tmDsx5lRmlu8Vb0gCT9IUIlQ+CN39zMDm5MiaNj38a71nrxA
 Dk13LfOfiZmLMAGC/BMj7ojRFrTDTIwmorb3dMW/PGVSJYTl2IghfDWkmB8sebisB4KIziCJtIm
 vevSkaKYeQj0y4EAOwuKlRqFgaeX60LjXtMOT4BDOM3qp4yNVDAc8X1BEcYyyDRmZDfsuTua92P
 aPKXidNU2Qscyr48MhH5HNWZPVo853qz2LY691+XydSTssZ/Ngy7VeSnOUvQM0JCS5Uian35Qi4
 p/927lRrc8uAyg61bOdXj/SNv+ViFJe18XXcX9zbLXvHOHCoNhH0VjHHqyLPEd9kBvVPSDj1wmR
 LkjOHPonIdRFJwg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the address signal.

The idea is to let MPTCP dropping the TCP-timestamps option for some
specific packets, to be able to send some specific pure ACK carrying >28
bytes of MPTCP options, like with this specific ADD_ADDR. A new
parameter is passed from tcp_established_options to the MPTCP side to
indicate if the TCP TS option is used, and if it should be dropped. The
next commit implements the part on MPTCP side, but split into two
patches to help TCP maintainers to identify the modifications on TCP
side. This feature will be controlled by a new add_addr_v6_port_drop_ts
MPTCP sysctl knob.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature will be
controlled by a sysctl knob.

Note that it would be technically possible to squeeze both options into
the header if the ADD_ADDR is first written, and then the TCP timestamps
without the NOPs preceding it. But this means more modifications on TCP
side, plus some middleboxes could still be disrupted by that.

About the implementation, instead of passing a new boolean (drop_ts),
another option would be to pass the whole option structure (opts),
but 'struct tcp_out_options' is currently defined in tcp_output.c, and
would need to be exported. Plus that means the removal of the TCP TS
option would be done on the MPTCP side, and not here on the TCP side.
It feels clearer to remove other TCP options from the TCP side, than
hiding that from the MPTCP side.

Yet an other alternative would be to pass the size already taken by the
other TCP options, and have a way to drop them all when needed. But this
feels better to target only the timestamps option where dropping it
should be safe, even if it is currently the only option that would be
set before MPTCP, when MPTCP is used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: split from the next commit
---
 include/net/mptcp.h   | 3 ++-
 net/ipv4/tcp_output.c | 6 +++++-
 net/mptcp/options.c   | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index aef2dbeb847b..e3adeee04962 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -153,7 +153,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+			       bool *drop_ts, struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -272,6 +272,7 @@ static inline bool mptcp_established_options(struct sock *sk,
 					     struct sk_buff *skb,
 					     unsigned int *size,
 					     unsigned int remaining,
+					     bool *drop_ts,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef0c10cd31c7..53ee4c8f5f8c 100644
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
index 9525b22c3db8..c5635c8781ae 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -818,7 +818,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+			       bool *drop_ts, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
@@ -827,6 +827,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	int opt_size = 0;
 
 	opts->suboptions = 0;
+	*drop_ts = false;
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.

-- 
2.53.0

