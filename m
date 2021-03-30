Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42D5F
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 08:03:03 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id m11so11587621pfc.11
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPIshJ8vcymJyMlbsn+yIAROwRmb0EQoG7n6+KYb3Mc=;
        b=pvz2QlaWalHeM+791YFPfmpCvvKcpQ+YlZjoNMc5CZx0PMLFRYm+CA7BuqlUsCVOS4
         j4OocxfDJaXc8dHzfe1fPIOq9rfc1IhZqB91OwXGlKVs6KVMQRNuYpaJq31gbfOL/j7o
         8paAXqLew2uGhjdxuRY9tAOFZloMyP8Wl7cFhySEn2oSiH7bfC6ogODqRKFJAIxq26WG
         8sBpwCWJaP9BTCDmNcEMFsgHJ8LxTu9MUTLNSUY3x7y2JSMv6Yp7q9R9neb27ponh9S8
         lmb5A87ubopnNU+jQlQdUNwYT1WsNGTvgn2jEdsUZwxwU/m3ZRMCSDQ5yW22NMQ4b86B
         FICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPIshJ8vcymJyMlbsn+yIAROwRmb0EQoG7n6+KYb3Mc=;
        b=cq5B+OEN/OSSYpMBhF8u/vun7fdAo7cTNANUD2qeHk8uvkc4wCOGM0gH0tV9Tprkjt
         U78HsVGoh49gSwHbpCF2Qe0ihHiox9QwXePFI2XbNgI1X8ZiUN920UE5G8GkXYHu5cLh
         bqL+YaTdUIDiQ3uuSSv4LkG3TDNgGEbLZsohcqSTnNfTp9YT7XyBR8j+6L0dQlsttByF
         AC0zwEpY6qWSYL8wO+Gxp3rpDMGHKae7wlxk4HEU1JfM221dW8fZEq95ku5Gs7CVFHCh
         y1CHTCDMDGeAqWI6W9fEb8+95CnixPQNRcNCmNDUGtSZ7Cn446CMav4ACQHvhqAggAJu
         jNZg==
X-Gm-Message-State: AOAM533UN0VGodBIfh1u6BDEnFa0+KCdFpLBtQXCFDJJTb76AmEW4T6j
	n7eZGzd8l92u9gWJEjLfoQOMsiVKGAk=
X-Google-Smtp-Source: ABdhPJySC1HUGclitFpFWbyKW0JpvrR1Lwfkre+FoDSuLamV3KMrX3hnc76/450bz1XtxychRUSnvw==
X-Received: by 2002:a63:e04d:: with SMTP id n13mr26944786pgj.185.1617091382324;
        Tue, 30 Mar 2021 01:03:02 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id gw20sm1862742pjb.3.2021.03.30.01.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:03:01 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove id 0 address": reverse Xmas tree order
Date: Tue, 30 Mar 2021 16:02:58 +0800
Message-Id: <fdf6bc5a67730afe487dcd7b916c12dfb51e6177.1617091295.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ues the "reverse Xmas tree" order.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 745073ddded8..6ba040897738 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1162,9 +1162,9 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
 static int mptcp_nl_remove_id_zero_address(struct net *net,
 					   struct mptcp_addr_info *addr)
 {
-	struct mptcp_sock *msk;
-	long s_slot = 0, s_num = 0;
 	struct mptcp_rm_list list = { .nr = 0 };
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
 
 	list.ids[list.nr++] = 0;
 
-- 
2.30.2

