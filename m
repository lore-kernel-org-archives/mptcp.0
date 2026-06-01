Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C45396D0A
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307236; cv=none; b=LKnyHEdk5Bl3xqlX5Y6QML7b/EcxF69vDAJRna/LDGNa6780F70E7p7fleK3fgGvdYoghJRB5KTMXFRLDHVSpICZAXQWLqTGp8LfdpX+0zLFM8yS8/l/QlCkgJmezO8p1ytOxOnHvTcGKfDP8MGgk2SqKrPQ6B7J9yNvqtuaP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307236; c=relaxed/simple;
	bh=Nnbvm3KJc5pJz3axRyuFx5NX5tC+6aGL322rgvxPN1o=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:
	 In-Reply-To:Content-Type; b=FXd3PrAlcorWJ7EfqBsBeaT/Ii2whyrpK0IHFli/JpM9OggKlEJn1DGJHHc++yQlEPatTVtIQ57gFtyZW6KSsregfUZoPyiSVwt2I8lBF6em2DwZYKjpvdxqpBPA45O3HSzcTb9eib7lPjKrGv9UJjcugEmca84yz99dSikNUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjsNCZ3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjsNCZ3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D681F00893
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307223;
	bh=9jcW5YWcJt1EBJ8h2uli8qTovIMy54Ws0O/8wEiLEt0=;
	h=Date:From:Subject:References:To:In-Reply-To;
	b=gjsNCZ3DpAycSLPkYMvt9XY+mL/0R5XyJI8SlsBQl2dPdRVsOk6EOmt7kQ7JfC15E
	 rqZx2uVRN1YMZPpUMul/hgPG+sGk4CZkV4R4QmULK9FTRGWthgGn2CxLoNnDRQE2uX
	 r1elgTzDI+1AuJsvbPOlF7MzEf33Ew5romAiAkRkPsxuc//alQvdKiA5SB8g7PB9kb
	 wEPEagy6a4q9dWWvA9XXSsaHKOfFdrcmIdSqn31ZSt/fACzXoTe77hTfhCs8izVR89
	 9huOaoNjJSA6qvvilQGOQSCL7z/j088Wbl3xIKSYqZc5ub34lvSteUeRKo4m4a5N7y
	 Utn9KUfxd/M4A==
Message-ID: <7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org>
Date: Mon, 1 Jun 2026 19:47:00 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net-next] mptcp: change mptcp_established_options() to return
 opt_size
References: <20260601091816.444738-1-edumazet@google.com>
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260601091816.444738-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Eric Dumazet <edumazet@google.com>

Instead of passing opt_size address to mptcp_established_options(),
change this function to return it by value.

This removes the need for an expensive stack canary in
tcp_established_options() when CONFIG_STACKPROTECTOR_STRONG=y.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
Function                                     old     new   delta
tcp_options_write.isra                      1423    1407     -16
mptcp_established_options                   2746    2720     -26
tcp_established_options                      553     503     -50
Total: Before=22110750, After=22110658, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/mptcp.h   | 18 +++++++++---------
 net/ipv4/tcp_output.c |  7 ++++---
 net/mptcp/options.c   | 31 ++++++++++++++++---------------
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e40b507257c3720cc2d78d37357d6d..cd4639beceaa53c573135ddaeb7528a80b4ca824 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -149,9 +149,9 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
-bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			      unsigned int remaining,
+			      struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
  void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -266,13 +266,13 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
 	return false;
 }
 -static inline bool mptcp_established_options(struct sock *sk,
-					     struct sk_buff *skb,
-					     unsigned int *size,
-					     unsigned int remaining,
-					     struct mptcp_out_options *opts)
+static inline int mptcp_established_options(struct sock *sk,
+					    struct sk_buff *skb,
+					    unsigned int *size,
+					    unsigned int remaining,
+					    struct mptcp_out_options *opts)
 {
-	return false;
+	return -1;
 }
  static inline bool mptcp_incoming_options(struct sock *sk,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef0c10cd31c71ff585a937fde37f2b08b1214b5a..31b459ecbe8307a8660623038fea6fa7b0860f7f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1181,10 +1181,11 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		unsigned int opt_size = 0;
+		int opt_size;
 -		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &opts->mptcp)) {
+		opt_size = mptcp_established_options(sk, skb, remaining,
+						     &opts->mptcp);
+		if (opt_size >= 0) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
 		}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983cff3082d68290626dd8f1e044527f..53528301394d70072dde6614feca6128ea949436 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -836,13 +836,14 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	return true;
 }
 -bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			      unsigned int remaining,
+			      struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	unsigned int opt_size = 0;
+	int total_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
 @@ -852,20 +853,20 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	 * option space.
 	 */
 	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
-		return true;
+		return 0;
  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
-			*size += opt_size;
+			total_size += opt_size;
 			remaining -= opt_size;
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
-			*size += opt_size;
+			total_size += opt_size;
 			remaining -= opt_size;
 		}
-		return true;
+		return total_size;
 	}
  	snd_data_fin = mptcp_data_fin_enabled(msk);
@@ -877,9 +878,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		ret = true;
 		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,
 						      remaining - opt_size, opts)) {
-			*size += opt_size + mp_fail_size;
+			total_size += opt_size + mp_fail_size;
 			remaining -= opt_size - mp_fail_size;
-			return true;
+			return total_size;
 		}
 	}
 @@ -887,27 +888,27 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	 * TCP option space would be fatal
 	 */
 	if (WARN_ON_ONCE(opt_size > remaining))
-		return false;
+		return -1;
 -	*size += opt_size;
+	total_size += opt_size;
 	remaining -= opt_size;
 	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
-		*size += opt_size;
+		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
-		*size += opt_size;
+		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
 	}
  	if (mptcp_established_options_mp_prio(sk, &opt_size, remaining, opts)) {
-		*size += opt_size;
+		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
 	}
 -	return ret;
+	return ret ? total_size : -1;
 }
  bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
-- 
2.54.0.1013.g208068f2d8-goog

