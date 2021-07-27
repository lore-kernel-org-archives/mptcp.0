Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209A72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 13:24:40 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id n10so15870081plf.4
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C32BesRzz9C4TW2aZwb5AbZ8hMQmCb8SDVOyxafOx40=;
        b=GhP7XfeuoS0QdT4Ou3B2byhU/S5Z/cDfkDFN8hMCXzy4/YCtNyJD07uMnUcWR8i9Dx
         xsE0WgqK8lfc+6tJ/ApYI/5NaeWUf45EE7XOH2+xnRp0Zfd6abqrB7r8c168ZrlUFcs6
         yHP0aj+UKix1r8F9H14qRXsnnKLONkHu4C2hVsze3yzlrmyDWzFhu3uXY5zdWjvga8IF
         3YUCEBtyVuaQALisS1zM3Kp6Ermm32bR1KuoCucmCgfb7wDmeyEqi6wPA3tohIaHvWNK
         tQQtmjqIDs8LS6OjIiWBkOYWCiYqUqBgPj/hNWHuFF7X5ZMOkyLkUIsLktuc2HMBiRFE
         bfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C32BesRzz9C4TW2aZwb5AbZ8hMQmCb8SDVOyxafOx40=;
        b=V1Wqy8ACmvQYJs3u2rrgeSiM1BQWz4i5Pq9ZQLYcYqrj0SYxX6ury+YIZ6nMk1lUzW
         bJLFcuE6YTDz0uL6/gbavM3cP56jOxTjWt3arPvcubFSnAnOkwe+nCw36Rlc1IjwkH+C
         PYUc6X6STni+HNf0+2tSIBYF+Ni4AiRKFdad0yJyhBFCvthE4vEszm0keQnULfspGtnc
         pu30I7/HYprIG0Wi4wlt70qMBdlJo6T5StMt7HwSxnuFIP1EwbMobqyrBtCwN+h5b6uE
         +UQqaEvvBORJ51J76LlMi+vJok3jflMzIUcfc66e3F46vtDrHt4/UgExhVTVkR3fzsAb
         RKOw==
X-Gm-Message-State: AOAM530fJeQ27LPtHvjDUAQ2z569JhaXCsRhyMdr5zQe/YlBM5PfYCxu
	DWml0FSWsj11hp3opk5ZYvg9ev29xDQ=
X-Google-Smtp-Source: ABdhPJwjJ7IGI/qmyxfeOZpZs5gtKsWguJ+YDuKfJb0gDIkvOzYf4GAsjqTybkf5zEz3XShx/jcDdg==
X-Received: by 2002:a17:903:1d0:b029:12b:7d00:7179 with SMTP id e16-20020a17090301d0b029012b7d007179mr18769854plh.4.1627392280456;
        Tue, 27 Jul 2021 06:24:40 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j13sm3511066pjl.1.2021.07.27.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:24:40 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v6 mptcp-next 1/5] mptcp: remote addresses fullmesh
Date: Tue, 27 Jul 2021 21:24:29 +0800
Message-Id: <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c     | 64 +++++++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 5 deletions(-)

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
index ba0e1d71504d..ecf43d45711a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -410,6 +410,56 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
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
+/*
+ * Fill all the remote addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
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
+	/* non-fullmesh, fill in the remote address */
+	if (!fullmesh) {
+		remote_address((struct sock_common *)sk, &remote);
+		msk->pm.subflows++;
+		addrs[i++] = remote;
+	} else {
+		mptcp_for_each_subflow(msk, subflow) {
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			remote_address((struct sock_common *)ssk, &remote);
+			if (!lookup_address_in_vec(addrs, i, &remote) &&
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
@@ -455,15 +505,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
+			nr = fill_remote_addresses_vec(msk,
+						       local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH,
+						       addrs);
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

