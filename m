Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAED177
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:04:58 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id 62so8645014pgf.1
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQVl6m2rmKeD5VU13pAXJmy7jUGRz/1xIPswfWNovEQ=;
        b=OqmZiUnUeENZ961KdZmUZ7LPcbe6A6iFe5k6qpqg2MW7eUdom0o/s9JvuCWdzNx0zM
         PKELSIC2Cm2wrU5s1JbJLJnfv44ZzgRVq0WnJD3MgM15t8yBTWWWkTBOWRxukbzSPHOD
         7NTQ8ap/i/wEbvn2hNYA1l3F1ba8dTafi7pvmTJMjp7njtEC0Jlj1xFlsX3O93hsNGLG
         0wNW7p60azjYe72Ou1QBCdysM4xLZOFptJIWB8x9ouZT7dY5b3QLLdrFeEl5bJXgfT94
         zQ1m7Zx3DXXUg28vEC9Udibt6iOy79UpvklPIOQXngTNmiY0rmQu5vXVdD/9KXZZaO2Q
         tOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQVl6m2rmKeD5VU13pAXJmy7jUGRz/1xIPswfWNovEQ=;
        b=nuTFmXMbAAGzIV6FlZNXgN3ivcJUV00+gRsiUzSBoJt+YVjLo2TWsYeL49nMf219tA
         0/ivIXWHD6lSS817BoZ2YbxjjNX4yVGJlYxIDBGZcrh6+1tI9qbNi+hMTTMpjJIrS5uF
         IUlvSAz9QekR8hWEIlLV8tgtPXPafmYrJ6IbnCvqIkegdce/V484pgahW3C7/tiqZ+cJ
         AVhKeuEmeGlr3qZW8InzdM9h3cK1XBIbnIlwdy6dXqunZSMIKyRttW/JHY3rzYGO7WKo
         bqw1C1VUzM50FlkYd1Bt6VEw23WkIoQvODmXJ12RqNOsqmLsaRzjN6BJbJ3REbgDUoHV
         HvBw==
X-Gm-Message-State: AOAM530MJfxvxGBsngVcGpakGVXBPl8hnjca+fb+uJpj1GKa6NWCFkRT
	rLHImuqrQgDmi6orqX2S0aljYZ7Xom7Ivg==
X-Google-Smtp-Source: ABdhPJwo0BA8zaXzL+Bdheum+5B5A61/mhWrdYfi4/q9PiPHz/1ElOfl2jTZ5Q3MOGVFUlrSSTSSmA==
X-Received: by 2002:a05:6a00:180d:b029:331:bcb5:1589 with SMTP id y13-20020a056a00180db0290331bcb51589mr7949579pfa.27.1626404697735;
        Thu, 15 Jul 2021 20:04:57 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:04:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 1/6] mptcp: move drop_other_suboptions check under pm lock
Date: Fri, 16 Jul 2021 11:04:33 +0800
Message-Id: <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626404090.git.geliangtang@gmail.com>
References: <cover.1626404090.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

This patch moved the drop_other_suboptions check from
mptcp_established_options_add_addr() into mptcp_pm_add_addr_signal(), do
it under the PM lock to avoid the race between this check and
mptcp_pm_add_addr_signal().

For this, added a new parameter for mptcp_pm_add_addr_signal() to get
the drop_other_suboptions value. And drop the other suboptions after the
option length check if drop_other_suboptions is true.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/options.c  | 24 ++++++++++--------------
 net/mptcp/pm.c       | 14 ++++++++++++--
 net/mptcp/protocol.h |  6 ++++--
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4452455aef7f..dc09c853ed5b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -667,29 +667,25 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	bool port;
 	int len;
 
-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk) ||
-	     mptcp_pm_should_add_signal_echo(msk)) &&
-	    skb && skb_is_tcp_pure_ack(skb)) {
-		pr_debug("drop other suboptions");
-		opts->suboptions = 0;
-		opts->ext_copy.use_ack = 0;
-		opts->ext_copy.use_map = 0;
-		remaining += opt_size;
-		drop_other_suboptions = true;
-	}
-
 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+		    &echo, &port, &drop_other_suboptions))
 		return false;
 
+	if (drop_other_suboptions)
+		remaining += opt_size;
 	len = mptcp_add_addr_len(opts->addr.family, echo, port);
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
 	if (!echo) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 639271e09604..c0a2c55008e3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -249,8 +249,10 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+			      unsigned int opt_size, unsigned int remaining,
+			      struct mptcp_addr_info *saddr, bool *echo,
+			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
 
@@ -260,6 +262,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
+	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
+	     mptcp_pm_should_add_signal_port(msk) ||
+	     mptcp_pm_should_add_signal_echo(msk)) &&
+	    skb && skb_is_tcp_pure_ack(skb)) {
+		remaining += opt_size;
+		*drop_other_suboptions = true;
+	}
+
 	*echo = mptcp_pm_should_add_signal_echo(msk);
 	*port = mptcp_pm_should_add_signal_port(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0f0c026c5f8b..96bbbb9698db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -776,8 +776,10 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+			      unsigned int opt_size, unsigned int remaining,
+			      struct mptcp_addr_info *saddr, bool *echo,
+			      bool *port, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
2.31.1

