Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6318629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038214; cv=none; b=p+mqphIlsXgGMJI9zdRymSRWjw9C8Y8hrE4zoyjzqRMYDUCV3pEqWEUQmgAlSJI3GAHRktWvaRLHxgO/njatW83ogAHlTHbsUGJYKT0TlfEm2vhCsD6Uq0dSh9Ca/FuojWnNWhNZcviIKVJdnusN0QYC83MZrlnfTv6DBo+XY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038214; c=relaxed/simple;
	bh=ElgKYJt0UtvBm0a4eHyxHwFDrKgdp9FKPDcdsaod4Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sf93xCRZCopUNX6cSRfFXgmoWqZ3WMH2tRfDanEb6xCzkSWF8j/0l9Rpc6MBi0I5RyeSh0OQzbIBVNwkVDGXimp4BTtNUJp7y14nPC0VFwdHs5yjeoXiNvMFc+pBLwUgHld88UdZ992vrrHkAb5KTy7u/MMzQqMNMYZ15Ob1aoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfd4LH4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfd4LH4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB2FC4AF0F;
	Mon, 15 Jul 2024 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038214;
	bh=ElgKYJt0UtvBm0a4eHyxHwFDrKgdp9FKPDcdsaod4Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nfd4LH4Sb4INE3S0wFZbLEMr2AcLLhusZEgXKFtvPyqA3TDL4NT2Jb0TYRQ3UYI41
	 hKma7ngEY5rAbWHVqa2Oh37g3HusTD2+hMbpxL3ir5mGf8lBBMaQenAhY8Jger+iLs
	 dDw79rDbAD2LbBrQ1Ijz3hMqePooUpzEOBQS6XvP3L773H+sviHOoiNyUZxJD8PJ9g
	 bnCpnFROjmyKNXbJb+JXteHEi1deliyYpi0XyFVKJXeWz2gpeK1/AR2+7X0eJk63SJ
	 jAheIFf/1kDqjJz9C/Mv0xUVDO5taH0ZuVI8VjYp9JhquMqnj9HDDMLYEtlCOsvFSY
	 bIjHFsOzLAqmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:48 +0200
Subject: [PATCH mptcp-net v2 10/17] mptcp: pm: re-using ID of unused
 removed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-10-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ElgKYJt0UtvBm0a4eHyxHwFDrKgdp9FKPDcdsaod4Ko=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3CYGFc7bOBnl6Ty298eGGOCeQzLB6SBgU4
 QVieiPhjRqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c+BlD/9Ham8jqMPCLVFARwH+g0zF+W5dzm4XVEU4DpK+9b39upMxWtL6O11ufb+tXIt3JqXYmiy
 GsycdO5qnG4Rbhbc7I8kS14Pyeg4KomRvfB7ul1QkmiNcj1aGEC0UyayzPsyDzvBWIDz+jtcIjn
 uCGRu4OKoc5WTIDn5xv032+2r5PLyL4RMyMF/Yjvat4ntmKK5xTrCx6J0FMJsGOMM4EvddJqmeb
 uTtbppIRlHDeHIOomkpLtDzckeISE3FWWt76WekhGrt70ORirME7rVxt1uM74dvy2grsQe/afeH
 xxDKaIUiMEWCWYc/QNFQJIICNPotEXgnCoXkAmSkNYUmgdDvR3F860JjqFm1L2lMYtgXfvwm6Rm
 eBG04uWI1CGtOUnqwfoi440hcgcLxLyNJOnT4EI/pITom+puXQ/GzmvdPhN7dBrqIlmiMuJ3jTb
 9vQhpuuzhi4tpwg1+Ge49r5dPX/WgHv8cjhmd4jyxfULAamelxqFbjIitQilD4nypdfwgYd64Eh
 67ivs3+d+JxaFSrcljn9lAwiW4PY0+KkFkmo1wC20r4YS84wAlOequ2QiNqUulOgnorKno26cKZ
 nDQiQ/ZLKawm4qYvwmloh61ARR6aAElSlExsnVpvz4GoQmPKB1Sdj+H1K97d89M5CBIP/1N0en/
 VKcmYgoKkhsGywA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'subflow' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the 'subflow' endpoint if
no subflow is attached to it.

While at it, the local_addr_used counter is decremented if the ID was
marked as being used to reflect the reality, but also to allow adding
new endpoints after that.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d44d318dce03..36a1bda25d2e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1454,8 +1454,16 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-		if (remove_subflow)
+		if (remove_subflow) {
 			mptcp_pm_remove_subflow(msk, &list);
+		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			/* If the subflow has been used, but now closed */
+			spin_lock_bh(&msk->pm.lock);
+			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+				msk->pm.local_addr_used--;
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
 		release_sock(sk);
 
 next:

-- 
2.45.2

