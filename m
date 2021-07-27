Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CE72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 07:58:32 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id b1-20020a17090a8001b029017700de3903so2313617pjn.1
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AGeSZTpZr2k0X+vSH9R2x5Vbr1BVrgIBNacgm/ZT6M=;
        b=iytmLxS1pEOCQKpXzC/kxC242C0KaYxoFm0hl2A0lPYb1/vpz+6PqVqKkFqdWgNpX2
         w+UiJ8bq/+fKbmuNa/SHC4pm72A3I8wAF/1CfQw5piD3b3klJOTkUF13/HCPsn4LdX4z
         33jZxBLiK2Zp83V5+Yn15kglNVu0nLSLeQCtNDJ7galj1HSWpPklgciOqUC8VuTpNXMg
         ErsCLDEePUn4Tvz5NeO+hrU3uT6mkSok71ydigF+3Ze9PRm1iQvhN0A9M2L8tcpJwqQY
         R4rCIVX7RJQXFoao0D//xd/LhAcCfxgQuWkujV/dUT4hlLYvE6R5jpmMhpokGvMBmT7A
         MU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AGeSZTpZr2k0X+vSH9R2x5Vbr1BVrgIBNacgm/ZT6M=;
        b=BzE8JKd8onQLltydmlsu0mcLbHVF/j3FbzlBwF5SA+mhJu9YtsaxpGiNRwW4r4K4pt
         GidfNA4QO5uXvlKhKubKweXxfvbaQh9U6aTBFPxJwhSuKG/+6m5x2Q+vWQc/rYvzyyWZ
         M73hzXXn+Dpn/CCg8P8dp2DLWpSNzBN8RtzzdUilZplXVFDnf/uL6V7OHYKvJokByVUh
         0V3Ndd3uqnGIKrMrcUK1Q/lTiLbRBHQNfLLA87xFod1nn1UGM322EUQ9fAyIy/x7QYro
         uifF/l3luQ3UdkRM82swODHx9RqbLZRN+vCWqPM2Eg4zun4FcvhDfkHjCXay/EujnnrJ
         pgRg==
X-Gm-Message-State: AOAM530JiHXXCEGTRs0cu2hpIvbLvBhwGgwdBT8Eel4iP6Q0hCmJ383O
	4aS00oG966KgXQXiesJYY/y9c4zY4iU=
X-Google-Smtp-Source: ABdhPJz0O2Rxdo99DfR843115QbrDQttCdLYgN+LTx5kMPTSl1E2wdsLsxBP42k7YeFvWiLUKU1BAA==
X-Received: by 2002:a62:ee0f:0:b029:335:a681:34f6 with SMTP id e15-20020a62ee0f0000b0290335a68134f6mr21796905pfi.55.1627372712477;
        Tue, 27 Jul 2021 00:58:32 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v9sm2544537pfn.22.2021.07.27.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:58:32 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v5 mptcp-next 2/5] mptcp: local addresses fullmesh
Date: Tue, 27 Jul 2021 15:58:19 +0800
Message-Id: <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c | 60 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2259c424485f..a85bac950f3b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -554,13 +554,62 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
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
+		msk->pm.subflows++;
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
@@ -584,11 +633,12 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
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

