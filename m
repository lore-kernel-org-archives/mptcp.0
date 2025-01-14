Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2022DC20
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846393; cv=none; b=opg3W16EJLDwM71+kAyHT8Ub8TjeOhtxjLVGQIak0s7eVKjcBVzw2N3p08yPMW4qIGO0BdRjGdo5n/PbeFEaXuh6xGUDLM7iYzWVznVgnnmnHwjfmAh6VejLPw0YOuw+aPEsGgx0DdYH2ol4/zMVuTPVs9qKCUMvQKpy2vWq2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846393; c=relaxed/simple;
	bh=Xw3wlccCqpdwPt88Y4SCvZLPmSfjOGk3ELg4WNOmO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxCZeBKKw6y7a52nk5gw35XKvB7Q2Ly4vhEbBHNMqvLpphsqZjIdMHZwfaz127yrmK3PG4PfsJg55s8PNo0fzrZpwZ6AEviS2S1bhSgfvxZuyifmQ0oLEzGnc70UCTMIkcjIKTS5RN7h4OijX5lA+pIAHfPKYKTASuNUihpJxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu3siqmv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu3siqmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87884C4CEE0;
	Tue, 14 Jan 2025 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846393;
	bh=Xw3wlccCqpdwPt88Y4SCvZLPmSfjOGk3ELg4WNOmO6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nu3siqmvy9Q3kiQwywuXQ08akqy9SDZiiye1VL+7XhWtQS5sdbQluMFmCI0D6ioTZ
	 TIQH9fmKawi3JMPbUgtviSlDHiHIFl3P0dJSpjdDwL4C39CH3aR8mh8e24S6dXJVl3
	 aNmg/RMMZhtmb0tKoxft1dAH/v1XPsspHDgfnrId7Ofn3FgTY1z3k2WlmKt1gn5AmT
	 4DsgMmfY3PsKsDa9Bi2ADDHBkK3t16xIUFtWTpEnMut/2UpdpjcMJaxqClyKvGwKkq
	 DoNTXlME85oHQ7TjENuJNrVQeQXl5xaGlYqDe8IwHQdbj6Y31X0cstv2XVBManmB4T
	 b/pzk/lroYTGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/6] mptcp: drop match in userspace_pm_append_new_local_addr
Date: Tue, 14 Jan 2025 17:19:36 +0800
Message-ID: <8a164dbcfc468cb4aa3158056d9cbd72a0a1475d.1736845893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736845893.git.tanggeliang@kylinos.cn>
References: <cover.1736845893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'match' in mptcp_userspace_pm_append_new_local_addr() is a
redundant one, and this patch drops it.

No need to define 'match' as 'struct mptcp_pm_addr_entry *' type. In this
function, it's only used to check whether it's NULL. It can be defined as
a Boolean one.

Also other variables 'addr_match' and 'id_match' make 'match' a redundant
one, which can be replaced by directly checking 'addr_match && id_match'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de17b18b78fe..7075c7f7229f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -48,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	struct mptcp_pm_addr_id_bitmap id_bitmap;
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -63,16 +62,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
+		if (addr_match || id_match)
 			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
 		__set_bit(e->addr.id, id_bitmap.map);
 	}
 
-	if (!match && !addr_match && !id_match) {
+	if (!addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -90,7 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.43.0

