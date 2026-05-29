Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA692E7397
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024923; cv=none; b=IMoH8a4hiTmLiJagQFgYw+CKwa6E0l8/svzFu7VgMnVc5GKhEY9exgF6d5QPPpKiTKP92BpX8A7ET1LAHQrjsT+t9MFFCxL4MsZEF7kaA1NFVxDh3QjMhV3cI+fDBRFAFe2Pwc5vXdfOTsoo6n1M4th2kqoKsFjoXHw+gKlVuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024923; c=relaxed/simple;
	bh=3K6SO233n2ggfre5CbdtCEp86GpEbPGt3ku7zH8RiIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5ls2qJBvv6WoaMCnq6dWjNCDCx5bRsNo/EMo3SnnOJwPT7X4QbB5bnDu6iwMYl0cW3d4FXzFGkVUxkPq8ii0tWml9h8/Xauqd2xV/sPdGXKLz5W0X3m1wQNEhw2BcColb4tI9vCxsNYuBBoKhRaXT/i5acuyUyphUQTUVywt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNJZ6bFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNJZ6bFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A21F000E9;
	Fri, 29 May 2026 03:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024922;
	bh=j5wtZa3ldRyLaVohLtyyQQ4hqdKaYcUUYh3NN/pPqAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dNJZ6bFmNsYyRpdeGzUgtHUVITM79aLYAvWu49Y9zByyinXLwPU3o/utNjLgNieJL
	 Xu7NNDkpkHdDUJZYDcv4JFPGqkDMPr1q3gajZYzyf1AQy2RI0TtvkKkGquYuoyeKla
	 NdaoVHbBM/5NgtQTYvyjrOHdxrHI2WdNJkE9d/wj292ZHVriB7u5VMYpFdfm+8uVcW
	 Gu4q4tNjuZhwik+dui2cw0WwAvSZ7zojx8VNt6YbYi66xRgf/sHn78GtiUC66MtO8X
	 4aVjJqn3KyJmbJwwtFt9BZG492kAS7+V4FkE7Fl9n0+CuH359nkQTM53zkIL3eiafH
	 Iu0QYxkK45MWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:40 +1000
Subject: [PATCH mptcp-next v4 02/15] mptcp: options: suboptions sizes can
 be negative
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-2-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3K6SO233n2ggfre5CbdtCEp86GpEbPGt3ku7zH8RiIE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWe7+fSpN7St9bClTlRlDpunin3v8O+3OQk
 TQf5QttV02JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c4K/EADxTWcKd6aMilKzp5bRyGFKnVNnDFOzX43o/wI8n0SYNbkLKcNIdnDT2rXWNoswNngf9Mq
 bBNw9fBZ5I8T6NShLVixjQEoAeDiStgCS1zJBEiVOlMuJUNJDILOYeQhaflcFt5BIAXlJA4P36w
 qFvd1NAsolb4EJfp7hjTEmL37p6Un4UEXqXgfeYTeTX+0whYKvMYu0AzBnG+MtLF9OgS1BA41bv
 jouiWAdII7M2FzCD7d1sp97NUP6qxO7TQgoz7Ykw1JQuYtDvjuFrzSujgXmGzsof6md7RNY6Sd6
 gjC6TdtiD1zPDB3xYnI5tVG3vDmPUd/WEDMPkOTOgS6KIfkVwQHdHRVoGdtxLhtqtHuvDTh74Xw
 AQDi377RW3GyA1An1KZN8eGSz6+sWXvawD1DtxZraoG0zGDzNrczQnAESn3xamHrGttF/5rNjat
 bf8xQ/GxfG2ctdx8Lgq85MKWoTzpgerLbfH3MZvOC00p7Srzl55Q09vrr8/0lUncVjx6kRIQhJ9
 sfngOdDhmvfT+GytnmfJAx0A3GOcBeOtLka7rViq4zrPR5+EVR7nEHUijfU3pLIiVptWsscOoQS
 fGH9Ty0E9feSX5P89/6XZWhG15H1RYCz9tWWA5EnhAEy2m3upEvn5Pocl8RwJj86P7PbGQ/96lt
 v3hdDOeZtvdYg+A==
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

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4: also switch to a signed int for other helpers. (Mat)
---
 net/mptcp/options.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2b35bdc113a5..b88e6c314b54 100644
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
@@ -654,8 +652,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
 }
 
-static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
-					       unsigned int *size,
+static bool mptcp_established_options_add_addr(struct sock *sk,
+					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
 					       struct mptcp_out_options *opts)
 {
@@ -718,8 +716,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	return true;
 }
 
-static bool mptcp_established_options_rm_addr(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -748,8 +745,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_mp_prio(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_mp_prio(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -775,7 +771,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 }
 
 static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
-						   unsigned int *size,
+						   int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
 {
@@ -793,8 +789,7 @@ static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	return true;
 }
 
-static bool mptcp_established_options_fastclose(struct sock *sk,
-						unsigned int *size,
+static bool mptcp_established_options_fastclose(struct sock *sk, int *size,
 						unsigned int remaining,
 						struct mptcp_out_options *opts)
 {
@@ -816,8 +811,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_mp_fail(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -845,9 +839,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	unsigned int opt_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
+	int opt_size = 0;
 
 	opts->suboptions = 0;
 
@@ -875,7 +869,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, opts))
 		ret = true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, opts)) {
-		unsigned int mp_fail_size;
+		int mp_fail_size;
 
 		ret = true;
 		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,

-- 
2.53.0

