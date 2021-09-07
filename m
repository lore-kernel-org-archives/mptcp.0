Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C43FC1
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 10:42:10 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id n18so9475154pgm.12
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nRF453gc3LoiL+DkmEG/qr8KJt3b8ZPwvak9UGeLFkM=;
        b=LAblFN+zHU/MP6R+KAFtj2sC3ddVaeRY6fFAKIr7sjTB2QUmvl/IgHgLO+NBvlZHH/
         PPKjaH3236lfhTZzOoAM1lvMIvf9U2w5wnl7VyFMAJVNuMcxBGAX7QPy2q3RVAhDDeFA
         MtEhzXFTDQaPcRIfaQAU+m0awzpS58uEIB9eeUJjilLdDi9KyBfKt53BDtu9as3gnQXC
         2qkjWgEfki0hkp9reBC6EVJSO+57kindgsibYyp3SCe9ue2qdr811el+CCBo/qYGioil
         d0wTR9coZdnF+d/vfKdYpz9VRmuoHDm10Rg1S6oEiHFDSMLt9WBK08wWOtARMhDq476Z
         DcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRF453gc3LoiL+DkmEG/qr8KJt3b8ZPwvak9UGeLFkM=;
        b=SBUIqRUBthnE6W4HyBYQs/nTUTw0eZh3jNeoeZd+/Hwf+7n0yZFEaYY1uqzOVVSEDV
         B3cZLQ0Trg4b+g0v8ica+rvwE89N1mReNlxhxrL5eImm3Yg/NOaUJODPL8WdwuGd1Gj/
         W/LUqeIM4eF/dgxI9FaLdrctzdmZC7DyyRSfNWipVMjRLMh42KPOeQUXwuGYBGuCNk14
         l1DiU5cI5Um0jYDLTpoAwWrUkaF8Q/eLbQs+JjdYmKLq0IHwbsRSVfCNy8LLxKFzro7V
         px+HsAUgZSt+1DMGU4gVL41FygEvX9/Uz2PoFX7/cNivfdHpet6gHo7K56Qdbqpb6TDN
         uiQw==
X-Gm-Message-State: AOAM5301G6fZ5C6CT5rAeKYOfaL5REgWR7XnFWPASnmOjH1z6G7O54is
	d07KyQj+8J4jw64qVWUq5i64Yy2rcJ0=
X-Google-Smtp-Source: ABdhPJyQlLPty/0iRY1S8pZE6y9c9upMmmMa+g7EzfNVXfaDnmzKuRwba93UzpnKp3jU1uGjd/BqsQ==
X-Received: by 2002:aa7:9282:0:b0:3e2:800a:b423 with SMTP id j2-20020aa79282000000b003e2800ab423mr16130932pfa.21.1631011330324;
        Tue, 07 Sep 2021 03:42:10 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x189sm10571885pfc.52.2021.09.07.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:42:10 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH RFC mptcp-next 3/4] mptcp: round-robin packet scheduler support
Date: Tue,  7 Sep 2021 18:41:58 +0800
Message-Id: <95d450f9694cf9d95081a77db529db2181d0d3b3.1631011068.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631011068.git.geliangtang@xiaomi.com>
References: <cover.1631011068.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Implement the round-robin packet scheduler like on the mptcp.org kernel.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/Kconfig    |  7 +++++++
 net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 10c97e19a7da..0df36991566a 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -23,6 +23,13 @@ config MPTCP_IPV6
 	depends on IPV6=y
 	default y
 
+config MPTCP_ROUNDROBIN
+	tristate "MPTCP Round-Robin"
+	default n
+	help
+	  This is a very simple round-robin scheduler. Probably has bad performance
+	  but might be interesting for researchers.
+
 config MPTCP_KUNIT_TEST
 	tristate "This builds the MPTCP KUnit tests" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ab72a3950f2b..b78c4eb4947f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1521,6 +1521,29 @@ static struct mptcp_sched_ops mptcp_sched_default = {
 	.owner		= THIS_MODULE,
 };
 
+#if IS_ENABLED(CONFIG_MPTCP_ROUNDROBIN)
+static struct sock *rr_get_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk != msk->last_snd) {
+			pr_debug("msk=%p ssk=%p last_snd=%p", msk, ssk, msk->last_snd);
+			msk->last_snd = ssk;
+		}
+	}
+	return msk->last_snd;
+}
+
+static struct mptcp_sched_ops mptcp_sched_rr = {
+	.get_subflow	= rr_get_subflow,
+	.name		= "roundrobin",
+	.owner		= THIS_MODULE,
+};
+#endif
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
@@ -1565,6 +1588,9 @@ static void mptcp_sched_data_init(struct mptcp_sock *msk)
 static void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
+#if IS_ENABLED(CONFIG_MPTCP_ROUNDROBIN)
+	mptcp_register_scheduler(&mptcp_sched_rr);
+#endif
 }
 
 static void mptcp_push_release(struct sock *sk, struct sock *ssk,
-- 
2.31.1

