Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB470
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 06:44:53 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id b12so18635143pfv.6
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sVb4P3xu82oUNiY2P/+l7KoCEJ0RNBjffsOwU+LwPo=;
        b=DJoCGOqcJNI6Kvkho4znQdvx3y4g3nZDarszIyj5kJPjPLez+7zu1XSDAKE1tZ/e+b
         SE1AdORhIWaQRoutwoNkxXjZSnAApxFvoJ+GHxAAb5h/R+tQMlb5OdnwbRgSsKzmVcUi
         SAuCucQllDxNtQESiziwHkHDnckKAzXEz5gInshPDPR/kNIpKTukU67GzC8X7f3gBWFu
         7W/zrfyO3VKdANLd2lpmXjGVO3JNfKtHA+ZnQds4h8kpkTmGqAP6W5EGrLtiBxAS+KsO
         WRxnA0VZHApJGStrDWcCOMrAEwLYlCwrMl+K5PkKzE8RzksFCOaawohwgYvLiVciar6m
         mIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sVb4P3xu82oUNiY2P/+l7KoCEJ0RNBjffsOwU+LwPo=;
        b=sYFlrbkSan900GqMZBXmF8vUifhEuOdQNMECq06fYn8p6I71Rds8MhqBDzREfyuNZI
         OczcKGi1kx+JOT6X8oCl22tCPxgTZrIMnF32fSD6PIY7M/ZBBFZbNUhmOZKCu4ePOv1k
         bYZlU2KdBQa85HNS5ophGm9k3itNg0/U8tEvbL6NzN8O4E1szWyC22jXGhIHIqL4zNGi
         mKVpiV5+KzWDzGD+dn24EItffaxEJxihGWt3L3Egg/zCPqXiRcHDA1aQxQJfPlMD+Jx4
         33owsQcQNyiQ6KS0c0+oTkeYZ+ngDWic2kxHDpAKaszP8vqfsEA/XGCPO1RaEgyLkvL6
         aK1Q==
X-Gm-Message-State: AOAM530oyM/SePVVb7ghLTmgaAECeu1Fq1qJYIZqJGfdpQcvUw++O6cD
	owVdXNdhixpAac2fepdQH7srvrH7ruB7lQ==
X-Google-Smtp-Source: ABdhPJzerRiSFvyhTem47Yvhq5bplKLiIEYFsjDl1zgOpmAVa7fmcmZYItVCapxEzwBCO3d6Q89SHA==
X-Received: by 2002:a62:dec1:0:b029:32d:1f6:3890 with SMTP id h184-20020a62dec10000b029032d01f63890mr2964197pfg.13.1626158693233;
        Mon, 12 Jul 2021 23:44:53 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 202sm15236606pfx.75.2021.07.12.23.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 23:44:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
Date: Tue, 13 Jul 2021 14:44:44 +0800
Message-Id: <f0920ba1126ff81aa1acbff47e805e5573c64abc.1626158123.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In v8, opts->local and opts->remote in mptcp_pm_add_addr_signal need be
populated after the length check, not before the check.

This patch fixed it. And keep the more original code unchanged, just do
the least, necessary modifications.

- Keep mptcp_add_addr_len unchanged.
- populate opts->local or opts->remote after the length check, don't
  populate both of them.
- add back 'echo' and 'port' arguments of mptcp_pm_add_addr_signal().
- add a new arguments drop_other_suboptions for
  mptcp_pm_add_addr_signal(), and do the drop_other_suboptions check in it.
- drop other suboptions in mptcp_established_options_add_addr() after the
  length check.
- update mptcp_pm_should_add_signal_ipv6() and
  mptcp_pm_should_add_signal_port(), not drop them. They will be used in
  the drop_other_suboptions check and in mptcp_pm_nl_addr_send_ack() in the
  next squash-to patch.

v2:
 - move the drop_other_suboptions check into mptcp_pm_add_addr_signal().
 - drop other suboptions in mptcp_established_options_add_addr() after the
   length check.
 - add back mptcp_pm_should_add_signal_ipv6() and
   mptcp_pm_should_add_signal_port().
 - populate opts->local or opts->remote, not both of them.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 43 +++++++++++++++++++------------------------
 net/mptcp/pm.c       | 29 +++++++++++++++++------------
 net/mptcp/protocol.h | 30 ++++++++++++------------------
 3 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5c0ad9b90866..37ff15aeb2f7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -663,42 +663,40 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
