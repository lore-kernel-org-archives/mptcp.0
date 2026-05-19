Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6A3E7BB3
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225932; cv=none; b=ltBAzLHK3qF9KCa8Mo2b3HvPs+uR6Wla5i/+z2p4HWasOenHNaxgb6H9yuQRRsPfLMdY8txk8K/eM3KEw/HtUV0j1nTkIiOvXsuwmmuExq9KfpU+lJTLEyFaYJ4ZgQZNuWQlfEgfPLec2FBc9w+3vHoETUtpf8fncWRAJ9MBBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225932; c=relaxed/simple;
	bh=wck0HWGKvoFvEux7M3uOGWGO0lZfCsVIZ081QzTv0cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScxagVYuZLZZvAcJVish4gaUmi82ahjvgTNYMI81So3cQTI/tibpZpseJHb/ko7oIVxkfwGZwZIISYVBtvfSmizu5RaEj3QfiiO+cTZqgRQ7rPrRhmYip6KdUugu6SnPi6DQO67olzAV6mNpzGvTrMIkG76A/iXtMAEovLdWPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVhiIDqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVhiIDqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85361F000E9;
	Tue, 19 May 2026 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225931;
	bh=EROsK5D10kLmYq30DCvG1M2tX7VvimZMgYjqr4mJeM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jVhiIDqCTLYaVWlGJpKKDnuGCplHSmzziBUvNv4dZeZyARk7ZAVUyGsRk10E61Qrb
	 FP23A5aL1eZOJSAh9ohRF7ulwCShw1xxL8CdrsaXg/rwFgtoQW6scMki0ByFd+ZUVM
	 K60kyeAKiD/ScCNV4JQc6TLOuMutx0gh77zUctH8eiRJlpGCvNXaWsnfXHDBszMidR
	 yfE22XLjNEcwTh+QUXoCjOnCs59fOEhNYuJKXsH/JiYjgkIqrd8unprMzZFSowT9sh
	 PyyGX9iImgfT5xmF6diCpOfcb8KE66qv+EhIMrROODLEmo12XsEC6EFUup9gPssnr9
	 pHm1IP252Ej6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:17 +1000
Subject: [PATCH mptcp-next v3 06/16] tcp: allow mptcp to drop TS for some
 packets
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-6-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4932; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wck0HWGKvoFvEux7M3uOGWGO0lZfCsVIZ081QzTv0cs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVB6JVYoPUT5PRFjz+NVmqNAUdrTkwEpWykG
 9mppCfxp0SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c0g1EADkb5SWC3C6KDc50OeAOrJB6Z6T1DOfD4tMHtxKE230MyI2ieXglKxfqy+lgEAqBPPGayY
 TLTVsQzORp98Br7xzdQjSjqG2ZBakX0LeEkWcyUXRQMrnKzUs6wjZuvehc63yzgkZvIlQ6IUQfR
 KX7HM1OW3K6jETmIecTyE4pGcGaExp9kvwa5izzey7QmpLWKNNG2mAcQWeCibx4kjNthT3+VcIv
 UqCWeL4mddtgrXMhEa70QyjXkyoiQ/aa61anQ1vkgC1vOnqMwIJgguyM/Q1jOydiQMbkfr6F6CK
 4gfna2RIVqNqzkyvGC39dIAnZ/e2igNU1qySUh7uMYAEpY7ZjUUfxjvv2lsRE7MJbQ162glptBs
 SOjRDV40tk+6jzSOzhROG2PVJGBy8V0AK3cfiY6mtb/JGrvmr6WCaB6ZIkBUVpymNPjEnWZ+QjH
 puZnhSEHHz6C8xsAoswvE3mawyd2xC+TmXIFqfyhvDhWcFAmDoIwTLk30ydrHDwFtoYR+ek1Sh/
 evRPN6mkA6b9WmmLHXQ7l58dgYcURwDmuS1iqQNuGmodk9+95DtCEHvFty6sjruWkILF1Wak/qA
 ao291PBFC6vqECzC5vNL2ASxiBNEdRBsuOXqpbXiuwLjjTG/8l/d8NsLOGVIz9XtuioUv9gGUHl
 98TgSocq1pzjpSA==
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
index c6d57997110d..94c182d845a4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -821,7 +821,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+			       bool *drop_ts, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
@@ -830,6 +830,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	int opt_size = 0;
 
 	opts->suboptions = 0;
+	*drop_ts = false;
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.

-- 
2.53.0

