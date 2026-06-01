Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F693386C1B
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302468; cv=none; b=YwLyEvWUKCY1YhbTXY2Ww/WWBR+7cW8B6VnmEnrOZiqR7K44UOAlgSnVd67x8B3ZCwTQVDLNHbUxWaXlFyAonkCQGVZ5cL2Vm9FLdX4HNTVxmLqGUONAD/gWUQnzs8oBjpYL3vib07mIjIuLyF83C+vwXkK48o7hEgxXKIHiBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302468; c=relaxed/simple;
	bh=i9SUWIdxkJAkA4RLbXnh9I2y+GZcWQFWl8191QvaDug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3JRXUj0pUtx8nzc9VsnRxpVRGnRzK3h8yeQMEm89oHgCP0/XA+vvjljpv5bHowaYdUdf8Uexky1DwcfQQHNY15bkrH56MuYfhM/aWqMZ15SMV3TwkN8kTgwpNPFmttiVIVKO+RhYouBN67vXgRVwhhXe+KISIZc0xnHj7vMVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF4dMVKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF4dMVKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322441F00899;
	Mon,  1 Jun 2026 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302466;
	bh=FVED1GZjFzhzqktIypPhI/VqWK8GJKKIdsIb+CD9G2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MF4dMVKwS8zANOAsRYheC8BFVQfJ1gpeF66jmMy+gcimQRakZ18f7MKeGlCnG0rZ5
	 woojZx5lr8UuiYQhDGTA9Sm6F+lPJEK51eO7YHigkSH7boxfgyTab20C4Uq7zaQ4X9
	 M/3sH4VY40fdptKiEBWsphNYB0XelqlhdN2CNJDM3WrMswap9zZ7R6U9B/QtSpl0S2
	 HIMOBjGacTfoqjfPpTdZtoASMkpyTd0DNY0db2pjvcMcm7BCK0NW0mevjK6AHA+Rq+
	 UF3kRRBlR7w0ofC9Bexzag1fQL0YrxKXUi3BT4VEmdfp7VPTUN41AGaeYI2XigV25k
	 Yla9dIhiFthNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 18:27:30 +1000
Subject: [PATCH mptcp-next 3/4] Squash to "mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-3-d7c842e80446@kernel.org>
References: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
In-Reply-To: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i9SUWIdxkJAkA4RLbXnh9I2y+GZcWQFWl8191QvaDug=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHUJ9T6ESLc/YPkLPjqnCrdbgrT1pSOGGEOp29
 knKJwXusHmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah1CfQAKCRD2t4JPQmmg
 cx8WD/0UCkooHXMUcxUIr5adUqzV/t+RVL7z21eo87QOSCHnsS3yzagBtDOuz19h9/CXKmQYCSb
 8W86fJJLKM72ITGGQFeHct1q+YDKCxYPtK5UuzWjoJAbV/+ZbkWU21Ndy2ctUMhQItgcLEtc0hG
 AeG4b6SaXULIWV6CgmNpMiVFOjs1IulvTC4iHcL5DNcCOwPDCGsoMGm03feLPF5IDkMN9TllxHw
 NyG3vJyWI4IiPErUdc9jWuiq10VZakY2PBSC1EdgDi96AoJuuxijOlkDUZHjTe4jCW8HZzaOCr0
 0HkrQD1+MPVrotgFw3R1HBkledpm//ejFv3eV/3SXKNfFYgQy5LT4zl4BKvF5D0AHlP8Csy+irN
 hoGU2m1lKHyXVcN+0mR4s37Pc9izTR76NwEi1sOmqcdIaoKftm/j/dKMRs7jMgpIvsu/EJKHPtm
 VWGfwIVCoLDVayX5gV3kFa76259UtmQ45fIjG2psb7t6+f6OpoXy29M6Q7/Q7zcoXJ0cW7Sb3hs
 jMcLrrFbvGfqvOEGgKSETlwufh004B/pNvK1xuz4kJk+D94ajAidG1d2jOu1t0VxI11JDjaJRdk
 tM4+gNxC2rx6AOrIzA2OdEHiua2wCGeO0tr0G6DDd8cQ6N6ygHNz7qMpX0gpyZifPCU4UDUgFjm
 3/2HffRr26hSJCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Follow-up needed after having applied the previous commit.

See Eric's comment.

Link: https://lore.kernel.org/CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a7785453b5e0..1845cf5bb377 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -659,13 +659,14 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk,
 					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
-					       bool *drop_ts,
+					       bool has_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	struct mptcp_addr_info addr;
+	bool drop_ts = has_ts;
 	bool echo;
 
 	/* add addr will strip the existing options, be sure to avoid breaking
@@ -674,7 +675,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
-				      &drop_other_suboptions, drop_ts))
+				      &drop_other_suboptions, &drop_ts))
 		return false;
 
 	/*
@@ -695,6 +696,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 		 */
 		opts->ahmac = 0;
 	}
+	opts->drop_ts = drop_ts;
 	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
@@ -827,7 +829,6 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	bool add_addr_drop_ts = *drop_ts;
 	bool snd_data_fin;
 	bool ret = false;
 	int opt_size = 0;
@@ -878,11 +879,10 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	*size += opt_size;
 	remaining -= opt_size;
 	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
-					       &add_addr_drop_ts, opts)) {
+					       has_ts, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
-		*drop_ts = add_addr_drop_ts;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;

-- 
2.53.0

