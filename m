Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE92F80
	for <mptcp@lists.linux.dev>; Thu, 29 Apr 2021 14:59:23 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id w3so100387677ejc.4
        for <mptcp@lists.linux.dev>; Thu, 29 Apr 2021 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpB7D1BhV8Q6y6cxK30GKIbID+Syy/U+AkGHCaXJoN0=;
        b=L0QVf2Ov6OTgTgAgNrddvmZ6a1Oj8QhoGxJvNQJ/YJeeAqMXCROU/OQ9IbUgHkjuoj
         NvfudKh+jEgk5P8xcnBNxqRF+SCl9IISLAuV7+tASMWVdycleY+FZQmpVPXZtgbgW30+
         ARy776Iswv1XTX8ddEbKlCoB38kfmG+Xls7Br7jrssxW7i6IfmLGz6ypJqOHF7cML41V
         ohLNGKMYMRvfzhWdGuBDDyQOU3/uhPBGJUWsXiZW+q/IlJLkZakgxPgHPjdQ3g3hszoj
         I1nrJDRyjnPfMXnz6d9URtC4dRTWB+dvCL1lK4FKbFJluEYgTLRKBY4dN82oC7tlo7WQ
         HpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpB7D1BhV8Q6y6cxK30GKIbID+Syy/U+AkGHCaXJoN0=;
        b=Y1Ld69uQsdy9SMctcX+Ob79nOnHdxyn30pyP6KM7WbN1edlaNFFYFVHCCH3mDfs9rh
         TSN0xm1GTX66miXI0rq22ixCrUWHT1dC7xro+FGaURyFMg9ysKnROcb5ZcIIbEuYKDjq
         f9Woom7CTJx4Y2t6zMkjkakc9FhpGSe/S496FLtfHZuUmYHjS1xbHN/ouBDLR/bEHxsp
         CuJsrx4fT2eUz0RGFloaeah7KgDQt/zq2E6FK3Mk7LwCAPwhHQjFMfGwm5N/LzdYVdv7
         ZwFiDQquYSDPQvvgGaqeFzTOY00xyjRow5Q5aC+BzYiqInsk29HLFZo/p8rz1pCqLxwG
         XOtg==
X-Gm-Message-State: AOAM530IvTlWTPp7c/Yg62OPqUlkiGMI2Cf46O5F0FH1vHUMvbHEMIA8
	zeBisF71AGJ/ZfKaz1K2JuHTGB6+kJLQlnKGYWQ=
X-Google-Smtp-Source: ABdhPJxB7uNBA091nkRzdCoyIuIsDxeoLBydZPFU5uKzvg0s+oC/pekuZDKIvdzEV47T9pSLU0JyEg==
X-Received: by 2002:a17:906:590b:: with SMTP id h11mr244461ejq.147.1619708361632;
        Thu, 29 Apr 2021 07:59:21 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id g22sm125251ejz.46.2021.04.29.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:59:21 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next] mptcp: support SYSCTL only if enabled
Date: Thu, 29 Apr 2021 16:59:12 +0200
Message-Id: <20210429145912.2022531-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of the sysctl support in MPTCP with
commit 784325e9f037 ("mptcp: new sysctl to control the activation per NS"),
we don't check CONFIG_SYSCTL.

Until now, that was not an issue: the register and unregister functions
were replaced by NO-OP one if SYSCTL was not enabled in the config. The
only thing we could have avoid is not to reserve memory for the table
but that's for the moment only a small table per net-ns.

But the following commit is going to use SYSCTL_ZERO and SYSCTL_ONE
which are not be defined if SYSCTL is not enabled in the config. This
causes 'undefined reference' errors from the linker.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    The "following" commit is "mptcp: restrict values of 'enabled' sysctl".
    
    The goal is to place this patch before this commit.

 net/mptcp/ctrl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 08c152199b89..1ec4d36a39f0 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -4,7 +4,9 @@
  * Copyright (c) 2019, Tessares SA.
  */
 
+#ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
+#endif
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
@@ -15,7 +17,9 @@
 
 static int mptcp_pernet_id;
 struct mptcp_pernet {
+#ifdef CONFIG_SYSCTL
 	struct ctl_table_header *ctl_table_hdr;
+#endif
 
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
@@ -36,6 +40,13 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
+{
+	pernet->mptcp_enabled = 1;
+	pernet->add_addr_timeout = TCP_RTO_MAX;
+}
+
+#ifdef CONFIG_SYSCTL
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -57,12 +68,6 @@ static struct ctl_table mptcp_sysctl_table[] = {
 	{}
 };
 
-static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
-{
-	pernet->mptcp_enabled = 1;
-	pernet->add_addr_timeout = TCP_RTO_MAX;
-}
-
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 {
 	struct ctl_table_header *hdr;
@@ -102,6 +107,17 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
 	kfree(table);
 }
 
+#else
+
+static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
+{
+	return 0;
+}
+
+static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
+
+#endif /* CONFIG_SYSCTL */
+
 static int __net_init mptcp_net_init(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
-- 
2.30.2

