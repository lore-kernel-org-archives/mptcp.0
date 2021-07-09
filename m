Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AA72
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:54 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id m83so738782pfd.0
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InCShVtN5s01HKMN71bHgEGxUy0XcvdEkHUWxQaN7cw=;
        b=qkXWvqCF03GxZSbrKqXHkPhbLTbKoHoFVAxXOLkiFC0DNX8O4WOXSon03RTI84j+oR
         MpgUSXclaTqmB3nh0dpeyhGV1qI+Lz5cmlSbGlyQ0pr6egY8gjwrvNsn+K8/xzLg+4vx
         uB+sAt/N/WOI5nNBFRuuHpkCi1iW50LQ5JLrKdQt3zHiZov4zDaCjVPSVj/2WpTAOK4x
         aT70kh4SKlC4uBA2dK14Xw1xt5vVnFnxjKjO1KQLVUoxc7maJXtwtryYQw6wbMG3Y16O
         jV/if0gELGxdE2mWKkfw5n9Qbe1P02GnTs08VEFJAkTTS92Sx1Ngmwmb7F08czxTSOI+
         eegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InCShVtN5s01HKMN71bHgEGxUy0XcvdEkHUWxQaN7cw=;
        b=dyx38Eelp1lOg0y66XBcA7dJGu+AGBhB4BhGG7rz5C1wGGNiwCuGPKQrZoy7fCdSqN
         dTxSQpfKHUdaqVjaPaVWDkwOmRvgTVC47ohcDLvGoBEHOczpribbhOTCx+b65hCsfOum
         jbKRLfXXWFNMniVqTDvznixa6z/vQEDV8xJY/vsSKfASmBiAvnwcztAWmu+9KkESjkKf
         XvsrbSRhGTuoFSfzVcFu8VxhUh+UzCZ7vRF0pD953dfn/urL99Gttwx/5P40CMeniuoO
         GyNPDOyc1ZoCgsDGNiN8lTQX740+VyslPc8y7VxnqjjqSGbqXrpYULHHX20cGyJMYEpT
         z8RQ==
X-Gm-Message-State: AOAM5325+ojuUS/VYJMzWkV+q6sa7vd12VTiP7BK413FmRLvvBn3V+o6
	kjg51nH+LW+JddVdZVvIwlyAXWXwzYoc0g==
X-Google-Smtp-Source: ABdhPJwo3aopz0+TfRQs36pN5Z1d1g/xpBJ7L/DiUxE+fk0iWOvyHDYArlaVSJnBeaRc8jF1L3uj9g==
X-Received: by 2002:a63:5c55:: with SMTP id n21mr35542800pgm.166.1625828694114;
        Fri, 09 Jul 2021 04:04:54 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 8/9] mptcp: add proc file mptcp_fullmesh
Date: Fri,  9 Jul 2021 19:04:35 +0800
Message-Id: <cac9bd939a1d5ef71627de0c3cdad94431a73016.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <9761e92041968743463b3e3836cc54d063e296b6.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com> <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com> <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com> <f4ea9c590e22735421bf6a4f11628bbbb493da16.1625825505.git.geliangtang@gmail.com> <077d3ff80fa785e602669724bb4fed9789a98e70.1625825505.git.geliangtang@gmail.com> <9761e92041968743463b3e3836cc54d063e296b6.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a proc file /proc/net/mptcp_fullmesh to show all the
addresses on the local address list.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_fullmesh.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index a48287ff4cc0..290ca06e565f 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -4,6 +4,9 @@
 
 #include <linux/kernel.h>
 #include <linux/inetdevice.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif
 #include <net/tcp.h>
 #include <net/addrconf.h>
 #include <net/netns/generic.h>
@@ -352,10 +355,46 @@ static struct notifier_block mptcp_pm_addr6_notifier = {
 
 #endif
 
+#ifdef CONFIG_PROC_FS
+
+/* Output /proc/net/mptcp_fullmesh */
+static int mptcp_fm_seq_show(struct seq_file *seq, void *v)
+{
+	const struct net *net = seq->private;
+	struct mptcp_fm_addr_entry *cur;
+	struct pm_fm_pernet *pernet;
+
+	pernet = net_generic(net, pm_fm_pernet_id);
+
+	seq_puts(seq, "ID, Family, Address\n");
+
+	spin_lock_bh(&pernet->lock);
+
+	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+		seq_printf(seq, "%u, %u, ", cur->addr.id, cur->addr.family);
+		if (cur->addr.family == AF_INET)
+			seq_printf(seq, "%pI4\n", &cur->addr.addr);
+		else if (cur->addr.family == AF_INET6)
+			seq_printf(seq, "%pI6\n", &cur->addr.addr6);
+	}
+
+	spin_unlock_bh(&pernet->lock);
+
+	return 0;
+}
+
+#endif
+
 static int __net_init pm_fm_init_net(struct net *net)
 {
 	struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
 
+#ifdef CONFIG_PROC_FS
+	if (!proc_create_net_single("mptcp_fullmesh", 0444, net->proc_net,
+				    mptcp_fm_seq_show, NULL))
+		return -1;
+#endif
+
 	spin_lock_init(&pernet->lock);
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	pernet->next_id = 1;
@@ -383,6 +422,9 @@ static void __net_exit pm_fm_exit_net(struct list_head *net_list)
 		struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
 
 		__flush_addrs(net, &pernet->local_addr_list);
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("mptcp_fullmesh", net->proc_net);
+#endif
 	}
 }
 
-- 
2.31.1

