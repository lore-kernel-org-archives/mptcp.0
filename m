Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790F20AF7D
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384839; cv=none; b=VRVMHxWpRn5HVF0zG5m68mmsKBNztE/NWqws4SzgtAAiPZfsa/37hhh3XQIkqrxSRN2f63+2S70K3Q0lMIampGcaOwnbGhKHLJmu33jaOa+S2A0ZSXvnlQ5TVrEDPUwn7JXVtubDPI1YzufKA/oJH1fuM7ojHqoGyEym/tIUwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384839; c=relaxed/simple;
	bh=oHp2VhYIwfXgRGGPij/JHd8Za0s2dR6506jv0zObong=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9RjS4MPAIk89tYqFnmwIXqQWPKlZx/HLmEfshraGy0qikH+RpwjYCtY0DiCH7CghcMTdBxwUcQxbzrMUeKhFw/iGzZpmFoa+sihKtPhmHXl6VWYOWTIv04FI9/n4FzDtQMEX641QHR24qsK1BSmiV74P9fpG4dBRjsQqeThZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZZlxbmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZZlxbmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E6C4CED6;
	Mon, 24 Feb 2025 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384839;
	bh=oHp2VhYIwfXgRGGPij/JHd8Za0s2dR6506jv0zObong=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZZlxbmM0k4wuVWqekHSOm/7r6KpkqTE8b+tVdaS2mjPwlaz8MhH3td7XK7rUBfLG
	 W+xCZ5iVyfEUSZiyAZmS9IWplevwHns9jm3PNmg3/608+MpBqK49m4Q78ZFZNmfI+i
	 DpsSXxwRl+EEUa5m34oEBSNtz9VXKA7YDZt0sZ8b2rm4DIdv7hg9xAM0bulJObXW47
	 Mogcm+6LKfE2T1pe5IuEoF3CxQT3I/PPFveo2HU4PZIQlAeaOpT40dMtxtQUG1glaC
	 vQ2hauVtz1E/QIA9M7+jKOvXq2IY4SvmwLi0NjNbpRVZwhvTe7YaVrFAf15J+5YB8k
	 5Uw71seBIem3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 6/6] mptcp: pm: userspace: use sock_kmemdup helper
Date: Mon, 24 Feb 2025 16:13:38 +0800
Message-ID: <eedc0383aec5fc4282944b47cdf40ac2f1830abe.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Instead of using sock_kmalloc() to allocate an entry and then
immediately duplicate another entry to the newly allocated one,
sock_kmemdup() helper can be used to simplify the code.

More importantly, the code "*e = *entry;" that assigns "entry"
to "e" is not easy to implemented in BPF if we use the same code
to implement an append_new_local_addr() helper of a BFP path
manager. This patch avoids this type of memory assignment
operation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5b3ee43130be..8c45eebe9bbc 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -71,13 +71,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
+		e = sock_kmemdup(sk, entry, sizeof(*entry), GFP_ATOMIC);
 		if (!e) {
 			ret = -ENOMEM;
 			goto append_err;
 		}
 
-		*e = *entry;
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
-- 
2.43.0

