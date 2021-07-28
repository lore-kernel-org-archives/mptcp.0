Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF672
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:16:50 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id e21so1915091pla.5
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LpBSFHQ0IkYm8MqvVif94WQ07s7w3msRbzWWEGUb9Tg=;
        b=SJPX/WhINVqFzZ6H+xAijHs/ysMPgOfet6dCEXO1p9UUUYo3VrY6OKLTvo1ywDUWx/
         Ho8UUMtJHUiKt0Co4pwZYnR391EYULVaw+RQXijLplBdDdSgR/kO8H2ik1Hv6/jXOs2R
         KCucC/06s7oQGsMbAXlaeXWB0+AAfxDXroo6W2MVhmmCh5hOzAGf6az6AkfUqGIaQPPt
         lNOFhuMnWIBf/w7Fbh8gLD1IkTRcqBuyRj//xIIfKUCMfdktP6SLC2uSNq2SemkNewBz
         hRKuIvtzr3uouOHeNt6m6B7peNYa4t0YnDXxQA8m5fLB7NQYp54EbptF24U2bqOyi2kz
         xRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LpBSFHQ0IkYm8MqvVif94WQ07s7w3msRbzWWEGUb9Tg=;
        b=mF04m5ZEQxqHuyiorrGc1gv1BGMDLrfpNrRlB4j/WkISHafbcA4yfrQgeBeOJ129dr
         svOaiwNLflngyYA5Tv67y72ue2vJ0an/G2+ADH+bJFSveQ01WQHRM/mQGiLhUp3hFR8g
         T9zqCgcInKxhBcxgqmqciJubq4tVOyvvA6boMdnkpdfOfNzstZubssoDq7ADRWzqTecu
         MwBjSjoAx5hLt5mjsUGWN0kaL/Z8w1uuTb4IFuxFj+qnGkPO9hFCHF5TSSEHtQW5fo0E
         mz9SiloN6AXwk1XexDI9WLOD1wxwkVMmSeiWxhg9oePuwvisnuoYNIyRScQHrERn9xEt
         jRNQ==
X-Gm-Message-State: AOAM5328Iv4Chk9WM8wlhqsg/uDZxQich+sXk/MORCmAsF9iJ2d8S5OX
	n5z4n4yXYX67SL+4CWSd8TxCX2aSzFM=
X-Google-Smtp-Source: ABdhPJzRPTl0f6JUtk+InrOHR24PFCdpedbKb4Blipq+6OlSznMyDKGyCqj5XlZLctXhtXIjNNlOFw==
X-Received: by 2002:a62:a516:0:b029:333:1995:5e75 with SMTP id v22-20020a62a5160000b029033319955e75mr26916969pfm.67.1627463810072;
        Wed, 28 Jul 2021 02:16:50 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g20sm6480955pfj.69.2021.07.28.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:16:49 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remote addresses fullmesh"
Date: Wed, 28 Jul 2021 17:16:37 +0800
Message-Id: <f5e079bf977b0c9e05e26f6b90d8cde4bb9a6c9f.1627463618.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Fix the checkpatch.pl warning:
 WARNING: networking block comments don't use an empty /* line, use /* Comment...
 #63: FILE: net/mptcp/pm_netlink.c:427:
 +/*
 + * Fill all the remote addresses into the array addrs[],

And some more cleanups.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ecf43d45711a..8eeae401c83f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -423,8 +423,7 @@ static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr
 	return false;
 }
 
-/*
- * Fill all the remote addresses into the array addrs[],
+/* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
 static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
@@ -440,7 +439,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	/* non-fullmesh, fill in the remote address */
+	/* Non-fullmesh endpoint, fill in the single entry
+	 * corresponding to the primary MPC subflow remote address
+	 */
 	if (!fullmesh) {
 		remote_address((struct sock_common *)sk, &remote);
 		msk->pm.subflows++;
@@ -505,14 +506,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
 		local = select_local_address(pernet, msk);
 		if (local) {
+			bool fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 			int i, nr;
 
 			msk->pm.local_addr_used++;
 			check_work_pending(msk);
-			nr = fill_remote_addresses_vec(msk,
-						       local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH,
-						       addrs);
+			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
 			spin_unlock_bh(&msk->pm.lock);
 			for (i = 0; i < nr; i++) {
 				__mptcp_subflow_connect(sk, &local->addr, &addrs[i],
-- 
2.31.1

