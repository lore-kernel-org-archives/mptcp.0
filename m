Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398B1EE7A9
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047830; cv=none; b=Rwc8tFOG1QSdUg2pmgxioMuX1bPnvKOKaCXy+zDXANqRMKEULYYJFn25nnIAVcQVje5YjP54J+Bj84QuzBJ7QRvJMejlsKOaXi+LQufHmpmOoRML/lfz4/jlDXpDBFMFyXPlzuCfGErqurocG+fCxTqj/W32MsJldHgl055jmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047830; c=relaxed/simple;
	bh=xDzGAdrjwvPLWNIOFtCx8zLVVkOA5fAFb9RqwPNKryA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwl5raGrewxa+P1vq5gJo/2fzOg53+PZWQOMGrvZ4SRgXzEDNFYPxZDpff/ytp4fJJTJx5T1nYnXrT4kgSfxZ/laH+6vJoB+6J8zJsz9H+tVUurFF7I8XB1FuQmUio9p43clegmqPda2zdaHq72nAqRkNPnImaFfI0W3E4GbzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXZ2ruxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXZ2ruxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF95C4CEE3;
	Thu, 20 Feb 2025 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047829;
	bh=xDzGAdrjwvPLWNIOFtCx8zLVVkOA5fAFb9RqwPNKryA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXZ2ruxLdRIlLz5gqMY0XJkTmzmdD1L9UIE8Cp2ycmgiKh6wnCMPdUcRURRnFwJeN
	 BP9RLTpxF8/jLbA96nx0rRdRN3TgRgpo9wBa2MTr7zjG0EQf3+TzE3d9po92LYqt97
	 slYqWNDZJIE/uMAS4tINJ411UfLKlCecfHEIlD4XKsDezhd2gY5wocAuBHX14DBbWQ
	 zQ0XwC21tsSB98+rNpJVtZQmng4IbqJACbPZXfWC64cTDBqeapFw0yMXF0guFf/v1o
	 wcclEsMXkrc+tosskgmX7YWBKbW1RZch+3eQXIJD+2CUL15viNpuV8YNENEZo8CJ5q
	 oPxXTbmWn05ZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/9] mptcp: pm: in-kernel: subflow_established interface
Date: Thu, 20 Feb 2025 18:36:53 +0800
Message-ID: <91b802cae1b3e338d1d8c311fbabd5842543d9d4.1740047738.git.tanggeliang@kylinos.cn>
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

Update mptcp_pm_nl_subflow_established() to match the parameters and
return value of subflow_established() interface and define it as the
interface of the in-kernel netlink PM.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 53246a3a1b09..9795f08a33a6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -652,9 +652,12 @@ static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static int mptcp_pm_nl_subflow_established(struct mptcp_sock *msk,
+					   struct mptcp_pm_param *param)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+
+	return 0;
 }
 
 /* Fill all the local addresses into the array addrs[],
@@ -927,6 +930,7 @@ static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 void mptcp_pm_nl_work(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_param param;
 
 	msk_owned_by_me(msk);
 
@@ -954,7 +958,9 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
+		msk->pm.ops && msk->pm.ops->subflow_established ?
+			msk->pm.ops->subflow_established(msk, &param) :
+			mptcp_pm_nl_subflow_established(msk, &param);
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
@@ -2416,6 +2422,7 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 static struct mptcp_pm_ops mptcp_netlink_pm = {
 	.address_announced	= mptcp_pm_nl_address_announced,
 	.address_removed	= mptcp_pm_nl_address_removed,
+	.subflow_established	= mptcp_pm_nl_subflow_established,
 	.get_local_id		= mptcp_pm_nl_get_local_id,
 	.get_priority		= mptcp_pm_nl_get_priority,
 	.type			= MPTCP_PM_TYPE_KERNEL,
-- 
2.43.0

