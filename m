Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E98177
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:05:00 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso6148852pjp.5
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IRG9xHzkfGOe6a6RpSMokTq15bFqQ4ymprKBRyJGzs8=;
        b=H6PlOO8csPDu0sMFkJOJm0pB4Vlb/LTwE8oqFXymEarfJdpUFxSl65rQWVGdlbccBf
         JI+dHFep5PSsAv43LCWDkneozZFnMJoq4VVHCtKrk2YEo7YpCZHlYDoLH/9ZQc68Plj0
         r97CUPOZ1Z81UCeRYI5/uYtPdp/lBITLHsye3HmZbKeXUHW+TC1qDnL94Pwd8v2Cv5jA
         WCJFjdiKbh5E1C8NoFPRsk3Jt1+5hZlDY8JULsEhNMu9zO4uaoLwqPXJJjOlv5O5jQKJ
         vYkPEXHfXK3TBvIw4DT40+4Fk+QOI3yDcTppg+yZG0NWutHyDxOhvqnOQylBGaRZsCjA
         EtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRG9xHzkfGOe6a6RpSMokTq15bFqQ4ymprKBRyJGzs8=;
        b=FHe31uZ1CKw+8A9geMf1sVpMziNJgXZHDXbmMnzTVnRgJjO3Kyo9p/C/lVFU6tw3bW
         M1x23zD9S4+JDsX7sAN72m3pf47FloNTUrcuDDRm++8+dP0A66cGVxurNYU+YTCvMeen
         eB7m5693afI5wK9wRksNeIiKg5xzaUMfSGHe3SupdXNzNV1VYSccPhwh5QdtrSPQdyvg
         bdQ3/GAgYvWjPVeUF0dd5DIcPUcV2eMlkpV7+LsNjddHKAHRUG1VPaZjturmzevpjHuG
         T1QfrBkISRHvcEazSVbXtC48qFwydXGG8wdoBFdUZXfGMgSiYinBLlMGi1w/a89jfIKp
         f5rw==
X-Gm-Message-State: AOAM533vqOlajC0G4/JPVrHiVWIiljuaQWS4GzIljmRl4SV4DiRIGIY7
	tdbdgOxvXhIjG0DUplnuRpMS06mwCW4UKQ==
X-Google-Smtp-Source: ABdhPJyRO1FpPiR/HIw0BoQcFJWUDqar3EGMDgLXbdxfvKjwnOKEMBhASFJVuamxyoN52yxXFa15zg==
X-Received: by 2002:a17:90a:7e81:: with SMTP id j1mr7549529pjl.26.1626404699527;
        Thu, 15 Jul 2021 20:04:59 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:04:59 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 2/6] mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
Date: Fri, 16 Jul 2021 11:04:34 +0800
Message-Id: <26aadb84ac57a74e69d5a81dbdc84c4770117b20.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com>
References: <cover.1626404090.git.geliangtang@gmail.com> <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

Use MPTCP_ADD_ADDR_SIGNAL only for the action of sending ADD_ADDR, and
use MPTCP_ADD_ADDR_ECHO only for the action of sending ADD_ADDR echo.

Use msk->pm.local to save the announced ADD_ADDR address only, and reuse
msk->pm.remote to save the announced ADD_ADDR_ECHO address.

To prepare for the next patch.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm.c         | 16 ++++++++++------
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   |  6 ++++++
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c0a2c55008e3..311336ce1247 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,19 +18,23 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d", msk, addr->id);
+	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	if (add_addr) {
-		pr_warn("addr_signal error, add_addr=%d", add_addr);
+	if (add_addr &
+	    (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
+		pr_warn("addr_signal error, add_addr=%d, echo=%d", add_addr, echo);
 		return -EINVAL;
 	}
 
-	msk->pm.local = *addr;
-	add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
-	if (echo)
+	if (echo) {
+		msk->pm.remote = *addr;
 		add_addr |= BIT(MPTCP_ADD_ADDR_ECHO);
+	} else {
+		msk->pm.local = *addr;
+		add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
+	}
 	if (addr->family == AF_INET6)
 		add_addr |= BIT(MPTCP_ADD_ADDR_IPV6);
 	if (addr->port)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d2591ebf01d9..4ad4c8ae93a4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -317,14 +317,14 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
-	if (mptcp_pm_should_add_signal(msk)) {
+	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
 	}
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal(msk)) {
+	if (!mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 96bbbb9698db..023a6903f2c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -729,6 +729,12 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.addr_signal) &
+		(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
+}
+
+static inline bool mptcp_pm_should_add_signal_addr(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
-- 
2.31.1

