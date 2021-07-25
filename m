Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F89173
	for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 14:18:18 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id e5so6613560pld.6
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BeXS/S8na+4tqktd30B89IdnbUNIERphBLgx0lpI4iA=;
        b=L5JWDpYcLtiBKAz3lk39SA5zp4JuEsOnOeGBFQk6ErPx5b89C2I3xz0AQoRz8vdxci
         pgJVuB2GHHcZBJlora5NAXp5M2fHORwoVBRQyeYuXDZS1jCe4SDZ+B9nyyGhINxB6ddB
         u8Dszc68NB89yaaZayxZvbGtwspaOhPPUQHFJhpHce7S1DOLGNK/nYXAxMFlzjmyOaZQ
         ZQf0ZN2xYClHgmKEbbxFijaUgnbkZ4kkO+nM3hp6ermaPtRnGECaEePCAq7rKrCXhYaz
         sfZKB9X3P2d87rUdDm2vZsTfPB+mOdg3dt0oTm6G6m8LcmcDwlmp7FrhUHSw78hHtDyF
         hHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BeXS/S8na+4tqktd30B89IdnbUNIERphBLgx0lpI4iA=;
        b=Ns/KKzLEadsmhgkVGJYsAspVx1BLWIkR7nL/sAxVgmFg5IF0aTsD/FFVs/Di4CUyOW
         BmSeDeH2gX8J+bHszTYJt9dkQdZR1kemjp7Yd/O/eiZj23hTrrq9kbxhw70MJO5ODrAr
         ebaeblHwhjq0WN2kdlu05Di2H7gE4DOeENvuev2aEG/phbY9v0U+hA70y/nQZ8Yf6Ly9
         YrIUaJ+5ENnaOaLMDIz21Pz6yoYesmU953eWv9fIqTE99htQJjewcaOLn5ru9LJqN8vG
         3RqaSvPSxzgzRQszWzTBU2clKkCb+A5DNBHP+VHOjEX02ROa8FXwdWAANvX0nHZxvu+7
         N9HQ==
X-Gm-Message-State: AOAM532pDrK/p27Sp95n1iOkCMfgYVckem+ABgt3gdTjmTErBzTr7lNn
	HvgFxl01W/BqZk7wxHU99K8ZW9ZWcT5b+Q==
X-Google-Smtp-Source: ABdhPJwyJnuvm0CgFO/x+OAUoho9R4NHotva6lAyictlOcLk5AcwiF2Vu6yKdPZQBBaPnNpI8BJFZg==
X-Received: by 2002:aa7:87cd:0:b029:32e:7954:2872 with SMTP id i13-20020aa787cd0000b029032e79542872mr13836507pfo.0.1627222698196;
        Sun, 25 Jul 2021 07:18:18 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id o134sm41200043pfg.62.2021.07.25.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 07:18:17 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next] Squash to "Squash-to: mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
Date: Sun, 25 Jul 2021 22:18:14 +0800
Message-Id: <ba5a3eff994cf1adf069c0e708adcea0d90daedb.1627222024.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
according pm.add_signal") reverts back to a single 'addr' field in
struct mptcp_addr_info.

Then no need to change the argument of mptcp_pm_add_addr_signal to
mptcp_out_options and no need to modify the code in mptcp_write_options
now, the original code is fine.

So this patch reverts back more code.

And the commit log needs to be updated:

'''
According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
the ADD_ADDR/ADD_ADDR_ECHO option.

In mptcp_pm_add_addr_signal(), use opts->addr to save the announced
ADD_ADDR or ADD_ADDR_ECHO address.
'''

v2:
- rename the 'saddr' argument of mptcp_pm_add_addr_signal to 'addr'.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 25 ++++++++++++-------------
 net/mptcp/pm.c       |  6 +++---
 net/mptcp/protocol.h |  2 +-
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eafdb9408f3a..cb29a5605776 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -668,7 +668,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	int len;
 
 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
 		    &echo, &port, &drop_other_suboptions))
 		return false;
 
@@ -692,8 +692,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 						     msk->remote_key,
 						     &opts->addr);
 	}
-	pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
-		 opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
+		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
 	return true;
 }
@@ -1250,16 +1250,15 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		struct mptcp_addr_info *addr = &opts->addr;
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (addr->family == AF_INET6)
+		if (opts->addr.family == AF_INET6)
 			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 #endif
 
-		if (addr->port)
+		if (opts->addr.port)
 			len += TCPOLEN_MPTCP_PORT_LEN;
 
 		if (opts->ahmac) {
@@ -1268,25 +1267,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
-				      len, echo, addr->id);
-		if (addr->family == AF_INET) {
-			memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
+				      len, echo, opts->addr.id);
+		if (opts->addr.family == AF_INET) {
+			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
 			ptr += 1;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (addr->family == AF_INET6) {
-			memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
+		else if (opts->addr.family == AF_INET6) {
+			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
 			ptr += 4;
 		}
 #endif
 
-		if (!addr->port) {
+		if (!opts->addr.port) {
 			if (opts->ahmac) {
 				put_unaligned_be64(opts->ahmac, ptr);
 				ptr += 2;
 			}
 		} else {
-			u16 port = ntohs(addr->port);
+			u16 port = ntohs(opts->addr.port);
 
 			if (opts->ahmac) {
 				u8 *bptr = (u8 *)ptr;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5fe3805af02a..8727ef75da79 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,7 +257,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts, bool *echo,
+			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
@@ -286,10 +286,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 		goto out_unlock;
 
 	if (*echo) {
-		opts->addr = msk->pm.remote;
+		*addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
 	} else {
-		opts->addr = msk->pm.local;
+		*addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
 	}
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b54335857b6e..9fce5b66fd4c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -801,7 +801,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts, bool *echo,
+			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
-- 
2.31.1

