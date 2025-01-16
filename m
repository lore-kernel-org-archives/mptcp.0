Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30B1D86F1
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012437; cv=none; b=oa5m1ZqDH7au3ljoB0Icc2xGZeT5PAuqIMQzzR5LEL5Ju0wIoKFE9uUpUAPkd5GZdOHU0pvE/yn+cBrmxz+r6IkcgQui+6bDb2fDuiVyYExgnQngCGbt6uD3LAjCpMyvVyzmFQ8C+9W0JH6L4NF65piSMir818uVNp8qzESTW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012437; c=relaxed/simple;
	bh=uSlZGjqlztPKPok6+ltWM2uKaOzY7i30VS7HCyC+g64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/KAYYc/Uf2o7dPx6wUFjecznhWc8XENlSqnW+vw+mvTlfJ+vzvzdR1ytOiajksbxdGbW4rY1E726iBpz5YrEVpZaTml93D1GMWOQ7f9FSIuhaaLTdSRvZ/84ADXI5jH1PoCKxdPT9iyFX3dNJBlGIRQSJ9GCr6OVuyxROetQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx4LQqvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx4LQqvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4325C4CEE5;
	Thu, 16 Jan 2025 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012436;
	bh=uSlZGjqlztPKPok6+ltWM2uKaOzY7i30VS7HCyC+g64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jx4LQqvVHIXY0YWPYVyXa+HhUYmYmSgxshCRAwzj4jEz6nTK5VSXOXlmzM4K3WHpp
	 QBs6zGfY89VCv/25s0iEVMQIH8N4iTKl5gLxQfTkV23mR7/PRuJUpE0q6wwzNbqyy9
	 lwCIBpWynRum7gl9uKg+59xZiVvqsiMmeml7bS0/juBS7phx+DFU98xoF1n3MSXsHp
	 6o4eQ3bgm6nJjD6UbjbNuEgDHysirWkNabbVNkxlGVVFS0/DK9zKwgkfeCSOhLgTzf
	 +z+s5bxcc7iZBgF/MhDmxESuej56RQWo33i+ImujE6UtIs/QemU/W+e8Yin8PhzCU5
	 hNkbPrcryaflg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/7] mptcp: hold msk lock before removing id 0 address
Date: Thu, 16 Jan 2025 15:26:58 +0800
Message-ID: <b4335f327203b21ba4622b14b8a0fd8b4991692a.1737012165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737012165.git.tanggeliang@kylinos.cn>
References: <cover.1737012165.git.tanggeliang@kylinos.cn>
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
index 8a0202d8bfa4..9a6c17948d7e 100644
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

