Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1965217704
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247094; cv=none; b=SPOJxschspfA4R8NKuUbssVVxsJZzJjQf/AL8v/NQb5nnZ4y2bmShym9/d4Ox1k5kwBQCr8aPUE4GdT7r/MML7IVCXFvWGle9sY9iAIJxh/C4XYX3GFtjVkSvro9Lo3BuJI8sqg9LAHyyhePYV6lGfPsU3zyK0llLcfR8n/Ernw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247094; c=relaxed/simple;
	bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkaLrUE0cXU2WXyuL9vsv2TwieKSsC+m1888pUIBE8N8QIgG9MDjpc9UVf1aFF53XuA1b6RBMy/9lWkNDLjEHtm7YlE+aHTGZw2djln+75duCJl8iZUrbbddK8BNBjbFeTWcPbv7peaCLTnzXp4cbW+j6872xorGEZPLza80MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stk/TkDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stk/TkDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5455AC2BCB4;
	Wed, 15 Apr 2026 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247093;
	bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Stk/TkDkOFNooUNq3FLaP5e+COqOODzHr/3a5AE5l0+jZN4AWhUKabHZjXNIKx+hp
	 7v8w/KljTIfCK/VxV7ALyer9omjeDvaYSYCN5/ZpsI4457K2OFJxKt6rsYOkC+oTsE
	 WzpbN1oHtQWVmrDCxU2qkpZXLKylHmNYyNYuv9TKetvgvTF/Tv1K81UBzUyAXiT+Or
	 NpOm509Mzkn7ocoLuv9polV8hEAL4FZqBx4hAN9W3nxnXvzDsWX4Tgcu4gmDDeM1bu
	 3jJiMDmt42JsgwEH++edV8xutqb5MtmVdM5CYZGN+6kkGz2MGT2DKEHlwfZ/vpiteX
	 0fnjA2L9Exn3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:52 +0200
Subject: [PATCH mptcp-net v5 04/20] mptcp: pm: ADD_ADDR rtx: always
 decrease sk refcount
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-4-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ6pO2+PpvbxKw3jm0cc2eyP2zblk6P7DqqUv7XPnv
 nU9fCqcHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOxM2JkmMim+l+l9MudCe+/
 R6x7XTk/n8k4KyagbbZgYohVtEbILEaGl9Zfnf6e95f6fuHAxB/3VWRXKl568/WeY1bV9zuKd/d
 P4wAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to the 'out' label to fix this
potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: remove '!msk' check: cannot be true.
---
 net/mptcp/pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6a75470dcf5e..d3fcf441b208 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,11 +331,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -373,6 +370,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 

-- 
2.53.0

