Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C122DC20
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846392; cv=none; b=roB7Li6gxGc4VTGZGuptnlU7jBOUk0m0pGZmXCAfksEo6fru6Tbu4HRmDiYOPTvzUih53vsjEgjM9R8Nh+cOJVnwYZjwX6H+4sOc4P2nneqwoo1vMH0sfpEo3fMSWFht9aIn6Zf6rcEh1TZsjOgKSRsRC80Xqs1Nq/JzO47MCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846392; c=relaxed/simple;
	bh=wgDmtBTPbeJRMEXqfy9UulGSZmSZ3VD6Zw43FACGutQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzACpvbpdJ78XX7O2QcTC2s1BbbhYD9w2OQ66wFqyuAoM+BtvLBodm/Jf+ws2g4N4cfJVCprvH5bT5JuMVQNqv/lsPrwRN1mcEWGSwBi96cjNT7kZWjjUSQuzawjeGDA86RwBtH0/3XbYaakBjSq+Yycq0UazCW3vTJQk/Db0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6T5qQVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6T5qQVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E7FC4CEE0;
	Tue, 14 Jan 2025 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846391;
	bh=wgDmtBTPbeJRMEXqfy9UulGSZmSZ3VD6Zw43FACGutQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6T5qQVLql8F+u98maf6vCuzso1jRVkYPb41xY2CJrEilkybJ7aehvpOeBK7R7vsd
	 xmrNNfUOGXL9qx4oATrQGLsNubVQpWsMjGmc9hoWF4XMhU07vVoWU/TAg3rI/np4Ky
	 m0js+QSt5Y9l91tZU+XRBnifMXAcL3u2XXtKNsi/YLNBUalK8+1LKk0jRsT0fwSjfY
	 3G3sJSP1y18xYKAzthj2NSq4vWMS2FliCpbFVMOw+rAJ6W+gMqZnIVv37pqI9LEVDZ
	 efqBVo+ejStc5oZtgtghGiHs64uOFBBlKoKGdEDMd1ZyKU94Q4lG0nadUgo76yqYKE
	 hU79SXvIkpDNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/6] mptcp: drop inet6_sk in mptcp_nl_find_ssk
Date: Tue, 14 Jan 2025 17:19:35 +0800
Message-ID: <c7d7620d58187fc9e2c1587fa73c061c4cfd399c.1736845893.git.tanggeliang@kylinos.cn>
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

