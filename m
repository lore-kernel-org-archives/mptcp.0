Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A971
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:32:20 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id a11so2743431plh.3
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMo6YfC9oGw26X+OkVw0d4njWgCmHXg2pUtqONRxrEY=;
        b=eY6xolM75HLJS/Rv45WJ+Ia3wdmDqvQcRYCczdfE7nP+oGPCYpKcVczwjCJLzM1Ggt
         l079x7biP/T/wouAjGL29yseNkHiN+fJgYFnrncaOHNurX1oEkVGqOf5UfszD7i13ZFc
         /JOEB5xfpctwecFk4PKzeKuOdoNA1szNTtlttt7QWeeKXcNB8UTANfRANl7gJmI0QI3T
         gLt1RGonSlhnc5dTsx5lecrplsGDi/fxxPrbvigtnFFN4XuKYl/Oowbdl8tCw528bcR7
         IoLFDAe5940lMG+DWs/aUaWsD3nRVZ6KPmHthSjDIwq9qPey+ZX32sFYOVp+1O+gOnDz
         gWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMo6YfC9oGw26X+OkVw0d4njWgCmHXg2pUtqONRxrEY=;
        b=QVMCqJ5sl+//IfwAHknYMnxfZ4orIsTx6BgC26U1GXvkrXhVUTnawjh3sgTcywU72V
         UfHTs79GMxEm0e5eSre2hGkUiCIldlfQQN3BfibjDzxeNo+G2SAljgSKJGtXP2D+c6TL
         xFzBdwtC3rH/tPlXlj57BIhnImVR0R0z2Et56qYOVkunZXt/ZEBb3c9HbbkvjTrnhbsy
         H+ltiZ960Sw8yiI899CQlJnFtXdCxSaKxkF+fl2ncN4ZkZTw1AmBgtiWaM8r70UEpaur
         ndSQJP5/SZ7/4c3v3iYaavdpZYIyJT8OEor725lF1jg7+OJMe2z3ji6sxOkfQKIxNspK
         oYTQ==
X-Gm-Message-State: AOAM532TBvYKy3wH+Je7KaCjeFEzPMv0GHlzeA2ppxhihAIjzoDZrK97
	XK0eHT75sacPuaCdkhgFN/kSnfzOP00=
X-Google-Smtp-Source: ABdhPJwGy6MK55qzDLTBjQ7oUitbQ0BykExOHVrBmbNRSR0jkSz7MvK/nALJPpjhHtdASy/l4uJ24A==
X-Received: by 2002:a17:90a:cf10:: with SMTP id h16mr2329098pju.49.1620275539602;
        Wed, 05 May 2021 21:32:19 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 66sm713741pfg.181.2021.05.05.21.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:32:19 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 2/3] Squash to "mptcp: add a new sysctl checksum_enabled"
Date: Thu,  6 May 2021 12:32:10 +0800
Message-Id: <89dab04f93300a924df81d1ab7399380b4d54087.1620275257.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <49d4717df8568a70b4bb6d3827046cd5a771b14e.1620275257.git.geliangtang@gmail.com>
References: <cover.1620275257.git.geliangtang@gmail.com> <49d4717df8568a70b4bb6d3827046cd5a771b14e.1620275257.git.geliangtang@gmail.com>
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

