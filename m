Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4070
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:05:05 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id y17so8586565pgf.12
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfcDdW3MOQuSFi42dzyLE2a3e0owA0IXcznnC0fXkFw=;
        b=t/xGdBnXMFbH4qnr62NwSTj3+AuXCw5AFExX8JfTlpWGQsjxxndAElo8DnIJRuK46D
         wsQPfUxa76kLLAorRu60WbKrA/GwcQ+E3BCSJRBYQoLAK+yt8/52u6KxEzTLb2fbGQPK
         IkS6U4ynPHgebN9HfQRJFZcPlCOTciAUsHqV+w6AQy8fyPFwLTpmjM72GC3lWBlCRwy+
         adPczoUaphc3RRtOqeBJUuFbRE9WKMQKtFYiK+cgWRe51OIt+rK71J3nWdMZ7bp2u3a0
         W4NQyOZ/eYdSr9ombpshYdDC4JvehcrFpyOO2Ip5SXbKJPWoEWSuUTJUEoFgTncVNKcP
         s7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfcDdW3MOQuSFi42dzyLE2a3e0owA0IXcznnC0fXkFw=;
        b=XYDC32zWkMspj89aPdPC0wrk4CI6o8lWbo3/2XC/8VpekUF3u+JrgyCGmoZgRqHu/0
         fcB0n0cX+ROaSOyCwvVnGRRwaduQ3lDoqsB4c+/tgY1IjlqZE4FK7/tdN/BgU+xcMHwJ
         f8r3wbPi7zUPcDGJWMg6YGb/yAI+C1JyBNanulj70NwT1xtmJwqIUwgoKgVTj4G+MrPj
         jnyf9Jif47kTb0Rk02X+ht5YWEjx3lptTOsQ9YY3mjnT9PGdLlZM4rsfRRvyMqIZCzkp
         KnywOaldeaWQIaxiH1d4yweyHmLen/PQmm/U7wcWgXuPfYeOcDg8ZxUdwV9+K/Wnj5f4
         +6Hg==
X-Gm-Message-State: AOAM530dGIPAKopgo/Fs5ZoQnlFim/9f4hmX2mBiAvdrQdQN5cmd1RpV
	i5pMHZXoDSeLF8HqNqDXi+cnV21Uv+VrsA==
X-Google-Smtp-Source: ABdhPJz96Vcy37/368D5XBz1Yt9T09YOnnbeNsBeqq7jpQwZWq4226y/LNBuNKklUvzbCfZay06vZA==
X-Received: by 2002:a05:6a00:1ac7:b029:32b:a408:939b with SMTP id f7-20020a056a001ac7b029032ba408939bmr8008367pfv.58.1626404705132;
        Thu, 15 Jul 2021 20:05:05 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:05:04 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 5/6] mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
Date: Fri, 16 Jul 2021 11:04:37 +0800
Message-Id: <e692d25333e3da8f0f2574277a508b274c5d8837.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <94457ebf428f392419c14baad4babbf7f93a26a2.1626404090.git.geliangtang@gmail.com>
References: <cover.1626404090.git.geliangtang@gmail.com> <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com> <26aadb84ac57a74e69d5a81dbdc84c4770117b20.1626404090.git.geliangtang@gmail.com> <6a400c9de23c2254e57d472ce7e49d16aec2e294.1626404090.git.geliangtang@gmail.com> <94457ebf428f392419c14baad4babbf7f93a26a2.1626404090.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT are not necessary, we can get
these info from pm.local or pm.remote.

Drop mptcp_pm_should_add_signal_ipv6 and mptcp_pm_should_add_signal_port
too.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm.c         | 12 ++++--------
 net/mptcp/pm_netlink.c |  6 ++----
 net/mptcp/protocol.h   | 12 ------------
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 10c9f44a1749..d0f39e814d1d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -35,10 +35,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		msk->pm.local = *addr;
 		add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
 	}
-	if (addr->family == AF_INET6)
-		add_addr |= BIT(MPTCP_ADD_ADDR_IPV6);
-	if (addr->port)
-		add_addr |= BIT(MPTCP_ADD_ADDR_PORT);
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	return 0;
 }
@@ -268,16 +264,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk) ||
-	     mptcp_pm_should_add_signal_echo(msk)) &&
+	if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
+	     ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
+	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		remaining += opt_size;
 		*drop_other_suboptions = true;
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
-	*port = mptcp_pm_should_add_signal_port(msk);
+	*port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
 
 	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
 	if (remaining < mptcp_add_addr_len(family, *echo, *port))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4ad4c8ae93a4..5694f51deee2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -544,10 +544,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		bool slow;
 
 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s%s%s",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr",
-			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
-			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
+		pr_debug("send ack for %s",
+			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
 		slow = lock_sock_fast(ssk);
 		tcp_send_ack(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1993e39a31c0..f8aa0f031ff7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -178,8 +178,6 @@ enum mptcp_pm_status {
 enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
-	MPTCP_ADD_ADDR_IPV6,
-	MPTCP_ADD_ADDR_PORT,
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
@@ -744,16 +742,6 @@ static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
 }
 
-static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
-{
-	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
-}
-
-static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
-{
-	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
-}
-
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
-- 
2.31.1

