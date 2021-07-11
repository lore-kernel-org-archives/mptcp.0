Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF72168
	for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 15:15:42 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id v14so756828plg.9
        for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JaoB6RXBSxw/WFbB1nIfEV9K8M4PtLerYrPhGDabs7A=;
        b=ABgyVm4J1QdSF2YUkK/YjVcvEMsdJ2iSOhNraT9PjU6QeyBsX3VmZxBAOYzlY6HUd+
         OiR0dp0Qt8YyYnFXK2AN4bIGEmjpItkL5mTQACP3WcOqMWyh0Fsg8TlXxGt/Um8bprlg
         xDFjVKuqTR++GG8+x0pz/ySSi0KPFsPVpMhw85IAJ40Fj8nS8/znvpNXIwL0mxEWW4m3
         lakeQ0vvB5bpxgb1SxvXSOFkuGhSiM9iNRXyIFn94hd84BLfkhO0hMBBiJ1zo4nue0/7
         eT+RmG+8tx8T+l7B0ntXqMbUBbv7uVG0zq+nMHRHDuX81TrOAKYy+yOukt/TEloF2csC
         pTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JaoB6RXBSxw/WFbB1nIfEV9K8M4PtLerYrPhGDabs7A=;
        b=bjq9DUK8BkjJ4TM5N10g1xhZrz7N8i3ESjQuIQ6I8WfpXvJWAa4dA2W9fGu67fxCpc
         iPWdL6fUHK2tyuenOR2W86wjWjd1XTNw1ErraCmC+9BtehoGGQhFluPrGZRUtndynGvJ
         C3Q9n8o/yjfFcmt7JsPbrwfwAZAOw3a7yVoWUbZgUrP2CnjRJLZ6wz+EiyWJBKM/s5+L
         HgT+RX013nI7ChKskKQ4xMRgW13mH+83urMPUxXS1IKvKYACkrXn/m2So7bWrm/ikAZo
         piBdIhI0Yotv/+aTzKq4vrP+AEc2u3/rVky2ibNaerjAXKZu4aThCaUnkXRJq6KB0vMf
         il2Q==
X-Gm-Message-State: AOAM53014FjmqTE6O/hcs/H7r8G7c1FQ3BU/IybgEerN1ALpWvBUOH/X
	FcKL+E34xCnW99eHN+gZXwsROeGYESsnaQ==
X-Google-Smtp-Source: ABdhPJzBAErjNeVak5oYVFe1fm/OazutdyqGc8ebASo9s7gQiWYkjbl78dBTSR2QKWImrwHbH+S9Vg==
X-Received: by 2002:a17:90a:7f02:: with SMTP id k2mr47773579pjl.134.1626016541334;
        Sun, 11 Jul 2021 08:15:41 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 10sm12139641pjc.41.2021.07.11.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 08:15:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate"
Date: Sun, 11 Jul 2021 23:15:34 +0800
Message-Id: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small cleanup.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 30deb76fa5d0..1eeecd68f159 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,7 +18,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d, echo:%d", msk, addr->id, echo);
+	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
-- 
2.31.1

