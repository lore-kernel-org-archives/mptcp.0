Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867A817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806133; cv=none; b=Dy5+Z/aqc9ILq4QGCFCLiM/paUsLRMYaOKCDUtojBV/PVf53L8wj+k1+WuG5l5Krt3V7iJ8xTRlkXgz9xOA0NVXVrLzeCrGVisyc0koLPA+LmwMh39TVABQAiwwLANl/xaT2OFMGXrN8fx+2hsxZb3VRwVtWjFaweuayKANJWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806133; c=relaxed/simple;
	bh=j0pfLB7wl00D0tpnM/81lnE2CgU2ZnxPd+PBvTXvUXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMvLSVb6iADZxVggfRu4jG6YXmwuOVfLmZ7UvRdqTXCqiKAYIXNRpcqu6Y555zpdAhOmNOJKSXsxl9hCHfdGigVxhjxS4Nj3UNSOAPmLCea/ZIiRzsaCrv/4qnsR/EpwpgXneJDc6tbxWTkxzsa3AKisFtmGttxeDYJa+XEiDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQqiFwfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQqiFwfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAC1C4AF09;
	Fri, 16 Aug 2024 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806133;
	bh=j0pfLB7wl00D0tpnM/81lnE2CgU2ZnxPd+PBvTXvUXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQqiFwfi0uO9VFQ46s4xzKnqciFEIEPjizssoOoNna8wixpPJ/7gDKl47Y0F7r7wI
	 m+OiHvUC0Cvy3e4MNghv5VDDZijS4VNx32bKLjxpU2Q9y2OfpOgXNWmxYWfpDwFrR2
	 pYyXZKKBTd3tS2umTy3T9jLNe3YaFZC7XxGdhbhrlxQqW5HzdfncI6Izwmnrwe6LZt
	 9ZJgujt8aUpjhsNq1Wska7o3wcfqUWwkna0/36XQs0ZSPdV1mX8qNhkPpp19OVvwKv
	 BDJOG7Zy3B47FPL5lSBK00lSgaIBK4Zbz/U6UJCYs73pMvRr/iY5frkzx1+rLeS4Od
	 k7Up1WxmZB7gQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:01:59 +0200
Subject: [PATCH mptcp-net v2 05/12] Squash to "mptcp: pm: fix RM_ADDR ID
 for the initial subflow"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-5-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=j0pfLB7wl00D0tpnM/81lnE2CgU2ZnxPd+PBvTXvUXY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGuYHLGh9cUKq4KCWFQiGeO91GqYHrec0yZ8
 M6XyOAtfguJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c4WiD/wLKu7L7DSuhZJPxmrNFP7mi2mUyXANOADX8XP9qJaoJIeOtCZP+WEd1J8ju5TxhIFZd/Y
 OiusF0Nla0Vwt7tIQaAPxdKawq1aokKgV+4U9R8cPgYj6WD1F2mpkjgMTVEvqB7oS99uOpnA09p
 bD9lS4v16Ru8gv1i0XWOnSvrueWswa5i2tn2mVelWtnH3Hejp+0guv/OsFqJgWLjhMCPclxs8KO
 +dNk6nWWBmqbJ+vGuwJZ7/LEyU5OYQ0iUQs8LMsxQsHD+xecX5wOz7BHKvzVrMoW6ZA6tBUJtTT
 LHUOMGVwSu/j6VKT9alqUyViZBEMiT+f3tUfjivjIo2qa4eHqgQgtRDYTkuCTukfANgdqig8zpU
 6vXcFlGf4DGwimlo5X2M0hG0nQqPGHeR10KRtQtDsaJgjANL0z8t+JRIdHg3zE8m+m1Bpf9kFlI
 5YfrU+laHtQ2Yq+MKEcSFiiKiG2RuESSK5Efr2ad3F33Yb1bNRrMLksAHcQtY7Url0652d/oHN3
 fcmO4naMQlgzfyrVIz6neHbi3AoTbCmy9KPUty9l163V5+hwBcRDTI/fcSonfbRn6H09BKgRk8W
 vtyeYNpv7F/s1SmnM+ewyOdPHuk+OA8+hba5NSaAwCb7UW+Grzx6ThMSDr19TSwTqBpkArqPaIb
 ANwdC7GbBLL47dg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be used with __mark_subflow_endp_available() below: the ID should be
the one of the subflow -- can be 0 -- not the one of the entry -- cannot
be 0.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eba3c0e2ec0d..b7173163c238 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1501,9 +1501,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
-			list.ids[0] = mptcp_endp_get_local_id(msk, addr);
-
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);

-- 
2.45.2

