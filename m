Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5214A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749509; cv=none; b=b3wxjzzO0+WL0l1eb0g0m0fvyFIP5WJcu8PhxziS6WnCJE5L8HVPKhzvNDy8O7yZpFxDv7UsjSL0wO44NRYyrD5BgLNUQUf+6MWYvE+N5k553eM4aUmsA65NNaBlnVAomcoUNllYTqfMtILR9bl6A8zcpMKfko2m+d/DotFgANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749509; c=relaxed/simple;
	bh=7YK4roPDwDWsGRUi5qG3TGk0IpQ1+zIoN9JIJXAhu2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIqh9SJwVvbjOnG9Dq8m/Pf3x85UcgO3u8IQRc151MdOF74M/NAekn8AYx6WNAfUxXGCdVIX6vQ9zvG+QB+YJk5vGOc/IGWVubE7SXFHyJaKmCa7x8y1yIEhGTL7K9M6yRp2lo1qG8YjNThVAmypKUWrixLRg7kX7OkEZkUa96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxE54C2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxE54C2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACA3C4CEE2;
	Fri, 28 Feb 2025 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749508;
	bh=7YK4roPDwDWsGRUi5qG3TGk0IpQ1+zIoN9JIJXAhu2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jxE54C2NYSuezpAYJOsDADa+WUZOTr86diHcC1a9T6UpWcS2tVbGUNSnouma7DvDn
	 5uBnkpscRHfOd8NPmrhqYtc7TP+K9SOz4gYJXTxDlw0dyg8fg+vsF37Jk4+ZZ0lbcJ
	 wpE1x5wdxxeKCD9pR7A9W4DtZStUpV6BHCYBkHGk8ZRqf0+saAb7zlhVG5Vshl8LCS
	 dr7k4Nr3QR0ggEC1OWdcx1DGJsIc3Uq7X5ZaqDbxihBcVxq+1Bx6O+gG+H1LVcS1+F
	 V2pD4ba+oJwRL81j5t4isdrKm8E1cRGrV4SulTtHrPJYxiLjHYfGU2M957Mpy0MKh2
	 DxkXWlfx9TtDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:27 +0100
Subject: [PATCH mptcp-next v2 07/14] mptcp: pm: kernel: add '_pm' to
 mptcp_nl_set_flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-7-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7YK4roPDwDWsGRUi5qG3TGk0IpQ1+zIoN9JIJXAhu2I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq6puXZ1LdVqkKF2mm13Qvqzmlw+ZttgaqQ2
 5uZOm+plaCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 c8jaD/4rjXz5DQ6hQLgyQZp5C+t22bLzy6v5M7bT+tATlNy7WoRonA1R+dcJV0pmkDirO1dYiOu
 RmUSDuVv8KXJi5l9vCjhrczaLcJwhm9Z/+Cy3vlMpW4dkXPeOle9Y7GmBiqqxqyEh15bcOLLMhK
 mR/sBE+B+K78wMuNQxlP35sir70kmpy2VBHXcUHh14aAzuWn5FvER+UEI2ujv/sp6sVzeBe8SKG
 ULzxudBbYejkoCC74F/k09hRkiInoAat9oc0+vZcvp8S5/H2P/mHF8deSrO3yZcakiaPg7mIUTr
 R4ECKxS9J0pt30FVSYeLveJzU3kPDBCuMdyjt+AuzBsjyoKiTs/6eeH8XUzKk1IwqfjgEvph5vb
 DzE1l6JT488dBokwBmBH1Mi8Sf4ZSjHgMkhcEPpmUzsZg77yLiToyc35xIojgqHiQTSYhlpX3b8
 lntCm7qjb/nFb11Rnly913bAJUin8TjGxHvCpAOj0KmxZcCBYWTOpSgHC4bDmtsjcKinCuhhvv9
 SiO1bR3Gpb5dT6CIszpsF1EPudNYPnBk30j6onlenXtO3zPGMywsa77/JSGecX+5opZNcG+m5NB
 kYYizuDrD73f+HcZiWX97McxqKxIs7c302dTAGO+wgrVnxIXK/WmNPxoTQPAf7aGKJT5oeJ4eCT
 B0QXUfdkXZWeo2Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. Here, '_pm' was missing from 'mptcp_nl_set_flags'.

Add '_pm' to be similar to others, and add '_all' to avoid confusions
witih the global 'mptcp_pm_nl_set_flags'.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 029a74162b0bce0d3f34f0aeb854ef1b99c020dd..781831c506918cf3c4b93549cefa1a54373935bf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1915,9 +1915,9 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_set_flags(struct net *net,
-			       struct mptcp_pm_addr_entry *local,
-			       u8 changed)
+static void mptcp_pm_nl_set_flags_all(struct net *net,
+				      struct mptcp_pm_addr_entry *local,
+				      u8 changed)
 {
 	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
 	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
@@ -1992,7 +1992,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, local, changed);
+	mptcp_pm_nl_set_flags_all(net, local, changed);
 	return 0;
 }
 

-- 
2.47.1

