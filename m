Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C229CA
	for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 15:15:44 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id a127so13705694pfa.10
        for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I25fEshtDqe0JE0WrNYNCm5YzHiaYd1BDVOg9a4KWIM=;
        b=fJxzeSyctSFa1PRXd57P4msupEtsFdMEvoXHAOAuCyq2Ru3AJ0tUjoiwNHjgmacXA0
         4bNlFUKbhVwcQvHeiMkjifvYXQtIGxFeZ+MAZ7/MMytzu/26ozdMWlWMcj4/WoFNgJob
         W9+1sISmg0SxL6EfytP9/Ond9TfnR3RiI+iSpLxA4y0adHYC2wjmnaybvmW95jm8fyV3
         fQn8hYkeXCI6LaVEvboRS4Ef+VQKCl/6cYdJdsuF8oOfRnX7e+sxUUTguyVYed9tvi5v
         0zfz6B00v169J1m2i/IkLnWX0aNgB2m0RQ3k5/YAH6Gn/tVEo0aX6LkLOIHXutB6y0ZK
         sF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I25fEshtDqe0JE0WrNYNCm5YzHiaYd1BDVOg9a4KWIM=;
        b=q9YigyicGZ1tLjmiOlRa2f+i76VY3GqUdr4zdr1GinN04gDjINnpoJcxsg+T4uPjWC
         U8SfkVJAmaaP3UKKxloAEahsSO+TSc8liBaKN8RfmrTntgOF74Yybq0sCSUOdAdW8Pfr
         22ioMVp/97FIs2LOHpVH5B5E9FWjDn78ILTFf1V3qRvwYvkMbH8fbYiG+rWDCh7eZ8/+
         sJDYmrnyZiwFCl+Ugpm1j/Ttj/CrX4A0zaHAGdovNRu24kOx/SDq6w1PysH5cGKp90NU
         Vvj9XScsMFoqL0L8wuOfZ/MsszGGnZIr/Ggiz6jIhoJenYjzc+jZbCzkau/cikhiLjwv
         69oA==
X-Gm-Message-State: AOAM530sYzIDpP2l4baPcvcsAwuXWYkG812pmW75PPmwjlMjBVWszTjF
	TKfBU4skhxL8ynnApFU5nrAZNV4VoQqyiA==
X-Google-Smtp-Source: ABdhPJyaMjMnnhul8jX0PZjWXmy98gf7d6D+RT4iXs47eirKW/I5MMVUZvmKKHhCwLBOVUIMcIMmrg==
X-Received: by 2002:a62:bd05:0:b029:30a:dc6:88b7 with SMTP id a5-20020a62bd050000b029030a0dc688b7mr49396408pff.51.1626016544417;
        Sun, 11 Jul 2021 08:15:44 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 10sm12139641pjc.41.2021.07.11.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 08:15:44 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
Date: Sun, 11 Jul 2021 23:15:36 +0800
Message-Id: <80fa33a249c2ecc7edd9d0047dd84f163307cee7.1626016292.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think there're still some issues in v8:

The remaining value is incorrect since "remaining += opt_size;" in the
"drop other suboptions" checks has been called twice in
mptcp_pm_add_addr_signal and mptcp_established_options_add_addr.

opts->local and opts->remote in mptcp_pm_add_addr_signal need be
populate after the length chech, not before the check.

The squash-to patch keeped the more orignal code unchanged, and just do
the least, necessary modifications.

Drop the "drop other suboptions" check in mptcp_pm_add_addr_signal.

Change arguments of mptcp_pm_add_addr_signal.

Keep mptcp_add_addr_len unchanged.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 35 +++++++++++++++++------------------
 net/mptcp/pm.c       | 23 +++++++++--------------
 net/mptcp/protocol.h | 27 +++++++++------------------
 3 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5c0ad9b90866..93ad7b134f74 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -663,16 +663,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
-	u8 add_addr;
+	bool echo;
+	bool port;
+	u8 family;
 	int len;
 
-	if (!mptcp_pm_should_add_signal(msk) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
-		return false;
-
-	if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
-	     ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
-	      (opts->local.family == AF_INET6 || opts->local.port))) &&
+	if ((mptcp_pm_should_add_signal_echo(msk) ||
+	     (mptcp_pm_should_add_signal_addr(msk) &&
+	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
@@ -682,7 +680,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		drop_other_suboptions = true;
 	}
 
-	len = mptcp_add_addr_len(opts, add_addr);
+	if (!mptcp_pm_should_add_signal(msk) ||
+	    !mptcp_pm_add_addr_signal(msk, remaining, &opts->local, &opts->remote, &echo, &port))
+		return false;
+
+	family = echo ? opts->remote.family : opts->local.family;
+	len = mptcp_add_addr_len(family, echo, port);
 	if (remaining < len)
 		return false;
 
@@ -690,15 +693,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -= opt_size;
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
@@ -1253,13 +1255,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
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
index 264f522af530..399b59cb7563 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -253,12 +253,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
-			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts,  u8 *add_addr)
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
+			      struct mptcp_addr_info *saddr, struct mptcp_addr_info *daddr,
+			      bool *echo, bool *port)
 {
 	int ret = false;
 	u8 add_addr;
+	u8 family;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -266,21 +267,15 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	opts->local = msk->pm.local;
-	opts->remote = msk->pm.remote;
-	*add_addr = msk->pm.addr_signal;
+	*echo = mptcp_pm_should_add_signal_echo(msk);
+	*port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
 
-	if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
-	     ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
-	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
-	    skb && skb_is_tcp_pure_ack(skb)) {
-		remaining += opt_size;
-	}
-
-	if (remaining < mptcp_add_addr_len(opts, *add_addr))
+	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
+	if (remaining < mptcp_add_addr_len(family, *echo, *port))
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
+	*daddr = msk->pm.remote;
 	add_addr = READ_ONCE(msk->pm.addr_signal);
 	if (mptcp_pm_should_add_signal_echo(msk))
 		add_addr &= ~BIT(MPTCP_ADD_ADDR_ECHO);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 937e0309e340..4b63cc6079fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -766,25 +766,16 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *opts,
-					      u8 add_addr)
+static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
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
@@ -798,9 +789,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
-			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts,  u8 *add_addr);
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
+			      struct mptcp_addr_info *saddr, struct mptcp_addr_info *daddr,
+			      bool *echo, bool *port);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
2.31.1

