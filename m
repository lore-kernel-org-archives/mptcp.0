Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68E1DB14D
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935187; cv=none; b=qyRAvTsgyGVpC4xvxTFyfImMExeE5tmWskE2097FdIexdaeENcGKXNLtSZRWN5NhlfEOR0VfYVyVQCW5PHfdA2jzgo4UmN9CdEVi9TV7UjZaHIllWOoWpK0i4+uckA0F0I2DM1p6eG5z7fpl0fbO3iztuD62zC3FMzOsMxsD2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935187; c=relaxed/simple;
	bh=wgDmtBTPbeJRMEXqfy9UulGSZmSZ3VD6Zw43FACGutQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4/f/RG0eVgaWiYygx0+ywdGYqJI7uGOVVmcq3PnI0IYkb7i9wKSt8mOITzk2VZO0deSJ8cE1DOY2vZtgTQfQkfQuIrKGoTwSBs5NsGtGSRANm/bqKKjh3xI2xMhlsDuxp9ZP5CDajD3mjxK3huse3wdLztPm6xhnci3oHx0spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgY8kMWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgY8kMWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B8BC4CEDF;
	Wed, 15 Jan 2025 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935187;
	bh=wgDmtBTPbeJRMEXqfy9UulGSZmSZ3VD6Zw43FACGutQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgY8kMWTgfzq5WcKGn89FbVvwmYc2TNCCtVcbFcR/Hq2fV03+ffVmYM760rgvdus9
	 m+h6MbJv8nlHq89By1CsD3hQ5s9YsZq6mSX5p0FUyyRHkt+vWXk/qKsmd4xC4iquD8
	 Q7Ft6fAmVL/A33ENjjkX6l1UdC17efS+0ihAN9AVdJuYqPA8dhaZRkx3gofqqg6mY9
	 ue83ww1Z8GDGDmrGSMUMi/6O+p9CFA7k1N2cj64mqo43uFU8pOlOzBQCKpMbr4NduU
	 2/7oBVa77bQiEAs1IlSLfNzmDB6RiRrSg4IYWfDiOCi0dQP+Sowz2mFz0Vk+er939P
	 2pR9Ts7J+98QA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/6] mptcp: drop inet6_sk in mptcp_nl_find_ssk
Date: Wed, 15 Jan 2025 17:59:29 +0800
Message-ID: <27f1c41a7a532e09596979e895af8dcbaca9313a.1736935086.git.tanggeliang@kylinos.cn>
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

In mptcp_nl_find_ssk(), 'issk' has already been got through inet_sk(). No
need to use inet6_sk() to get 'pinfo' again, just use issk->pinet6 instead.
This patch also drops this 'pinfo' variable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e53426a5fc52..de17b18b78fe 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -465,9 +465,7 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 			break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		case AF_INET6: {
-			const struct ipv6_pinfo *pinfo = inet6_sk(ssk);
-
-			if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
+			if (!ipv6_addr_equal(&local->addr6, &issk->pinet6->saddr) ||
 			    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
 				continue;
 			break;
-- 
2.43.0

