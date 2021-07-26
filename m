Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941E70
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 06:45:29 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d1so3149254pll.1
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNYxRzf8dxG7N1Zd4GP+t8eu9yILbz6jTE6Mg4KvkR0=;
        b=iBvwmmrIg12beLYssq+ATyIzZCU3y4FW9615v6OLWZOdRPbhqp/V0+pM9k0Cr3U1eW
         gaVmH48mJcxtUTX+A06NRHggC6ASd9HVuOTJ8w5DBDiGJ2So3+Klpwv4nhshvEx4Uolp
         XGnXsLHoaYTkJypOJdGNZxtQWC9FBtVTs1ChcQAlaUFHc61pnB4OFews/D5tLKG0DHUc
         DvXvvHVR9AgF7v6DpCLFTw5Ez96ak9iVDbNsImVsZvCEc9L+DnEHk3YbyrguNBmlvTkc
         KA96JXHgWQian0y8BkdaDfGMr2uwVOGifj1uQAJ0fndqKQmG6QjRNwtl+Lhtk/j7hSbp
         yw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNYxRzf8dxG7N1Zd4GP+t8eu9yILbz6jTE6Mg4KvkR0=;
        b=aZmthkeYFGDxyNdkvthxSWkdu9bRGpAlJN1svJYZStu0pZyOEeQ5TRYS8cOw0VuOif
         AbQIU0NPOHYLCxIl8q67prFLwb+W5ZVUAqZndeae0sAfdtC5acXnPRLde/es5FwasZbd
         RhUumT3jtDRtWHmLp9w9d8FI9Re9hN18RzR+v92BRXen8og5DDP0nFAh988Yr42VkJ2N
         JM5JnFe8Sb6zcCiFhMKpJGiB2zCsoPT4KBTzSQ/kPMftAskEzHzGAMi8Pwk59GlyC8i6
         E4LE+Vry3SQy/yXUkYLm4iM9VsqMAX3pcZFMufzeoMNnBt8dQhzKA0DUyjPpI+xGlI05
         aNZA==
X-Gm-Message-State: AOAM530fV0fnnO7xR3Q0ZTiergkiY1+hjcoIRCxfvPG/LrDEQaAUZIIS
	TUBNGkVutyx8wMk91EGKYCDheoPoHsVV3w==
X-Google-Smtp-Source: ABdhPJyRm2O1BTsT6XGKX+5Bc4sU3uRhm8gUVpDgpz+eERRdQ0MTQ8R+Pdzz+CicITfadurTrfXurg==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr24497598pja.133.1627281929152;
        Sun, 25 Jul 2021 23:45:29 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k11sm10634697pgc.30.2021.07.25.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:45:28 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 4/5] mptcp: add the mibs for MP_FAIL
Date: Mon, 26 Jul 2021 14:45:14 +0800
Message-Id: <35c5e28e2846f7e2efc7c672d20dcafa3e70828e.1627281326.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <8bfbc479bd4513a51a96542b5174b6f75d33c656.1627281326.git.geliangtang@xiaomi.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com> <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com> <bcdbfa514af7e5dc3741c16bb692c070ed50f3df.1627281326.git.geliangtang@xiaomi.com> <8bfbc479bd4513a51a96542b5174b6f75d33c656.1627281326.git.geliangtang@xiaomi.com>
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
 net/mptcp/pm.c      | 1 +
 net/mptcp/subflow.c | 1 +
 5 files changed, 7 insertions(+)

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
index 62085834782d..c915cc144d75 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1151,6 +1151,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4a5cf1261ee0..3509345774a5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -258,6 +258,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	if (!mptcp_has_another_subflow(sk)) {
 		if (!subflow->mp_fail_expect_echo) {
 			subflow->send_mp_fail = 1;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		} else {
 			subflow->mp_fail_expect_echo = 0;
 			/* TODO the single-subflow case is temporarily
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a69839520472..c25b1d961206 100644
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

