Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7B173
	for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 13:41:16 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so10406255pjh.3
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucaDzAOuM83CPxeMTN4XHYAbN3oxTzxTngVrfOw2mZQ=;
        b=rYg7Wh+M0BvC6FkQtTFk4YG6PV+FQKJknXwXzDuMojbtDU0TYds/gl1//xGPxeb74t
         ZA++4UY1k9mlgYAIreCmvhuT0qAx7i8a44EWh9xnLHS84YRP/8qMTaG8BM91Z3LWnPD2
         PNI/7G8tQL+pOnMbUP7G0dYtLVp2ZJ8mVzt4eXMQGni/3jsM0JofAZLAzMhMogEAd4qv
         1VEodbjwyx6lIXcNXQyXHcB6Lt/ocUQDOeQKeERcPstehCpkrnSMqutZ/2eSWu4oaSpS
         tYQgFy3YyUgvucn9g/mFkBM415bxc+DbPYkTFdpw/ZIqDQrwKY3sISh6G/o7TfspoE2S
         lLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucaDzAOuM83CPxeMTN4XHYAbN3oxTzxTngVrfOw2mZQ=;
        b=iwlleGNdxKk8sVVixAJ519jZ8ifvvdTnyaCCEhUxASjcr5d6XLzwDDjOB2Qa0yuNPy
         LCpv7rCzGD22OEBP8qaV6jS/aOafinmDjiQOFSKHnwSk30rfVeP4jd4MJHPQ3URFJ7sM
         wHxWdOjtpJKB5voJkjqGHlEIVMrnwJVSojddUbMHeydpEvJAhiDXR1XInwrYdjGJFKA6
         CkdwgSVRUJ2dT4Dp9lOh+xh2BbZ6XpQzHtq+/6aOkW88NBhou4dS4wB0IYbo9iYDkGM/
         lFg4bkJNrdL9ZCeOgPIvjptkFfxir4Pr2UiDgSi5aQbL/7OoStzIwKQhbX3sCvBz3HGp
         uSQg==
X-Gm-Message-State: AOAM533bXzOXbHQN7AfK1qDGx05ibHrLN5SUlxPSm9QJX5meGh3atwUI
	eZwQNaAO5Ot7az4/hT+LBjYOBKz4Qneq1Q==
X-Google-Smtp-Source: ABdhPJxDgP/i+7/HfWZvkqKcC6/NaKCHLdAkMNDrKapyTsDuK+6Py5p134UPn5i8XVQuxb+YittU8w==
X-Received: by 2002:a62:3107:0:b029:377:858b:20a3 with SMTP id x7-20020a6231070000b0290377858b20a3mr11760056pfx.25.1627220475757;
        Sun, 25 Jul 2021 06:41:15 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id k11sm8314694pgc.30.2021.07.25.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 06:41:15 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "Squash-to: mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
Date: Sun, 25 Jul 2021 21:41:11 +0800
Message-Id: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
according pm.add_signal") reverts back to a single 'addr' field in struct
mptcp_addr_info.

Then no need to change the argument of mptcp_pm_add_addr_signal and no
need to modify the code in mptcp_write_options now, the original code is
fine.

So this patch reverts back more code.

And the commit log needs to be updated:

'''
According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
the ADD_ADDR/ADD_ADDR_ECHO option.

In mptcp_pm_add_addr_signal(), use opts->remote or opts->local to save the
announced ADD_ADDR or ADD_ADDR_ECHO address.
'''

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
index 5fe3805af02a..781da0885f98 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,7 +257,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts, bool *echo,
+			      struct mptcp_addr_info *saddr, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
@@ -286,10 +286,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 		goto out_unlock;
 
 	if (*echo) {
-		opts->addr = msk->pm.remote;
+		*saddr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
 	} else {
-		opts->addr = msk->pm.local;
+		*saddr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
 	}
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b54335857b6e..099e3e6a4c89 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -801,7 +801,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts, bool *echo,
+			      struct mptcp_addr_info *saddr, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
-- 
2.31.1

