Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4538D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450262; cv=none; b=cq8B6jpoIPUN2IeF/jRhzqPT5mRkz/d09ZFM8NgA7VmoUOIPlrgXcNK272frjiR0bTxKPAATc1D16d5Siq/QGxJv5DWnZ+ZgMKRR3uC6ByMUMSh82iLIQ8gtCY/aQ5mcvCm8Fv8KjBDtkFrfgDINAbYi25rZjA7p3+iRM8GUodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450262; c=relaxed/simple;
	bh=+QTwOfvr867pZlzJSBxuhHOHKebIjrhAdeI5wQOZOCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo4WZPXTvVITDKUdVAAkxX7rZnGqO1+oo5FkUPfI23B4L9Q8HZ8ySrWeIW5d6Ph4TSbqr2FMu4VaxgbLk5NrYiBRMqvbMm4/2zO4mr9CPgdanTTJVEo2hWx9ZaqipCxc3O1fBdLEQpmewdKlT9ADGFjLYt37CM+OBQUOndJ3C2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEy0IL9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEy0IL9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CDAC4CEF0;
	Wed,  6 Aug 2025 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754450262;
	bh=+QTwOfvr867pZlzJSBxuhHOHKebIjrhAdeI5wQOZOCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEy0IL9oF0J7BclxGNB2rQawHkkv6/ZQsdQ36p+rinUd7m7rMRTVCF+WptCW/GW3n
	 2NC2vk9BZmxN/Yn4OhQsbJr9IIBblpSMN+HpVUbz5HZOwVEnztbwYG6GtK3L6ykfn/
	 O6GxMSWI1Vlz+MPM0TbBedeFQ47Op195iG2mCqm5D67ACusRigZ0VoWOSwkVlfgwDO
	 0A/oioeXxmHbNMhkSZq7WBE1p/Pn15i+NAVldEBU9Ncibxv8QMN3xtAyjqcl+1BV0U
	 rEZbWawYMo02uv9MQXPVAIjVz/AfqWa+yYrFLQlrLhrBC/d4Qh/1WtPp0+/Qt6gQmi
	 CJgIUNhDloleg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] mptcp: remove duplicate sk_reset_timer call
Date: Wed,  6 Aug 2025 11:17:34 +0800
Message-ID: <f9f437aeb4bfd2ea461045c932c836ffea96227b.1754449947.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754449947.git.tanggeliang@kylinos.cn>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5dec018fdda2..1330af6a2154 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -348,7 +348,6 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -358,9 +357,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto out;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -374,8 +371,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+out:
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+		       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
 
 	return true;
 }
-- 
2.48.1

