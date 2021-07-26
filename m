Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755F168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:08:33 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso13722589pjs.2
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3wEDrxWhjCX/1ey679B9LH45wBozCdesRw0RARZYT4=;
        b=E+c1FAO+aTDbmSWad+oECgwTEN5DNAMdQiwjygQU3xnXJrrQPDv7vew/DLaOgTqdzH
         IDwtWHuWQ+fP4qYJ99C435wCkgDrNPJACY0wnZWx1u2cI5TwShm/gZN9SkB4Tk9zBQ6p
         5SwjVCdMFoR2pwQL77OD0S1wrGO/xwJHn94PjEX+w+ZZAxsQkXZIyBa0B8pC54MUG8xM
         CPGDaRjWyVZKZnKyenh+/sjDCU5Iex/jzp8We4KGgy0QnY5v/6rCdQ7XhpfYe5+dRAbB
         ceYwaL3t3g+HCj73eSX8la8DsQUhyBfY/yCEcARXIr9Jfh4rV7PCekWqDgeDSzUec/Z0
         iVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3wEDrxWhjCX/1ey679B9LH45wBozCdesRw0RARZYT4=;
        b=TC6QCPe9oL12f+hyoWJYKv+WCXRk5FXaIQOBwxRXIH05M1kYVW5L7l2h0bMu1Kva3z
         665uFLeVyrpgZTIvniznsfhQKcGVHp26khy0rTdf0AJmWROrAiZ8FZv46fTjovU/9+d9
         ErVQUuG+6bsCmdvdub8LA11TYuGjLRNSoWtzxS/dvcbbLVA7N4fg/NfWDMv0gzrgqJMY
         gRsneqf8zxqMUOgJcJrTGIjbWlp1reEv4wupuD7HoJhsPopb70xIT5xQCEqdj7c3oaff
         1YPpQHRyJIFZOavPV+B5wDRR/57vhICy4CTfWOJOqga6JGFkyi8s4rzATywVfUQ40Vg+
         chNg==
X-Gm-Message-State: AOAM530i86K/qWoEJzx9AtRBPqA2HVDbZV6oK6/4Y6h+3Z6gChRzP1ro
	GPNZ768MoexDVgrm7nkoATF83qCwDc3aHw==
X-Google-Smtp-Source: ABdhPJw4CT1FzpxWbcmu4lOFGUKN5FpYEkjWKPzmh7TShRO06iTMSVARPa18I42OrM3+wz+KHFnp+A==
X-Received: by 2002:a17:90b:4016:: with SMTP id ie22mr13347161pjb.68.1627297713104;
        Mon, 26 Jul 2021 04:08:33 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e30sm50282700pga.63.2021.07.26.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:08:32 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v4 mptcp-next 1/5] mptcp: remote addresses fullmesh
Date: Mon, 26 Jul 2021 19:08:22 +0800
Message-Id: <457db25d2c745babb98b8f29c6d2ace3d6348ff5.1627297096.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627297096.git.geliangtang@xiaomi.com>
References: <cover.1627297096.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm_netlink.c     | 66 +++++++++++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 5 deletions(-)

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
index ba0e1d71504d..2a09d28d98be 100644
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
@@ -410,6 +431,39 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
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
@@ -455,15 +509,17 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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

