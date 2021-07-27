Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301372
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 13:24:42 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so4302657pjb.0
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LthFdDtSRIje737QCuFexJkWpiRWrLNduLEWprPiZ4=;
        b=IDm0AuwYHFVSt5APWUga3Y8uAiMwz0AABBS8ZJz8VXF9mFyxzfmmt5qHJPsbocM1k6
         944VEhV3uawCsrLu07nlOdnbqEZkkxLLiV8YPJQYV5p56ZejLDhB4jhGugt74SdMvEDX
         LTaCLgt2OznEtubwT+Rhtg7XaqXH8e8yRx79HgMOMouCCBgP/WKsx0JqYN2eFZFPnbsZ
         DAIoT4Xn5IzEthx3pGIGN/l2KA9+kfZrK27DTc2otlBjrcwBgdFrVpn7976WeGLtamN7
         1jcxe6zFncG/zespTbjf/vlM+mefo6fGJ0NCWiQYCkniAEJQf7rOGMs8QY1PMWEsWDCZ
         9yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LthFdDtSRIje737QCuFexJkWpiRWrLNduLEWprPiZ4=;
        b=RRFrqs5v8x3eMNEhzBSm6KVXROP3ax8cRD8TLv7/1KsbzcMW5dQ3PX8ko5emkHtELN
         eB60cm5UXZsb/PKNsI5ni1V7t9gkQjf7hXyRWoefExlLkpUCg6Zu31tHGiMsve3fNIsk
         6WwPjtF58rkun1kZN1S1BdRROGTmspwWNUZWYrVTqTPbnf3zQJl9/QRRTdI2ofLpWCXL
         /e/UgSeD89b/sni4GDNdsWJCSyc9gHcY4zvyN3uXAX2G8/N67/wApbLtB3nvuNjeT3a9
         Iawc/piazBXGH+O1JaftmYcUVnIDfjbeMfVAw52+2tW0drbQm/Jl08hPJHIk7jVdVYSn
         VoDA==
X-Gm-Message-State: AOAM533CMTEjrc1FE56WmJCbpSzh9T1ptdhtxMG3nHxGF8dDfyx8mQDL
	+yFPDVC71w++cjs1jKmTTmmhg77TSxk=
X-Google-Smtp-Source: ABdhPJwlPsNjegXtYfcPT05J0J3lc4lNWgXXvQe2ww6UZsNUoz3PWMJ6sd6t3QF4KUDh/9WmClc+8g==
X-Received: by 2002:a17:902:fe97:b029:12b:e3f2:f5d5 with SMTP id x23-20020a170902fe97b029012be3f2f5d5mr15255203plm.74.1627392282466;
        Tue, 27 Jul 2021 06:24:42 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j13sm3511066pjl.1.2021.07.27.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:24:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v6 mptcp-next 2/5] mptcp: local addresses fullmesh
Date: Tue, 27 Jul 2021 21:24:30 +0800
Message-Id: <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com> <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c | 81 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ecf43d45711a..b2d2256f2abd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -538,13 +538,76 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
+/*
+ * Fill all the local addresses into the three arrays,
+ * addr[], flags[] and ifindex[],
+ * and return the arrays size.
+ */
+static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *addr,
+					     u8 *flags, int *ifindex)
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
+			addr[i] = entry->addr;
+			flags[i] = entry->flags;
+			ifindex[i] = entry->ifindex;
+			i++;
+		}
+	}
+	rcu_read_unlock();
+
+	/* if the array is empty, fill in the local address */
+	if (!i) {
+		memset(&local, 0, sizeof(local));
+		local.family = msk->pm.remote.family;
+
+		msk->pm.subflows++;
+		addr[i] = local;
+		flags[i] = 0;
+		ifindex[i] = 0;
+		i++;
+	}
+
+	return i;
+}
+
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	struct mptcp_addr_info addr[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
+	int ifindex[MPTCP_PM_ADDR_MAX];
 	struct mptcp_addr_info remote;
-	struct mptcp_addr_info local;
+	u8 flags[MPTCP_PM_ADDR_MAX];
 	unsigned int subflows_max;
+	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
@@ -556,23 +619,21 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
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
+	nr = fill_local_addresses_vec(msk, addr, flags, ifindex);
 
+	msk->pm.add_addr_accepted++;
+	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+	    msk->pm.subflows >= subflows_max)
+		WRITE_ONCE(msk->pm.accept_addr, false);
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
+	for (i = 0; i < nr; i++)
+		__mptcp_subflow_connect(sk, &addr[i], &remote, flags[i], ifindex[i]);
 	spin_lock_bh(&msk->pm.lock);
 
 add_addr_echo:
-- 
2.31.1

