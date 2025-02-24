Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA85134AB
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384831; cv=none; b=HnduULn1fyt70yKPFVPP57QWueURPH/j65UhNfQ/isXgEdJODPbA180KcoNcs70jSfNN7mvWnomZaFj2iX8WMlP8sa5NDww1t+vBah43sJg6dvRw0nQaRVU2eXH9bKLzMbN4Ll0UJ9nffw15vHlxN5SMZwggCDAu0ZtWPkSffrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384831; c=relaxed/simple;
	bh=NOyIDquAJI/RMBwfa2jKn/aNdesPUEYCHsZfnuqzwpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMKwv7i5TWLrye4m42HDigl8CTG6oeUeyI0r1AKtguk9EvjVb16hUZZn38gbSYtflOC++TmluOsJBVn9vfXjue1mwL9+xGtKnv7rS6SkAdffmpu3yF+9jzfp5EPWuFqyLeWGPvU3p492k5SqCDDSAARWe23W27ag06b8BhOZ/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiqIG2GS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiqIG2GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD4DC4CEDD;
	Mon, 24 Feb 2025 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384830;
	bh=NOyIDquAJI/RMBwfa2jKn/aNdesPUEYCHsZfnuqzwpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiqIG2GSW899YwPOs2jnoPjRF00r07htemuYhVWwFGofQoZJITqEAxUQFW91ZBnqP
	 K5G8FhALd8hrn+hCysz0DmhVRS+DRwNSUm7SgI1lSuzIDzYzsMp6nCxTu0Cnm4yt+u
	 YngbT2iDsNPUsibgGgR1Kxb+6H4RU0XQtgoCkr8NdxG09Z8r7K+e/66KaDHZlrF6N3
	 SbF7LFeFhXmrI2RgghHbhtteTibh84IjrLy0RhfeFRJ2FKJwpCwUBaX7z0vCLa01pV
	 LlnKo44jhzJjecTf+mc0tbAHTt+s95C2RuSHVoUKUxshmpFeOnxz8EdgWNqwrs5z8W
	 Wos6RMn7kg6Qg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/6] mptcp: pm: in-kernel: avoid access entry without lock
Date: Mon, 24 Feb 2025 16:13:33 +0800
Message-ID: <1ccd8b5eee126272e4841635d69616ca79977ad8.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_nl_set_flags(), "entry" is copied to "local" when pernet->lock
is held to avoid direct access to entry without pernet->lock.

Therefore, "local->flags" should be passed to mptcp_nl_set_flags instead
of "entry->flags" when pernet->lock is not held, so as to avoid access to
entry.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4328443d844..fb83eba041f1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1983,7 +1983,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, entry->flags, changed);
+	mptcp_nl_set_flags(net, &local->addr, local->flags, changed);
 	return 0;
 }
 
-- 
2.43.0

