Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F868168
	for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 15:15:43 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id b5so7706483plg.2
        for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1Px624SNrsY9lGXI/ctGYKAOiJEYhxszMEApOAhIR4=;
        b=nK3KAg0xi6HPV1z6EZiw+S/pqw/7uoWyGBZdOBIzfLmJduq1PhXXsjKrEdBONxU6bf
         JajPrdug4yO9TeHgCDqbsrMwxWWNaHObUDUbfAw2st5bZ6eu7/3H7BMF3/7gA2iMzg+I
         7wAxxPcjl0+eUk+PCXYATJQWNIs/MMR6G9qHjcMd2Nu7DmTXqa5Zzs98Bcv55lq0aaUY
         wX79CGiIKXW+orVDcd5gEzyNkXeillItpLpwIUZsJlBQ2XgoADQK++c0JVvSfN13RPcR
         HuJfyoSiTW8mcqlljcG/iQrXJpM1s+/M0vvntoAuYxmq3WXk7wLhHdcMuNk5N1nTP/n0
         toBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1Px624SNrsY9lGXI/ctGYKAOiJEYhxszMEApOAhIR4=;
        b=R/vzNBj09yq8A3u7LjGU9bdgtwkjdugwWxIU/TdJvQ5dP+QW8oo12jMPSzVu91qLRI
         Jt+9Q56PvYXkYQG/GNZU2OVAPRJwDngeUqGqiV23/Xi9+ixe1fCFnTn1hln090670deQ
         dzgC3U6sYBsEPNDR02AnVesJPvy6OIJh7Md8HeZmUouPmSwn+ezLzQuWQHgd2Ed8JB5C
         WtmkJUZQq5HdML0jDXYrPv+H96Es6EsG6f+4CCm7ttUaDEeJyvoxn3dZXMvuK/BvR4Ht
         rtTJfu6x4tTQlfRKggmCqw+lqN1wGz2RJlr7go0ll2Uq7KIauGYDcIQT39+qdWJiHvEJ
         hrXw==
X-Gm-Message-State: AOAM533ikNXOZd2rtcDZTlQWpSLG0UmDgG6HjB16iML6oOBxxlQbo456
	bcDaD7fgYDR68ZrlYLI95+a/T8EhLPsbGQ==
X-Google-Smtp-Source: ABdhPJxH3VF2NxC7lBZr0rFfboW4FXY2YLJGpEkyJmGJmGkLewfNp3oOC76pDQkLrAu9TzAXoqb22A==
X-Received: by 2002:a17:90a:708d:: with SMTP id g13mr9559737pjk.81.1626016542905;
        Sun, 11 Jul 2021 08:15:42 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 10sm12139641pjc.41.2021.07.11.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 08:15:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other"
Date: Sun, 11 Jul 2021 23:15:35 +0800
Message-Id: <5802c6e8aac9d3a6502fd3a8e9cdda01f658dbcf.1626016245.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add READ_ONCE() for reading msk->pm.addr_signal.

Use mptcp_pm_should_add_signal_echo instead of open coding.

Use '&=' to clear flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c9622696716e..be16da2dcb6b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,6 +257,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
 {
 	int ret = false;
+	u8 add_addr;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -271,10 +272,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
-		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
+	add_addr = READ_ONCE(msk->pm.addr_signal);
+	if (mptcp_pm_should_add_signal_echo(msk))
+		add_addr &= ~BIT(MPTCP_ADD_ADDR_ECHO);
 	else
-		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL));
+		add_addr &= ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
 out_unlock:
@@ -294,7 +297,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 
-	rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
+	rm_addr = READ_ONCE(msk->pm.addr_signal);
+	rm_addr &= ~BIT(MPTCP_RM_ADDR_SIGNAL);
 	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
 	if (len < 0) {
 		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-- 
2.31.1

