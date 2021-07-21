Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAF70
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:52 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id u3so1043790plf.5
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsgeOfReq/68vI9YwP7hm4AozeSZbvBxttbBBGeSw48=;
        b=fgr4MZQr9B2JHJokG0+3oV/2yyFwS1ugb5TeT3IvJP1tGU5FmW8XcMFRmerePoOHD5
         Xc17myn6rUj9C5j4pRktoOhgxdESVhtxB2De9sZTfIp/7D7/DKYMNlekAm8who/lshzK
         cx48MBU4K30Suwk0q3rMJm+BHfUigbwGBX7NWQtGoU/OJY/ZebdK0/xg6/h0nDRA9IQ7
         JhiYCNeKQto8Cznk0h8j0DEQYwxqVwMlr2Z/t4UfivNfbWC3t4BZ+TjIvq/+DP7fQ8Gv
         M1hIkLfTUQvM1R0HGXBBtI9cJO8Z1nlhkYThp3TTaValMwqz1GiiHDoVdXLn0IzZdj2g
         EGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsgeOfReq/68vI9YwP7hm4AozeSZbvBxttbBBGeSw48=;
        b=jIgVKs8HLxCk6+VQvCorwO/+q9m/fswo0XYimjs2nXZXbJAxWtPDWadJxDS8Kmw1Gh
         h3YXEdT4Vn0gkXkQ8vtgCIsAQF4ao1bCcLsvArBdJILncMk8FNP4TmS3pDhZsrUOaO33
         zJ5i3OXDFvAOz+1ZHXDhvAx6f67i3qcl5sOAcAQugFKLQf4TNtn5zDgfveUFLzIpTPre
         RplDim5pd7w6g4lAyemjCn+muB3jflL7azzbE0ZBFoppy6suzwToKGDkaoDtrQUECpO2
         t7EMSNvLkW2aFbkOxRLyPLiXP2HYGCureXuRAHZB4xowV9EGgXXt34Y+uvHXshsmJftR
         mZXg==
X-Gm-Message-State: AOAM532I19i6efJV0QbzW7/Vb3V2DhHRGhCs7G0s9NYDKoH6qZSYrC/u
	XF1MHK/xh1xMiN/gNNT0F6FO+kC4Wfnw0A==
X-Google-Smtp-Source: ABdhPJz0mio64N2n1JMlHMY+8HR+aIKyavD87PMNVvF1w/dF5h7AVfIppdfBu7dKF6ptqA+IokIG1w==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr6368204plq.59.1626877912257;
        Wed, 21 Jul 2021 07:31:52 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:51 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 07/10] mptcp: add proc file local_addr_list
Date: Wed, 21 Jul 2021 22:31:31 +0800
Message-Id: <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com> <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com> <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com> <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a proc file /proc/net/local_addr_list to show all
the addresses on the local address list.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 765d59dd2a5d..3bf7467af74b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -8,6 +8,9 @@
 
 #include <linux/inet.h>
 #include <linux/kernel.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif
 #include <net/tcp.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
@@ -2006,6 +2009,46 @@ int mptcp_fm_cmd_del_addr(struct net *net, struct mptcp_addr_info *addr)
 
 #endif
 
+#ifdef CONFIG_PROC_FS
+
+/* Output /proc/net/local_addr_list */
+static int mptcp_addr_list_seq_show(struct seq_file *seq, void *v)
+{
+	const struct net *net = seq->private;
+	struct mptcp_pm_addr_entry *cur;
+	struct pm_nl_pernet *pernet;
+
+	pernet = net_generic(net, pm_nl_pernet_id);
+
+	seq_puts(seq, "ID, Family, Address, Flags\n");
+
+	spin_lock_bh(&pernet->lock);
+
+	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+		seq_printf(seq, "%u, ", cur->addr.id);
+		if (cur->addr.family == AF_INET)
+			seq_printf(seq, "4 %pI4, ", &cur->addr.addr);
+		else if (cur->addr.family == AF_INET6)
+			seq_printf(seq, "6 %pI6, ", &cur->addr.addr6);
+
+		if (cur->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			seq_puts(seq, "subflow ");
+		if (cur->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+			seq_puts(seq, "signal ");
+		if (cur->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+			seq_puts(seq, "backup ");
+		if (cur->flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+			seq_puts(seq, "fullmesh ");
+		seq_puts(seq, "\n");
+	}
+
+	spin_unlock_bh(&pernet->lock);
+
+	return 0;
+}
+
+#endif
+
 static int __net_init pm_nl_init_net(struct net *net)
 {
 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
@@ -2015,6 +2058,12 @@ static int __net_init pm_nl_init_net(struct net *net)
 	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
 
+#ifdef CONFIG_PROC_FS
+	if (!proc_create_net_single("local_addr_list", 0444, net->proc_net,
+				    mptcp_addr_list_seq_show, NULL))
+		return -EINVAL;
+#endif
+
 	/* No need to initialize other pernet fields, the struct is zeroed at
 	 * allocation time.
 	 */
@@ -2033,6 +2082,9 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		 * other modifiers
 		 */
 		__flush_addrs(&pernet->local_addr_list);
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("local_addr_list", net->proc_net);
+#endif
 	}
 }
 
-- 
2.31.1

