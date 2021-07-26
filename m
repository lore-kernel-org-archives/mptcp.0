Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93032168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:08:35 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d1so3847253pll.1
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxgtDl7wP8IvVyHWQPgzg9R6pBxZ2yfCotnr8Hw1VYU=;
        b=nV74MpkUspeiznhEa4fKLUAJvDjGLsta0PIXe24z3eOG2UYPdGqE2e79p9owSfDpYL
         nadTWhrQq7d+yHn653JcWOqDpejrde9dl++OGKAfTdmEOdTVw5aQG29SpM9u1y5lVdnV
         /yjZGExGv9QO/ELJT1JSfr68QwhDco5lQDP1Eh0MeX/aTKYOpIr/OUC8Vy8SJ71E1g97
         XntHmefgMzwvxxtZQfcV0mmkjjNGOIPWSMWSjjMImkIWBdsBxJvNFZc57bo9f85UQcrM
         tJ3FhNz79JgutOsBAdtLSttuvaVv5sIt8QesWVz40w8kPCiafA1PHoG35xSpueNoVule
         R94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxgtDl7wP8IvVyHWQPgzg9R6pBxZ2yfCotnr8Hw1VYU=;
        b=OMsIHLcBSX0IpOwVtelV2/q+gLzLE2qHnWVyFq3HPoz9SmoCCCRHCGtq0xarN1NiQU
         +FWeHghRi/P5bdwn7JReuqpwOy+4fccEOEe17J1ZuVRdnIEb4sGZHY5sO8IGrCYLp80E
         BbDpDSG2wuqU/GTjIKOvELaqvkR1cDtI582KOGep5Z5oXDb8qFmB5C/QuHjNb/24vTkS
         //kFsHOlfe8FF4cfEIgv74W5bBf2/ePFSrEDB4yWfMZPza//d6mvYkaX/vMe3QkHD0xA
         BAMcGwMsi7cr6yjF0hGZUDAqPvjNy/YmwXFO6paTYbx562ORlfsRmfARdCDjMUwV1SVe
         5ptg==
X-Gm-Message-State: AOAM5337axSP8C+ZdYvmxfCfPb/Q1LgfNQkce2tyqSWjhwEAjz1n+ySP
	qHHFW/zbw9ARR9qrQ1v2PM1WXcfZwLf9ow==
X-Google-Smtp-Source: ABdhPJxpJeHI/qU/TabLcKeYm8s3cEZd3zQ9lpQIbANttd6zyS/l83sv99sc+QFeFEwC57hk3jXUwg==
X-Received: by 2002:a17:90a:be16:: with SMTP id a22mr492613pjs.169.1627297715163;
        Mon, 26 Jul 2021 04:08:35 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e30sm50282700pga.63.2021.07.26.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:08:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v4 mptcp-next 2/5] mptcp: local addresses fullmesh
Date: Mon, 26 Jul 2021 19:08:23 +0800
Message-Id: <afc79f9b4d6b8afb6492a52e9c1ccdc780fcca90.1627297096.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <457db25d2c745babb98b8f29c6d2ace3d6348ff5.1627297096.git.geliangtang@xiaomi.com>
References: <cover.1627297096.git.geliangtang@xiaomi.com> <457db25d2c745babb98b8f29c6d2ace3d6348ff5.1627297096.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c | 59 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2a09d28d98be..10f09a96952b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -540,13 +540,61 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
+static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *remote,
+					     struct mptcp_pm_addr_entry *entries)
+{
+	struct mptcp_pm_addr_entry local, *entry;
+	struct sock *sk = (struct sock *)msk;
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
+		if (!lookup_subflow_by_addrs(&msk->conn_list, &entry->addr, remote) &&
+		    msk->pm.subflows < subflows_max) {
+			msk->pm.subflows++;
+			entries[i++] = *entry;
+		}
+	}
+	rcu_read_unlock();
+
+	if (!i) {
+		memset(&local, 0, sizeof(local));
+		local.addr.family = remote->family;
+
+		entries[i++] = local;
+	}
+
+	return i;
+}
+
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
-	struct mptcp_addr_info local;
 	unsigned int subflows_max;
+	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
@@ -570,11 +618,12 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	remote = msk->pm.remote;
 	if (!remote.port)
 		remote.port = sk->sk_dport;
-	memset(&local, 0, sizeof(local));
-	local.family = remote.family;
-
+	nr = fill_local_addresses_vec(msk, &remote, entries);
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
+	for (i = 0; i < nr; i++) {
+		__mptcp_subflow_connect(sk, &entries[i].addr, &remote,
+					entries[i].flags, entries[i].ifindex);
+	}
 	spin_lock_bh(&msk->pm.lock);
 
 add_addr_echo:
-- 
2.31.1

