Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D174183D2;
	Fri,  5 Jun 2026 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651324; cv=none; b=B7eTX/+nb337pU+Sq3RRNjo6s2Bbl9U26hJ7W8AlgBV8mzlhrhKQq6tmlYbYMYtrwkgQOleNKRq0gvL0v/rerrlXGLb/hYjkLglaympG7eVtztRQI3sklfNkgSdZO6g9cg06k1yn0ObUjw+YwJJJ0ywBG0A1RLUPplxTAAHz8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651324; c=relaxed/simple;
	bh=2rz4qXhcGLgCnPcrtLKqQR8RZlz7VL1w/36bRANJbeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJ2p/lE6SH3BTyV2QgamhmAhKMM/5AezPXXrNUL7KWsgD9hp4AlQCqxjINxMxwqdJpSOrlE0n17ur3PpXJij8YQO1nVkxFw+awP98jrI/y35DwGPByrY4amGY/WGg/oVxvhEALtejpw6CUhXn/PQIkwV9qCHKAq/uwynpi6ycP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKASq/Xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKASq/Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFA71F00898;
	Fri,  5 Jun 2026 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651322;
	bh=Wtaeein1M7WCMCqc8P6wOdEgWRKe92PgEMrjQTsfYt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aKASq/XvJQc4BsLE29w0D4ypvGCI5UgWnqaVgzIrwlgXk0yTqEWccyhlVUqt3EOJr
	 7hl+QwB2H6gDH0GQLtQrkWUSu6j+6qGkNw5mNAAIabGlFzMXLmgSpF9VmNt0xlS5RB
	 2HF8VH0MW8v5Q5AppcC2IGQ40QRvYDrUFl3GBPD5saI6bJrEPzlatYlc4/aFZRFG6D
	 XGHT20g7OP+pmUND+13TnEdnWkCPgKZVJaWOAjZ/RG62xE2uvTKDyL97nhkfzrSAXK
	 MDyhILji9G+EcfrkZ+9CR9r3lsDIMJcs0tbpFcFThKSKTna1/N3RKS/Y01GuPiI+W6
	 3H3xLSMxpUcdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:45 +1000
Subject: [PATCH net-next v2 01/15] mptcp: options: suboptions sizes can be
 negative
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-1-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4757; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2rz4qXhcGLgCnPcrtLKqQR8RZlz7VL1w/36bRANJbeA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxhd/2U0duHtrO384RTrX7yBTrHEgqui4mX
 DrhJhZ6R/uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c1/lEADjqxjZ1GUezRRkGXKCYm+rdryuuy/2H+TdVpAuCSoRAPCV2lMlIXG1YwrC91/IU71+hAy
 ytCCMC8l+0IzCPTixHte0fHoi1WC+dc5K77nJLQwe6FJY3sofDY1DLx4thggL9gt+3vZJhCdSI0
 K01I409NYThbaMatxiXpJz4UVyuyhUKe3OMnH46cq+LV9q0A6/XL2yTLL93/8qcEemMnMirHood
 LVDUxzNtS5iT/Bi2PTeqZyPyG9wiu6FKI5kD49tGDzPWI4t37wGpMrimEOEgMDwWRWh6/pnyS9k
 YZ7iR+PgGlg93UbGflmDkl4RKx9BG0x/83rb6TWEB7IRIr7QuVp/l1GUnWL1g0bGzT4Jj0+PpK0
 RPT/2+IAPmKOyEF1Y17hiHA2Dox6zh8fxrwvXeXKNugI93dLhc/5Od3IgHPHjsuIMPEiBhH4tPZ
 sZjQL1hOzWOmiW2BSoScejacm2IyqDWLr/Fuqc8OALFp2FT7VwS5UfKAbDnGkqfPPY7ZYogcWHZ
 6+9UBByLXQePIpfAUvqaG2jBGAQ9/vJinm/rIBLO55ZtC+OFpqk3KEfG4BvR64WhdB5u7Ape61g
 Tclhl4gc2FbWzBrKFylgv5/f32jzDuRm3yGLECgsz9RDqj+RJ3Kjo9bY0IhgLhHoE9I7Tf46cUT
 7leg5dFNV0Rl8GA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Use a signed int for the returned size, because when other options are
dropped, the size can be negative, e.g. to send an echo ADD_ADDR with a
v4 address, and no port.

The behaviour is not changed, because it was working as expected with an
overflow. But it is clearer like this, and it will help later on.

Even if, for the moment, only the ADD_ADDR size can be negative in some
cases, a signed int is now used for all mptcp_established_options_*()
helpers, not to mismatch the type, and as a question of uniformity.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 70b939f3c33d..fd972047fdf7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -447,8 +447,7 @@ static void clear_3rdack_retransmission(struct sock *sk)
 }
 
 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
-					 bool snd_data_fin_enable,
-					 unsigned int *size,
+					 bool snd_data_fin_enable, int *size,
 					 struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -560,8 +559,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 }
 
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
-					  bool snd_data_fin_enable,
-					  unsigned int *size,
+					  bool snd_data_fin_enable, int *size,
 					  struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -658,8 +656,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
 }
 
-static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
-					       unsigned int *size,
+static bool mptcp_established_options_add_addr(struct sock *sk,
+					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
 					       struct mptcp_out_options *opts)
 {
@@ -706,8 +704,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	return true;
 }
 
-static bool mptcp_established_options_rm_addr(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -736,8 +733,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_mp_prio(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_mp_prio(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -763,7 +759,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 }
 
 static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
-						   unsigned int *size,
+						   int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
 {
@@ -781,8 +777,7 @@ static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	return true;
 }
 
-static bool mptcp_established_options_fastclose(struct sock *sk,
-						unsigned int *size,
+static bool mptcp_established_options_fastclose(struct sock *sk, int *size,
 						unsigned int remaining,
 						struct mptcp_out_options *opts)
 {
@@ -804,8 +799,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_mp_fail(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -833,10 +827,10 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	unsigned int opt_size = 0;
 	int total_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
+	int opt_size = 0;
 
 	opts->suboptions = 0;
 
@@ -864,7 +858,7 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, opts))
 		ret = true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, opts)) {
-		unsigned int mp_fail_size;
+		int mp_fail_size;
 
 		ret = true;
 		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,

-- 
2.53.0

