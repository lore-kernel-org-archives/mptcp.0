Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EFE18B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269793; cv=none; b=MrWPdFcWUS+a6d16zx5r8OosuVE6cdKCjLaIJvSvXwpa01cjg3kFxqKjRqsgPHL5J3gAz9z0dzAcYQ1/Z9f6g7hLRdKp25SeknYlssL2Z+uVgYkS6J/RWKGRC+o2xf7RcViCcYEPzHZ0RZc2Hc8zZyelnw8oYApL1UKn1UTsWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269793; c=relaxed/simple;
	bh=QhHjmFhBlE0YmAlV+jp+HXi53XIHEUZ3lgLic9en9yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTJv+j3rUA+YX+XNoubH8EcBpYOkFO1Lsfx42+KRxIyzSiBD7GJJVc55UqsUl+PUTYjH0d0TfdZ21PIZX2L+7eVoxfLoeYBsftqXfnMvFcFZrHYUcTeGp880BGvsPfCKdgrS6Knuy8P369BSaokVVlyTKJXVV5FPlIDczcb5gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f33zE/mX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f33zE/mX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE25C4CEDE;
	Tue,  7 Jan 2025 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269792;
	bh=QhHjmFhBlE0YmAlV+jp+HXi53XIHEUZ3lgLic9en9yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f33zE/mXakXMgat5kls+msWBo8WYkRVffk4yJIitC987PdGN1Uoo8RBoU/+1vJ2sP
	 VVYAdox9SoUkEzCV1M4rMglwo51fVIp54HlKSkdcUJBiVTCbFv3SXdJSH9yGRy4VS4
	 qTiG8974n3Phh36+mu5oJb2U5PTNTvBmWu8DgwZy9+T1YSLxWwQLI+lP2q2L11AUCJ
	 iPQcPi/j0hLWlNuU6GP2+aR3AnuJKjkr1vaL3KfpT8RN8tgYnnII8a5L8Pa1EUZ7yI
	 lh/7+ILAZO0Qj/1544IqCs+SMuLuy6OgHl0hFTookPR5TZm/gtlAgeOC942QJPcTkp
	 d8sTWiteq7OoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:29 +0100
Subject: [PATCH mptcp-net 5/9] sctp: sysctl: rto_min/max: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-5-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QhHjmFhBlE0YmAlV+jp+HXi53XIHEUZ3lgLic9en9yo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/ai6SNgmZ2r+j+jDo6ClMUfYtcRPycAPYej
 DeVM+wLbfyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c5qjEAC6o137OLmX7z73Qc64/z8X4lpEUBT3fsCMtxN/QE2S6AJ6XPMnvru6xJzSbZLGprXlR+r
 3Kbic5EVKYUcn3VtfydcuV+TXqztWAgzNn4nKU+Aep8RYdZTAw9JkV1ta9P6epu4bfomsbixLJG
 fyPP0YCOck4Spy8pXi9q2SrrgNqv+mWqGkptmouXy5BnI/kKLN3P50J4rfYcS85Ogl8NaFRVOBK
 ZOFi4DOCae3I20J2Mr9LPLWmh1CMNTvpPlzrWb81bua569+2Reff1qYGr1ggAhuh3Qw8UqgmWQ4
 1kVzrpDgwa21Sv9yxLFy6ChxQ24kWswHQz8GxnycW5px4soeqxrmO2IhNmfGCgntlfx4iWtPzDe
 CXHWXFbRraSQJ15b3LBQ1W4ixSIa7f7Q2yM/f394a0wvNF6KV0e1B+hyvRPcSGFo6UBm6XQnH2U
 VwZ0ZsG1HPepwDLw5Rlbdr3KueIujnJvgH368dnjiOymsE41P4eiEPC7brktMvw0BsOlBb/ToHa
 Ovg8w5/7XklAgsrHhbv3nM4dsrPNNk5O6CCdkdgcbSojcyalFKmyIzrM2CuX6h20QLxTM6Zew98
 fEHJz32ChfjZY4YTXmaoWE8Ls1ghQBz8xWelB1Q+IQq3eKXDhaSAmAnhKV3jNyf5V63yv4L1p9V
 eMAb3old836GtOA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, as this is the only
member needed from the 'net' structure, but that would increase the size
of this fix, to use '*data' everywhere 'net->sctp.rto_min/max' is used.

Fixes: 4f3fdf3bc59c ("sctp: add check rto_min and rto_max in sysctl")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 9848d19630a4f760238a3a2abd3ec823f012d34a..a5285815264dfa9d88d1d71244f309448e97a506 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -433,7 +433,7 @@ static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -461,7 +461,7 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;

-- 
2.47.1

