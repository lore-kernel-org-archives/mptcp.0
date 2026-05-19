Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB922DF68
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169878; cv=none; b=QwK4r0J7pgW7EcnXbNgwFHdkiawfcaIGimWTNFQcbglcToztOgRPrpIddlq4/nvJcD2DYcU6gQ1fpYHVsyW8/TTgi/YSxA3UETJjlWtnqI8BkNVd3fpJWrkwm2GWO8lNkxO5rBGukYx6bXcpXC1bS8sOdoRQ35WtGuBh/j4Hm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169878; c=relaxed/simple;
	bh=1V/0E2Fp6bqGFvlNXIDG5IseSYm9DVjOBS+MuA0YryQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9k2LpzOjvf/MXIig7lI1CLwpaFGR9M7eesPnOwoTr5i32igoAgtg51TvE4ztp5bejLijo5IGFCfEXlafEWlQKNrVpTvio2wgTjlsc0r3DjRcFaUbA9yIrgH22UQoCMC8sqatHgSxT1K4yfuE04BzWXqy2/RGYjkVD8BNqtsAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYlm+1m1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYlm+1m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91048C2BCB3;
	Tue, 19 May 2026 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169878;
	bh=1V/0E2Fp6bqGFvlNXIDG5IseSYm9DVjOBS+MuA0YryQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYlm+1m1vpKbwRlTMAJzp+LyUNbUHJn+VWOQmyjQ51YbGmvJvuc0UBZu8G1x7fiO4
	 k7O+EI+bApY7G7AWioktgV3TqvPXdGeGk3JevRQXI2tYcaKTs+wKpSSnxvOpubNhns
	 OqUXadUR561i6m+r1AoisRyZhT5jMy5akBqcik8J/GtMk3Qi7rAqkS4FceRF69Yy83
	 MvEg6Ib0ZPd7WxLs04ILn/e+XSNLQL47+jSX6ISJHeovHaxdM5DBQRKYINH9xbJrKh
	 UOAZC1cr6jFiCxUUtyN8g61sRUu9wBWEJg52Ki2lx8kOpLxQdaAsNq67B46tqM/SbF
	 rG2Bx2e2pniNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:11 +1000
Subject: [PATCH mptcp-next v2 02/15] mptcp: options: ADD_ADDR size can be
 negative
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-2-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1V/0E2Fp6bqGFvlNXIDG5IseSYm9DVjOBS+MuA0YryQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pS37ijuFpb098tGmRLIADHl+ZKIL3c+YW/9
 Pwqdcxpj0KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c/JfD/4wt8qiJy6hRhHYHHWwI3INmtlKBlIJfFLcLz9cn951bM2ze1IWlUFiqVWTNFUiLiVx+92
 c1h/Pt/L4v3+yCYByjUQJnFOZKXhP6f1gNXr7MiHgAcAmm0zfASkdEZsh0J3dvrlp0I1/eFy/VG
 325GtLyYJzkX8F8+An0Llx9A4BpQbrfTyO8vQ3kfEubahEsOsJCGhtqkIO9hlxrbfCevyZRafR+
 ux8zUC8Socl733o0l+dsyyrWXaKYEql/GohyMydOBV1YG4dCiC+ktayt0nEDXKfGjHxeV4sBsda
 JhqKZmsu73txzbzQRG32WnpemYPEmuWfcoZ6eUbRtm6s6WSAzSIC6X0gs5N6/ko+uAjv5mN04S1
 f+Ezb9Mxg3RY+O7lNUKhBoGXh6G9qDzwpUFmL04CMCBD/qlpKDheJIQVsu6JTyyOvA4JBfkJ2rP
 hmie5p69/1Sh/TjDbFWIunuJsz+bmfl76tBPIpP9dfl4CYIL1/6Y3WsoI8Sv33l6niXorObmJrD
 M4QwPsKU449kQf0qxDmdwGRDImsR+lQPRm55qIXm/0PIiS/LkuU6JMlUT713MRyQKv7hxpSXKbF
 4g5UrD5qGMgyiMunhBk0H/w4+HkMu4PX+OP7IPX3w18E9ZS6Y2iEguuV3ZpyTcsr3v7Bn4vYfpF
 778fXQZxAAQoY7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Use a signed int for the returned size, because if other options are
dropped, the size can be negative, e.g. to send an echo ADD_ADDR with a
v4 address, and no port.

The behaviour is not changed, because it was working as expected with an
overflow. But it is clearer like this, and it will help later on.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..966f6a867287 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -651,8 +651,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
 }
 
-static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
-					       unsigned int *size,
+static bool mptcp_established_options_add_addr(struct sock *sk,
+					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
 					       struct mptcp_out_options *opts)
 {
@@ -842,9 +842,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	unsigned int opt_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
+	int opt_size = 0;
 
 	opts->suboptions = 0;
 

-- 
2.53.0

