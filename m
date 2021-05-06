Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5972
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 07:49:01 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id i190so4459095pfc.12
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMo6YfC9oGw26X+OkVw0d4njWgCmHXg2pUtqONRxrEY=;
        b=dUTvjzZf4mKJuY6Dd4SPyZJtnimmY9cZAYmaQXgzNoLBowjs7Gyca5GfTgTxFb7F1J
         EadRxWPRmiv6fnJxWkQ4ctOGe6DdGlA4UWozxdjHk/tEi+yr/TlqLrdvNAozRA62vChE
         Rdo2SYNVQxQS9GvyjVJEuwljsAfGt08CpOKxAFv0rQZTwv5E+VExmFX2T24SuocSph8Y
         sQfWrQty8hMTL5JDN83IEDQbrEI268NuCVThevmZfTm0AIaPBjOcksVO37AIQiUy0tko
         DiHwzC73ZLxU88srKGUWbhAgtGUQJGDkvoPhETqW5vQJp3pS3eXFEyj/j6qI7fZ0Zn8z
         Ui/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMo6YfC9oGw26X+OkVw0d4njWgCmHXg2pUtqONRxrEY=;
        b=YcqmbaCh7v2IDK/+dwNqq8R6lcE1ZFKUWu1nqy6JHdz6h/Dt80+zBtQEhFiBiGHGY+
         ULCeO2fUe4xWKVDaD8ZsP+94EcYn5Tu0SAxbf5Dr2iPRx+5BX+yueB6y/bN5PwN/CxW/
         DzS4oMZ6YNGnn8Mh1zDuKeYAVyQDjs3Et8xGWHt0AiGQm4tt31iioim0aH0J+ceDKJD7
         nwAHC56YnE2qA8r0FLpOP3xmD6fQsUFvgkqdqSuaOwLFrHoqHBbzEXyZf4EYLRmK3GOJ
         8FtVbzEOY6mjyZFXRtpxeXbfHR3m0UW6QktevIDRbEpTGr9miPFuoPlyCQn4dKuEixN1
         /i2Q==
X-Gm-Message-State: AOAM531u3iuRY86Oq4PZq/JPFV5AUog9z5wmFAb121aLY/5hIez7Jv5Y
	rcGr6JdwjciJ7K2GdqueWyLUhQ+a8KQ=
X-Google-Smtp-Source: ABdhPJxpfLQtREKOuCOGDnWoRWNxq88nUwvL3r+/bcSooQmzqi2QTiRc0ar8LEeRKoPVrjEJyn30MQ==
X-Received: by 2002:a62:84d2:0:b029:27c:bbd5:6c0d with SMTP id k201-20020a6284d20000b029027cbbd56c0dmr3266342pfd.32.1620287341487;
        Thu, 06 May 2021 00:49:01 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 3sm1232404pff.132.2021.05.06.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:49:01 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 3/5] Squash to "mptcp: add a new sysctl checksum_enabled"
Date: Thu,  6 May 2021 15:48:44 +0800
Message-Id: <0e4f818d6894959b07da34e2d190ec2a7aaba51e.1620286893.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com> <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com> <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update this patch as Florian suggested in the "MP_CAPABLE C flag" series.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst | 2 +-
 net/mptcp/ctrl.c                          | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 901fa3e4650f..ee06fd782465 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -25,7 +25,7 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
-checksum_enabled - INTEGER
+checksum_enabled - BOOLEAN
 	Control whether DSS checksum can be enabled.
 
 	DSS checksum can be enabled if the value is nonzero. This is a
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 014752c481d0..b5ff77dae503 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -23,7 +23,7 @@ struct mptcp_pernet {
 
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
-	int checksum_enabled;
+	u8 checksum_enabled;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -74,9 +74,11 @@ static struct ctl_table mptcp_sysctl_table[] = {
 	},
 	{
 		.procname = "checksum_enabled",
-		.maxlen = sizeof(int),
+		.maxlen = sizeof(u8),
 		.mode = 0644,
-		.proc_handler = proc_dointvec,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
 	},
 	{}
 };
-- 
2.31.1

