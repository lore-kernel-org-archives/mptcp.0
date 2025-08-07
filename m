Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4391D8DFB
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534681; cv=none; b=gGt43yiUsE6o03gTq3brD1ZIJ8pKoeu+CPzgyJ1X2FO4LN7KE+yLOo1+ZsbrAg2AWGdfhBqiFJyNsxOQ2HmxiM0U7MRw3VWtEFjbvvJOM7PZYWdtIxfP/Ynz6RU1C6g5kSiXidOhAq8XgYImJ8rS8p/8SyaqrMMPgNQVcrsY5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534681; c=relaxed/simple;
	bh=/2mIlQQmRDBdBjg1Yl78VrOSsbXHGXUPtw1utb7e74c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXXZBoC0ecW4s4Jjd2Zdz20ivH37UAH1xDewRiQXWk428mLPtw8JsBaQRKXTcIThKriUccnJC8ZlC+9J6V7PgOn/Qf7js2X1LlUW7aBKi6XWwZGTSev/4+lp9hQb8eYscOYISI3ZNfYStdeotZrEeJDITTA81WDpjqPnvsEL+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn9kznTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn9kznTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80CEC4CEF6;
	Thu,  7 Aug 2025 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754534678;
	bh=/2mIlQQmRDBdBjg1Yl78VrOSsbXHGXUPtw1utb7e74c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mn9kznTyzYQm8w8dipwGLoo5j+03KsPlSUZ4lTWBQWTfFNX78xEuIJeWTZr9YjzMG
	 a5qMM2eXqqXmsZSAlhJ6s9KDx0uO9I7Xjjtj2DZ2A/AAj8gruJiTmFFwLRCUaggSxN
	 PO0mKGnjGrZ3ByJ6IQdxo57vQSs4OKCtTPwH0+MW7iLvutNBWEfuLnuAveXFdui9bk
	 rAqlg/sQSAJJP5OwDKVeWj+akHo2WBsAYZhA4G2+IOJ79Z+iHFgQokkFofU3Wl3YZI
	 JgENjK+Lrkff535So5KVdgQNUFQvoVDjjIiV2hcMDWi1prM4S8YmohJT0x/y4cVCel
	 ey3kmfTbbV3Rg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 1/3] mptcp: remove duplicate sk_reset_timer call
Date: Thu,  7 Aug 2025 10:44:23 +0800
Message-ID: <00ec85a29c5efced0aca8c260856a44ffbc83b5e.1754534416.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754534416.git.tanggeliang@kylinos.cn>
References: <cover.1754534416.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list. Simplify the
code by using a 'goto' statement to eliminate the duplication.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 687dbb59d084..b66126692ac1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -353,9 +353,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -369,6 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.48.1

