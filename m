Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A922F82F
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924514; cv=none; b=Kh418fGsao0Ju+p9zJnjHdd7DW39clzJNVm2A/VF/4cH90s/O3GDNgQhE/pz7UlTIgJu/XngTt4NeKlow8t6hPR/vrYODPjfC2OaFFwkO+GYwkxh3D5aRR5HZMAb7tjIVP1LR2WD9pFT5Gl2Xa/XZw0o5BhVcvKVh9mftYHv+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924514; c=relaxed/simple;
	bh=wgDmtBTPbeJRMEXqfy9UulGSZmSZ3VD6Zw43FACGutQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orOmTvCJO3uCvG8Omrgw/x9CT9wFRX743v4lH1PaQVFIgt6gBq74APrYVaCzfeSP+0Log50JBrA0OaTqo+yhd5ilcD4wS1rECSxSb/z2TW3aBT9NdL0vhUmyVRBAs5ulpGZr3WctkY/WnqvGLnNx/5ZFOpN73Y0++GE8e4Ak5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqEYH8Rf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqEYH8Rf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9D7C4CEDF;
	Wed, 15 Jan 2025 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924513;
	bh=wgDmtBTPbeJRMEXqfy9UulGSZmSZ3VD6Zw43FACGutQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqEYH8Rf3HQ8tH3XewfDCYTTgwlSQCc+kfiF3S9z6m7YlYjHEmsEAxBDCrIOZvb/s
	 60grcbGJZzKXQWuUlioSNv+urLrhLTJxFsCPBiF3U5SjhQMGwn5/JX9oO96kJD1QDh
	 cbr1XtSOxT0sVV7uoiO+Xs8Tf0UuE7/VnBcdrPN7YXkNhf72daiycto8dDotJX8y4G
	 mUkJ/kFGKliHgKcBOJt9mfUX9N5kkKTZse0hWcbRtFJGDOltd+oXEuLYAV22DoXvff
	 2uVIGqc9OrIe+lF+IsxBZmx2/L5Wo7LVxEENztA4wjJrTSaARVlb76Xkcbz25BB93s
	 ku6P31lIV2uLA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/7] mptcp: drop inet6_sk in mptcp_nl_find_ssk
Date: Wed, 15 Jan 2025 15:01:36 +0800
Message-ID: <4b85fda724470edcb98a82c2f01c91cc72b3439a.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
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

