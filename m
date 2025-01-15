Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174E1DB14D
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935190; cv=none; b=VqMt/Lb/1B2DDIJsX8BHek24KPNummNGZmHOU/fHNqgRQ9zjq+N/JCMMGrrnyMrvzssiJWvVqxMWv1st6dMknKrgrcvqDZLvGpu8nthFSI6v+SIt47BEgXBDtmyuZSW43kjnrxL3jdBtoQ2p0MQ6g1TWDzjYLCxsRKpDF4zOi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935190; c=relaxed/simple;
	bh=rXH8FpolB35Qn7+rHdrsYKPOEuRbjgNNE0VlMv4qb6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP85Bo6AINfkO6HMimfbDV2qY3rSIJbHh+S3VrNSyc1F2QopE8zjSNRddRGX0e57/mEcdaCn06fUVrCJKs4WJ3RxA6bdOVbmt+OHpUNFnpvp/lGBDqr2gbZOAapWsAMO24azvwKy1OElnGJofUumzMnOJ08yKSaC8hYhqKp2xZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2wHd+9a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2wHd+9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13067C4CEE1;
	Wed, 15 Jan 2025 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935189;
	bh=rXH8FpolB35Qn7+rHdrsYKPOEuRbjgNNE0VlMv4qb6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2wHd+9aWzfV8qTwv3zbNWxhPT7+4jtyPu6ZCmqh2qtxgxi2QLgAwOBvRcbMotTeo
	 KmUPjX+UYbJFFDRHCtLhVSuroll9tqq8jI2bcEAm6ZWUtxl8lZUaO6XtPMS1NJ2fL4
	 fejcMhDtU5kM8fAL8oiv7OCK8lp2XppU19VNtp/evdDi50l61b/VzDu3sHIgmVRw9j
	 AsJ1xCyGAQLnNZggXQvHVKadFmCSz105qSGaiko9BlwcYe6GSOXMtZTrfQwq6BGdtr
	 FfaF1vJ2t3CYXhZ34hrhiWWTEMBDjueLxukR46U+Jrao0/9ybOZKEy53B2pQ2NPv5S
	 zlWtXq+ehpWdA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/6] mptcp: hold msk lock before removing id 0 address
Date: Wed, 15 Jan 2025 17:59:31 +0800
Message-ID: <9eb68e270d56b0bd7cc92e6d84c735465cc39bd3.1736935086.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736935086.git.tanggeliang@kylinos.cn>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
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

