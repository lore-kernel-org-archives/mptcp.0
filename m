Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC41CB9F6
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848775; cv=none; b=JvBqBuDxSURm9AvaQGt76cWxRj5FHApYll8tkIW1WJ4L2kL07+uZwe4+pQcSFFA8c6IJvI61qrJXi/PcTS7Bd/zyZiY5gd+4Y4CcMU/ICccYgZytxVTVv/+anes0gM8augVlzIWgip7EsM1WF+DJdvQkWo98iikxBvBAvf06Wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848775; c=relaxed/simple;
	bh=MKdNsixnE0//0EK+oCzvPayH9T7YIceGSZoLgh00jSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ou3SeABE37i3k1+Nih6Jf6G5rxguXpRGzBqX6MpH/yz+hbR8cKl+dPBnT6qp9r+1BGuai9ZBfHHXYa292EsGWf1O/yLZqWY9DGZiicgOphWgO3CT18Vj6wKPaV3aLde6rB3+m7Y7Jx/qhFwfsZ4QGJ2+O8XRiS3yNtwRz4R48BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVOcbko+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVOcbko+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D103C4CECD;
	Fri, 25 Oct 2024 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848775;
	bh=MKdNsixnE0//0EK+oCzvPayH9T7YIceGSZoLgh00jSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uVOcbko+18EEO5W1RmhFAcZYMNVr3RH0vXnk0/XrkGmO5EuaVfBHMAGobjynIQVsx
	 yd7NUFY+K0g6lTAiBaX8QglqRqbl1FzZbFKT2D5uSoXGe9ETZMAU8GYQWxeUJDDkpE
	 P+44EhbHGvqqV6o3t2yyb5HWYJ3lNi3MLBim+Jxhfhbutg0Ei5zBJOr11cn6AHHjWi
	 gl1gDu71CkCW7I5AbVnTKfSlsnaypVqRHCWMW8MmgswSgxW++7SeR/wZOizGs5fVoV
	 dORS5dtZsDceZ/YzRqje3KXc0PoG3mGpupJ209hwcoNcG4DHQQc3/iUmGjCs5+OtTt
	 SLUWEvm3kEKWA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 25 Oct 2024 11:32:31 +0200
Subject: [PATCH mptcp-net v2 3/3] mptcp: pm: avoid code duplication to
 lookup endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-mptcp-pm-lookup_addr_rcu-v2-3-1478f6c4b205@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
In-Reply-To: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qN92RkiNi/OxsiAmYdeZ53c4pXGuGE8QPi9XPouJqxo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnG2XC2PAR/k8VRNFTiWCaA5OQmTq6eWKEQfhNT
 LdUJH0OIn+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxtlwgAKCRD2t4JPQmmg
 c55VEADYQ5LeVoGUrqLGjPoO6rJDQCdDafZ9t0K3Sn3fP8VRkSqqJa3sA70BRYtu7fgjIPOxC6h
 mILOca9HXc06XYIdQsQVnm4QsJktvGZcWx4BED6AIOKgZIEtoxBddvIqfqF5iA/7Gwahm9tsTS5
 DovFWJK8RFqg/DN5KkKInFcLML2H3k1I6UKOcVuAgrQfWZUz1mFe85n8yy/1bYIq6qbGePiYAun
 nGT7L3HOTOnlQVjV+pByYoIkDn5hDclKJSdl1MT/TYb/bmJf0I9Jro5tICEj0lwHDe7UGD78vTV
 wtoOJGFabM9/D3Kn9fDSHr/3V7aMNupFUhsnJW7wi1NwRzwMKT1k3nzjWNqtQlD/dK5vs0MTLi9
 +BEkwWJQjW4zfp59f+jUitMItQQCIscjOrxOG1N6mCYgNTq3mzz0KpezUTl1OmzUQqyNKrlIjSQ
 XFvxcmBCdg83SkSX4CAsEzQ9nvFBWJSWxPw18zfPPDmk9qkEc9tdSffy4MSrK4k5Nw7BCkb6VqV
 ojV29W1KUWgP+dO8Kl5hAU5zrY+omcdQ9t0utcvqbYshwDmNXUUfy22G149BPGDftycIprIMpvd
 PaQIewVcCxjx1Y3EfELXXjekCh3AXRehp0wanB8ThkMiHP0pqdR254NOIhvp62yRBO9xMwVWCak
 lCWK+XqUtoXHI2Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper __lookup_addr_rcu() can be used in mptcp_pm_nl_get_local_id()
and mptcp_pm_nl_is_backup() to simplify the code, and avoid code
duplication.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Notes:
 - This is also for -next.
---
 net/mptcp/pm_netlink.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f38e1ccd34e95cd88b179a8b50e6965731542871..7c6e664b236d1659a554d003c78c72ec91895ba5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1154,17 +1154,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	int ret = -1;
+	int ret;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
+	entry = __lookup_addr_rcu(pernet, skc);
+	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
 		return ret;
@@ -1191,15 +1187,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	bool backup;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = __lookup_addr_rcu(pernet, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	rcu_read_unlock();
 
 	return backup;

-- 
2.45.2

