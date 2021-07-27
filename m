Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E072
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 07:58:30 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id t21so14717762plr.13
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FUY8ElhrCLL2b33BQwcGX7MNDnAw4hdyPuQgL1INlM=;
        b=ASUa9wPmrKVcamQFx3T+mZewNQecwDbS4oqp8G5oVD+lcHu2Qo1YJQr3AADRq6SKKs
         voEJL/i7t/znpEmh6NGgQ7wTOBF9S5Mi7bbp94tFkwb5zPzdErxXWFlWnZWcYutBjIJA
         MYuDI6dj+ApcpEqNyoYj61PmNxB2S0dzyk+CKTLadQeiyIIrZeSlBMtUwFPyrEkJXu12
         thzjs/qqPDVZjNBYTc2V8l12XEIyr18c/5NndchkN/ge13WPA4yjr2bgzCu99+SLcW+W
         eQzqtbj/mvTw+jXEWAEvVHgcq9ROA6Xqcozd0GiZTvd55W1utUujTwPW0bprDsOBhslS
         9j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FUY8ElhrCLL2b33BQwcGX7MNDnAw4hdyPuQgL1INlM=;
        b=DJchTXnDcknlcEllwl/DXCQ478UBVDdok3RSNqFQezhXIWh92sbAabp5+/YJukJmvp
         uHNvaBqR/7Y+ceT523ru7tcgLGjD1eEUA5uFf9oOrhG2dfGV1xvdFWbyKI8wwW4uZ+57
         auVPiuZjix9UhcqvK9tcdS+Tk7/TrPRAfEH8uxM8JX5X+L/LARKNcZx06YTphpuqLMGl
         HZRu0RRjWW2lmCEeOXw1tO5AmHTVjSIedFT2ryGJ3F/PcIRiySWiIF+H6631Vu8XchAT
         W67/RMtKzgGXJ/kIz/kdf/28b9Oe3kLmeiFUsej25vQ6A+wFLmY75jYkCDEG9QSevFbw
         2NCw==
X-Gm-Message-State: AOAM530h5HjqRpP6UM9wWbwMkDSjMRqRyfyXrEls21RDL2lXjjvl7ShA
	rKYcFkkpQkf9O/ozq8WWfALqegS1dVc=
X-Google-Smtp-Source: ABdhPJycK6USpTfK5Loi7Su79OOWvwWllft3TivctT3U4GNiHSKKMSgn00edRUBjSRhdw9GFAEdkVw==
X-Received: by 2002:a65:4386:: with SMTP id m6mr21900529pgp.430.1627372710452;
        Tue, 27 Jul 2021 00:58:30 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v9sm2544537pfn.22.2021.07.27.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:58:30 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: remote addresses fullmesh
Date: Tue, 27 Jul 2021 15:58:18 +0800
Message-Id: <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added and managed a new per endpoint flag, named
MPTCP_PM_ADDR_FLAG_FULLMESH.

In mptcp_pm_create_subflow_or_signal_addr(), if such flag is set, instead
of:

        remote_address((struct sock_common *)sk, &remote);

fill a temporary allocated array of all known remote address. After
releaseing the pm lock loop on such array and create a subflow for each
remote address from the given local.

Note that the we could still use an array even for non 'fullmesh'
endpoint: with a single entry corresponding to the primary MPC subflow
remote address.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 80 +++++++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 7b05f7102321..f66038b9551f 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -73,6 +73,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba0e1d71504d..2259c424485f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -158,6 +158,27 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
+static bool lookup_subflow_by_addrs(const struct list_head *list,
+				    struct mptcp_addr_info *saddr,
+				    struct mptcp_addr_info *daddr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info local, remote;
+	struct sock_common *skc;
+
+	list_for_each_entry(subflow, list, node) {
+		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+
+		local_address(skc, &local);
+		remote_address(skc, &remote);
+		if (addresses_equal(&local, saddr, saddr->port) &&
+		    addresses_equal(&remote, daddr, daddr->port))
+			return true;
+	}
+
+	return false;
+}
+
 static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
@@ -410,6 +431,53 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
+static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
+				  struct mptcp_addr_info *addr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (addresses_equal(&addrs[i], addr, addr->port))
+			return true;
+	}
+
+	return false;
+}
+
+static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
+					      struct mptcp_pm_addr_entry *local,
+					      struct mptcp_addr_info *addrs)
+{
+	struct sock *sk = (struct sock *)msk, *ssk;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info remote = { 0 };
+	struct pm_nl_pernet *pernet;
+	unsigned int subflows_max;
+	int i = 0;
+
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	if (!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH)) {
+		remote_address((struct sock_common *)sk, &remote);
+		msk->pm.subflows++;
+		addrs[i++] = remote;
+	} else {
+		mptcp_for_each_subflow(msk, subflow) {
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			remote_address((struct sock_common *)ssk, &remote);
+			if (!lookup_subflow_by_addrs(&msk->conn_list, &local->addr, &remote) &&
+			    !lookup_address_in_vec(addrs, i, &remote) &&
+			    msk->pm.subflows < subflows_max) {
+				msk->pm.subflows++;
+				addrs[i++] = remote;
+			}
+		}
+	}
+
+	return i;
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -455,15 +523,17 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
 		local = select_local_address(pernet, msk);
 		if (local) {
-			struct mptcp_addr_info remote = { 0 };
+			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+			int i, nr;
 
 			msk->pm.local_addr_used++;
-			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
+			nr = fill_remote_addresses_vec(msk, local, addrs);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote,
-						local->flags, local->ifindex);
+			for (i = 0; i < nr; i++) {
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i],
+							local->flags, local->ifindex);
+			}
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
-- 
2.31.1

