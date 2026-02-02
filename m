Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C92DA779
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059879; cv=none; b=mxbGvn5xQuFYiK5E7keWhsYHbi/x/FBX0kxQw7nFcgaov3C/pNHFFwunzz/VOYGJ9d+DYecI/YQhzTLRRohOUDZr3maM84IF0wjAA7RuT55ziEsxoGkA4YlvcPZKHZWEeZjRL1hla0GYgKds8Xo6kBgdIRGtxRmpJhUe6Ot/R2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059879; c=relaxed/simple;
	bh=95zxeuc0jpT98w/9SfKxG95bYoI/CttavxMvtT0ff3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3hs4vyrBoIgwbgfhV6bKvXt+9dDbLIqVvmDEOF5/1BwgV8FwJVCAmOUWO5aILhDFHLENd24Jko5p3w7D5eszmUI9Fi2eiczTyS9agnwELCb/UPCmsfj3bR/TY3j85hQM5zpXgzBL7Z75itWYRRnTVvEVUpejmAtoqqwCt2cgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdwyI5qy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdwyI5qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B998FC19422;
	Mon,  2 Feb 2026 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770059879;
	bh=95zxeuc0jpT98w/9SfKxG95bYoI/CttavxMvtT0ff3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KdwyI5qy/YkzEKluejYaD6t1/KN498UNTxhj1pFouY1zWNDHoFMegNV+PqnTEcxb6
	 f2C2mzLlhJNTE7UHgN0Ng9qJEY3ggIpm2MohmnG66xTwZJCzb7IcYaId8f+mDCeVPS
	 F1mo60ulncDqb1J/97enqxkJUOmZhfMU3d6R1QH/qMksz0hrSm1wXfnkdcbD80rKD7
	 eYbauPQS2LDyR8Ui8ggudceXxxofnbSgeiSAyBaVL5YihaJBqvGzWW21n+LqTvmCA+
	 HGr5GFmIIK36iN0OcaZDSDHuNeyAVN/60atq9xhKRZF12DvwykJBu3S701QFgfucmP
	 D5fwOP8xrlDpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Feb 2026 20:17:38 +0100
Subject: [PATCH mptcp-net v2 2/2] mptcp: pm: in-kernel: clarify
 mptcp_pm_remove_anno_addr()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-issue-606-mark-subflow-endp-avail-v2-2-7f9df0ae6157@kernel.org>
References: <20260202-issue-606-mark-subflow-endp-avail-v2-0-7f9df0ae6157@kernel.org>
In-Reply-To: <20260202-issue-606-mark-subflow-endp-avail-v2-0-7f9df0ae6157@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=95zxeuc0jpT98w/9SfKxG95bYoI/CttavxMvtT0ff3w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIbfqRcf++zbsXB+nsWMrd8PNM13x7Z4vtPtN+0dK2Jj
 cdx6RczOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACay+iAjw7t6ceYf37tvx12s
 PeXfwsF8e2+I+Xr5Z8J7oxuT53U52jD8T/U7LvTWaneC2eonxjPFAy8+NdD7eexAwLfIxsIvbjb
 iHAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The variable 'ret' was used, but it was not cleared what it was, and
probably led to an issue [1].

Rename it to 'announced' to avoid confusions.

While at it, remove the returned value of the helper: it is only used in
one place, and the returned value is not used.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/606 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 94a4fdab28f5..87e37c729f81 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1045,24 +1045,23 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
-	bool ret;
+	bool announced;
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
-	if (ret || force) {
+	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
+	if (announced || force) {
 		spin_lock_bh(&msk->pm.lock);
-		if (ret)
+		if (announced)
 			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-	return ret;
 }
 
 static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)

-- 
2.51.0

