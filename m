Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2403C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497082; cv=none; b=LylVbXPUceaMwOvFu0t3zGFzwQT38k63IdcalEnG5idlzvPniq69HIIXP7EqUlKikC7Z/IejDFhidghyapbdOhMhH1hYXiSF1SypQwexwGPWgNUxfqzJSEc3rvGxEwQJ+yD1Z/6NMlL7JwUH/nSTnhPcqzTT5SQu7w09OnMvz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497082; c=relaxed/simple;
	bh=MQH2DyIEuqM8zxy/9qZ9uOZnuvNFpDxYAdujiAjV4A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZdTSTPmyYcAhRUXEGrxJbMUM7VLAO8jWSHFSVt0ISo0kjnoUoOg4/TmbNMeqhMP5UlrxAJD7DdJssiTRslvyXZ3LrsAGthWJAPn2Yz6nUzRRwu7stKx1PLCZsn6Yvh9EY38OLF0PFqGz11fVuiW9UX8IDm1fbgQnrYpVfsthuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0zKK8SL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0zKK8SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436F3C433F1;
	Wed, 21 Feb 2024 06:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497082;
	bh=MQH2DyIEuqM8zxy/9qZ9uOZnuvNFpDxYAdujiAjV4A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0zKK8SLc1i9GOTADxYMPDAXbw3wTVEGauqk+LQEmofypsCtHMj3xeGE9oItULqmJ
	 PUxK5yoUgqnNzPk44yAAPu46aMYB/Dndqwn/3SG+TOpPFBriBZ8dHwfkKbxhIKaARt
	 OcQRVy9aA7vI6f8Mn+2WyEF+wTDwhvlkqVA/k7LajpynCJKYorLjLxfIThbpULk5Br
	 vrcDPkhOXsYwKDZPrim9mkktxv0niarLjW7pH5miFzcTNU+q5xScUGDwQnHIJI6le5
	 8aHOlCRvauKsPFLDmzf1LCDN+8z1nKJhNussdpi/DH7ZBBeyfEtk9kkMnsY0mzNs7L
	 e6bLROsXoJ6HA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/8] mptcp: make pm_remove_addrs_and_subflows static
Date: Wed, 21 Feb 2024 14:31:08 +0800
Message-Id: <56aeab5adc9179f4c99bbcc57247223192555dc3.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
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

