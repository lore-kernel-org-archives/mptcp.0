Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959B3FC1
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 10:42:09 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id fs6so6022365pjb.4
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7jUhcYhzYJSdo9US0yEIy+lB4N82r6XMS+6fJgmaHM=;
        b=JeupBXqy7emI4mmIe4A5OrrBiF123Wd9JhFIcxd2wyIu4/nurBezbnVwNTg41tBH62
         Z370PeqERyvOWSmBECVGV3ExcwGcP6GjQgfqP/XhDgy4PkTMo7hbyEOgob4m9ZYguC5B
         TdlDyzxY6oQRu5DKwZTlnlMmCJ/bszQ8BBy98LwVPUQZKcspSG9xyI85XUd3I5qKd3iA
         kkRpjEu5ngPdL/L3TaL8DwzVK6bKjw078g92Z4gae+aIpwH3+HMoEVfpzrr3rR6rUZkS
         ucb9WEJUsmWJCczvUWTlmQ7aXe3qVOwS+RsVfNAvjU5wZU5hW91ztVN4lwFYlQws2vd/
         Y4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7jUhcYhzYJSdo9US0yEIy+lB4N82r6XMS+6fJgmaHM=;
        b=JQru0QT9BOH2UhN4qnfAFFvnHkrPExUXdr0xcQcI+Y7Dvpvzy1IGK9AJOmsJwPgZ/S
         rTh67YTD781r0CcWEwfHJNpchZJt2DJe+7QbGzdRtiAeDmBNhD3v2C1kUgE+AXIQSYtT
         aTbQUzNWy55f9AdQAcetG8m1eR0LTpaJGQJgCh2iGXE+dKBdBvLd7KPRrwG96QQMkHiE
         C4iT7mvxBM/i0XzYYztY4EcXJX0brdiPeoPIIlJ/g9fZruOkJVP9KPxmnE1RvKMzdRec
         W3OZNRaooVy9z+d8eDcb9aAWh/QuW3DqrIbTwK5Ya0NiPugpnPzBDshf5HYiqVoBTDnU
         Z+Bw==
X-Gm-Message-State: AOAM5339OFI1zEjR6JYcV7d7KBtvX826bJrKTPnjZ3h656kGaZFg1sQl
	5jaw5DnVA0nNnBwuMJdc2Jy8rAIbZks=
X-Google-Smtp-Source: ABdhPJxvotBbtg5UqEdTEI8ce5BueFb6UHezuSSDfTwwyHX/yDnHIJvZ//wtXdcbHzWATHcy45en/w==
X-Received: by 2002:a17:90a:6503:: with SMTP id i3mr3929796pjj.22.1631011328575;
        Tue, 07 Sep 2021 03:42:08 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x189sm10571885pfc.52.2021.09.07.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:42:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH RFC mptcp-next 2/4] mptcp: add struct mptcp_sched_ops
Date: Tue,  7 Sep 2021 18:41:57 +0800
Message-Id: <4089672c8557e031d38306ef49e26e9902e7db57.1631011068.git.geliangtang@xiaomi.com>
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

This patch added struct mptcp_sched_ops. And define the scheduler
init, register and find functions.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c | 60 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  8 ++++++
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a525c7ae920..ab72a3950f2b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1515,6 +1515,58 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return NULL;
 }
 
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.get_subflow	= mptcp_subflow_get_send,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
+static DEFINE_SPINLOCK(mptcp_sched_list_lock);
+static LIST_HEAD(mptcp_sched_list);
+
+static struct mptcp_sched_ops *mptcp_sched_find(const char *name)
+{
+	struct mptcp_sched_ops *ops;
+
+	list_for_each_entry_rcu(ops, &mptcp_sched_list, list) {
+		if (!strcmp(ops->name, name))
+			return ops;
+	}
+
+	return NULL;
+}
+
+static int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret = 0;
+
+	if (!sched->get_subflow)
+		return -EINVAL;
+
+	spin_lock(&mptcp_sched_list_lock);
+	if (mptcp_sched_find(sched->name)) {
+		pr_debug("%s already registered", sched->name);
+		ret = -EEXIST;
+	} else {
+		list_add_tail_rcu(&sched->list, &mptcp_sched_list);
+		pr_debug("%s registered", sched->name);
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+	return 0;
+}
+
+static void mptcp_sched_data_init(struct mptcp_sock *msk)
+{
+	struct net *net = sock_net((struct sock *)msk);
+
+	msk->sched = mptcp_sched_find(mptcp_get_scheduler(net));
+}
+
+static void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 			       struct mptcp_sendmsg_info *info)
 {
@@ -1567,7 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			prev_ssk = ssk;
 			mptcp_flush_join_list(msk);
-			ssk = mptcp_subflow_get_send(msk);
+			ssk = msk->sched->get_subflow(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1686,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_sk(sk)->sched->get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2534,6 +2586,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
+	mptcp_sched_data_init(msk);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -3005,7 +3058,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_sk(sk)->sched->get_subflow(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
@@ -3569,6 +3622,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 305d373332b7..71237d1458ea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -207,6 +207,13 @@ struct mptcp_pm_data {
 };
 
 #define MPTCP_SCHED_NAME_MAX 16
+struct mptcp_sched_ops {
+	struct list_head list;
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	char		name[MPTCP_SCHED_NAME_MAX];
+	struct module	*owner;
+};
 
 struct mptcp_data_frag {
 	struct list_head list;
@@ -264,6 +271,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
-- 
2.31.1

