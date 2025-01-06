Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB33B1A2
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151389; cv=none; b=D1TV5KloIl8BDDKzf26oVNUPfXIp+0dIKlyEJjfDrA9qAQ2bFPmoR6dE8Ggqf0c2SSI6WP/5wdW0eJy3N4U84wQnMQYBBUz6UK0uqUYuPRt8GzfuL372eKouukxdGxAT7a8EjEV1xncarFHzB4bQRuR0L2h48c5nvkrRPxO7ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151389; c=relaxed/simple;
	bh=tVvSCQIaFg7O1KP9M1bNplJoAUNRPn6YoKcoASC9WZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezaYBdkh8JyRfL0457f0JZYfCtoA9s0yMoGTNn1QBD9PSzehxBnjObET8R+mtFDBaketE9BemIK1sf/VhY8SbyPqrlfOOqhTW93zMm7D6nsccStkDDvvca5HX7G5eywcRCNJXFWhhihMNn1c8vwYGM0eiW80h6hozTJwkOLK2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4yWUUSQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4yWUUSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4BC4CEDF;
	Mon,  6 Jan 2025 08:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151385;
	bh=tVvSCQIaFg7O1KP9M1bNplJoAUNRPn6YoKcoASC9WZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4yWUUSQxHtWSdUfpavylR1J+RHyCta1OM7JfPREg6yjdhANqXNIoZ4ObXz1UP1AU
	 OiXuuyUkYubplGfr9yj/cHZqflHZ3yiJLpklPm55xgFBcGG51vvgFHIEHkhs/eI2sH
	 wPQ5VLQIcvtBLWDiR0u/UnUWh1zxXAyVEM1PhomXGHyiwMRkUa0ahS0JnUD/v4bDr7
	 l83KOj9WJTzMUXNsGRnBLFKySJh3NUKpMY+gVroiSh4WQ0vMRxRdzfNcK/j1dObPAa
	 Nwi+iZJDbry1qeUnKq37bJyKXXuAb5YxPllLKTdEt419B+rUeFxdqOjWSCRpdLDf91
	 JHXDemaUfkmwA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v7 01/11] mptcp: pm: more precise error messages
Date: Mon,  6 Jan 2025 16:16:06 +0800
Message-ID: <702733ca36c469e621a3d4e9173eeda587dba85c.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
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

By splitting some error messages, NL_SET_ERR_MSG_ATTR() can be used
instead of GENL_SET_ERR_MSG() in order to give an additional hint to the
userspace developers about which attribute is wrong.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3d477059b11..40fd2f788196 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -223,8 +223,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+	if (addr_val.addr.id == 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
+		err = -EINVAL;
+		goto announce_err;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
@@ -530,8 +536,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	if (!addr_l.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
+	if (!addr_l.addr.port) {
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local port");
+		err = -EINVAL;
+		goto destroy_err;
+	}
+
+	if (!addr_r.port) {
+		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -579,17 +591,24 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
+	if (loc.addr.family == AF_UNSPEC) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
 	if (attr_rem) {
 		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 		if (ret < 0)
 			goto set_flags_err;
-	}
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
-		ret = -EINVAL;
-		goto set_flags_err;
+		if (rem.addr.family == AF_UNSPEC) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+					    "invalid remote address family");
+			ret = -EINVAL;
+			goto set_flags_err;
+		}
 	}
 
 	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-- 
2.45.2

