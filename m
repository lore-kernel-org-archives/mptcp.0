Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555DE17D378
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069968; cv=none; b=WVy/zBRSJw6cltvarxM0W0upoUaKi+wCQL7JVJ5Oue10SJ9ck/bW8OF3ViJ19d29fpgF2GSoWHYCcITQn7EeFbGg946IpVzOJaTa8ERiKDLcMQ6PCFVuu8saMUMmJmFIpraMgnTAuoCghFYVDgUrG7cUQY7Xwb290CD/ENbbqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069968; c=relaxed/simple;
	bh=ijKOH/eCdFxvz5RnSeeb027EaSLIlLFbnOsrdlM7J40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Mst2nfJRubKNri0GtYwFqDmRSyzFtRZnKFz/xyBUHhLNWsHCZR9qP7G4Ya+8ajQXll5Z/YlXdvPbo6LvsQK7xpxKRrxxOd2pHlBjzB5oBLvEmKh/+EMt7/YgWKQIuLHr0tox7WKB6jRBToC4EWV2vrCmjGSq4umGsT/3JrUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZDEA/e3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZDEA/e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1952C4CEC5;
	Wed, 16 Oct 2024 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069968;
	bh=ijKOH/eCdFxvz5RnSeeb027EaSLIlLFbnOsrdlM7J40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZDEA/e3SzNV8ETf9zzDyd8LRTQq1k7CPD/zsh7WEBv7eF6fJR+TrFnc3NKfzJNat
	 7fhhI9OIXjIucgqKQsE3v5orClaaggqAejjAK4rdCHxhY5vqZxCEiEZqjUMgIcvH++
	 zWIjs8EelRmaLTcpbbeY/rOzVYZ3LuV5HaPjJ4/2DAuSr35lpyjis1CEXD9UvUZE2Z
	 O4m86M7iQ3ukkRpl3y41nJexAsKjEkJ5aPDuC7YFGBHREiZgQNPAs44wIJtMP709FQ
	 LtAKe36fwR0LUkYa7K/N0oDjTtDSWI/wBP+MQBRpRC8VEDiP8TB1PX5NDD4mlPvs24
	 jakPFBkCWYGSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 01/33] mptcp: drop else in mptcp_pm_addr_families_match
Date: Wed, 16 Oct 2024 17:12:05 +0800
Message-ID: <4c1705527b0925af04b4358b4feea1ced5cf8ca0.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_pm_addr_families_match() uses "if-else" to handle IPv6
and IPv4 addresses separately. But the last line of "if" code block is
a "return" statement. In this case, no need to use an "else" statement.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..f3d354a72c94 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -495,9 +495,8 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 		return !loc_is_v4 && !rem_is_v4;
 
 	return loc_is_v4 == rem_is_v4;
-#else
-	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
 #endif
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
-- 
2.43.0

