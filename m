Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799017BC1
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589045; cv=none; b=GuBDn72pTFg5JkDBxoo1MaqoFsvJNwaeRSAUmXCc+nKSfp4PbzxGvWKqopK73IXe3FMfvc7h2ohLErj2PR5G39p3GDgN33/LDxlsmZBnQu/wAQXe4gxvJWRVWQpju83yve/rOUW4fc/C0nvVO2L4fB70kMRgpOjY+7WbUFySGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589045; c=relaxed/simple;
	bh=MQH2DyIEuqM8zxy/9qZ9uOZnuvNFpDxYAdujiAjV4A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PyydF2sDyYeqRR4lYwLqHQgls77QihVzToetMAVFjnDW1BWDBacxs1sMXdW0/6gJKmkk76dDsuIvZKmGQXdGyVtAExX7wbSVL2xAmUSJhSIbMP/KIvqPsYUIVM7Hfr0IWw+oXc0eh0pqvqAkbx+e8trijbeft5qNtpAmcElEJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbw0+Wzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbw0+Wzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E3C433C7;
	Thu, 22 Feb 2024 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589044;
	bh=MQH2DyIEuqM8zxy/9qZ9uOZnuvNFpDxYAdujiAjV4A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tbw0+WzuseEiYOksoWYTiIsuoZa6/f5MULuNu2xXZHCEjUy+2kr5j71oR4lM3MzHe
	 DAIKFFWtyvVlrg+Ek/k22NjvNDkUpPPKMaZMXndYD0VI0TFOgjgWgmRvje1GK5mqW+
	 RYo/KEdJIS9tf6L7loLxqcwveBug9JpmWicXGUMn0pUxd3l7S6Lanp1I3Ynfi68RZa
	 /BWCgnKog/WU9la/O1ixA5QPfFRLZeSp8cuvyp+TAZZdvX46e1YeHv9CVBcGchJxw5
	 bvYc40QiRL5gAhZqiA4UPQgXtib2PikamiN1sLDbdkncwF0k+0OqydBB72QgTjtbIq
	 xuHRywcGEqS2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/7] mptcp: make pm_remove_addrs_and_subflows static
Date: Thu, 22 Feb 2024 16:03:52 +0800
Message-Id: <e4c446312b1736bc35d6efc8080f98fdf95ae816.1708588977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708588977.git.tanggeliang@kylinos.cn>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_remove_addrs_and_subflows() is only used in pm_netlink.c, it's
no longer used in pm_userspace.c any more since the commit 8b1c94da1e48
("mptcp: only send RM_ADDR in nl_cmd_remove"). So this patch changes it
to a static function.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f04e354b0c64..16f8bd47f4b8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1547,8 +1547,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list)
+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d611968ae6a4..746d0d1f94ec 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -988,8 +988,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.40.1

