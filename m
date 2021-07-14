Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43088173
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:42:07 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id a2so1959949pgi.6
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UtxfM2rC5QXS12eiF3SCcOyviljOaQQpD9ijOTmzAo=;
        b=epkrI6610X7tKI4Yo9hZlKZVBh3/DfpPqGYtSiGt1bBG7FWvoYi7nGYVZ5t1HP2vHT
         ahV2mhUlz8Ks1Fc6clp3w4hfXQslwIIoE0BDxr7joVGsKZr9qGocDpQQwQBf85I3vZr6
         TGvoHC+1Kbuy4Yu2VVjxDvvLvx0bzWaULquSk1gePGRgZz2sDBtMa8IlBA3x23l6q0Do
         0XdjHJ7wcNDkAaO0cHwOIwwhQFZ/smtAgDaAVamw3HNpkH4i6Ukmnod9COpXuKrsuoHo
         xapugaEoK8WDAghb3yQ/DQ17Chd2zJdUzUjr8nXtvfIk9naEUAjRq7DC321xO7kkfM9k
         Kk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UtxfM2rC5QXS12eiF3SCcOyviljOaQQpD9ijOTmzAo=;
        b=Z6DalAwDQFQSBR6JayzeJZjcUazIcd1Q8JA0hH2/rqQ/xpNe6hP0rmrutZX/RzdVpo
         tRXlzMA6gKjeHN3qTzE8VEXjRYHDeXXzXFIatBJawM2etAOEN8/YWSGX9XXHVLbCOwEK
         mKcLKaUHx0B7X8DK7p56PCKqTg9WJJ7Ny2GiBjJrBPrGruXXrVbk9MpOkSe1JHk1/E8t
         le0MAYgPxipPJ/t+rkV9PZFPvu5uIopelmHx/f3hJVQ/YZIrBH7+JFWUs0dymBulXzGB
         HY5pzNW89UO2Dv/hl4e/6xDuA/UiyalHMwtfiAesBtSTxZXPRHyV4BI7u9NWOQO6Mloh
         v4WQ==
X-Gm-Message-State: AOAM530SHHM3zTHQSRN2T/ti4v94qM2Po/Pqew/ElCzJEXgXJusNSnso
	QSnN+0QxHYgRcboRai71g7FSRQekTwwPkg==
X-Google-Smtp-Source: ABdhPJwUICiso4s/2zCogWGMtvXSY9Ns9U4uMeND0/WZCn8qeBdMP/VkdEMwwaOqMFcDiEVqVgbKDw==
X-Received: by 2002:a65:5503:: with SMTP id f3mr8990338pgr.232.1626259326796;
        Wed, 14 Jul 2021 03:42:06 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x18sm2122904pfh.48.2021.07.14.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:06 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 4/5] mptcp: add the mibs for MP_FAIL
Date: Wed, 14 Jul 2021 18:41:56 +0800
Message-Id: <5df5b6ba135e5951c40056689f885e5101dd1abd.1626258797.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <779edc1afc2f4622d9cffbdf3f8ccccfcdfd33cb.1626258797.git.geliangtang@gmail.com>
References: <cover.1626258797.git.geliangtang@gmail.com> <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com> <c9b00f7ce8d17ea4fb6e60c09433f36cc144a2f7.1626258797.git.geliangtang@gmail.com> <779edc1afc2f4622d9cffbdf3f8ccccfcdfd33cb.1626258797.git.geliangtang@gmail.com>
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
index ff2cc0e3273d..44d342c90121 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -44,6 +44,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
+	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
+	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_SENTINEL
 };
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 0663cb12b448..0db62d5d4e38 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -37,6 +37,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
+	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
+	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	__MPTCP_MIB_MAX
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ed9a4a645459..9a2fa52c0bf0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1150,6 +1150,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d4c19420194a..ccabe3b9e5ee 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -9,6 +9,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 
 /* path manager command handlers */
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 11a719fad718..5046ae431206 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -909,6 +909,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

