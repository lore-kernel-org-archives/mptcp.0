Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D92F80
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:37 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id o5so2197266edc.5
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2R7IB3T8nXkD3Z9xfKk+7vNzqPqPAMPWq/WLiAQ3S9E=;
        b=bOem0Za/rcxp2rUARsm4ezRrbv8sLvGyDnRL1NFcaJc7J0XEM45wpH4pvuMTkwwfGQ
         f4uAoqr/S467G49vD57SHMDAqGiK7FXBQrKi+UPD/Iz3gRLhotGCCf376M/r7xEgDoLz
         rf2vkZcvi4UNbYVqJXXrbjBz6GwsbhTDJoIeR3k0ugogopsyatXk6zOdNgxFJLUHKl7Y
         SyOK5DZn9Fe2JHTr/l/W0SlNXeTVFO0J9LhUITRY+LAtRasFFEpcLabUwyKsNBO+Rj4k
         2WRFbJuBhJMllVoRypP2RczQXcsuPN8g04GvR9wBehsBL4bnGi5d0/DOhff1T4klPkx+
         ngOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2R7IB3T8nXkD3Z9xfKk+7vNzqPqPAMPWq/WLiAQ3S9E=;
        b=M7UPhd/9u0TmoyDzfHXwJt4z6+hMzCuMRAmDTK6omIWBQtM6z3Yi+et9slOdEJiuLt
         jq7Hh9KPeM9kYN8bvXGsQcaFh/xNaYRwpNuXxoUUac+eaAXu+Wses/K3Ji2YVKs/x9JP
         ThIGS3UhH4A5FnRr3GTXwR+ctuHwim0TJmk2NHQmK/Kwq3+Wxsni9Pb3gehf7zWdALxO
         tWAiIeZe1k0IIHzzaQSVHz5bAFgOkmLXFLwL+6HuRTOPJRo/8MDK44x+dipScK9zqc4O
         Xif+cuPm3ERAfS+oKGYSs7SatFjdF/vhDzU91Re2LMw4fYFdFiQ+XptK+YNciAr9q42u
         LVfg==
X-Gm-Message-State: AOAM5330avGPTv9q29RgYyuDvG4U14K4uPGS4pekHf2bD3qtfesKPhGK
	bkgNhko4AIEMWq8RkY8+wfoH1bEV1VqvLfkm
X-Google-Smtp-Source: ABdhPJzbommUWU/1oNok1zZ9+0dyCHkzU7v7kFjId0z1/Yy9sz0OYhjnY2KRKX7NUQaRaG32E/vjkA==
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr37856452edc.362.1622045315802;
        Wed, 26 May 2021 09:08:35 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [RESEND] [MPTCP] [RFC PATCH 2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
Date: Wed, 26 May 2021 18:08:06 +0200
Message-ID: <20200924143505.27641-3-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160806.rIDA-4-syBCl_52leGyXIBVIYbqUskUiH4uMOJda5WU@z>

From: Florian Westphal <fw@strlen.de>

Will be needed to fill in the MPTCP reset option from tcp_ipv4/ipv6.c.

It would make more sense to place mptcp_option() in mptcp.h, but
TCPOPT_MPTCP is defined in tcp.h, and mptcp.h is included from tcp.h,
not the other way around.  Placing the helper in mptcp.h thus results
in a build failure because TCPOPT_MPTCP is not defined.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h  | 10 ++++++++++
 include/net/tcp.h    |  5 +++++
 net/mptcp/protocol.h | 11 -----------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6e706d838e4e..5f5062580e0e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -68,6 +68,11 @@ static inline bool sk_is_mptcp(const struct sock *sk)
 	return tcp_sk(sk)->is_mptcp;
 }
 
+static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
+{
+	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
+}
+
 static inline bool rsk_is_mptcp(const struct request_sock *req)
 {
 	return tcp_rsk(req)->is_mptcp;
@@ -153,6 +158,11 @@ static inline void mptcp_init(void)
 {
 }
 
+static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
+{
+	return NULL;
+}
+
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
 	return false;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 852f0d71dd40..ea8c134802e8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2406,4 +2406,9 @@ static inline u64 tcp_transmit_time(const struct sock *sk)
 	return 0;
 }
 
+static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+{
+	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
+		     ((nib & 0xF) << 8) | field);
+}
 #endif	/* _TCP_H */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..e8c873c66182 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -130,12 +130,6 @@ struct mptcp_options_received {
 	u16	port;
 };
 
-static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
-{
-	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
-		     ((nib & 0xF) << 8) | field);
-}
-
 struct mptcp_addr_info {
 	sa_family_t		family;
 	__be16			port;
@@ -486,11 +480,6 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 
-static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-{
-	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
-}
-
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
 	return (__s64)(seq1 - seq2) < 0;
