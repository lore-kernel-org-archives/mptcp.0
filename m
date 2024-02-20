Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1132605D8
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423119; cv=none; b=cf2e/sW9k5GDia8uFcXuA1ESEgse1Qe21u2omkkllgDm98D1TciLCzJkFpxMUAmYuFs5AM0jfQB3eS/HY+ogESSZWPOX7RV0FPf+2ww58lang4Uso49zmABJi/Zq6iOjz7PDCWnDLcPtOWWdJbP8Pb3K1Og918OHge1iRM+7c5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423119; c=relaxed/simple;
	bh=vXORsSkjiEGHERfcCLl4bm3dWULv/6LtyQzNqLp1Wec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDLVLh5leBSaNU8SKkfeP22b2Nrc5t17BWzekyQp/j86kaJE+aG5Z4sLvy6kLO1/z3I3rob9/DpQ7wqSSdJx6fldPdkkvhpK/0+gh08ufVkkaPii6fhlNDEhp614iZpI9UCriuWgqlhfnj2VpJ9tKlx+KgWOgdeijKQoZdc86yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmHDWAaq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmHDWAaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CE2C433C7;
	Tue, 20 Feb 2024 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423119;
	bh=vXORsSkjiEGHERfcCLl4bm3dWULv/6LtyQzNqLp1Wec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmHDWAaq+RpB69ggBoVj46osYWnA1DwISDHBt5Oz+zMWRGTYSKTOG30KdMqfzadzy
	 kyh4QD0iC+reqRhAVj8gVg3bgAJ2VCBf0EHFh3FRNH8janKnWrBLS14DZeJARfL8kK
	 pw6XlBPxhCLGwqr46laFsuG6wWiZkTQMAoPJePGMMRIA7aPs0s88TSw++t8Rx5wR/z
	 XW9YrxX/JA+U7yDR0ySV7oiVeEuTFNe9w8y98LPrhN3yEuV2J84AftvF+8A/TpAzF+
	 JELyBdYNMmli6DfyWvKxfHYuOyxPhX5SZqVZ2HB2hl1XM3xPBGuJJ/dZ6EBsq4ti/W
	 Eg20EXoDMFjSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 04/14] mptcp: dump addrs in userspace pm list
Date: Tue, 20 Feb 2024 17:58:18 +0800
Message-Id: <ed4fe318aa313705e6dd0f99e351cb6e7cc01385.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch renames mptcp_pm_nl_get_addr_dumpit() as a dedicated in-kernel
netlink PM dump addrs function mptcp_pm_nl_dump_addr(), and invoke a newly
added wrapper mptcp_pm_dump_addr() in mptcp_pm_nl_get_addr_dumpit().

Invoke in-kernel PM dump addrs function mptcp_pm_nl_dump_addr() or
userspace PM dump addrs function mptcp_userspace_pm_dump_addr() based on
whether the token parameter is passed in or not in the wrapper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         |  9 +++++++++
 net/mptcp/pm_netlink.c | 10 ++++++++--
 net/mptcp/protocol.h   |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 53e0b08b1123..193198cec74a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,15 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
 int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
 		       struct mptcp_pm_addr_entry *loc,
 		       struct mptcp_pm_addr_entry *rem, u8 bkup)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5cca84c6b87b..7b15bb4f12c1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,8 +1722,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1765,6 +1765,12 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0f6eee5496ad..6501b0142794 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1071,6 +1071,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 
-- 
2.40.1

