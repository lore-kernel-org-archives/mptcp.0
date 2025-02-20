Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34871F03E5
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047831; cv=none; b=gQMBYZw4Jty5tjrkhGrVQt8Xslax66n+8Beioc0+eDMIVDX1Io/CiFUPS2JadduvKu48pPmu7sEg/+F0DXIPGexZL1lcTBiHkZyAG/EVfnl/T4JQAXV9cmTyqnESJfiqz6EDFiJdrLMUw08Nfbx9Cq3Fe7k/zQYmj+kt3wVVmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047831; c=relaxed/simple;
	bh=7JkoS/bIxMPoDoPD5p0DpX7j6bjcV4LPTcSZCM9F584=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5M2VW/fv1ztz+E9sKHdwuBbYnCdWCJzhjztNMrI2PIqWrSBcB4IV8EWAZSbnIunuWmTHfrBIjUDpDxw+LmGfN0korfUGmhBtOlgzj2lj9mA8v68kJu+1Nm+gLwio9ssVkHvCsG2lbpVRmNHOIVyt3NpjM0fXIN4mp69Mx8BuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT5pXsx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT5pXsx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DA6C4CED1;
	Thu, 20 Feb 2025 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047831;
	bh=7JkoS/bIxMPoDoPD5p0DpX7j6bjcV4LPTcSZCM9F584=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT5pXsx6mARyrFV56r30GpXoPXpAhB1I4jwfrGHaoHRHJ0O7kzFlKzRCHn3qS5QlT
	 N/Ih4jRLYiSvZXp+gQBbFHfNQgjt+X5tYqrybHVtnSqt64QSgb78a7Lq+xtgcZ5mpJ
	 vdnhfNUsKZj7p23MxyBEmwCo6jSE3Zak/203246kJLXuGV1zliOgI3lABOH8kSGu4t
	 q7bkRVW6Irx5dDWwukAo+z87hN5A8uvT5cc7ex+54tSV95rTAR0lgNEQj86/92OM8n
	 eImOYzebPyWy9NsJy5/dU9CVgfIsxG7Pp8UyppZUToHN9z77dV+WVoPyc42nOdzawa
	 zVgI4H5gPIxeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 5/9] mptcp: pm: in-kernel: subflow_closed interface
Date: Thu, 20 Feb 2025 18:36:54 +0800
Message-ID: <bc557b86200f66d9541d0b6ba61f756c7d1c8766.1740047738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740047738.git.tanggeliang@kylinos.cn>
References: <cover.1740047738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update the 2nd parameter of mptcp_pm_nl_subflow_closed(), and define it
as the subflow_closed() interface of the in-kernel netlink PM.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9795f08a33a6..a6344945874a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1540,8 +1540,9 @@ static int mptcp_pm_nl_address_removed(struct mptcp_sock *msk,
 }
 
 static int mptcp_pm_nl_subflow_closed(struct mptcp_sock *msk,
-				      const struct mptcp_pm_addr_entry *local)
+				      struct mptcp_pm_param *param)
 {
+	struct mptcp_pm_addr_entry *local = &param->entry;
 	struct mptcp_rm_list list = { .nr = 1 };
 	bool remove_subflow;
 
@@ -1586,7 +1587,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		msk->pm.ops && msk->pm.ops->address_removed ?
 			msk->pm.ops->address_removed(msk, &param) :
 			mptcp_pm_nl_address_removed(msk, &param);
-		mptcp_pm_nl_subflow_closed(msk, entry);
+		msk->pm.ops && msk->pm.ops->subflow_closed ?
+			msk->pm.ops->subflow_closed(msk, &param) :
+			mptcp_pm_nl_subflow_closed(msk, &param);
 		release_sock(sk);
 
 next:
@@ -2423,6 +2426,7 @@ static struct mptcp_pm_ops mptcp_netlink_pm = {
 	.address_announced	= mptcp_pm_nl_address_announced,
 	.address_removed	= mptcp_pm_nl_address_removed,
 	.subflow_established	= mptcp_pm_nl_subflow_established,
+	.subflow_closed		= mptcp_pm_nl_subflow_closed,
 	.get_local_id		= mptcp_pm_nl_get_local_id,
 	.get_priority		= mptcp_pm_nl_get_priority,
 	.type			= MPTCP_PM_TYPE_KERNEL,
-- 
2.43.0

