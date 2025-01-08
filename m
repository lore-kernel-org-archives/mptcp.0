Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93A2C80
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300661; cv=none; b=d1g2ddlksWolicGBEapBl1PihrAOZ+eVQGt8jb93ygF6EPFXXKFLlhoG0h1U735Pk2kp6/If+ONPA3OBt51qrNSnjt0V+bChGdeoHSkchnGEEGbQqnG0Kdv88X2GsU2BvDVHifR/2eTEZ76wfFzY15kbhMJvtZvNrD5wEhmyh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300661; c=relaxed/simple;
	bh=cQ5/ht1MhEKJnGUiCvumlLsoSzZ7WkaoBBdCe30201g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBDTjVyooS8fgKjaUTaVDjzcseB3K/UgFcrRjN6YiJxTozVkjtHoJUCworlCuHFhbMYhlVHHKXRwngVju2OQNn/xvt+OFEVJO/CY2wc4OQyLvHBPHGFWlGI9GNnG7A+v/4LVZWHd30CNvOBgDFtA4UJmpJbSb+qE4/F7z9Nqq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO61Pv8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO61Pv8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00877C4CEDF;
	Wed,  8 Jan 2025 01:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300661;
	bh=cQ5/ht1MhEKJnGUiCvumlLsoSzZ7WkaoBBdCe30201g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vO61Pv8HwAJwwTD3bxc9kEO0k1T1YLyPktzSLtEN0prq6RPVIYOJ0bGgOC51vnOFY
	 YQnyVY/90U1Q6hNdc5PFFzFSWdj1QFqkk4LS0u5Q/0CPNZK9tz4hSEwUHF/0p57Y8w
	 HHHJIkmVZgqG0D+rF1J692x8lExsOwZBl2Gletr5ot3Zjp8tTOBwS1SwtQ+yocf8X8
	 5kyR6SbA8k5Edi75+Z3xcbI1hGePrihwZFGijRiEBXqsRC0Y7WO/OPY5/MHjmSACn4
	 qUEsGFlGmX85ZfCuFV3S/25c54EkaoIwMjb7FhjSifAwlho9IbgQFu4yvPGI33HiT5
	 TfhzZ34OWZayA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v8 2/8] mptcp: pm: userspace: flags: clearer msg if no remote addr
Date: Wed,  8 Jan 2025 09:44:03 +0800
Message-ID: <0151403138cac7363208c011580d9c1e92b34a4d.1736299989.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736299989.git.tanggeliang@kylinos.cn>
References: <cover.1736299989.git.tanggeliang@kylinos.cn>
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

