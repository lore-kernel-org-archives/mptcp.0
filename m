Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB172
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:22:11 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id a2so9629909pgi.6
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ob8eb9+a85O9uDmbs7d0BJbDJ1V2w0+v7UNPVklXiRw=;
        b=ojpWtlTSaH/FXUMGMmp+RFAkW4fzgW+CwtdztD6FXCzmn1J+2Vyu0nyhYDhK7pYRrQ
         mBT1Vo8c0Msf9v8KZYmEK3BspwodHyHVHa6KfNHcQ/8B1vh4pOHyk0guXPR6lKmwiLqG
         B9u90fsuBjrpHilTPdB7oF3A3efnVOHK+RN1aT+5G5nVcwu5+4IPNLr9GHcrojjJzA+/
         z34+HpTYGvLhLpGYYy8FdJxfBD+gGAJ05kILDK806jTobO3SHHQPcTC8hvv4jfD115bf
         hKHSGjdJ2LmpflDDZPkQJigMgC2oTJivsGORYr4ogDoX38oQ+fQY+OOj5jK//1diEfaS
         nwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ob8eb9+a85O9uDmbs7d0BJbDJ1V2w0+v7UNPVklXiRw=;
        b=VJ5poqIsuKc6omLxARxTQrlb0nJU0kutCWF67Dp9egrSJ4fIHbyGZZgpKhEZmFuyWs
         6tohd68kbZq5BmQnmSFuCn12DCkNyK0/K7IFmDwu4qsQMH9iQzkJHss0vi/mG7F4JGUd
         b2LdCeQJdyjA758zgS8sUrxhnDqsz+0O7iPGdBM1mf45gFuSpnhJSZow8IPT+36Rxc3m
         WIjEbagkllbtqUP2REfGFRRMbFAAkGJtsGTkrTEPS9zJHsbwy8XN5EbOofHKrUnpoFRa
         1yXr4BbUPMBWxIbiec8eRHO0IBSFLTo2e+2aQYk9mUwLDKbeCw/HC+K+bmgDRlK2WnX7
         WMJw==
X-Gm-Message-State: AOAM533BsUC+z6eazFrHGDssHRNlvXR1ujEGd2P7BzfgDwb9R2I+L9dX
	rJKjqRZbE4u1v9v85YfAHgrMgrQlyVv3Aw==
X-Google-Smtp-Source: ABdhPJxyjU4jw/Z+2QtPKVKXgIuuqAkO5nMKsWEp3DcEwQttHI+q7Bbst488kQKIiVKT+kKUCwU05Q==
X-Received: by 2002:aa7:93dc:0:b029:328:d6c9:cae7 with SMTP id y28-20020aa793dc0000b0290328d6c9cae7mr2744821pff.53.1625829731214;
        Fri, 09 Jul 2021 04:22:11 -0700 (PDT)
Received: from MiBook.. ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id i27sm6911377pgl.78.2021.07.09.04.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:22:10 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] mptcp: drop unuse rcu in mptcp_pm_addr_entry
Date: Fri,  9 Jul 2021 19:22:03 +0800
Message-Id: <75536cfb651328a9c8446676ec123b84e5f4c35f.1625829674.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree_rcu() had been removed from pm_netlink.c, so this rcu field in
struct mptcp_pm_addr_entry became useless. Let's drop it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d2591ebf01d9..56263c2c4014 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -27,7 +27,6 @@ struct mptcp_pm_addr_entry {
 	struct mptcp_addr_info	addr;
 	u8			flags;
 	int			ifindex;
-	struct rcu_head		rcu;
 	struct socket		*lsk;
 };
 
-- 
2.31.1

