Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF9311C2F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024925; cv=none; b=SQ5KO9b8218lENRGJTkOo3B5Rhm2c/Xxro7KJutEv6tF2mqeF9Uqp5wwanbraM3dLgCx6MO13hBF7vFHmszq4w3gJAODweVXkwXipfzbU9Rb46gC9aQ1VQ7eH3ZsJiDNLCiWpFP2QjsEjjWEroqC568fOU+7POrkYUXrX1KYuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024925; c=relaxed/simple;
	bh=uHwDh8R18n43NL3hbgebKD065IPpTcukuk0fgmdzcbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOpv6y3lUYOmv5n9kzX+iX8b1qfY58p4Pwv9qHug1s2fIrf43RzPdtOTUUwV/hVllLKf4ZedWL9EyInb+47hu6iCbLwJi2tZEeCnlQ5TW9gfKauHKfJ45cTlMxW0rtUKiI6OsIczTeD2r/keMGv6rlYEkepjavrHpfMfgIT6hfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiM7tuaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiM7tuaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A9F1F00A3A;
	Fri, 29 May 2026 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024924;
	bh=2+mpwDP3/bGtoafxwdaZwFmoAMN2p0ja8s3NsSCK/ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YiM7tuaPL7L5i0If/Z4ihFownFXqwM5cfvtFZtPGSFvBOg+KKmTThs7ZCp9/ptDyk
	 qcsIFYB3We2msoLHBGRpgTGdBH5u4qlZWqyMHM60YIG12chjv+FHtvuqf8D+vBL/cG
	 ZS1gcsSuzHvWS1Ibv4Rl3QQh6IOqUkMQPKn42di6Y9twkBOl1Cut91BIGs8K0dzYvm
	 ec+a7yWhmyukYnOnS0ApI1t0DxGqxWpeykmH7cJLtHiz1LY/NnWUV/xoJykcdg/beM
	 3rbfYaETpBMpkGumWIQsEq9BKe/VP3T+2Ij+MwSRsnBYKqaHX9+qn6XtNf5Fjs3J78
	 UpHLVlyF5uOvQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:41 +1000
Subject: [PATCH mptcp-next v4 03/15] mptcp: pm: avoid computing rm_addr
 size twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-3-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3760; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uHwDh8R18n43NL3hbgebKD065IPpTcukuk0fgmdzcbM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWQh9yLncQYkXQ9r7bHdX8WjmKMFbuS6y8f
 iiXLuklB3qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c9yOD/42dQ1iZcFgOkiNGAi5GytUz48PT2FOxRmIkox4XykbEQPuQIiCEuQWfm1+tVCbKDYBLO1
 hJ9IIiMNRjAEvpOlelTv4dCyIu3dWi90HYncVFMVUMUWzaYlxMrTqDm8Fs+FsmlNKtWGm6Q3WHq
 tDVvrJc5atNN/Bg0xvk3mQPSj1OxSrHdm1cmep7N8J4abtFW2J0mh74XJVME5OPTp8rXY0tOUp5
 Rl2W7Mk/0iNe34RA5JD47X8EXlKKAazZTIpi+YAn+DC0JB8QdudXXw6h/WAB08kgj7hWu3KCMfq
 RXn5as1p4aW598r3BkBdTH8QRdo/Ny8Vj2QZpPPQKAUH9Wn9Ng14ShJjqOyCdi/niDASOYYO9mC
 d1JmIDid+sJs8O3sXiSbxmzCxgUtyPP8bLaKjUlQD0hkru6RC5bQLUdmWt9SoFZw9hRP31vt82U
 Rnhv8QWfH+XYU7Tpp6t6CoRfxrb8B38WBZE9855vF8PMVsDykzkYM7JycNWJYF1JYU84HCMx2Zr
 7riOdn4Yv+yHhSitMC8QDd2ZbP4I12FEL1NSoQbzK4DEasGHDtYkMrVdutl+8z+Cv0pbhzeQsoo
 IPTH1P5mR9yFVQQF/b4ivzMlRX4f1hTOyECtm/InpjPStJa/b3icXEXa4U7OVHRRdrtQPjtV1Gi
 tUERyPhVnguzmGA==
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
v4: use signed int for the new size parameter. (Mat)
---
 net/mptcp/options.c  | 11 ++---------
 net/mptcp/pm.c       | 11 ++++++++++-
 net/mptcp/protocol.h | 10 +---------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b88e6c314b54..3960c6d93177 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -723,19 +723,12 @@ static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
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
index 851f6886ad23..3d5dc711a866 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -961,8 +961,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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
+			     struct mptcp_rm_list *rm_list, int *size)
 {
 	int ret = false, len;
 	u8 rm_addr;
@@ -982,6 +990,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (remaining < len)
 		goto out_unlock;
 
+	*size = len;
 	*rm_list = msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2321ad4d845d..e9d97fb471ce 100644
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
+			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,

-- 
2.53.0

