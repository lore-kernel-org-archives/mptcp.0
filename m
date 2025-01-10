Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AD14A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494254; cv=none; b=ndCMXnjodoCWfpw/3LuyIwdnReWMhOElhtn3zUKfJ8xWqZ63S13q0sfS2TygZTdOYszVSvDNLJ2GhBaFffjIPeL3olBekrwaOokPi6rXkjxA7ZpcnhcswgEJQqgac/lkLoF8bbeuiZ4AzX9c/MZid6F5ThH28dlCOGKxv+RCGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494254; c=relaxed/simple;
	bh=RD9pZ0XTea6TSP8rZSY/4A9M07ardPO+MyZfBNc5Bi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbVTuVd8FBHydmz/wHjBxc63tr6EPuxiw4tUDakO5B099PAAtzqPnHB63sjfpvzijuy4STVE0xfInWuoiBEw3PIsKuw4Oevp66eu3z9njz2SrBYCqNXuw7rLmY0XrEPh63RQySzMBD+MdOrmBWPJVAg0hcUqymYq5JFyZkhHiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTlBGECD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTlBGECD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE4C4CEDF;
	Fri, 10 Jan 2025 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494254;
	bh=RD9pZ0XTea6TSP8rZSY/4A9M07ardPO+MyZfBNc5Bi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTlBGECDlmXwVox9hdS/Qd+5I8hfXZvSZBAOeQDYyA6u/9PutbeF2yffpnnsP7o6d
	 leypqZmVrP4ErYvjUVGqtA5ICAh2hZuklB+JAqt8jnqYGZubND3UaobIkFmOV1bxDy
	 OiGszbZwhMBJFF7UT1ThpfdE0zue72XIj71knVkSgOBqDtYOThRu8bn+meXJijhWMM
	 GO3kPZQ5Lm5gpy/RwMf1bOIlmKJcrPrUM5maf6c8C7gQ4X/0mrCVxJW6T8yY/joXQ0
	 Iw9h+H8WB4HhjfNtHzEoqnbsjwxE9vwv3V6Qj5PzVtPFgFN3Fs1fP3uUORtm541mpP
	 lS20W0IXVFLtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 3/8] mptcp: pm: more precise error messages
Date: Fri, 10 Jan 2025 15:30:37 +0800
Message-ID: <006da446a1eadc361b68ad559e42a32f8a1c0873.1736493803.git.tanggeliang@kylinos.cn>
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

Some errors reported by the userspace PM were vague: "this or that is
invalid".

It is easier for the userspace to know which part is wrong, instead of
having to guess that.

While at it, in mptcp_userspace_pm_set_flags() move the parsing after
the check linked to the local attribute.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 v2:
 - move the code using NL_SET_ERR_MSG_ATTR into patch 8.
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b6cf8ea1161d..cdc83fabb7c2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -223,8 +223,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+	if (addr_val.addr.id == 0) {
+		GENL_SET_ERR_MSG(info, "invalid addr id");
+		err = -EINVAL;
+		goto announce_err;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
@@ -531,8 +537,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	if (!addr_l.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
+	if (!addr_l.addr.port) {
+		GENL_SET_ERR_MSG(info, "missing local port");
+		err = -EINVAL;
+		goto destroy_err;
+	}
+
+	if (!addr_r.port) {
+		GENL_SET_ERR_MSG(info, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -580,13 +592,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
+	if (loc.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
+	if (rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.45.2

