Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2E2FB6
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 12:02:57 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id c8so4977042pfp.5
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqS8zjFTkZjrQNE6qhLkNn0KteMS96e/f4BX5wpkWQs=;
        b=MUBklE23/OHag60zTpv09AcrNEvLcYPdySehWaxPjWfS8Pqvof7+QmIL7bL6DzEAQK
         8gqEmvfOeBDO6qfsVvd3Qs8B18mlNf8Zg+DGnRhdU052CR3QiVwODiHh8jEaP3reWAEy
         iZEqahmOx1YVAfnp02zf02+G/eVoupsKvYlq5b6T4OfLyXRKUacO4YpgnotBeu6pV4Tj
         DA69tB7jU0LUIqnax/ypF5uflnyKI+CmhtsfFjMcuH1S0dktoFoNkllaB+P3itN3o+dc
         wTkN8DsKLT3dj717Z26N5oD8TWYbMFUgZ5lTj+DpJ4EqthKFmDgHygDuDmve9GBqy2bO
         O9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqS8zjFTkZjrQNE6qhLkNn0KteMS96e/f4BX5wpkWQs=;
        b=WSskbhW8DH8qD6b3I29nUwDzOr4vcH0NpVsjIb5fgMoscsUJ51d6g3RNfDJDfbhAgm
         F/Tkhc/VNJ55qgrTZdyQG7v9ERUdRfhXu1K4HnBUYJjGg2nrao40vwdUZbhAKNWNSAri
         RGnG+pnEaPaeROtcBgvxvPsVqGD1syNpJf5Jg/8e9dZgIbR4qY7JZHeUQsTlVDHiXREG
         MvnHpE715fJpyExqFK/Ib9kmavM+xrwAKh0NcxKHyVrSku42cHeH3HI0v6aKprHfBL9m
         2jVW62cSV/A5hGWCGZNkVRaydFT350178g3mAi3MOXbIE3EEbM78OYEIrLZeApkkcf4F
         YypQ==
X-Gm-Message-State: AOAM5326BkQekYyb6mrQeq/NlXnQm7hz7dg7rAfQYwELbm9fNjnmGlPf
	d3323GJi9WF9ZYBl+ZdffQx1XL3aS6nPpw==
X-Google-Smtp-Source: ABdhPJymUI+zv+TPf05SYmpb23z5Y61WVn1hrcKJGM42I644ro8oQYkHAdq5eCAFKZc5VKDbJzGtKQ==
X-Received: by 2002:a63:5019:: with SMTP id e25mr4379644pgb.280.1624536176759;
        Thu, 24 Jun 2021 05:02:56 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h24sm2863824pfn.180.2021.06.24.05.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:02:56 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: add the mibs for MP_FAIL
Date: Thu, 24 Jun 2021 20:02:45 +0800
Message-Id: <a19dbf57d8d1a44e1bf3314f95b1e6023ede46f9.1624535762.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com> <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com> <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the mibs for MP_FAIL: MPTCP_MIB_MPFAILTX and
MPTCP_MIB_MPFAILRX.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 1 +
 net/mptcp/pm.c      | 1 +
 net/mptcp/subflow.c | 1 +
 5 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 52ea2517e856..3f0df09138b2 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -44,6 +44,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
+	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
+	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 193466c9b549..2a6cb1d8704c 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -37,6 +37,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
+	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
+	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd4d0521556d..5442ca39b3eb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1136,6 +1136,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7792f6e38ba..d74eb56043c3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -9,6 +9,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 
 /* path manager command handlers */
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 13e53a6bd3a1..1228ed275a9f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -914,6 +914,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

