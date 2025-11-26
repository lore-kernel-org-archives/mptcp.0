Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FC8462
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181884; cv=none; b=DnP1XLQadvP6FGkEdhpX6ENgkyKXvB23EwqxG6dnAOG2Gl8Y06d+oCWHNB/casZgmAfXZkHqWnH89NgrkfJA8ywUN0kBUdmPeq/iTSnVsOL3M5GrnSgjcc5lnAbbj+IwHqMy0fu2WfBH4Z3daIpf0BFImNpBVLfyDlu1DmK6s8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181884; c=relaxed/simple;
	bh=oWDb2ylL1XiSI5MQqx19XRUboiHTT08OtPrMvbPD/Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jc9/hasR9ZOdL2Z3V5FP8cNjEVzngAA1UwCZ4Uj4DGbO8QsY5FfOV/f6x8bau820Wr4yKVUWudNExeeeSX/ywhHreeBjAPEMAUstYiNGWR37bp6zrLXS+1/+fxZxQ13TjhIsO8Ots8lD64gK4MNxLlJ72Cq0WPvlKWEqn5cMQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP74cIL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP74cIL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99583C4CEF8;
	Wed, 26 Nov 2025 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764181884;
	bh=oWDb2ylL1XiSI5MQqx19XRUboiHTT08OtPrMvbPD/Es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HP74cIL8JKBB3qfKkWnaOCo9SdzAP8GSy47vE8sYlefWpHZfI0EJkEwYcUHLqEUOL
	 lCTsM0xz/d2wKMhnBpFy5a5EaxxcJQ2MtwUT81NdIDVuO0UBgn/JcaGNG5NshDyzSb
	 DB0ReiDJR2HJsDJ+eayI2bzaw4NbBBczuXhgD/6dFbQCA/hrHXTfq1HyHuwjoTxD11
	 I3giqPxenvbXVjkwZDnLgRuPiHb+eASTKEfhXeed9WSfWV5b3j3aj8UwX3aWFNY0RC
	 M+vMufc2qRDM2udtXdDge1TMBDD7to9T9TvXAHH9NidFVaSMhU7kRYpZu3aU/9Jcbn
	 SezuMrtxAFplA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 26 Nov 2025 19:31:09 +0100
Subject: [PATCH mptcp-net 1/3] mptcp: pm: ignore unknown endpoint flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-1-d2e4c2ebce0c@kernel.org>
References: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
In-Reply-To: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oWDb2ylL1XiSI5MQqx19XRUboiHTT08OtPrMvbPD/Es=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLV3cudM/hdf+UvzH0yew9T2KzcLe1Xrx6dqXPINsew6
 ln8vzcHO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbis52R4dP/aTcs93JxPFTN
 TqvLcDp1/k8Ms4ThzzPrF110Uk+/6szI8F75hbzywZ4X4m92el+Zt/GLZWTax80BHLfM/804cFf
 /NT8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, the kernel was saving any flags set by the userspace,
even unknown ones. This doesn't cause critical issues because the kernel
is only looking at specific ones. But on the other hand, endpoints dumps
could tell the userspace some recent flags seem to be supported on older
kernel versions.

Instead, ignore all unknown flags when parsing them. By doing that, the
userspace can continue to set unsupported flags, but it has a way to
verify what is supported by the kernel.

Note that it sounds better to continue accepting unsupported flags not
to change the behaviour, but also that eases things on the userspace
side by adding "optional" endpoint types only supported by newer kernel
versions without having to deal with the different kernel versions.

A note for the backports: there will be conflicts in mptcp.h on older
versions not having the mentioned flags, the new line should still be
added last, and the '5' needs to be adapted to have the same value as
the last entry.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 04eea6d1d0a9..72a5d030154e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -40,6 +40,7 @@
 #define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
 #define MPTCP_PM_ADDR_FLAG_LAMINAR		_BITUL(5)
+#define MPTCP_PM_ADDR_FLAGS_MASK		GENMASK(5, 0)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d5b383870f79..7aa42de9c47b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -119,7 +119,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	}
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));

-- 
2.51.0

