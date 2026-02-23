Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E3190462
	for <mptcp@lists.linux.dev>; Mon, 23 Feb 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868162; cv=none; b=XQzoRlRZ5cTNHW6xVriiKQ+FcRNL0zqbm44wYXS8is/kNNAW2Uf95nIXebxAdv+ey4YTSDn69l0MQRHUSAI+Arq7xMW0z9dGzlcw6fjjQIzGRXcJlxUHosWRozdz5HxV/S7fKHtVywJAkzzbh1mz6f1APxI/Pu/tHDKwkEplb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868162; c=relaxed/simple;
	bh=Lsfs47cxEi8R9BAET08daPiAWqyMXzFatRrNKHXrLN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k9/rqjX57P77pwFPqURvgaiJg9dw1dyqmiMflS28PfHNhKM7MQ3utQ9GcwbNoaUT95jrZ161mX9xT/xtCUH8KHbp3T2POj7sgTZ342GjKf1f5wuB2ZQdT1OofJB6d2n2hSpAQ/YY+Tb+kbZBqQJ3t0wsL7AMDGUQBOOSbonadvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjR6qlyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjR6qlyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06658C116C6;
	Mon, 23 Feb 2026 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868162;
	bh=Lsfs47cxEi8R9BAET08daPiAWqyMXzFatRrNKHXrLN0=;
	h=From:Date:Subject:To:Cc:From;
	b=GjR6qlyBE9DpqRl1mbK0DNK3EVbU5uu4V6e7xMpn4zW0A7/LPq1bMfkWIZYwMMJlh
	 DFd8+V8hYHJQyA+hyVXjybLcTUze4FSJ91CT8KuTx6zZtqjRboSCSioZLM/0yVBzLF
	 O/HnWSgRucodeF1CWZ93gn+bBPMyd8D5EyBJX3AQK+SriLc/9IhFNKKqmtfOvV0Zpi
	 vgcNJIGi8FnxkvKpxaOFwvVD8tkmeCnaolpK1MI0zZ0GIrff8rsLqAA+YhCa/l7eNW
	 HBc0CtgUVhdS0APCVUo2rV/HGd4I8798qf+/QVrXX/vQBt7hVkmLitXfNTciJJP5ZS
	 0DksQDzvyjFcA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Feb 2026 18:35:55 +0100
Subject: [PATCH mptcp-next] mptcp: pm: in-kernel: remove
 mptcp_pm_has_addr_attr_id
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-mptcp_pm_has_addr_attr_id-v1-1-1efb38ad6488@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPqPnGkC/x3MwQrCMAyA4VcZOVuYGQ71VURCukSXw2pJyxiMv
 btlx//w/TsUddMCz24H19WK/VKL66WDaeb01WDSGrDHsUccwpLrlCkvNHMhFnHiWp1MwhjjDXW
 Icn8wNJ9dP7ad7xecLCTdKryP4w+EDdP3dwAAAA==
X-Change-ID: 20260223-mptcp_pm_has_addr_attr_id-6bb52e3bd89a
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Lsfs47cxEi8R9BAET08daPiAWqyMXzFatRrNKHXrLN0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLnTGDMupd/vr4+vCts8+E/yrp673Ys0Cyd3rjMJqxji
 cz+DZdmdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEai8jw93zb26vMp5V7nas
 vSJAYKnao81/ozZZnGCT+MTD2GcuW8zIMPVVesW6jdtXfptcME/lNtubfRxX6u+Ye7+9tLbthtx
 Lbi4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

There is no need to call this helper: it will check if the address ID
attribute is set, but this attribute has already been parsed previously.

Indeed, the value has been set in 'entry->addr.id' if it was set and
positive, which is what we were looking at. Then only looking at this
already parsed value is enough, not need to re-extract all Netlink
attributes again.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Seen when inspecting the code, related to ticket 612/615.
---
 net/mptcp/pm_kernel.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 87e37c729f81..ba15fbf2781f 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -711,7 +711,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id, bool replace)
+					     bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	int ret = -EINVAL;
@@ -770,7 +770,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id) {
+	if (!entry->addr.id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -781,7 +781,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -914,7 +914,7 @@ static int mptcp_pm_kernel_get_local_id(struct mptcp_sock *msk,
 		return -ENOMEM;
 
 	entry->addr.port = 0;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -969,18 +969,6 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 	return 0;
 }
 
-static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
-				      struct genl_info *info)
-{
-	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
-
-	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					 mptcp_pm_address_nl_policy, info->extack) &&
-	    tb[MPTCP_PM_ADDR_ATTR_ID])
-		return true;
-	return false;
-}
-
 /* Add an MPTCP endpoint */
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
@@ -1029,9 +1017,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info),
-						true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;

---
base-commit: db54d4a79a413b2702191c0dc1d855bc3c9e1a98
change-id: 20260223-mptcp_pm_has_addr_attr_id-6bb52e3bd89a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

