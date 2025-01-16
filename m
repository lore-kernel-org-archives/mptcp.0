Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C467198A38
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012434; cv=none; b=B1uttiaMsBmenzUoFxOq4G8cvgB+du/ObyvKHoYSQxJnn0RfqnipY9jkluuKEG4jqIBZWUwV9em8EQNG1+s3/c2pudgJX37Pdz+Tf84ualGR6rWuw8Kdu2b2dhX4X1UOznUbeaPPV2pxQIIVL4ngV69wU9/9bJZEsCBZTCHeqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012434; c=relaxed/simple;
	bh=y1t7q0vwe49t0ogiFRo2CbHZBYgeLugpFFHooOnQWkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdykJ6lfOIiLlcZfOFk76pmbyFRc9sWNVK5/kVntGw8Ag+cjWt0jsfRUUKKg8wvexYrPKXdhJRBqJakwY323aZtyZQyjb9/d2IqRsTM7yjPlFyQyF1oyc97V05LG4PzGsc4tIIUSb3cJG1GH23QKa/AEF8dyFh+UeaUcYKdxEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtNHP1PO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtNHP1PO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E496C4CEE3;
	Thu, 16 Jan 2025 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012433;
	bh=y1t7q0vwe49t0ogiFRo2CbHZBYgeLugpFFHooOnQWkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtNHP1POTcc2TLTcbQ+Eeftdiyjxxvkm7keM0ufEgMdW0YCUuetep+AIkuuB+AQv/
	 t9Lxa+6UEXiUcj7ta5RsL1PS/YzHWWlGhmkniUKiL/zqG4yxf77a/BzoUlZBAWU0V9
	 3tNj7JzJJLyf3LTTp+y7n812EYqaUCxY+lRGvp5EJswa4e5WIQRnItOpdL8HZ4OMiq
	 Z8p8Y6eC9bZDZPXogDZD0CEDQokZ4WFdICJ5DyUIWh3ePjU92NNctTqCn0ZHPDVfWf
	 49zeQuGVD9SXfZYKDmQaNbp7e4xRG3ta2KfOl7FUbDQd+liOxmEQ9E5/RB/+QpAi6c
	 foOaUM/6QdXAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/7] mptcp: drop inet6_sk in mptcp_nl_find_ssk
Date: Thu, 16 Jan 2025 15:26:56 +0800
Message-ID: <d85d524a26e83f4e8e923e79234e351becd05862.1737012165.git.tanggeliang@kylinos.cn>
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

In mptcp_nl_find_ssk(), 'issk' has already been got through inet_sk(). No
need to use inet6_sk() to get 'pinfo' again, just use issk->pinet6 instead.
This patch also drops this 'pinfo' variable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5c7a8817595c..bd09a637049d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -465,9 +465,8 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 			break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		case AF_INET6: {
-			const struct ipv6_pinfo *pinfo = inet6_sk(ssk);
-
-			if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
+			if (!ipv6_addr_equal(&local->addr6,
+					     &issk->pinet6->saddr) ||
 			    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
 				continue;
 			break;
-- 
2.43.0

