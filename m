Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344013D618
	for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478820; cv=none; b=Xd6bMZLS/945r8PgUuIHxnoFOyKMYqT8aDYFn7EjUjp4gsZ5oLYvrM3HaSOmQgnkuBmvQDr8VEVMS4Y7MT7IDXH8bMiOKp7tKBEq1hLHDkKJyeq+nTotXJB7F0AZ+cI63nWrnc2jVEfIXjFrOfLCGXcqrYhIGJT22EHDi8Cd3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478820; c=relaxed/simple;
	bh=VAU3ALS9gJEyoBIZDRFuHrx5VVGheT+uTqPuNaV4ZpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwxE+bDXBJu+nOkP4R3YHF1Mx1P06tIDBqv8WUg1AbqG0Cj2WUc/rt5Cgbh6R3GK9qQjb+cU6N4Hc2r7kodUV+esI7+3+i1ZTHYyv31Mv0EnTdBE5/5jfZhJKzEDB9Z0+6IlaaRRokop4WETxyWUizE52HstSCqMG7IhtiyzRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLXy2MNo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLXy2MNo"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso5818217a12.2
        for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478817; x=1715083617; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPXzCxemjkj/xUKmH/yneaMxGlgsNYeCjRqZPEGXhDs=;
        b=LLXy2MNo/QEJiHeWbA5wYA1DIHMKlBwVZcYMEqNxric4zNJonjo9cNSrPCI87F5tbp
         GiuwGKWNJUgX3mLqYZyjyhqnqUm4rMfXupjz7Ke/u4wTsc9Kj+wtKKjeDBbP5PQJDbhU
         BWCd4NeHOsPFwos8eSVRi31Y+CGY1RiSH6YdXq+SA2sXwtP/LruQE0RczfNZqAqvwZmV
         2zhOnzEJxo/oDoFViOAK9CA403ySkptKlf+zS0IhWxiX9ORQF9vW4UQ2UwhZzFyOQn1u
         4py25Ows3fukWCpLTxEbVDWHlDbR5axDKTs9GfwL248WE0JnJhcNER4Ohsb2C3LVoAqN
         nchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478817; x=1715083617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPXzCxemjkj/xUKmH/yneaMxGlgsNYeCjRqZPEGXhDs=;
        b=M5Q+jxm9baOQJEdTrLhfRGjiUFF+3trCN53cxAaS0AMW/5EpbMS4NgmTVzO4EAl61y
         1h1nqmCdkzVaDhs+cu0pAMjkURfvCVv7DSYRJMhj43vtq19equr/GtCyphAPXQ/7sMnk
         Nd5AMDm6xIe/MU0VS9knGnBUWKLldMfeIZlco0jttNNQI4x4b5ArviV7STohAWNpxDaF
         v7yJHf9pKMGYUXzGmsHupcTBIZn+WcAAGcW849p9EBuFH0XvFfGUXA+7LNEIhVcEES8D
         7MdMKQ1pkShzMA24ArpOuijXMgO6chS6upbZjz6sqx5RpA2EA3Iw7HS0qXW3DWWwvbYZ
         1K6w==
X-Gm-Message-State: AOJu0YzPRKXQfFEMBTVZEDlW8PnArc6V7Vx7CFl5ueHY2M/A/ULG09QC
	KFBAwCDPMlqbErsq9Q3hZd1FiQMxbCVIdWjKfRSmI8EDs3SxNbX4
X-Google-Smtp-Source: AGHT+IEUcAD2Ds2ePtu3X/qH01i4VuxtqPFeKXiA1ePJNvborRNVuG5MSvWH2zxylkt2CxF41XWqpg==
X-Received: by 2002:a17:907:bb97:b0:a52:2d35:5e28 with SMTP id xo23-20020a170907bb9700b00a522d355e28mr10499331ejc.57.1714478816589;
        Tue, 30 Apr 2024 05:06:56 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906bc5100b00a4660b63502sm15242626ejv.12.2024.04.30.05.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:06:56 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Tue, 30 Apr 2024 12:06:41 +0000
Subject: [PATCH mptcp-next 1/2] mptcp: only allow set existing scheduler
 for net.mptcp.scheduler
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-sysctl_scheduler-v1-1-8187148850df@gmail.com>
References: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
In-Reply-To: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714478815; l=2098;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=VAU3ALS9gJEyoBIZDRFuHrx5VVGheT+uTqPuNaV4ZpA=;
 b=PEHezW0x4eY2kBNSpVdTgQuFFt6SbQdMoJaB7mF/VLbzoXXO0TjoQkCrkXujBI6sgZ4/E2IiG
 j93K/mhnIh1CRgDkqFIfSIK9rTqRxstSu5NDFtvzQ8KvVWcu7+yWtmE
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

The current behavior is to accept any strings as inputs, this results in
an inconsistent result where an unexisting scheduler can be set:

 # sysctl -w net.mptcp.scheduler=notdefault
 net.mptcp.scheduler = notdefault

This patch changes this behavior by checking for existing scheduler
before accepting the input.

Fixes: e3b2870b6d22 ("mptcp: add a new sysctl scheduler")
Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 net/mptcp/ctrl.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8d661156ab8c..0e69bd0ea302 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -96,6 +96,44 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 }
 
 #ifdef CONFIG_SYSCTL
+
+static int mptcp_set_scheduler(const struct net *net, const char *name)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct mptcp_sched_ops *sched;
+	int ret = 0;
+
+	rcu_read_lock();
+	sched = mptcp_sched_find(name);
+	if (sched)
+		strscpy(pernet->scheduler, name, MPTCP_SCHED_NAME_MAX);
+	else
+		ret = -ENOENT;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int proc_scheduler(struct ctl_table *ctl, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	const struct net *net = current->nsproxy->net_ns;
+	char val[MPTCP_SCHED_NAME_MAX];
+	struct ctl_table tbl = {
+		.data = val,
+		.maxlen = MPTCP_SCHED_NAME_MAX,
+	};
+	int ret;
+
+	strscpy(val, mptcp_get_scheduler(net), MPTCP_SCHED_NAME_MAX);
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		ret = mptcp_set_scheduler(net, val);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -148,7 +186,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.procname = "scheduler",
 		.maxlen	= MPTCP_SCHED_NAME_MAX,
 		.mode = 0644,
-		.proc_handler = proc_dostring,
+		.proc_handler = proc_scheduler,
 	},
 	{
 		.procname = "close_timeout",

-- 
2.43.0

