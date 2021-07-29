Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588C72
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:06 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id j1so8982867pjv.3
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B68x7vyF6aiLCTG6YQXZBP4wuxZEGgElPeaKR1afKBk=;
        b=CCAz2gHr1nuKfxBaOyxz0m/1gMnMoWGOKmS75Z6IA+pGqYPyuvjneYv671uEkMSDWX
         A6dsoXaD2j7EJE9UkHVQ4GwgBLN9jP9busybo2QcbLIac/x97iVNbhWtG6LQZVzaR4no
         ifyBoQWMrRVw2JgovHGzEsJUG4epW8ciKSXgSDCvFjzZnkmOkSZJztsyHKjOhVErLyNS
         FO0/Mct5Jn3wl7Ja0K7sJYcnOHACIbUaWOFYHTuY7KGDmXw79XGnK5QfBB91ihMJZ4Of
         pvjhJM4AExKhWxZ//khzme/SR4D/84nm80gBDlIVP4sGuGVTAqmPP1TU60GzsM200PcF
         FCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B68x7vyF6aiLCTG6YQXZBP4wuxZEGgElPeaKR1afKBk=;
        b=QBSTCWH+Qvh8JX4wJ0ahwJIHRGfP+eTioBGp//1yGTpnTR5CRTIeYXOZk6S1WzYPpG
         1yS8ld6F7gQfNtI4jRMty681DHYQ8IrBts16XAVGPKCPgssWnTJllxcHjfINmOi97PJz
         TFQ843rme9b0CyL4q9jQE2alOQNtKeKKHolLr73fZZ7S65IYz252BEnTFSzvQwdcYBd/
         +hlgaN2yay4VICWolyrjgPO2gHz0/RTK3gkTRYQqfpi6FWTeMbAIOkgkC8zb0k27lpNM
         sDrFZUkz52h0JbKQp0QNFQIaeAoqBFPvP7c2UbeL6UL1NzBdVTq24/FAToHqOTdlM+Gm
         R3Qg==
X-Gm-Message-State: AOAM533GKBMWpZznVDzVn8agbGdCetdwfaJXeZaQWRn4ZgJBPQPJMjf+
	hDcCNDjDBEThbQAXfM41Tex76zKOY1E=
X-Google-Smtp-Source: ABdhPJybxpqMdndgWZRTbly8C/hfUjBioTiznTzmtGUZ+DUFKarg30O1CNFlPkXeG+SOGXgVqx+5MQ==
X-Received: by 2002:a17:902:c643:b029:12a:e698:f74f with SMTP id s3-20020a170902c643b029012ae698f74fmr3313897pls.60.1627543266313;
        Thu, 29 Jul 2021 00:21:06 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:21:06 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v7 mptcp-next 3/6] mptcp: local addresses fullmesh
Date: Thu, 29 Jul 2021 15:20:52 +0800
Message-Id: <349c97cf4d1091f28aa62e8200ebfe4fa0f5f2d5.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <af7def3b48c96f1f0c68360326d2e9cfe2500826.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com> <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com> <af7def3b48c96f1f0c68360326d2e9cfe2500826.1627543032.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

In mptcp_pm_nl_add_addr_received(), fill a temporary allocate array of
all local address corresponding to the fullmesh endpoint. If such array
is empty, keep the current behavior.

Elsewhere loop on such array and create a subflow for each local address
towards the given remote address

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 73 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 77cab67e732d..b0be7c9477d7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -536,13 +536,67 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
+/* Fill all the local addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *addrs)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info local;
+	struct pm_nl_pernet *pernet;
+	unsigned int subflows_max;
+	int i = 0;
+
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	rcu_read_lock();
+	__mptcp_flush_join_list(msk);
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
+			continue;
+
+		if (entry->addr.family != sk->sk_family) {
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			if ((entry->addr.family == AF_INET &&
+			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
+			    (sk->sk_family == AF_INET &&
+			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
+#endif
+				continue;
+		}
+
+		if (msk->pm.subflows < subflows_max) {
+			msk->pm.subflows++;
+			addrs[i++] = entry->addr;
+		}
+	}
+	rcu_read_unlock();
+
+	/* If the array is empty, fill in the single
+	 * 'IPADDRANY' local address
+	 */
+	if (!i) {
+		memset(&local, 0, sizeof(local));
+		local.family = msk->pm.remote.family;
+
+		msk->pm.subflows++;
+		addrs[i++] = local;
+	}
+
+	return i;
+}
+
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
-	struct mptcp_addr_info local;
 	unsigned int subflows_max;
+	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
@@ -554,23 +608,22 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (lookup_subflow_by_daddr(&msk->conn_list, &msk->pm.remote))
 		goto add_addr_echo;
 
-	msk->pm.add_addr_accepted++;
-	msk->pm.subflows++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
 	remote = msk->pm.remote;
 	if (!remote.port)
 		remote.port = sk->sk_dport;
-	memset(&local, 0, sizeof(local));
-	local.family = remote.family;
+	nr = fill_local_addresses_vec(msk, addrs);
+
+	msk->pm.add_addr_accepted++;
+	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+	    msk->pm.subflows >= subflows_max)
+		WRITE_ONCE(msk->pm.accept_addr, false);
 
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect(sk, &local, &remote);
+	for (i = 0; i < nr; i++)
+		__mptcp_subflow_connect(sk, &addrs[i], &remote);
 	spin_lock_bh(&msk->pm.lock);
 
 add_addr_echo:
-- 
2.31.1

