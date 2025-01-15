Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6622FDF0
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924517; cv=none; b=UHqlP62rVI+mvJ55Zy8uLCEtQdlxSq8Li7J9eVCkz5MkswqboFkBFTaK8aF4ypY5HBT/Hf/DIgawwjVOtRlbUMvDw6NQcbKd/LipdfRfYFIDEkyQG84mBA4Qn4PXO/DFYoiyU9jvUohuYK+Dbb0HAYXjUhvTLv9s3w4OChVdtXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924517; c=relaxed/simple;
	bh=rXH8FpolB35Qn7+rHdrsYKPOEuRbjgNNE0VlMv4qb6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB8+TF2kCM9RrTtjy/08aarzZtkBrKQ5pvfjHiW7WVBByus4Ms+q3cArKA8c0LD7EExmOHn0r0ik4KZs3NUjMQg7Wq0QMNTEAmdvHmNzYxIm8eHz3vxoInlp6mbEMWYg4kH4ewxeiSrHgC59zuD0l/duuB5q+JiZSrn9muYe2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPquQcvS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPquQcvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7233DC4CEDF;
	Wed, 15 Jan 2025 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924516;
	bh=rXH8FpolB35Qn7+rHdrsYKPOEuRbjgNNE0VlMv4qb6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPquQcvSvx4WgfGtZtg6pvdpPYZqLOUFuK1nnkSh7Cr3hist1L539D45VES/xZFDG
	 fgosin1OquWeZeo3dwUhdngwGvuALScKlOH30CTHho3ftxa/k5XbKlYcF6GnWKWmLl
	 nr7TBcKUVTNb/CNhsXZr3fPIwELpMCbePq00lJXXZSqgqV8wy+58xFhTyegQGJGKp4
	 SvP2Es293VuUgyjQEm8U1yncWtG0T2u0V5YINtdAVQGKC4jI9bZeQwJrEXx96cFVul
	 J2saVsUSFg9pKJBZdfuhosStJ1KQ9xYa9trrQf94PFjwgRWeWPJ67MvGHE2R1qa0iW
	 8dRKAg0F4+lYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/7] mptcp: hold msk lock before removing id 0 address
Date: Wed, 15 Jan 2025 15:01:38 +0800
Message-ID: <e8b289926ff62318ea6159717c584da3440e60e0.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_nl_remove_doit(), move 'lock_sock(sk)' before invoking the
function mptcp_userspace_pm_remove_id_zero_address(). Then no need to
hold and release this lock in this function. And 'sk' and 'err' variables
and 'remove_err' label in it can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7075c7f7229f..eda4277bfff4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -256,11 +256,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
 	bool has_id_0 = false;
-	int err = -EINVAL;
 
-	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
@@ -268,7 +265,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 		}
 	}
 	if (!has_id_0)
-		goto remove_err;
+		return -EINVAL;
 
 	list.ids[list.nr++] = 0;
 
@@ -276,11 +273,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 	mptcp_pm_remove_addr(msk, &list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	err = 0;
-
-remove_err:
-	release_sock(sk);
-	return err;
+	return 0;
 }
 
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
@@ -324,13 +317,14 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	lock_sock(sk);
+
 	if (id_val == 0) {
 		err = mptcp_userspace_pm_remove_id_zero_address(msk);
+		release_sock(sk);
 		goto out;
 	}
 
-	lock_sock(sk);
-
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
-- 
2.43.0

