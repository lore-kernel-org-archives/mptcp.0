Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159401A3031
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565069; cv=none; b=BzsZ4eOlYLZ4aopk8i3Eb2PaNMmjCxLeL0CbLfQvfDMHiPqBMLaoPoqadpxc07Ciy8w6RBmkyElryn4y6E7DaDW/J2PsSkwLYdlWBY/tnNQLexAusYlZxdC6lUj4iZJ7BlkIueHuQU1pgBUKOnewLefZ5pI4smHPdxxfO7PvSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565069; c=relaxed/simple;
	bh=VuUWBl+yDbg5KEAuDjQHLbXMDdBhUxR/KJHYliGw0Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7B1UI9MTUO6tq8oBbY/w/bNdVzxZrNtObTeGpH+Wb4IcvVIx/wXJ8qKbofglj3PrOErTVkP1M+ShgXKBWu3Er3Ig4X4HJAQwHtRxX9tjir1KJzoWPfITVG/wpLEAj7iYBKf0R3+FXoMq3geRlqzvDGZSc/xz9Uk0xT03lqJAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVfFa2f/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVfFa2f/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A60C4CED2;
	Mon, 30 Dec 2024 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565067;
	bh=VuUWBl+yDbg5KEAuDjQHLbXMDdBhUxR/KJHYliGw0Qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EVfFa2f/EIggVgkJkU1WWfI5RwAju5b/CJ86Y7ERfbtPW9tcfFl3IcnG3ZXL9Oasu
	 sEmF0mgAsBDuDwR98itEYe6l7d9+ZbqJrv/mz/vffOgHpVgFf4u+01yQVHx9yDmq0y
	 u17Pyu2JK2MZ6F7i1vpf22YeYXY7rh0ULEOv7qAC8Epg0zwHSA1YILuVJSMOjLMcZz
	 C+mBbSIBz2rhkzFKocD7pQC/M/l877qnNI7IJR/vuzOWQxVhsejqT8KPkoOqMZAT6m
	 5HC/zxje1aBNKZTmjBhaJEV5skTa65N1UsHzCgMSgHwgGHuJR6lLvmee+o1qJzX0XW
	 vhuVHI6A6vFhA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:09 +0100
Subject: [PATCH mptcp-next v6 2/7] mptcp: pm: more precise error messages
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-2-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VuUWBl+yDbg5KEAuDjQHLbXMDdBhUxR/KJHYliGw0Qo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8J7p5F/oerlf+nr7K/S/qBGun/pzEz7vXH/
 OrPnAWEWp+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCQAKCRD2t4JPQmmg
 c2sxEACmUDEym0fBJdtapAaTRkuZLvLVxZrDRdt6fcBekYfig7NKxcMj00Dp7hW+ZAe1KNqLmNa
 nyhstVrwBJrQ+sFLUAYfC4JNRJy5W1mlZULJvmi9nyC9T8QrbUO1rU3V1B1P7z3gng9IYH7TvSb
 wld4LbrU6a1MSv+cXJ/a0N5F6wbowMM1fiz0A/oxP/iAHYuqSV27/ThX6lzXgtfBPlMnuGJ/F/M
 ItuibJDWEAhQTIGqh8ZgVVpRxB43hYByWeffFFQUhjDuNlGeQfLCCZ3SV91O9QMMmdnDBjIICP0
 gdFjkTBgcrZmk3s06B7ZNdmGAGS2yeVhfAE2Lgq2QNKTz9Yto+y2KRtESc+uNYYph41OnMqpn2R
 hbwknqrCi5bhR/AEbqRkzFdZcp61tqYVwLQ2RDTYIBHTzM7VH+UYsKonvi8Gk4w4ruwpSc4goYD
 XlCKz5R/6xKwSFkL/EQZ/jhInBxDoJRSGxY9EAk/VPTq6YW1dT1hBowiD33GA8iBGp/qN++VIlE
 srRs9dO40QSP9LdycbIapTmdu/mF3GO6SH38Im4OsxyjsGO9lfyPYURpW9mMhwcpr/YStKuHek+
 5YrssrYxrKJTgJhGQWDKV/LNIdhb3imVBfum3TysWkyNwD/5sQfgaxtAQi0hnaG9p/NmJGLX4SM
 KsotF5Mbc22Eoqg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some errors reported by the userspace PM were vague: "this or that is
invalid".

It is easier for the userspace to know which part is wrong, instead of
having to guess that.

By splitting some error messages, NL_SET_ERR_MSG_ATTR() can be used
instead of GENL_SET_ERR_MSG() in order to give an additional hint to the
userspace developers about which attribute is wrong.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 72d4861e497eef5a516fc1c3ec1659807ffedd53..9c0bec588c498e0aa78acf4018db509abe90cad2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -224,9 +224,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		NL_SET_ERR_MSG_ATTR(info->extack, addr,
-				    "invalid addr id or flags");
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
@@ -537,8 +542,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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
@@ -592,9 +603,16 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 			goto set_flags_err;
 	}
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
+	if (loc.addr.family == AF_UNSPEC) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
+	if (rem.addr.family == AF_UNSPEC) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+				    "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}

-- 
2.47.1

