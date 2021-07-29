Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB470
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 08:40:27 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso14523738pjb.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDgJAUP0S0b2EesBRAqbIppXvUW8pdYAC+LZOCoF3BI=;
        b=Dqz2D5AtBo4RGjg86q66i+r3Ox41D9EK61DQPXr1sZNptmQfZeP6HFJ8GQ92QvsHXp
         LT9HKQbUq66hw6e/i3UgOrAMi+PgGBEHujALwms0XW7KfEWWQ88AqO3o5fss5Z48b8js
         SZVBlv0cz0+GxJIfFNFEoca0SYIQM1wJeZ0t+URJdWR4JiWVhXNgXzRA0vk6NdcU62vu
         bQaLaDjrpq1+f31+wZmFWG8RCGTU47YQPc7sK3W9kukEiVx0RKiqTSgsW5buqJduqlsN
         g4Lkz0kU8wdtS+vWFDRKkYzUSdsbOPZXQH9PjI/VjbvlvzVdGGuz8L+4A1Ktlx8OeHoC
         vyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDgJAUP0S0b2EesBRAqbIppXvUW8pdYAC+LZOCoF3BI=;
        b=VUQJ7khzmLrP8W496IVjhWyGbMtVcUz/ObuWTxe4PmZliwGtNmG/AfZq/f47kzNDMc
         AVr54+s5+NSJvN8ab6x9nCRocrj3DEX5lGpi/VS52LgP7yKrh5+SwFoBEcnhP5Wjo1Gc
         3cRmmOM5rBom9mVK1YlKH705CecI4HPMW3mmA7alHG9zkV/HSt+0DSUtAvxoQ6/YAfUt
         iOd24yliN0dU4iQJ3/V8Xlikl+AplOYyRFun10MNVZQhzH8uFZArGGfSfJXEpGk65KIj
         VWlwlGM7de8xbV4dm0qOxSMtJkq3x9+Sx8FB6uk56NQQgF/IurJzTx99XNxlhFSD5tPD
         JnCg==
X-Gm-Message-State: AOAM533jri8gzyfaPmhEl+LLoIwTZa7UBrCrXmBwnLRo2urMQk3hy4w1
	qCjkLPmF2E2TmjRcDiI0kpqwrDpxt/4=
X-Google-Smtp-Source: ABdhPJzU/tDGLpiXRkRJq+TtSCBA9VxMPMruN748jn8KxPn3YKoTDFFNhvAB21yNxtUd5I3/BgEWHA==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr6254532pjt.78.1627548026896;
        Thu, 29 Jul 2021 01:40:26 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f5sm2401539pjo.23.2021.07.29.01.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:40:26 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 4/5] mptcp: add the mibs for MP_FAIL
Date: Thu, 29 Jul 2021 16:40:12 +0800
Message-Id: <1ad053e0160d44c3bc998149aeef9a55306e3eb4.1627547666.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cfc2f48712c35a61be26ee92db8e900decc07217.1627547666.git.geliangtang@xiaomi.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com> <d04456a7439e4cdab65aea27a035e5b89d5c0e2a.1627547666.git.geliangtang@xiaomi.com> <0c155f43f4bc75c90cf45283e07ea48432178d48.1627547666.git.geliangtang@xiaomi.com> <cfc2f48712c35a61be26ee92db8e900decc07217.1627547666.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the mibs for MP_FAIL: MPTCP_MIB_MPFAILTX and
MPTCP_MIB_MPFAILRX.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 1 +
 net/mptcp/subflow.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3a7c4e7b2d79..b21ff9be04c6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -44,6 +44,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
+	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
+	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 8ec16c991aac..ecd3d8b117e0 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -37,6 +37,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
+	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
+	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ba7166daf6cb..eaee69df6635 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,6 +1158,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d405385d2e7f..0f210d95133d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -911,6 +911,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

