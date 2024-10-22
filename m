Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865A19538D
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588499; cv=none; b=Mqd/E7WGCdA3dyrjHJZuqyGRb+/ktlEfqFCJtecHXbmS4Ri+44+b/tCqi73gKnN5P3V/tNzddWOg8du30bfcRzoQrqMpXbQXOGD4dAogcsdFK9/W3NLOtrh2dsyeBI44X8MkX2D19GsS2bprtuR4WHfiNov9Hsrm54WHi9askfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588499; c=relaxed/simple;
	bh=IuakAWX0xTzLWwD4mdftvwBV9YBkZT0/hmzinMHSb1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYWDKV3o2NnaOTIxGdiv0PJ2vcHFryRpPL39jcdL4Ot7C53UcgFzDJqaQ/J45/JF0qtzMKeReRU/nqpNgc3P6rEJ5NazGwn2sePN9Et1Mjrf0tDRj+dt7F5IOHmTTPC9/20ZDmVc/qORChfdd7bErgnYEsJ2+A6Z5hRQSJijZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRPNGd9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRPNGd9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00B8C4CEE3;
	Tue, 22 Oct 2024 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588499;
	bh=IuakAWX0xTzLWwD4mdftvwBV9YBkZT0/hmzinMHSb1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRPNGd9dbnjKQarSea48CbSRs7tpab4eSkeJwhPqb7uixbFbn167inYaTlKVj3dLb
	 hejyCD1BCZsryxSuMbmsdeDme28x4nldzOO4aHK4acKXAEUZlOrJO0/r6miMspZL3v
	 ZfqG1mzQ1wHcyiI0BHutCVr7suazhv6a6g+VJfifoyvectu6vYAiqb9sg/xdxJk4FE
	 YjIejeXM4Z0vhQYzMVmNNLCoY2VuecnmPq7upUkhTb+kCWPk01lxdCv4vS341nifRQ
	 DM6fjFKpZcgQ8yGpUL4bFqfxLogIafdObmOu2mYHLXciTwtqYpLI8gr+UG36waXUPG
	 aKrpl31AAEpWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 04/36] mptcp: use sock_kfree_s instead of kfree
Date: Tue, 22 Oct 2024 17:14:12 +0800
Message-ID: <a42d735295ec53ca466b7c274e6d1c465010d960.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The local address entries on the userspace_pm_local_addr_list are allocated
by sock_kmalloc(). It's better to use sock_kfree_s() to free them, instead
of using kfree().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 00a7f9dd90cf..3fb5713cd988 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -91,6 +91,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
 
 	mptcp_for_each_address_safe(msk, entry, tmp) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
@@ -98,7 +99,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
 			list_del_rcu(&entry->list);
-			kfree(entry);
+			sock_kfree_s(sk, entry, sizeof(*entry));
 			msk->pm.local_addr_used--;
 			return 0;
 		}
-- 
2.45.2

