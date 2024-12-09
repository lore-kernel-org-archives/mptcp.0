Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3A14AD0E
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724764; cv=none; b=eyjJQAU8Le2lqpxtuJr2hnMaslWcukA86OYCeOPA2WlopSRmJo82wY3ih1uzjCsGtzkmD5zmGwVCMG2dnb9YdHJ34zDwpZ9GEvocq6AWmOnjtuCuiz0tFO9903/wrEqAqE7YzuL6wy3BIO8iEhyvpi5aiB5Yg4KkTvgOLLL6Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724764; c=relaxed/simple;
	bh=p9RhqciZ4Ay9md7Mm0qZn/e1aU0ZbpK8cJuhkq4chxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiI/8iijhmwKhgpMObn86rT2kGI6is2I8MGWtPzFTrPCT8nEodQ6VhjlfHZyUbugknk1tVlmFv/CmYYNT3ozsJmx5kyVECAP/dL8+9sJk2vH0uAF20K8apoSci0TV/xmVImOZMAGX3fS8UPrbuTH0JYjpsn0vwvN4JJt6MW6jY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn2g2y2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn2g2y2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2017C4CEDF;
	Mon,  9 Dec 2024 06:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733724764;
	bh=p9RhqciZ4Ay9md7Mm0qZn/e1aU0ZbpK8cJuhkq4chxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tn2g2y2z/THqgwDOPgy9jJYEO3HNStqtga+CYzN8InphC83kBPu5sgnFVFOarzpy3
	 yRQUsE6klA2vZ+yOgF1/ycGrK6bm64TUYwRoSgghCFVxMUZVrXlWh51WO6HeudywZ+
	 xq8+UYf50vrZFsfgDHWCu3R17SQ2WvSQLZBFEB9KYHtE4RqRVqRRXiRqWTuUV1CSwG
	 /Vu5/vI5P4mK57LyRmg3Xo2d2noW4/sISW/xWJ4eMEwrE6yeZaknAPpkZMFFEhqkXP
	 Z/yeW43HuVPojUpTU0lWt0Sa2NVBPi4ibkaEyySRPmOkbg6gOJ39VOaoS7grYZo0Ag
	 kh/ALC38GcPrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Mon,  9 Dec 2024 14:12:29 +0800
Message-ID: <a3b662d844608b493eb2c89789ad2fd539df17d2.1733724383.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add "sizeof" and "alignof" checks.

Address Martin's comments in v1:

- bpf_iter_mptcp_subflow_new returns -EINVAL when msk socket lock isn't
  held.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f9ba0a46a9f1..566c3a32ab73 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -232,12 +232,20 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 			   struct mptcp_sock *msk)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct sock *sk = (struct sock *)msk;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) !=
+		     sizeof(struct bpf_iter_mptcp_subflow));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_subflow));
 
 	kit->msk = msk;
 	if (!msk)
 		return -EINVAL;
 
-	msk_owned_by_me(msk);
+	if (!sock_owned_by_user_nocheck(sk) &&
+	    !spin_is_locked(&sk->sk_lock.slock))
+		return -EINVAL;
 
 	kit->pos = &msk->conn_list;
 	return 0;
-- 
2.45.2

