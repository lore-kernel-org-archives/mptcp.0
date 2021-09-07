Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A983FC1
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 10:42:07 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 17so9497895pgp.4
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4ipqZ6YwAe6GdDe2f7sH0TYCUu5GsEf1qXuaqPdSx4=;
        b=N9rLV4cajSM9s5dDghKpcLxeXPiUQer+Z41da+Nf3R/rgP9iVlfu/vjYR+ebxCalsY
         QERBWnr32bN6uE8iPkMElkbROg2cP16fX0Syuf/SGOwkBsw/7qHwerJl1N0xWZoNcG/+
         BU3uWdnrv7KiSa0jmOFvtcr2CbuNZsh8bunLucjCvL2eQHCn/KCpy3/d49atphsR6JHR
         IL0ikE983iVln3qiWu4TW6oMpdwv+mjrOFocoP1FbTXaqU7Q25rRTJAG3+YVbN+jXhwF
         qib5RK/Ih6BBQwFWIy5L3RY24aNaRbtJU5vzeuYcAcesVEwiawND2C0gxV8qBuwztUwA
         8UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4ipqZ6YwAe6GdDe2f7sH0TYCUu5GsEf1qXuaqPdSx4=;
        b=Jk/DiS8M9o4lYd8c51qQa2Wo/gjjxT7rFva4gowN5WMxryu/9qSIdEVrZjpTHQa03l
         AWZxK5g8/h3sDtIsQkYF/N3GOu+JAJnYRv7sHVjE7UTEedrtrEJ/vQMsAcWkRPiOYniY
         sGmIYENwDwzVnzdMUegiej+CBJZ2W0A09DyyaS+QHGuwPWbkTb5e/ttNXnEhe0dhoK7v
         5lTHwbLdDwg3x33PSbO3pG/XQSWf4JOIy9v2P8js1w7FosU8Iyv+nqB+9wLQYpZ5Qwx4
         URSUZn7z7v4tNNHZ09yhVdGVyRbU30On/Sxe68ZVMHkD9ksf5G2D/vUaFJ3vhXeTlH/I
         qjMQ==
X-Gm-Message-State: AOAM5307iF0yQyx1crro2ZdraZ51U0kkSUGc16Gr5cYre0SgdZ4GxmFQ
	oe81xmXqhrvvcVaa5J3a45gcsmZa4Yk=
X-Google-Smtp-Source: ABdhPJyhUu6Aj/NtviSFv8P0+FCLfQHY8mYhwZ7VjSbu/+7L5G5od222xHGcfoxPJ1ZSBCNadqZiEA==
X-Received: by 2002:a62:8048:0:b0:416:2682:e56a with SMTP id j69-20020a628048000000b004162682e56amr6139567pfd.73.1631011326896;
        Tue, 07 Sep 2021 03:42:06 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x189sm10571885pfc.52.2021.09.07.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:42:06 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH RFC mptcp-next 1/4] mptcp: add a new sysctl scheduler
Date: Tue,  7 Sep 2021 18:41:56 +0800
Message-Id: <268ae875a7e4546922c30a974f9d675562b632e0.1631011068.git.geliangtang@xiaomi.com>
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

This patch added a new sysctl, named scheduler, to support for selection
of different schedulers.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b0d4da71e68e..ecd593c44e26 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -57,3 +57,11 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
+
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8b235468c88f..369369b0b17e 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -26,6 +26,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
+	char scheduler[MPTCP_SCHED_NAME_MAX];
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -58,6 +59,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+char *mptcp_get_scheduler(struct net *net)
+{
+	return mptcp_get_pernet(net)->scheduler;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -65,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
+	strcpy(pernet->scheduler, "default");
 }
 
 #ifdef CONFIG_SYSCTL
@@ -108,6 +115,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_douintvec_minmax,
 	},
+	{
+		.procname	= "scheduler",
+		.maxlen		= MPTCP_SCHED_NAME_MAX,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
 	{}
 };
 
@@ -128,6 +141,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
 	table[4].data = &pernet->stale_loss_cnt;
+	table[5].data = &pernet->scheduler;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99a23fff7b03..305d373332b7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -206,6 +206,8 @@ struct mptcp_pm_data {
 	struct mptcp_rm_list rm_list_rx;
 };
 
+#define MPTCP_SCHED_NAME_MAX 16
+
 struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
@@ -564,6 +566,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
+char *mptcp_get_scheduler(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
-- 
2.31.1

