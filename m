Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384514A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494253; cv=none; b=PqHtA0g5C5x78JQfQJaMm+dH7liCQM9onUgLS8Sr2I1LU7XCBnQDwN7hNYdXrVYICRTCDnAuW+EUz5+M5QnnFI1uKycmtt/Ra3iBomGz3U2lD1wB2u6Gasq75W6HrsjNwbdiYLD8c/z4CmbPyH/Y7FUI1+7UO9dFsQ6wiTTCZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494253; c=relaxed/simple;
	bh=cQ5/ht1MhEKJnGUiCvumlLsoSzZ7WkaoBBdCe30201g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4AmC4nl1X09ze40CcdP1dJM1ML9DEqXkwca72cwhvd364c9hEbfRf15Fhv40Ypg6nTQwfQOv39L/6bjXgYnKJf6bKijsT3c+32/QfihgJJ9DDy/vpFJJaGZB4V9s+ES0JZ9ptp+3FDJXUbZlhFrw0YTtK/6nSPKNw40rfTVTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVSuY1ww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVSuY1ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D35CC4CED6;
	Fri, 10 Jan 2025 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494252;
	bh=cQ5/ht1MhEKJnGUiCvumlLsoSzZ7WkaoBBdCe30201g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVSuY1wwdNx8hh+oUVbyJBxOWd7lVPJvnkoBKpiVpNXFdVbnWjcxhfd72qYiOueNO
	 mrhDo1zAM4Ic4wrpc5a+Ja5sRVKVsTtp156C3+jh/M2ChEyHT5mtXiP15xOoDb+VI8
	 QmNufjsDfYLKiv7okMFj1vREPfhoSGqCh7IxVgLvgfylMfOvdPMM/D///Wdim0G5om
	 QviYbFTd/YKcTbamgGdvrehsshQ06srKSL04tpTU7nDlEJTHirvGQ0XY2245k7lX75
	 qfuxpBFP2SGSjUc3jkzoI1r+aKQfnqMTzrZUdG6kb+lBT++GSyrwTQa14JNSjpDBHe
	 BD76RcZZL2Wfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 2/8] mptcp: pm: userspace: flags: clearer msg if no remote addr
Date: Fri, 10 Jan 2025 15:30:36 +0800
Message-ID: <3a900efc2b0b26c6d63d6e932672677f0336abf1.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
MP_PRIO signals from userspace PMs"), it was mandatory to specify the
remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
check done later one.

In theory, this attribute can be optional, but it sounds better to be
precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
are multiple subflows attached to the same local ID. This can be relaxed
later on if there is a need to act on multiple subflows with one
command.

For the moment, the check to see if attr_rem is NULL can be removed,
because mptcp_pm_parse_entry() will do this check as well, no need to do
that differently here.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4de38bc03ab8..b6cf8ea1161d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -580,11 +580,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
+	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	if (ret < 0)
+		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
-- 
2.45.2

