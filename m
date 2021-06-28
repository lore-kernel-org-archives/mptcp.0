Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABA70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id m17so8187686plx.7
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZ36rJaFN+ym2lmdiaZt1P0Y7aS3u0kTZswounBM8Mc=;
        b=tJItUByBi022I1Os4zFc8//zKpwqekRuxDn+9180pjlnn0Lav9tNadSLwvzMRutC97
         NjVie1ZbKLcuXW8Voc/hwxlHbEXfwJXJqVBgK5YqIujpkjfUeLxlFdMTuJ7j1sF5RvdD
         yN2It3M0r3SQAhf2ONRk+v4w6t2xnbp//5F9Eu4aBS9fTQj4ur7wq3r6FueTf53/rkSj
         JL3dJ54wT9Jb8jp33TzKg55bzMte13Rj6BmCbciT/WJlL8ASbdBvfOEfhHlWkKcMgD82
         nreR4+El4ySV39U/pNAsmA9x7pDmwPksWW4I6Nlrq19f7ZRSwaB9epzDIzeAGZad0Txd
         XU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZ36rJaFN+ym2lmdiaZt1P0Y7aS3u0kTZswounBM8Mc=;
        b=QhBeVLf+mLoDPNYzsIPaXw4W0WVmj/qK8XbMVkyF9QdmkmLxkpCsXxbb48+p5SJ/Tj
         DGMmwEbmPch0DrkPQ+2YjIdvFVgmgVSWTqqvVC3TLxDREhnJ8U1qumV8WVqjExUTwOKj
         ed1WtAeyBe6lSVqW/zV6fZquzgcy3Ki+zZ6Jip8C8dER959Ml26EcIZrSvxunEajPGmB
         s2R1j3gwaJk4nm3+TA0jR7rpnxRrzyTL1Q12PObaDUsCinPdy6eoKQ/p4W1IihTbgHdE
         u22GCrJGU9ONBC8MUqEEmMUoCSAXOBbZEdZlT+yW0yKQsS6/G9pza6r6LZo9vVh3oJJa
         wI+w==
X-Gm-Message-State: AOAM532qHckASwpBtJFCyvVhn/+AFMw39y3sFdVmhIt+CrydTYkFSk2i
	7KZcwgL/SA/LZUXm8geVjhMvDko+8sfF0w==
X-Google-Smtp-Source: ABdhPJyyffJ+cGm0RafLU/co4eRDsLfIy2udKDVUXVcie7EpdeH+B9gX6KAMgFbM59JbT4XMdHyDXA==
X-Received: by 2002:a17:902:d90b:b029:11b:f58c:f3d6 with SMTP id c11-20020a170902d90bb029011bf58cf3d6mr20992031plz.42.1624854561452;
        Sun, 27 Jun 2021 21:29:21 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 4/8] mptcp: add the mibs for MP_FAIL
Date: Mon, 28 Jun 2021 12:29:00 +0800
Message-Id: <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com> <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
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
 net/mptcp/pm.c      | 2 ++
 net/mptcp/subflow.c | 1 +
 5 files changed, 8 insertions(+)

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
index 9e6ab6a3d425..9c2e122f1a6e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1142,6 +1142,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c34c9c0b2fa5..539fc2892191 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -9,6 +9,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 
 /* path manager command handlers */
 
@@ -258,6 +259,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		if (!subflow->mp_fail_need_echo) {
 			subflow->send_mp_fail = 1;
 			subflow->fail_seq = fail_seq;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		} else {
 			subflow->mp_fail_need_echo = 0;
 		}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 46302208c474..d46c171ef9b0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -915,6 +915,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
 		subflow->fail_seq = subflow->map_seq;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

