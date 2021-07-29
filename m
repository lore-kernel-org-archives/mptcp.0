Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A272
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:04 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id f13so5938959plj.2
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XO6UvU39x6gNzTfsUjgQppkqU5MSWbZ1Jhg5k3Ey+xI=;
        b=T91svLWu61/1N5JiMjJuv9jJV3ury5OOupMP2MCDrj+VGkoQartr3pfn7rcrwSuxq7
         jWBwcjsJrQV0wkPuq7+P+FHep5YVRrA0OymhoEEVYSH36UC4qosar5iwoQL1BT7x1xBp
         xI+PRgUsm2mjxuCh96GNdHzWQMAGAjQkVAe9V1l71ls50rrt28MWHJW6DawTw9P9OQEM
         BLMoTmdavGk3YHW/G6dFj0IaLMg+ZzYrzJzKP6wSLgZxtFtQ2Ks2UEUqHBXhRnNCva4m
         06KgUXhMgc/j5EKddo+Kjks3yDmUef5yzSwwsKUg6VttShw0XjMi/Z1REiDabBriuvR8
         CG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XO6UvU39x6gNzTfsUjgQppkqU5MSWbZ1Jhg5k3Ey+xI=;
        b=FB4DhuJIny+ZQCT2GsQqG25rZDTrltAVHTRuw+KhdWqt1WcF21F3xgtVr7p9VvTCPP
         VoRh1VTVlUfDg8QHfP7g6WYfNOpAiPYGwluJIg0tv7Ge/Y54hcZxhycMSXIhboYdKZZi
         x/PfUwSwOcxsDMs8k56uQtiOIQgIim98Jmx32p4T4wM8NvWwGteNj9uqyjqOHioYQChk
         jv/PrczVXIoEiXG2/JgqnTTYDDjy+IRF3OoGoePnwrxQ8Fy7MiVyof8JEpOP4e8a6VXV
         CdzSQEzYuIrMgnit5BB2wJE3zAWTRXP/E+Fasc6aGzHGDxCGwNLhZcn+/APLToK7tR8W
         ZBCg==
X-Gm-Message-State: AOAM533sT7wfB8+ap/rB1xHSejlVwQeXXj0HO+FXchTcQY6dZHl8QcBG
	Hy9zbBdVyQ2QRcGnRJh9+rEviMOoIhs=
X-Google-Smtp-Source: ABdhPJzjzZqDJ1hXTKs0Wd3yQq2DfUDsOI+IczVI66e/hk+oJDvAkL0pTz/yLg8vnI/UFhF0j3sB8g==
X-Received: by 2002:aa7:939c:0:b029:377:8bcf:2374 with SMTP id t28-20020aa7939c0000b02903778bcf2374mr3560097pfe.53.1627543264161;
        Thu, 29 Jul 2021 00:21:04 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:21:03 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v7 mptcp-next 2/6] mptcp: remote addresses fullmesh
Date: Thu, 29 Jul 2021 15:20:51 +0800
Message-Id: <af7def3b48c96f1f0c68360326d2e9cfe2500826.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com> <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c     | 61 +++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 4 deletions(-)

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
index 94c68d6093de..77cab67e732d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -410,6 +410,57 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
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
+/* Fill all the remote addresses into the array addrs[],
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
+	/* Non-fullmesh endpoint, fill in the single entry
+	 * corresponding to the primary MPC subflow remote address
+	 */
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
@@ -455,14 +506,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
 		local = select_local_address(pernet, msk);
 		if (local) {
-			struct mptcp_addr_info remote = { 0 };
+			bool fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+			int i, nr;
 
 			msk->pm.local_addr_used++;
-			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
+			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote);
+			for (i = 0; i < nr; i++)
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
-- 
2.31.1

