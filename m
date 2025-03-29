Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056C3987D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743265592; cv=none; b=YU0dbiGIxDgnMXsUGpCnEPunXNfUwWiexKS2BVSSwqqx2w+VyoSxeIDMaIydvszoPdDFLzlYrfS0ZsOOAyUp02sc8ir9iUCTeX24sA9I6hwowQa8M4MErGkLSKEjFrJL317jcikJoqDP1Q3jsy76MXAm1UesvBleBsW2+Hw2kT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743265592; c=relaxed/simple;
	bh=do7LBD/99VdQmTCPp+WjqU2P8s4k6TTlS3y0ykxOkfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+TtIzHvBfBMLdpb9EwpaYdeEE3Vjyree02L52uOTT5Cx/ANIOvC3R+qQay8A/elD2RoN4y4NokS/EHNxLllBfbt94CXJaO8D9ZrcKGJfTOPcbRrTxdeA9n8VMZ23Q43qGp8Btg+bkuOncaDDmBWHmyhm+6C13Fqv09VWtUaNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBWl9uJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBWl9uJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20249C4CEE9;
	Sat, 29 Mar 2025 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743265591;
	bh=do7LBD/99VdQmTCPp+WjqU2P8s4k6TTlS3y0ykxOkfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SBWl9uJEZ9iOuoE0siKw2Yjf4cU+t+jrweQNZC4JL+NgwbgFp9X8rFe7O/yQW7yee
	 9TlSiqt1fEMMV4HsnyB4zD1fJv1fQhNg3NcUdwVA03Dle+iZj7V1U+5LYOCx+FRDny
	 yT4QeIVhSan3ASgadk2cW7opaikR7nwOOX7F9RFby5QwH8NlDFzxj6RJgO0Bt+zDL1
	 X7O9GWM9H0IbM09rOl+7QRxUtH1RloRK3V6oJGxXtO3mMQQqhqHoHPgTQkpBC0jPsW
	 SUnTC5SPfcbRMcmsQ4OG5zFpkiKBQRMfbJvvKC6TiYo5Vq6fZkOGEuc0q/rrDk3Rb1
	 7nmxGwFpDgivg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Mar 2025 17:26:16 +0100
Subject: [PATCH mptcp-next 3/5] mptcp: pass right struct to
 subflow_hmac_valid
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-mptcp-mpj-reject-v1-3-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=do7LBD/99VdQmTCPp+WjqU2P8s4k6TTlS3y0ykxOkfE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn6B8zaDbS1E8D+IIVQXFNq4qtCf8uqJzQ7yg5P
 YzsiC5ORiKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+gfMwAKCRD2t4JPQmmg
 c09HEACiBirzexAFVvMJMsJxj4dvXAVKd23bk9SCzaKvEw1zSAH1UF18b1t5R6vMmXGCPmoPSYv
 zIJ8yZXsdXIGj5fPN3I6SDOOEvad8qLn9Zch4xjgJ/Lp9ACmMiKaSoZMMGFwHFb7lyoMfxu321j
 xuRwbnd4TEMCT+QVyGVlx3syxHo/NoshEmSRryw0il8GLsgOxv3PrKL93/3ertkP5et/LS3NN6e
 xsmmrLnizJduB3FS0qnauDKT1qCe6I8Xl27J6IbmHgwT0XMOcaLbroHEf6m5yYM+4YzIukH2pGg
 6DvN7Qbn8YAVCn6DEv6hZ8I9siHoUarvy9e/QnLfNXi2/KrLyU5s36L2foiAAnq8eNJOhGY/7hb
 X4e9QjMvl8yH5y3wlWYSocLHbk196Y1grRakovLEBtOkLSyeJvHyTYQScG7UykAmd2YzgXLS9n/
 lWrSSBiTRz8GSj254Cl/fZaY2SGfssJOiC0MBTZjHkGSezDHEy8MJK6UfTyj8BxSrN+t02rZzi1
 VP5i0lTlQcpmgeFFmCmwIdsdRzols18m7qw21ITK3HhdqbT3Mv5Q0O6rNustumYMddntSicqtCo
 iAhw9ZB8IMZJuGabev8T/b4n8/cXrYCORWj299jYu5qUfp38hDqaDKry4sJdfIcQJMxLEHQ9Z91
 R0upYMtRb+VlOWg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

subflow_hmac_valid() needs to access the MPTCP socket and the subflow
request, but not the request sock that is passed in argument.

Instead, the subflow request can be directly passed to avoid getting it
via an additional cast.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 24c2de1891bdf31dfe04ef2077113563aad0e666..e7951786a97c91190c7341d2c586a1f4acc05ed5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -745,15 +745,11 @@ struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *op
 EXPORT_SYMBOL(mptcp_subflow_reqsk_alloc);
 
 /* validate hmac received in third ACK */
-static bool subflow_hmac_valid(const struct request_sock *req,
+static bool subflow_hmac_valid(const struct mptcp_subflow_request_sock *subflow_req,
 			       const struct mptcp_options_received *mp_opt)
 {
-	const struct mptcp_subflow_request_sock *subflow_req;
+	struct mptcp_sock *msk = subflow_req->msk;
 	u8 hmac[SHA256_DIGEST_SIZE];
-	struct mptcp_sock *msk;
-
-	subflow_req = mptcp_subflow_rsk(req);
-	msk = subflow_req->msk;
 
 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -899,7 +895,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt)) {
+			if (!subflow_hmac_valid(subflow_req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;

-- 
2.48.1

