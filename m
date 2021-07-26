Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C472
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:12:38 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id e5so8111413pld.6
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 21:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwzUVmV/Ns4rOlsowWueyz5335N3kUx3Uo2uSMHtx9I=;
        b=gTzORcy/sFw1RibHwbFUvdZ7ggGp6UxrxkOENILM6VoLW8AsfKR1je1l1BCgkfdJQo
         lWJIuP1N8u5AsVwz0Bn0tBPuzLYnQTtR0Lrp6qNAkZwgGLxAESAztZ7lbiwgmuG+rT3m
         AAKFZw9m+nyKjhTHkZsIFMxWxPZSTL/bd4OxAvAOSrWW6DdnaSmS+LHrVrN1dsg1mHzq
         T7gsT5XMEnZ7hif8flim7PHUbP1dzXw+9lcvNvJqGG8fI5YswHc2c0ZT7fV36adKsTy7
         SSrrmHT/FhzhTqcefALi82TExvsWGR7/wOKFhclhuc1F6t07QZ31IVv+51AzQd+bdGra
         7UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwzUVmV/Ns4rOlsowWueyz5335N3kUx3Uo2uSMHtx9I=;
        b=BVEh5TAp7LG4IkDWu/yPFMCQTUE/Rg+rcaCLahHTaEFe0ulnPgfZKA9YMeA3Z25vB9
         gvoPgkclwwY1SGqReTusMH7JtNW1gBHJg9rijtj24qjmQAHgZnmly0XabuaWtKelV6df
         8TfN8SL+uoZ2RJqR0iOB+kyhV2siM6Vd337Bo3zNjOmlZUFeEdV+MB9MJPIwjVsVp5ic
         uRzWmq9Pc3VL+QvsX31UvZWTBAvtA68aLMy+epL5B2BQDgNlTkHa0axFOKD8HiNGOZ5Z
         /bsQUX0fHWRBWxjJscqGN6XKGqlOB1MSc+D6XnA1CgWL7YKup+jPIpBRPo8g5YxE2fQ3
         scAA==
X-Gm-Message-State: AOAM533rpZFcj9ul/izRpssIN7+THw9X8iEDoHDfJPJBenVZb0epOAzV
	84DrrRTKrKKXWY160XlfIa9qJg0wQs6Juw==
X-Google-Smtp-Source: ABdhPJycf8KPy34pVAdbpSz1v8zxEV89i6ndXNV8vE7GGCZxJXGwOa68SYVQoNhN0jcZdIYkLLGWKw==
X-Received: by 2002:a17:90a:bf0a:: with SMTP id c10mr15226834pjs.59.1627272757997;
        Sun, 25 Jul 2021 21:12:37 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f3sm2608543pfe.123.2021.07.25.21.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:12:37 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next 2/5] mptcp: local addresses fullmesh
Date: Mon, 26 Jul 2021 12:12:25 +0800
Message-Id: <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com> <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f57db5b9a50f..a03e8fd3a584 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -526,12 +526,17 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
 	unsigned int add_addr_accept_max;
+	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info remote;
-	struct mptcp_addr_info local;
+	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	int i, n = 0;
 
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -555,10 +560,34 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (!remote.port)
 		remote.port = sk->sk_dport;
 	memset(&local, 0, sizeof(local));
-	local.family = remote.family;
+	local.addr.family = remote.family;
 
+	entries[n++] = local;
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
+		if (!lookup_subflow_by_addrs(&msk->conn_list, &entry->addr, &remote))
+			entries[n++] = *entry;
+	}
+	rcu_read_unlock();
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
+	for (i = 0; i < n; i++) {
+		__mptcp_subflow_connect(sk, &entries[i].addr, &remote,
+					entries[i].flags, entries[i].ifindex);
+	}
 	spin_lock_bh(&msk->pm.lock);
 
 add_addr_echo:
-- 
2.31.1

