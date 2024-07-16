Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FF54F95
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163205; cv=none; b=VsfrxmwjKQFYRW7TvyfEZgxauubjCOeUaB8S9l63Dgvqce9+lYp70HPSWUrGdpJ4hZdGX0j6JZoA6PvIC2ozEGwU4Rg5M00CX+bamHbeh/ihJZKK2bhgMF/g2uEERZIvlDjy3aPSovxNO2efYQ0DcBlmUyujpiRRcnF5qu6CQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163205; c=relaxed/simple;
	bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pw6lrZnoy2BcEx5Oh8l8Dno8v5bqDpBXpZWnTW53DQFdTWOE99rlwXoV0+m/ZMa5NXAwQ3xwvC9ven/3rHJrmpNvLir/7OMNDVeBRCBgzccGlpg5poLBVtPd81eG84kY3X6Mj3Y2tWfx8y5aPAHaMzvt1ecJ29B9p5TzoWaGoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyWRrrvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyWRrrvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06ACC4AF0C;
	Tue, 16 Jul 2024 20:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163205;
	bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NyWRrrvtX4iQ0zeHGwLFJd2TJYz74qX6aubTAiZiFXhYsI3K2x4LRKD4olMpcqnoF
	 JiV72GKlJdLOYedZ/68v0k3qkAvU7416S6mFA15t8l3jChs5hE0/S5G+YayDQxCqR5
	 ST2VTi7A/+hdsf5j2LUc7IM08mVjdEFi1pUdyZWXVsDfOeJOWXN7Yb6jpmSNAd0mG/
	 R1KaG+s7748PQBg0CFw5aKU7e0IrBAhx6UqqYejuN8YDStQzzDOZjBKY7qZKJw8QE+
	 2tQurW02CGdPrxOHIbFhgUV1E2/poKRxWNrqxTB4pft1i3vpoLN6fjw6fLTtjmihNP
	 hrhY4W97w6MQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:14 +0200
Subject: [PATCH mptcp-net v2 2/9] mptcp: distinguish rcv vs sent backup
 flag in requests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-2-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3BzzLFRUoRp0gpSraEk9DEH7P43V50KMKNb
 Q3hmqPRAtKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 c4vmEACN1AwU1Vhxnt5/8A/eHjJqkC08Qqlk7mt+SFbW3WdSOX65wQx0HHrdsAe8k1b4oMlK+jL
 6W4Yu8mgdPbKBRJpxqTCDc3UePcqc1/vWkAHIUFGWg0JVMhhXAfIkNht8Rs7CfRPVIqny6G6DQy
 TpOqtDGOg05aGJ5B+TvbETJEahjoSRGJ0xCOZ1X02Hd3UDGOVgBTRJLYGGZXM37xPQ1gIzZEk7Y
 TN4x1wTw/FxCirQP6JH6bR65yfdbpgU06vDn37TcZ3q6h+MdzVYC/Xpaz1L0cAl8B93oRGljc0P
 t5QM2xK/OUXyECPCVv858mn24BFLk+Dt/IcgVPPS/t1uHcp9TiQ5AWPipa9AKWd/TB1LLWeqzfd
 qoRbfoXOgylOv4L7070IJwKflvFuoYUfyIwAWnXlnE7DjtryPloTgoTz6o/5Q/Q4wtVQ16rhygM
 EU5qad5XkxhglzNfMB1TVyn21/nGwv6KdNavrU6vON+YqxL/yvg3oR8wuO1AzhCOaha+7Dz33N3
 8rdkoi6QOIjzXYP3sw/Y1wM+ajjJF4mscUyw0/LUS5PNXLf5R5+kD4Vme6Yzbe5Kku3tw6tl4X5
 bMgSVfugtWdcsvHTGB/mYM7EZUumKTliHw6Zj4Py/f6xd0pTdJm/ZQaB1joZ2+ow73AQgs8+33x
 lrl0eWjGHyHY8og==
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

