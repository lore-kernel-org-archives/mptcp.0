Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46B72
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:02 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id q2so5881035plr.11
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKvRbtmuJdjfqH2ZpwdzAOGPNsmuuT3RA9iii/z0e5w=;
        b=XgN7A4cIx8dmB4UKHEsZt4AUlfH1WVLY7U+Ik69OBT12nkgjT5V16bLOEcFOwE+D5R
         unTDNq8/DC/dsiKV2gzBwk5XbuwIIzuFMMJ8AC0Cr9SFTxb0xxBorPEIzo6a/6ciIMkV
         Hi8zznvHX7MxNfzFF6/tL4KjxWiW6Y2odRe9fSZnlcE2EZTPgO6fK4j2MA1lLmxMbaTD
         Ev/mDjZ3nj7hxIiVApMLyV/11zmweM4UnmL7I8WkFEvD4D7U4WR5bDSTwKm0m+P7Hx7x
         3/s4DZ3w+fhVwSRwMO5R2sch2VyM1WWAOCd1a6dYUO9hkeW9THQ63F/wSkdGa33VEEDf
         xOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKvRbtmuJdjfqH2ZpwdzAOGPNsmuuT3RA9iii/z0e5w=;
        b=ni68HlGPROXXgKdz7L0jVHL9U4lMVbZDC8FAWeXfOlQgmKKmFZLpJVW4gZxzB5h38z
         2TBpeCF7LYYYVfFtY8M0RbmcIPF7UHipmRuBFe/TJ09+ltYwltsl2Jkf0FYSO6xz7Bmn
         EZ8w+tQi9/ZKrDXikEoxzVvcnu8N2ORnBA1dKn3YDy3uePzwUVFmJZxXY8tHe7H4hA6T
         OTWjEjVeTJ9F/9RbTi8hrCnp3IwzQhlBnyHmajLGWDf7Hh3ofol0s7UK9sNE9fd4RI8Z
         4q7sNo+Iery2Gk6kiLp6zbNMVFdscvAeRnTFE8enaa3Qk0ZE5kUTRwW/4YVbvzJWgsmA
         T85A==
X-Gm-Message-State: AOAM533O4d/Uq74sCI8V14qNeLNvU3pkucilhlvZCOl9Su9RqLG/RosO
	tUR1tYXIsNpPT0SL0QHz5s6ipr7qb2s=
X-Google-Smtp-Source: ABdhPJyluETiYNNtJOwtTRqU0TxovmUl3utYUS9ljoO2eiQPu58Sr+oGOENjw0cfEeZLv9MjJwNL6w==
X-Received: by 2002:a65:49cf:: with SMTP id t15mr2667081pgs.109.1627543262085;
        Thu, 29 Jul 2021 00:21:02 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:21:01 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 1/6] mptcp: drop flags and ifindex arguments
Date: Thu, 29 Jul 2021 15:20:50 +0800
Message-Id: <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a new helper mptcp_pm_get_flags_and_ifindex_by_id(),
and used it in __mptcp_subflow_connect() to get the flags and ifindex
values.

Then the two arguments flags and ifindex of __mptcp_subflow_connect()
can be dropped.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
 net/mptcp/protocol.h   |  5 +++--
 net/mptcp/subflow.c    |  7 +++++--
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba0e1d71504d..94c68d6093de 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -462,8 +462,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			check_work_pending(msk);
 			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote,
-						local->flags, local->ifindex);
+			__mptcp_subflow_connect(sk, &local->addr, &remote);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
@@ -518,7 +517,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	local.family = remote.family;
 
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
+	__mptcp_subflow_connect(sk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 
 add_addr_echo:
@@ -1103,6 +1102,26 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 	return NULL;
 }
 
+int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+					 u8 *flags, int *ifindex)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	rcu_read_lock();
+	entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
+	rcu_read_unlock();
+
+	if (entry) {
+		*flags = entry->flags;
+		*ifindex = entry->ifindex;
+	} else {
+		*flags = 0;
+		*ifindex = 0;
+	}
+
+	return 0;
+}
+
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e8a36ff52af6..d276ce16f126 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -576,8 +576,7 @@ struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-			    const struct mptcp_addr_info *remote,
-			    u8 flags, int ifindex);
+			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
@@ -732,6 +731,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
+int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+					 u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1151926d335b..8c43aa14897a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1355,8 +1355,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 }
 
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-			    const struct mptcp_addr_info *remote,
-			    u8 flags, int ifindex)
+			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
@@ -1367,6 +1366,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
+	int ifindex;
+	u8 flags;
 	int err;
 
 	if (!mptcp_is_fully_established(sk))
@@ -1390,6 +1391,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		local_id = err;
 	}
 
+	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
+					     &flags, &ifindex);
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
 	subflow->token = msk->token;
-- 
2.31.1

