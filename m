Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6217A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:50:34 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nNGO0-0005Jf-0j; Thu, 24 Feb 2022 16:50:32 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 4/4] mptcp: remove per-address listening sockets
Date: Thu, 24 Feb 2022 16:50:10 +0100
Message-Id: <20220224155010.23676-5-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155010.23676-1-fw@strlen.de>
References: <20220224155010.23676-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not required anymore, syn packets with a join requests are redirected
to pernet mptcp pseudo-listening socket.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/pm_netlink.c | 65 ------------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dcbc11d6b767..836326e04c4a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -27,7 +27,6 @@ struct mptcp_pm_addr_entry {
 	struct mptcp_addr_info	addr;
 	u8			flags;
 	int			ifindex;
-	struct socket		*lsk;
 };
 
 struct mptcp_pm_add_entry {
@@ -883,8 +882,6 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
-	if (entry->lsk)
-		sock_release(entry->lsk);
 	kfree(entry);
 }
 
@@ -972,57 +969,6 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	return ret;
 }
 
-static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
-					    struct mptcp_pm_addr_entry *entry)
-{
-	int addrlen = sizeof(struct sockaddr_in);
-	struct sockaddr_storage addr;
-	struct mptcp_sock *msk;
-	struct socket *ssock;
-	int backlog = 1024;
-	int err;
-
-	err = sock_create_kern(sock_net(sk), entry->addr.family,
-			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
-	if (err)
-		return err;
-
-	msk = mptcp_sk(entry->lsk->sk);
-	if (!msk) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (entry->addr.family == AF_INET6)
-		addrlen = sizeof(struct sockaddr_in6);
-#endif
-	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
-	if (err) {
-		pr_warn("kernel_bind error, err=%d", err);
-		goto out;
-	}
-
-	err = kernel_listen(ssock, backlog);
-	if (err) {
-		pr_warn("kernel_listen error, err=%d", err);
-		goto out;
-	}
-
-	return 0;
-
-out:
-	sock_release(entry->lsk);
-	return err;
-}
-
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
@@ -1065,7 +1011,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->addr.port = 0;
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1284,19 +1229,9 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
-	if (entry->addr.port) {
-		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
-		if (ret) {
-			GENL_SET_ERR_MSG(info, "create listen socket error");
-			kfree(entry);
-			return ret;
-		}
-	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
-		if (entry->lsk)
-			sock_release(entry->lsk);
 		kfree(entry);
 		return ret;
 	}
-- 
2.34.1

