Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683FEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004139; cv=none; b=cS58upIJobgmnvF9zvEuPy+kazEc3VUtLzaLGi7CMi7A0PjntCAOqnwmtur0qzwux0LEBG38mpmS0SllMFQqeQXUUOzkk+huMdoDHcUUwPYn4E15VAFjqcEpj5vugkxFdvekNtguHY/bP/H8WR7WMckcHhx31issG7pIIfzouB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004139; c=relaxed/simple;
	bh=DOHoy8izdqQ/61q3Mvd3BLf7aV7oytJb0i8xgA4dX4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFYxPOO9K+g5o5dZWO5OL/dk/nx9Yzz6ymVxpYHr8eejRw57o9Tegy/n3dR1/r1EknaXL+aTPC5D8lOkPJBEtRd3gnQmtX60I1LKrUGXJO9nI0xw6PzPbtBEzaoNnLvwKwPS2GPGWoFwEExgKfDg9gekZKxlYMpY2poVsA9U9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ourX3/PV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ourX3/PV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0230C32786;
	Fri, 26 Jul 2024 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004139;
	bh=DOHoy8izdqQ/61q3Mvd3BLf7aV7oytJb0i8xgA4dX4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ourX3/PVP6Oq65ziT/twv+jmUHaiOhK5f+XJRogWX7zbw8rrrTuQ5tkilRDkMqVtL
	 vQm3gXpNJGEKyGrLnos1f+o34Ue76SlO2TqztHJmAlTrk9spm0Lv0zdPHhHbkLzqt8
	 ymUsJ5xvaHqczXM0gcpIsdTfHQ1nBKamrZEwVSIs/gOjiwMihb5L99ckx1FnYT5Qag
	 wQ9HkZ12TOcgtIMd6KKpnw6FO2y91rtTEs2kTP76CwrUSm2m5L17uCqwgNYfaRAhJp
	 ycsXa2rdRTVbYjbdepFcX0uS3vvYtjS27I/mETYGoVDyOotHfPqGPGRaHSTpFolLwO
	 fynmQRakALlrA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:36 +0200
Subject: [PATCH mptcp-net v5 10/13] mptcp: pm: avoid possible UaF when
 selecting endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-10-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5548; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DOHoy8izdqQ/61q3Mvd3BLf7aV7oytJb0i8xgA4dX4k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7Kc6y7SoE19SQ5BkxzNeODhKiZJRUvhaKTqd
 nOK2Fklm4aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c4pID/9ZRPGgac4+FXnYUPOsVLQf/bpbfrgfSyLR26AYn3sshOWHv1t8lnG5gpoEwYh94mjbR+x
 ACjvlXf+RabRxfSY6yK0McMjVeIi6RyWH0swJ1Y3RhjuNBFXAyAnbkkRoryYn7n9e/slBywfjn/
 8+p73CTJoyZK/B3yz8nLw4G2QvKa4IiwOvOFanitUyZVUkZaRov9lW5VcN02/+axcYkLCBdiQ2/
 GtZAmHVgonlGvAmgcl/6W3+bxbrpcoufNCeQJs1k2yl4L2C86ejRZ2wwJae3cvTR5OWSG849OlV
 uXHukibZBsab+2oSluuU53fqTZDnY8XJd+WlMIYq5BDnjETDQR4MpRkpFapi4fHdgVAgk4Hrhkw
 Ps4MCAu+qyz50vr98EhukD7zkOzApmaiix77gYqcI/EMzFZOwRD5Mylw2t57+pLozzz1mlnR7t2
 1dVgxjukIpORKqaBAa3CgIDX9O4LtEtrZNJAx2UMHRA8o/oXLcj/2iPKerbgFuoxt6ja0VQnUwe
 qjyR0gXRuL2TQWgQE66JUEdw5e8OLAF8o58hJnOqUHGHvR6WwOrtLNRq+z7Qrwal9mqbc20jsb5
 85EseFV/xVeXp2TsjYz2o/HCAXEjhtP2ROnIXV/pQv07mnlyZuSFmZ/7vj5xdTPrm9mThqMUGF4
 IneA9ueSnmfm8ww==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

select_local_address() and select_signal_address() both select an
endpoint entry from the list inside an RCU protected section, but return
a reference to it, to be read later on. If the entry is dereferenced
after the RCU unlock, reading info could cause a Use-after-Free.

A simple solution is to copy the required info while inside the RCU
protected section to avoid any risk of UaF later. The address ID might
need to be modified later to handle the ID0 case later, so a copy seems
OK to deal with.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v5:
    - fix typo in title: s/whend/when/ (Mat)
    - avoid using memcpy() when not needed (Paolo)
---
 net/mptcp/pm_netlink.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bc9c2e40881e..0dacf16a4b53 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -143,11 +143,13 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk)
+		     const struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -159,17 +161,21 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	rcu_read_lock();
 	/* do not keep any additional per socket state, just signal
@@ -184,11 +190,13 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -512,9 +520,10 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
+	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
@@ -565,23 +574,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		local = select_signal_address(pernet, msk);
-		if (!local)
+		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
-		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-			signal_and_subflow = local;
+		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = true;
 	}
 
 subflow:
@@ -592,26 +600,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		if (signal_and_subflow) {
-			local = signal_and_subflow;
-			signal_and_subflow = NULL;
-		} else {
-			local = select_local_address(pernet, msk);
-			if (!local)
-				break;
-		}
+		if (signal_and_subflow)
+			signal_and_subflow = false;
+		else if (!select_local_address(pernet, msk, &local))
+			break;
 
-		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);

-- 
2.45.2

