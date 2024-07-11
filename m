Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B928FF
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712397; cv=none; b=En5Y4rDPTz+uPqLUg+vsA6hm4Ou5LMWVlxxanL2zq3nhXMoRsbvQY4mbMD97OvGnM+0kQG1GxCgGx7MtG+BMS4CDg4kehbni00jYwSpuCX/60/MHrw/P5atvVoCIHVe09fNGqGzLhwHgFLF/RUMmiVsgu1ZJBvcXPi6tPsf4aZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712397; c=relaxed/simple;
	bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRtzBS9jrh3pDrr+1tuDF4GS95LtIcLGMuHQjnbqF7nWNecL7XbfSqhrQA073LyofLBtk3zUx5QdEVBNmmJUk2FMeqZxYQl2gwY2N0Z6JEl5p4B/i6itkP3GzW6gF7ykeTPBWytg13/lmYIEuxTu9CkSoxAOa6+DUi/YBECOOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEpv2XRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEpv2XRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580CFC32786;
	Thu, 11 Jul 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712397;
	bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UEpv2XRfiEHPUaxdjfcsZ52tcJTJ9knuLL3SWOn3PiAo3OXgWiNwvkX/VvRw5wfx+
	 0cs256vUC57jVbqe7vNcjXmEfFiJXcbv3WhVShrn/maWLvwPJiG5ADYSUj9xXug7vT
	 OKjqegEPXhA5J3KKSDlnRJjhLEdL6uKS73AVfTlSZK/75ibDcqrg2/KYsaucTRcXIh
	 IRNghyyLddgAcCYpmyCYXwjjgSYDywhyET6YjsHqfi0wq1j1lPnn1SdHB4BY2JPhMt
	 //TKRBDVZkMMUDEI/Qp5fQd3W1+uVtvB4ZY70nVyHfE3iOvlDjKkVcV4ACwV3hy3SG
	 XlN4acy6GaP6w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 11 Jul 2024 17:38:59 +0200
Subject: [PATCH mptcp-net 2/6] mptcp: distinguish rcv vs sent backup flag
 in requests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mptcp-backup-mpj-v1-2-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
In-Reply-To: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmj/zI3emiMTm+PUH1qAwLi5xZPIq0qjlhlZz7Q
 0CcjUs7aiyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZo/8yAAKCRD2t4JPQmmg
 c8eyD/9KJVWvx8YaQIEvVCEWSSOdpaBveSScNTVyfVVtiB0nQRC5mTjJflLDLsK0Cdche7I6kVw
 WoPr9U+Nn29cco/6+lfxJKbi9piJkGamIp4io+KjXashxjjQ5mGuOT5zL2oZ5CZQar3DcDo0RD9
 Ih7r17ZejpmMhLYwIffYvKmMzBa/V+fjIx5cSwsnT0hfJvc0bKVcu3XxuvgL9YR1mV8RH0AS+lo
 xKY7yvU415KpezobNgvC4Pj2PzR1SrHH99gfWTpTOPSSynszSHA9JNEpmCK/mELxhHIPcodHbcB
 LqvI9+6D9gdnZVa8TE9HD3j5jUG9BOQQw1jtShiXlrc3422TTzDTvTMQnXiqBgoTidrpcdxTBv0
 yBqAb8DS/vKWjtJmp6yIgcIhS4/z5DPbSi8OrNOxQbH/lQP44X7GTPJ+jIPxCBT04DyXqISYFgd
 C5bKhK+1zutmIGI08jGbMKgO6k6ajIptmROidlGb6LM6xKQ1Jbu/HwZKIa4134gDtkua0MFPKA1
 9ZYn/zYPpQ+U+xgpKYUYluIa82+Jt7JXB50gKrgNbsa5S5UxXGHXEyP9krrfTcR+20UZCRqLQkq
 cj4rklDgRLZyHuHWykpK9JBQPncVTzAscj5yhx0DPJlZ+GOosva5Arh0oopBt5bAhJvgvqKPUS9
 +jVBBXdPcxqvNBA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_JOIN + SYN + ACK, it is possible to mark the subflow
as 'backup' by setting the flag with the same name. Before this patch,
the backup was set if the other peer set it in its MP_JOIN + SYN
request.

It is not correct: the backup flag should be set in the MPJ+SYN+ACK only
if the host asks for it, and not mirroring what was done by the other
peer. It is then required to have a dedicated bit for each direction,
similar to what is done in the subflow context.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c0832df3b0a3..2f8e357f58a3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -909,7 +909,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19d60b6d5b45..6b6b76152db5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 39e2cbdf3801..a3778aee4e77 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2005,6 +2005,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->fully_established = 1;
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;

-- 
2.45.2

