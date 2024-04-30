Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7B13D29F
	for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478821; cv=none; b=aaCJaM7nX/EdApnBnDufrZDN5sF9uuUZWtj9sQzAQCzRIId+692oJyrRpzTHSXFLSiut9SeIY14pqUOQFtjXJ9esZNSottCE3GQaNlPUxt66gbpFyDthqECxKubS/n6xxCOsnhWEEX6syBvlBwmOMi/pYYCLWpWJ/yQ7s05cmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478821; c=relaxed/simple;
	bh=ho/CdjjDsDZdgjEZ7dpIeNM1mlgl7aRmIt/aI7sqa2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m87c/I5LiUeqi5OjS1M2WnImfR/wXwVhROKs30OwmOihlmI9OiOqotcHHScJLwhBn+JkmLfCCRxSfODLoxmWyZWjrHCqGzYdxvOqIEvcdgEtJ0Z5GuZ9uUK176ui0wdJHDh7+Au9gExv+vo/fuGVm9ulaTWYWtmVctIj1W/G5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh5BIs5f; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh5BIs5f"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58c89bda70so509221466b.3
        for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478818; x=1715083618; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rN0scuznZwDPHvCOqMgcCcoePCWiG2hrUIzvoYG+xfA=;
        b=Vh5BIs5fKp3QGXDbg2/KxaWIdc/ioIKc2DjQRRcLttHHWId993mSVRBnSSzcax2FyT
         ZktQ2Vp3SFLn3F1EJqq1cossMEiYvQ0WISD3i+h5ciBO+bR9ol6hGZ8StwcAyH6oYpWD
         GrKK81SesYigDdjyFch20KNVvnAmtAwFU4WVOtwL8Ll4/6e3uukJgBFr7chjaPxTi+y5
         xHsOgRSdxVjcEKlHhX/KfYRVkDT+UX4pQAhXvHe0vP0axjpSrp2sPBzXXxiHfaRdqun3
         05ijYU+BsPDpWGqirhsIVcZl5goevjw8c6s7/NgCVG69DpuYldCuHiuUgsRInCQaSliK
         e61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478818; x=1715083618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN0scuznZwDPHvCOqMgcCcoePCWiG2hrUIzvoYG+xfA=;
        b=E17aPlugTicg0HCBf8jSenMsTyZIGBLWrcnD+AN8SruMuIgq1FuQ0ve6plJ9OGEVKP
         jy0XhlRq7CGtazgTnDBCyft0TXkqx/9LzyZ9fS31VDjdpJzaYraQOBSNFZUw+nDbswFf
         dT3ZLGrHPqKjedYt0u6HHuGkc7YvPUgF0WrI08zvancTOXe5z0VPF729add3cxXDXO5v
         jHstroV7sqkO/BI1DZQI+fy7ivlypTy2CE/wacnL3NYs9O6u0FYoKeNdQnOk2p2uWwrf
         yQz335G+JHXWBkloIZ4m+AeJr3wprVW/wYDeqSKLVhbTGVf/F59TbNzv98ombnWS2y2c
         FohA==
X-Gm-Message-State: AOJu0YwIyDF1UN/NXQxeg4HqtcKHBovopqWICmmrISgy+PXceQ21097/
	/3vfcqydvCMvK+jMoUVk1Thq1viQ2Qs4XNIualcxTyq2unr0PzZuyqwQfgle
X-Google-Smtp-Source: AGHT+IFgPkzlkxjJqWFNmsTuUS6r2pmi7wV3JGgiEUZ73vISw1HuJWpELU9nx6bdQc2AMWaJ0AZt9A==
X-Received: by 2002:a17:906:c04f:b0:a52:4394:fff7 with SMTP id bm15-20020a170906c04f00b00a524394fff7mr8085062ejb.11.1714478817383;
        Tue, 30 Apr 2024 05:06:57 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906bc5100b00a4660b63502sm15242626ejv.12.2024.04.30.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:06:57 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Tue, 30 Apr 2024 12:06:42 +0000
Subject: [PATCH mptcp-next 2/2] mptcp: add net.mptcp.available_schedulers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-sysctl_scheduler-v1-2-8187148850df@gmail.com>
References: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
In-Reply-To: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714478815; l=4064;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=ho/CdjjDsDZdgjEZ7dpIeNM1mlgl7aRmIt/aI7sqa2k=;
 b=nfu7U06xJolC93QvqlpaqEsW7swcfUk+13aDbmCp1uIK0SoDfk2rdZ4Te6aSH9PJpm5B6JbZP
 UycWN48LX2OCQsgmhI9qfn/VTAE0ncYLuUs1LSMG1LcCVC9RT7ufnJm
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

The sysctl lists the available schedulers that can be set using
net.mptcp.scheduler similarly to net.ipv4.tcp_available_congestion_control.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 include/net/mptcp.h  |  3 +++
 net/mptcp/ctrl.c     | 27 ++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 22 ++++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index fb996124b3d5..0bc4ab03f487 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,6 +97,9 @@ struct mptcp_out_options {
 };
 
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SCHED_MAX		128
+#define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
+
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 0e69bd0ea302..808df66ec53b 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -134,6 +134,24 @@ static int proc_scheduler(struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_available_schedulers(struct ctl_table *ctl,
+				     int write, void *buffer,
+				     size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tbl = { .maxlen = MPTCP_SCHED_BUF_MAX, };
+	int ret;
+
+	tbl.data = kmalloc(tbl.maxlen, GFP_USER);
+	if (!tbl.data)
+		return -ENOMEM;
+
+	mptcp_get_available_schedulers(tbl.data, MPTCP_SCHED_BUF_MAX);
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	kfree(tbl.data);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -188,6 +206,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_scheduler,
 	},
+	{
+		.procname = "available_schedulers",
+		.maxlen	= MPTCP_SCHED_BUF_MAX,
+		.mode = 0644,
+		.proc_handler = proc_available_schedulers,
+	},
 	{
 		.procname = "close_timeout",
 		.maxlen = sizeof(unsigned int),
@@ -216,7 +240,8 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 	table[6].data = &pernet->scheduler;
-	table[7].data = &pernet->close_timeout;
+	/* table[7] is for available_schedulers which is read-only info */
+	table[8].data = &pernet->close_timeout;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffd00fb45433..8750254eb3bb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -683,6 +683,7 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+void mptcp_get_available_schedulers(char *buf, size_t maxlen);
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       struct mptcp_subflow_context *subflow,
 				       const struct mptcp_options_received *mp_opt);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a7e1c10b1984..8def10abd60e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -51,6 +51,28 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 	return ret;
 }
 
+/* Build string with list of available scheduler values.
+ * Similar to tcp_get_available_congestion_control()
+ */
+void mptcp_get_available_schedulers(char *buf, size_t maxlen)
+{
+	struct mptcp_sched_ops *sched;
+	size_t offs = 0;
+
+	rcu_read_lock();
+	spin_lock(&mptcp_sched_list_lock);
+	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
+		offs += snprintf(buf + offs, maxlen - offs,
+				 "%s%s",
+				 offs == 0 ? "" : " ", sched->name);
+
+		if (WARN_ON_ONCE(offs >= maxlen))
+			break;
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+	rcu_read_unlock();
+}
+
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
 	if (!sched->get_subflow)

-- 
2.43.0

