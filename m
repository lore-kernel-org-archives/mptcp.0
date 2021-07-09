Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116A72
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:51 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id d12so9578568pgd.9
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3/ROBWnCaS+Pp35IbMGwyXIcH15HTo9TFht+PwEpto=;
        b=q7yMX0fvQVH1ljzCSRXP3udFw16uC6GAabQOVZW1O9k4S5Jy4lmVr6vQIxgpZve7l6
         oX9/9/t+EeR2XIDhSmqat4TX3HfMgqhAT6bFC9SwxgAe80opywFYHGmd8GblPxiHzp5X
         1Xf0K+UNnQ21OUF3xh2Tl0/VF1SM97+Uc1GwvNnrbl4uCc/r5Y4nb9kIbCKPn9LIqKE1
         Svnh4zlDcOQdSzPlXEDlCM6iWSWGvKEgiahpXw4S7B+9VvK+L8ANmeWgAnivUqg+kzqb
         PbslWyj2PjufDW6E0zaq8sj0ra4Tb1CcVfuwBQZfMbwRQW/tZFOAXj6SfFFgvPhaTrsO
         G8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3/ROBWnCaS+Pp35IbMGwyXIcH15HTo9TFht+PwEpto=;
        b=dl27lN/LqJVJqy+i5J4+YVX3fkkx+f/jCHtfbFboid4WiISrQB2C1tykCMlyKRFEH3
         bnsP+6VwoWZFbSnt1lrkWVOx6WlpiWjoAmWz0wdLCl6Z4C6FKSqWird2BPAu85+Z5IUi
         D3CuQ9CfN5OfYWjZ9aTqZTuhJEEsDUsWmIZ3xZc33sePY5vbeGeYyLCUhpxz0cN7It5b
         NxbOq23GMmXhBswhqzOwZzsL2SVkpxkQGkmAJg1P5e0NFc0z/uMTrogA2jnokIY25wD4
         cnYK7AS9CkqeKHkyFZzWPHIALF0B8aGJB3IniTfLcbGyLIYVp+qHf470mMoCXBuuz8fY
         vfEA==
X-Gm-Message-State: AOAM5324izoMjoRNq/4brZ9OGBwqOXXD7sBGlIf41rLfUtGUeIIz9Kb/
	kvWWuLCB9JAmHIEJA9GTu6tiuhsLmQZq8Q==
X-Google-Smtp-Source: ABdhPJy3PSNaYn+7tToPUciuoEYPoqfP5IotPLAOOpqieHVUb7aASpxPvpiBJkVJFnhdTw9M1U2q7A==
X-Received: by 2002:a62:6101:0:b029:326:3166:8b0b with SMTP id v1-20020a6261010000b029032631668b0bmr14033181pfb.4.1625828691113;
        Fri, 09 Jul 2021 04:04:51 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 6/9] mptcp: add netdev up event handler
Date: Fri,  9 Jul 2021 19:04:33 +0800
Message-Id: <077d3ff80fa785e602669724bb4fed9789a98e70.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f4ea9c590e22735421bf6a4f11628bbbb493da16.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com> <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com> <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com> <f4ea9c590e22735421bf6a4f11628bbbb493da16.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the net device UP event handler function named
mptcp_fm_cmd_add_addr. In it, alloc an address entry, populate it, and
append this entry to the local address list.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_fullmesh.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/pm_netlink.c  |  4 ++--
 net/mptcp/protocol.h    |  2 ++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index 4b2eddc2b4e9..1ef268d34360 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -132,6 +132,47 @@ void mptcp_pm_fm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->accept_subflow, MPTCP_PM_FM_MAX_ADDR);
 }
 
+static int mptcp_pm_fm_append_new_local_addr(struct pm_fm_pernet *pernet,
+					     struct mptcp_fm_addr_entry *entry)
+{
+	struct mptcp_fm_addr_entry *cur;
+
+	spin_lock_bh(&pernet->lock);
+
+	if (pernet->next_id > 255)
+		goto out;
+
+	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+		if (addresses_equal(&cur->addr, &entry->addr, false))
+			goto out;
+	}
+
+	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+
+out:
+	spin_unlock_bh(&pernet->lock);
+
+	return 0;
+}
+
+static int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *addr)
+{
+	struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
+	struct mptcp_fm_addr_entry *entry;
+
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->addr = *addr;
+	entry->addr.id = pernet->next_id++;
+	entry->addr.port = 0;
+
+	mptcp_pm_fm_append_new_local_addr(pernet, entry);
+
+	return 0;
+}
+
 static int mptcp_fm_cmd_mod_addr(struct net *net, const struct mptcp_addr_info *addr)
 {
 	return 0;
@@ -140,7 +181,9 @@ static int mptcp_fm_cmd_mod_addr(struct net *net, const struct mptcp_addr_info *
 static void addr_event_handler(unsigned long event, struct net *net,
 			       struct mptcp_addr_info *addr)
 {
-	if (event == NETDEV_CHANGE)
+	if (event == NETDEV_UP)
+		mptcp_fm_cmd_add_addr(net, addr);
+	else if (event == NETDEV_CHANGE)
 		mptcp_fm_cmd_mod_addr(net, addr);
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d050dbd89e24..debec16e9209 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -57,8 +57,8 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
-static bool addresses_equal(const struct mptcp_addr_info *a,
-			    struct mptcp_addr_info *b, bool use_port)
+bool addresses_equal(const struct mptcp_addr_info *a,
+		     struct mptcp_addr_info *b, bool use_port)
 {
 	bool addr_equals = false;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99c23a1887d8..ea93bd1b4fde 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -717,6 +717,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
+bool addresses_equal(const struct mptcp_addr_info *a,
+		     struct mptcp_addr_info *b, bool use_port);
 bool lookup_subflow_by_saddr(const struct list_head *list,
 			     struct mptcp_addr_info *saddr);
 void remote_address(const struct sock_common *skc,
-- 
2.31.1

