Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6372
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:12:36 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so2025037pjb.3
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 21:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xf6twHH0dlS9sUwB1ifZ9Erd+fGc4dzVLtHyo+fRBwg=;
        b=rFXWDsYwk5iVfUTcdjMOmNt0Op6Q10528xzhvHUOm/nF67igcxAcE2R+/Vk9jBGVsk
         nK4XCJFQVUY/FaAzFhz6ks7ZtjhE9XJ5fCa9xY+eI7qONr8xXwaCBxsVZ19RH1Svs2nh
         73dCQQ9MlPmDAQkgyTEMVvctdfys8H9yuXWNlhc6cobRV0Tcj7trHM/vBbRz9voZ7bCE
         NOJF8mXx1KwJFzo+4P3IZe+C0HRxOoHRKDKxFdxNXV5K7sRvVUs55g3kIW0wqA4Sgeec
         cHGkGZTCJqnHifNVC/Bqh0louaiA5Okx3B53TC7BLShCH6aIegdU2fvboyj46iQF0kUt
         HgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xf6twHH0dlS9sUwB1ifZ9Erd+fGc4dzVLtHyo+fRBwg=;
        b=gsjHHn/blIm0y4TBKRWcOOGuzDcKspxOv4ouICT6TuAkoHB/qqnzdMV8Dpb9BhOMzE
         Z+1SZCGqEXKMtso7KvzRZXZKACUmISjQu4Uj3UATuK7H9EdYVjgldyvqokFC/0ZkPe2A
         YaNPG49Tq906itUO8HnaIRQgSitgc8mLQSPQWBbbYOygvwB9vVHv44JpqBVOXQvH3ZfS
         k87Wo+95EjDISUIPnuXlEAzsgtLhmPAXOexXSoSTbbpbu9Doyuk6rFPJZkN+YgJC9ni/
         PMcM4L6LCcqzRUg7yQUhDonXikca6aHr24+XD6w9BPk4gD9HvmWSMvuGCXYwGXnuxzhW
         l4kw==
X-Gm-Message-State: AOAM532OCxaiHJDqk+H4uwFqmZzkSzDVz/eOf5HJo6hlF70DMuhj4K7o
	QF4ynB5mocK33RQO+foSQaVLfOn0HmFODQ==
X-Google-Smtp-Source: ABdhPJzivFSB7w/SvkKTiKDHQ6nbBzYVbpqt2Gs59sG1mJCowsEoatZZAFV8pX/VyCpC1HMqZPjghg==
X-Received: by 2002:a17:90a:c297:: with SMTP id f23mr15562818pjt.194.1627272756097;
        Sun, 25 Jul 2021 21:12:36 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f3sm2608543pfe.123.2021.07.25.21.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:12:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next 1/5] mptcp: remote addresses fullmesh
Date: Mon, 26 Jul 2021 12:12:24 +0800
Message-Id: <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c     | 46 +++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

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
index ba0e1d71504d..f57db5b9a50f 100644
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
@@ -455,15 +476,34 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
 		local = select_local_address(pernet, msk);
 		if (local) {
+			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 			struct mptcp_addr_info remote = { 0 };
+			int i, n = 0;
 
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
-			remote_address((struct sock_common *)sk, &remote);
+			if (!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH)) {
+				remote_address((struct sock_common *)sk, &remote);
+				addrs[n++] = remote;
+			} else {
+				struct mptcp_subflow_context *subflow;
+
+				mptcp_for_each_subflow(msk, subflow) {
+					struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+					remote_address((struct sock_common *)ssk, &remote);
+					if (!lookup_subflow_by_addrs(&msk->conn_list,
+								     &local->addr, &remote)) {
+						addrs[n++] = remote;
+					}
+				}
+			}
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote,
-						local->flags, local->ifindex);
+			for (i = 0; i < n; i++) {
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i],
+							local->flags, local->ifindex);
+			}
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
-- 
2.31.1

