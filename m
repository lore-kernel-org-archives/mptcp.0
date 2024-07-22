Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82DC17164A
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676976; cv=none; b=e/sxixbsespzAZ+z0rf2OBY47kBdCwm6YgqtuktPulR5xQU+Ten4by9s4D2lBTThLAwmNjeeHUNAn4jvyAJSl0VDmz/wYXow3AnG5lIvvvFGUWAxnFkzrYVGcreFIebbsxpDDckYXcLXIAGRAQ1xRCn/SUesPCjzURTU5FJ+agI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676976; c=relaxed/simple;
	bh=1aSC34adX9MvBBLUjIdTdbm+F8mIL4DdjnonVqglugc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GagUdYQfQaq5JvOflcD83UjuKppYZXGLvUQxJJ2aWJZzxTPi0DRz8H17nBlxz577u2Tc1R6ReiKVoScbfUOtGGflNM4O3rkFDVyHsea6+zqIrSZbGMHz4IydNR0UEPpdQhHb47LWn/uCiSWWyhfcAfi1ldz0g8YMVeI/k1eJmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j30kiuFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j30kiuFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EFFC4AF0D;
	Mon, 22 Jul 2024 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676976;
	bh=1aSC34adX9MvBBLUjIdTdbm+F8mIL4DdjnonVqglugc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j30kiuFzpGa36x5YtEe1wry/lgw+JzoFH0RRqq6zrPefaYnBPJ2w3+IvkM5uH0NMO
	 c1VcK7t94r2A5o0RkdOz8CRC0gDuVBItxTNi9SVQl+BMVoANAM+2INsDxeUYxL6BAt
	 raWazVHBwkv8wnC+QyZ+Z7PUzIQgdaJDV12gn+1erggxKlM+A1SLg8AGlUotD5Qj7o
	 8HaNnLB5ddSkeBd/KGZn4/hCh8/dqPfMrq+SSD9BiCRMOtYoyX8RvaJjPqgytT+eJQ
	 IMNhc48KAe/h/X/RLQlxxZD0Ha2K7R2bQMBNQ1iZV9ZRAysXSSbqDf5R+HD6H6/uBJ
	 p3828bj0AsmOg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:59 +0200
Subject: [PATCH mptcp-net v4 21/23] mptcp: pm: avoid possible UaF whend
 selecting endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-21-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5510; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1aSC34adX9MvBBLUjIdTdbm+F8mIL4DdjnonVqglugc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXp12qiImCHuEWJCz1w8Jw15HDnesBV0PDF
 W20oJ1/j9uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c5yOEACz+6QeARyfdHTekFXr95XZWB9EDAvYdl28miIZBR6dVnAtIAWZOFg7PFVVftnG72rNtIk
 TBhCqAFx+Mr49T64jFizvr7XqEbAwRVUdAZAbkwDz4Y/vTGz1HFo3QxodE8FDU3z9CzQ+JmBdq3
 poryaKqPMX0Z7x2JLrsmdnukib4/AA+Nv6n8z6oSRgKycRGdlLy8m8aU5ewCfayvcIa4yMyhI16
 z8EwKYfI+L3AnLgSL3QOqdUk5//h74VrTqO5kK8rA/pn+v6BJE379ZaXIURdZLGDUAsodyyp0Ej
 uP+i7yafDVbzPGg00FeJ8CI7xb8HolkrI46vA3cUrt6+N/4MQF4JINZpaNVkpQAhR88pnXU9MdM
 LDGk4kfa6KI7ALf5rdTGpvmoDGiPPuOdgaWB461fhNajJZJ5zJC/gKh+Ij88uwBNQ41XTD0f/kO
 rrsfV5ipcqKDDVxq9H/sULxmZtJgBjr/SdyZzTOC6ZnqyllGXHY9xOJFwiT2lxD1dtn1U7QsuYB
 sBIZOC+Lp3NtwiNvkMDzT2MW0Bl2OshWGQLNRidSP9L0rf6SfvVQEfJkAI0LZuR0KrKGP4nZ5Y8
 w3M+dD2ExPfvhXxn+jaKKDg4EMlC+fhmmhf+9bUjovC2NELrWNu/EyI53qzVsJEM/BT6Zjq2l4D
 7vTDVba4EVZvOrQ==
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
 net/mptcp/pm_netlink.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2c335202aafb..8f25690a5edc 100644
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
+		memcpy(new_entry, entry, sizeof(struct mptcp_pm_addr_entry));
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
+		memcpy(new_entry, entry, sizeof(struct mptcp_pm_addr_entry));
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -513,9 +521,10 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
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
@@ -566,23 +575,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
@@ -593,26 +601,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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

