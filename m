Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A794D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318046; cv=none; b=u25E+B+oMkR9Cs3VSVGMpJ4/4N2eB8Vx52D3ll2yEQfGGz/XJRTL1dYuAkLB217GepSgjs4zpokhTVikEw2wRU33fw30fbud7/rfAHFtmbj7AxT69/XoNHN0pnckKUQ3VOUAEXBA6dmohTTaCAosAYioHizfEP04T8RcElUZdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318046; c=relaxed/simple;
	bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALksv9FWsE/otGaverzsYsRWNZ4BG1jI3rri2uOBA/mTJ236Zph5mw3Pi4lapvdXdBFZtJ5WRBGowiai2Ip94YqgaDODxZ7Kb8UdvgGLAwZXfLl4zMjhzxefPVYWJ/SMOy3AD2wO3ofqGKIgaQxSfpZvDBBQElQ09WaPDmpzEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW9GhOM8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW9GhOM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A4DC116B1;
	Thu, 18 Jul 2024 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318046;
	bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BW9GhOM8fm1lih926vfgoJRxGUbHxb5NcYfoUwwi4Mmz+ZcvjxKqVIJzEk6RBafRM
	 Dt/1KWRQpBelfz6c1vHAIdBJAvTR+YOSbST/RLDQX+La1Krk7QZegjrP38qieY7Ywz
	 Kh2SsVkJoRnzS5EZ2AX3x4KoSxCzhXD9s7pBXXUcF7nvW70jnvrxBSxC8Rg+G+7fcf
	 iAyEqr+sprUU2UF3frZAHxNIDf45U3lMidbH67YRFwrxcTyGfY2bSkm2VrEjCXVQCp
	 m7HZtYl6KC/BboORjrH2z0UDT2yiDatsYd8CP03zuMnWPHOzzR6jKBVWiKbNBp2aCJ
	 Afv3Hsq02//6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:53:59 +0200
Subject: [PATCH mptcp-net v3 2/9] mptcp: distinguish rcv vs sent backup
 flag in requests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-2-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x3ZEThtNs38wRTpz2yLpmSS6NLa42FjFsoITlWG7NIE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbA1CPT87t/0kZimUqQMo2XuwEunOyr/8q8
 bsxr+0855GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c3JBD/0dnx1qSi6SZEtV5taqwxCc7ucxwDtmDwdU20l3D9YslE1EtSRUJL1VvpPUdPf//GwLo0I
 DD09wM5lmCDX+WrEKV9/KR8W2MxqAcWp88+6y6HaPxwZMp837HqTBp8kM1TEaSqkzai1oJWUNSS
 +esjNPV3JwC6PoktDVSPS3561UUuwcjcJ1yEG1rLuhDOCkCA227tvQVFup18/vyF16XlnAFncWG
 ERUBonMMSrqx2G1+Y1/+OT/YoprOPUDndfGKjrv55HxZhnK+Gu1FCUAwqiBYJ+dtFBPUdkcY+WB
 jki3UA4nA+n72VPk4L8ZcdJG4CkFiclZ92atnkvl1TpJK3qNpyUryYXVqaYjZWpJdq9OdM4TXUL
 aj0YUjzvWgJScwi0zMwyeLmqtbUIN+dQmP27Ij5/aZhyoS3MQlXiKEXWDRtxjUIauzMBzprs2rE
 Qj7n8D04+BLnFuGsAUx+Tw9KJ0K+3xY8DqYllBjy0yaPUwNcphbIcBlxxibaSnMx3n6+53rfFgS
 DiYNAdTMn6ug0X6gmtYdNlFOb6Nel5JhdywPEx1FVDV9/+PKIew/k1He/c+VmQckuKj8aGaioaA
 HtupgZvaIoHampzrSyDHwte/MhiQd1M6rAnn3KZm2sbN0jYxkfS/FhvHZAR9amL2xrh+Vz+HI2x
 j9BViaE681aajZw==
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

