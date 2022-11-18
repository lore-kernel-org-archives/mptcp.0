Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874A7C
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 07:21:01 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id v17so3848742plo.1
        for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 23:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn3rU0lQxMzHCsGRYg1iXa4HZdm9l5N0KJ8eX3S9glc=;
        b=q3CZbXDuCtcter8VvJNva0r8o1+1zdaMffPAUjl82CKqJB7kMAzwmdNmTXVIjLK0uD
         gWKHF4Mp+nBJdaocVrPY1sAgFfaIX+J5RK/camgAl/RTg8IQlxm22/XlYZH5bnwLLw0T
         F0l+w/TnwP+PtnSyefosgjSts/fQs5s/0DLJTspdTahqaoRDViDIK7F2XPeounQaxFSK
         FJD7k/IgjaVTUzQcjPrAXdIxGazBhtz/bbZ5/sYq8K496x6MwXA168s3a2Px6TyTBmVE
         A5NkD++2SFGc7crwxiuKi0OLUstp7diCmzAcB7w+rrxWNxr/ukvLg8xZ1+yo0zjSCXhc
         tnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn3rU0lQxMzHCsGRYg1iXa4HZdm9l5N0KJ8eX3S9glc=;
        b=WmpjjpZ9RfuyUf4q+LyapzgECK4sANEBTlVR2CEctqYgzLFHy6fV5uWcliv5yQb4MW
         W/pw66J7mhsbDoBTSTjYhSWH+y1oi3vqP6H9YuRqD0sYuiPKf/yC1cbEXJ6qXfgdxFka
         Y4dTBj0HmeZCdJ68i8wwnYb33M1VEJtxyZqWNN33o8ZgXqYmnyW2awNwUcoGoME3Km+g
         eMwtUj7YIBlo45mqRGE4NrYEhgLibzXWao2n2wDLh2jPVtaTM5hKngTDdmfoHRjUrQKN
         zy5cMSOoQx6FiezaLlvNY/DA/5VhAae6ZwzODe+QE2SBLrcNjMpE9DIXs0Hrf+wLBQyL
         3Raw==
X-Gm-Message-State: ANoB5plOANwW2W8icvU5EpCOFGW+v0VvUpQtgbzabTCyMfxntHRGeOrU
	FfTwyrujWzCF+xIyg2QAUB8=
X-Google-Smtp-Source: AA0mqf4EhknNkSzglZsVDj/sD/x7q4FwbGEv7BjdkyGYc/pXfWmHX5XBokbKftG6bMivt93yq8Qfeg==
X-Received: by 2002:a17:903:2c2:b0:187:1a3f:d54b with SMTP id s2-20020a17090302c200b001871a3fd54bmr6569529plk.9.1668756060983;
        Thu, 17 Nov 2022 23:21:00 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b0017854cee6ebsm2830072pla.72.2022.11.17.23.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:21:00 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Biao Jiang <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH mptcp-net] mptcp: don't orphan ssk in mptcp_close()
Date: Fri, 18 Nov 2022 15:20:30 +0800
Message-Id: <20221118072030.3500578-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

All of the subflows of a msk will be orphaned in mptcp_close(), which
means the subflows are in DEAD state. After then, DATA_FIN will be sent,
and the other side will response with a DATA_ACK for this DATA_FIN.

However, if the other side still has pending data, the data that received
on these subflows will not be passed to the msk, as they are DEAD and
subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
these data can't be acked, and they will be retransmitted again and again,
until timeout.

Fix this by not orphaning the subflows in mptcp_close(). I think that's
ok, as they can still be orphaned in __mptcp_close_ssk(). Maybe we can
also fix this in mptcp_incoming_options() by check the status of ssk and
msk?

Reviewed-by: Biao Jiang <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3796d1bfef6b..5ac1584baf61 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -815,7 +815,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk))
+	if (move_skbs_to_msk(msk, ssk) && !sock_flag(sk, SOCK_DEAD))
 		sk->sk_data_ready(sk);
 
 	mptcp_data_unlock(sk);
@@ -2940,7 +2940,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		if (ssk == msk->first)
 			subflow->fail_tout = 0;
 
-		sock_orphan(ssk);
 		unlock_sock_fast(ssk, slow);
 	}
 	sock_orphan(sk);
-- 
2.37.2

