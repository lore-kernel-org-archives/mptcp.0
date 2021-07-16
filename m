Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4370
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:05:03 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so8028097pjb.3
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPydqLc3R6TA0RJtyB8NDL1Wvq7t6mfjHj8cMmGpvY0=;
        b=b7N8eLsH1kWcTIwLU+xNpRkf3VtKRy+AiBEeojOdAxqhQLi6Gj2xufBAvwOqNRy87M
         nDl+a0nxtF/DUcnZxBeXQvgIzEncOUDhlXm0PvmU0WRKzN3cpsQzQ4Ralu4sRnAMcTLo
         jvgVc7jdo5+cY1nazoTi7P5g16zwNeik/N9LcuwnZ1OvnOEcB4KZUHX8bbbM0xM9Rr0v
         4hJLMnCY0gaMkEvbIHLj+zShXKUDZRUDwl/bpgcTvbZcC4/fIfbdQYDlcyvqMa9TqQP3
         fHLRZ2gOlUa9D66J1PvPWpi6EjYj8PdbWgWZGN3zD8e79inE5l/HF7H6qEN9sHo+jKjt
         6NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPydqLc3R6TA0RJtyB8NDL1Wvq7t6mfjHj8cMmGpvY0=;
        b=qnV9sIhqq3bkCKzN6BSWiI+wARf8kb6E1i2XVVVW0oTcgvY7YvosMNYgaamAGMsGkr
         THOq92MMZjnLuuDOVY03cm9YsMW/fe+6/WXT6sHIJ5torarp0moxSFteXBdH0M881KiS
         Dumq+hfsleU93JH0pUUdiDZeEtlwQI5yKRPCC8rH+hL6Qd82hqPPVa6Y/amh2hcY+bK0
         Hq0ZnO1aGv4ZOkKMjFB5Gf5SWFqKaMEeT45wWSjpE+fmkJXQmIiA2jIQoa5s2VIRuUpw
         W4q+N8WbZRIAcfIPFzVeLraK8hMp24/PzTeuO0+dHU6fwb8vxNLcRwuobdds2q1TkEMN
         9hgw==
X-Gm-Message-State: AOAM530+ATOlekwbLHCqd+VFVBmfbDxV5HicMr6+wTrMtOPRpGjV4g/5
	wBnQYZM92nXIJPcUr8CFB/qKmEJo0a7yIg==
X-Google-Smtp-Source: ABdhPJw9g2u1lOZmCG/e2gRLwdzPrVTPy7ATxreCtj75fASeM+p5sWQLQpyyicB5khV/bvbObx61jQ==
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr13088841pjo.97.1626404703393;
        Thu, 15 Jul 2021 20:05:03 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:05:03 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 4/6] mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
Date: Fri, 16 Jul 2021 11:04:36 +0800
Message-Id: <94457ebf428f392419c14baad4babbf7f93a26a2.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <6a400c9de23c2254e57d472ce7e49d16aec2e294.1626404090.git.geliangtang@gmail.com>
References: <cover.1626404090.git.geliangtang@gmail.com> <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com> <26aadb84ac57a74e69d5a81dbdc84c4770117b20.1626404090.git.geliangtang@gmail.com> <6a400c9de23c2254e57d472ce7e49d16aec2e294.1626404090.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
the ADD_ADDR/ADD_ADDR_ECHO option.

Add a new member remote in struct mptcp_out_options for the ADD_ADDR_ECHO,
and rename addr to local for the ADD_ADDR only.

In mptcp_pm_add_addr_signal(), use opts->remote or opts->local to save the
announced ADD_ADDR or ADD_ADDR_ECHO address. And in mptcp_write_options(),
put this saved address into the ADD_ADDR/ADD_ADDR_ECHO option.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 32 ++++++++++++++++++--------------
 net/mptcp/pm.c       | 14 +++++++++-----
 net/mptcp/protocol.h |  2 +-
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b5af683a818..d0b9e4a7121f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -61,7 +61,8 @@ struct mptcp_out_options {
 	u64 sndr_key;
 	u64 rcvr_key;
 	u64 ahmac;
-	struct mptcp_addr_info addr;
+	struct mptcp_addr_info local;
+	struct mptcp_addr_info remote;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dc09c853ed5b..37ff15aeb2f7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -665,16 +665,18 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	unsigned int opt_size = *size;
 	bool echo;
 	bool port;
+	u8 family;
 	int len;
 
 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
 		    &echo, &port, &drop_other_suboptions))
 		return false;
 
 	if (drop_other_suboptions)
 		remaining += opt_size;
-	len = mptcp_add_addr_len(opts->addr.family, echo, port);
+	family = echo ? opts->remote.family : opts->local.family;
+	len = mptcp_add_addr_len(family, echo, port);
 	if (remaining < len)
 		return false;
 
@@ -690,10 +692,11 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (!echo) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
-						     &opts->addr);
+						     &opts->local);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
-		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
+	pr_debug("local_id=%d, local_port=%d, remote_id=%d, remote_port=%d, ahmac=%llu, echo=%d",
+		 opts->local.id, ntohs(opts->local.port), opts->remote.id,
+		 ntohs(opts->remote.port), opts->ahmac, echo);
 
 	return true;
 }
@@ -1248,15 +1251,16 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		struct mptcp_addr_info *addr = opts->ahmac ? &opts->local : &opts->remote;
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (opts->addr.family == AF_INET6)
+		if (addr->family == AF_INET6)
 			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 #endif
 
-		if (opts->addr.port)
+		if (addr->port)
 			len += TCPOLEN_MPTCP_PORT_LEN;
 
 		if (opts->ahmac) {
@@ -1265,25 +1269,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
-				      len, echo, opts->addr.id);
-		if (opts->addr.family == AF_INET) {
-			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
+				      len, echo, addr->id);
+		if (addr->family == AF_INET) {
+			memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
 			ptr += 1;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (opts->addr.family == AF_INET6) {
-			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
+		else if (addr->family == AF_INET6) {
+			memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
 			ptr += 4;
 		}
 #endif
 
-		if (!opts->addr.port) {
+		if (!addr->port) {
 			if (opts->ahmac) {
 				put_unaligned_be64(opts->ahmac, ptr);
 				ptr += 2;
 			}
 		} else {
-			u16 port = ntohs(opts->addr.port);
+			u16 port = ntohs(addr->port);
 
 			if (opts->ahmac) {
 				u8 *bptr = (u8 *)ptr;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 046ad6ad6692..10c9f44a1749 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -255,11 +255,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo,
+			      struct mptcp_out_options *opts, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
 	u8 add_addr;
+	u8 family;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -278,14 +279,17 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	*echo = mptcp_pm_should_add_signal_echo(msk);
 	*port = mptcp_pm_should_add_signal_port(msk);
 
-	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
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
index 023a6903f2c8..1993e39a31c0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -784,7 +784,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo,
+			      struct mptcp_out_options *opts, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
-- 
2.31.1