-	u8 add_addr;
+	bool echo;
+	bool port;
+	u8 family;
 	int len;
 
 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
+		    &echo, &port, &drop_other_suboptions))
 		return false;
 
-	if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
-	     ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
-	      (opts->local.family == AF_INET6 || opts->local.port))) &&
-	    skb && skb_is_tcp_pure_ack(skb)) {
-		pr_debug("drop other suboptions");
-		opts->suboptions = 0;
-		opts->ext_copy.use_ack = 0;
-		opts->ext_copy.use_map = 0;
+	if (drop_other_suboptions)
 		remaining += opt_size;
-		drop_other_suboptions = true;
-	}
-
-	len = mptcp_add_addr_len(opts, add_addr);
+	family = echo ? opts->remote.family : opts->local.family;
+	len = mptcp_add_addr_len(family, echo, port);
 	if (remaining < len)
 		return false;
 
 	*size = len;
-	if (drop_other_suboptions)
+	if (drop_other_suboptions) {
+		pr_debug("drop other suboptions");
+		opts->suboptions = 0;
+		opts->ext_copy.use_ack = 0;
+		opts->ext_copy.use_map = 0;
 		*size -= opt_size;
+	}
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
-	if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
-	    (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
+	if (!echo) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
 						     &opts->local);
 	}
-	pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
-		 add_addr, (opts->ahmac == 0), opts->local.id, opts->ahmac,
-		 ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
+	pr_debug("local_id=%d, local_port=%d, remote_id=%d, remote_port=%d, ahmac=%llu, echo=%d",
+		 opts->local.id, ntohs(opts->local.port), opts->remote.id,
+		 ntohs(opts->remote.port), opts->ahmac, echo);
 
 	return true;
 }
@@ -1253,13 +1251,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		struct mptcp_addr_info *addr = &opts->remote;
+		struct mptcp_addr_info *addr = opts->ahmac ? &opts->local : &opts->remote;
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
 
-		if (opts->ahmac)
-			addr = &opts->local;
-
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		if (addr->family == AF_INET6)
 			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 88b5db9114f4..62734d6b534d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -255,10 +255,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts,  u8 *add_addr)
+			      struct mptcp_out_options *opts, bool *echo,
+			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
 	u8 add_addr;
+	u8 family;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -266,25 +268,28 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	opts->local = msk->pm.local;
-	opts->remote = msk->pm.remote;
-	*add_addr = msk->pm.addr_signal;
-
-	if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
-	     ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
-	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
+	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
+	     mptcp_pm_should_add_signal_port(msk) ||
+	     mptcp_pm_should_add_signal_echo(msk)) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		remaining += opt_size;
+		*drop_other_suboptions = true;
 	}
 
-	if (remaining < mptcp_add_addr_len(opts, *add_addr))
+	*echo = mptcp_pm_should_add_signal_echo(msk);
+	*port = mptcp_pm_should_add_signal_port(msk);
+
+	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
+	if (remaining < mptcp_add_addr_len(family, *echo, *port))
 		goto out_unlock;
 
-	*saddr = msk->pm.local;
-	if (*echo)
+	if (*echo) {
+		opts->remote = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
-	else
+	} else {
+		opts->local = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	}
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 937e0309e340..08a76eaea2e5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -753,12 +753,14 @@ static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
 
 static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
+	return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.family == AF_INET6) ||
+		(mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote.family == AF_INET6);
 }
 
 static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
+	return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.port) ||
+		(mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote.port);
 }
 
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
@@ -766,25 +768,16 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *opts,
-					      u8 add_addr)
+static inline unsigned int mptcp_add_addr_len(u8 family, bool echo, bool port)
 {
-	struct mptcp_addr_info *addr = &opts->remote;
-	u8 len = 0;
+	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 
-	if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
-	    (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
-		addr = &opts->local;
+	if (family == AF_INET6)
+		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+	if (!echo)
 		len += MPTCPOPT_THMAC_LEN;
-	}
-
-	if (addr->family == AF_INET6)
-		len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-	else
-		len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
-
 	/* account for 2 trailing 'nop' options */
-	if (addr->port)
+	if (port)
 		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
 
 	return len;
@@ -800,7 +793,8 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts,  u8 *add_addr);
+			      struct mptcp_out_options *opts, bool *echo,
+			      bool *port, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
2.31.1

