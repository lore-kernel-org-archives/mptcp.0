Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0D3F99F4
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109156; cv=none; b=j0Xx3b+8V5dcXQ2gfBIXQkiYZpeRa5PfCCniAD8X0JZkuIrkbc4gW7gHzDMFFUUC3WYhalJzQ10ONJxvbVvVme+j7c6Gfa6Wo3z3iZSJyE17Pw1+U7YIL4Iv/Ah1pVHm5m43gweFPktZA/MFIQbOUL8JBEeJ+2VHfYPxF8Qm/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109156; c=relaxed/simple;
	bh=n13zN/IU+LST8Jraigka9JE0RR3Rxi6PrlKglOhNsLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFO8eCIrRDxGXrgqe947KoPVf3NcwHDyUgldkVnzOn34poISeqD9k5pQ78WG93X4LGu3Tej4oDIJ/cSXlrjc+eCOgj5bPpuPbYJDZ3XJ+TEE17F0NAe4sRw7mkJnS7xPRgjabjLZPLDDlGtY6UuZIFngkMxKwS7sqgkSTj3UV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArzymE3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArzymE3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84375C2BCC6;
	Mon, 18 May 2026 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109156;
	bh=n13zN/IU+LST8Jraigka9JE0RR3Rxi6PrlKglOhNsLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ArzymE3w7iMGDe2rg2DgqGoDdQYOGIzc/D98bBeF46CwboDk20+rcEUvdEA5Md0R1
	 DESV2x66XoCAluZfwyrDtEGKU2r8lm/jdJfuX9N1EG/NwY5oHLgVjz2dag+/xsl4Nq
	 IuQss18sxTl25u7hQcM55mWTkxwJgjQ66OEqK7oKMZT519FBKkiPOHGC3emp0LtZgN
	 E5k8ajsL7EJuRlbxt/6/4EAU/8q0qBatUtJM4dkn1HDmOlfpzrkn+xc+NoK3t+CGS6
	 RnKd820AUU6U/xQSUMJ49xzZ2y/sUTa5fHUu2iuN6Llh/FLK1tIkKIPmZMbD1pPQnf
	 us/uQbNodLYgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:05 +1000
Subject: [PATCH mptcp-next 01/12] mptcp: pm: avoid computing rm_addr size
 twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-1-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=n13zN/IU+LST8Jraigka9JE0RR3Rxi6PrlKglOhNsLk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0ggwwqm8j71SAh/cS7QHWLUzQr4mVbDStQS
 ZaQVTC7VH+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIAAKCRD2t4JPQmmg
 c8sIEADJqDEOmVRooCN7+nYzljpY1juN7jUPl6e9joWH9vW/UPf8TvDpM1BH/+7o04v8eU2hdp+
 oqBooi45xKH1svOghXUgcBatRs/p/vgaVlo26uGuQUYuAmrO3SqYv6CbM13GMD5USAMgg9aIi32
 ODyRxDynrRa+i8kiJX792ULm+SkJnXklpKxxz4auTK2lE5BWGzTE+o6C+R2k0sSK0KlVljd4tYg
 UsNA2u6UxHUodnKhUr1FDtddV9CDWdteo/+jIcm+paWZdOwV08D5U8T4bb/pfPnng2Lk2h2Rcm2
 xoWn1cYObmpeAMfxUpJl/y9nRuN30UYqECHFQqdyGaRIkg4vPkv4Jr+emE63y0ClFuxtiARlxeR
 U2NSvDXV99VFG22REvDvI+7Z2rDQSMphcJ10CBcu5J1QppdM2ENFZNUA2sCv97c1Qn4mK1RurxR
 7RilvIkG71cq5CHDNVwtDmCkvd8k/sEIo2xH4RHGOA8HIoF5vcIdKlbpztZlu45qfTierEFC6we
 1GgEtw4CaDUcfnw9CJS3Fa2L5wzBNHz4TUUTG14hNZTzrf2PwAqn9x0GCR/visbdz4SlWMKJasP
 WghX4HWP1mLZYCc7QBzboFjIUUCjWy1HjJktfAsREoMBdOe6hLkU8pRkhuCbbj3BD3VyW6oMyrV
 adcvJRUz22vkUgA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_rm_addr_len helper was called twice: in mptcp_pm_rm_addr_signal,
then just after in mptcp_established_options_rm_addr. Both to check the
remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_rm_addr_signal will return false, and the caller,
mptcp_established_options_rm_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_rm_addr_signal can directly set the
size.

While at it, move mptcp_rm_addr_len to pm.c, as it is now only used
there, once.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 11 ++---------
 net/mptcp/pm.c       | 11 ++++++++++-
 net/mptcp/protocol.h | 10 +---------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..d97205707647 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -723,19 +723,12 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_rm_list rm_list;
-	int i, len;
+	int i;
 
 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
 		return false;
 
-	len = mptcp_rm_addr_len(&rm_list);
-	if (len < 0)
-		return false;
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
 	opts->rm_list = rm_list;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b460b153dc0f..bd6f1b35acc5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -960,8 +960,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	return ret;
 }
 
+static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
+{
+	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
+		return -EINVAL;
+
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
+}
+
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list)
+			     struct mptcp_rm_list *rm_list, unsigned int *size)
 {
 	int ret = false, len;
 	u8 rm_addr;
@@ -981,6 +989,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (remaining < len)
 		goto out_unlock;
 
+	*size = len;
 	*rm_list = msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..6f3c73ad4284 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1224,20 +1224,12 @@ static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 	return len;
 }
 
-static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
-{
-	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
-		return -EINVAL;
-
-	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
-}
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list);
+			     struct mptcp_rm_list *rm_list, unsigned int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,

-- 
2.53.0

