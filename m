Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A072
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:16:54 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id b6so4158281pji.4
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42PilqGRHSZAd14O9tqNDmSeDBA2KhHTeEgbRvqpVBA=;
        b=lEakA2XCmx0Jt+0EF/dun24H3E42uWEPvt4je9dasfMdH06Lr30JV40BFHOyHXxe4v
         a5Un0DrxxVz1DrUsClb2EZ9cboACgtv5EpUdQ+gQ1oRFL2rZLC2j/ziZpVsfC6xmXmdG
         qaMkgtDjbRDZJGd0BUzvuAvI/nkH/oQQDZlPk1TrtHwPRWoD999tq/ooSua4vD26D1e9
         0m91xgpI+2r0ls04KQ8S8JxwW02o+J3b35+GbJVR0YbGiApNyUHkMVmzgvh62uQKwmw8
         9s3LLWCtGRy3L2DEnIeHJouA9W4PqNtU8eHWBK/RPIWeFfx4sDu3sgzLI6p8py41cHRT
         BSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42PilqGRHSZAd14O9tqNDmSeDBA2KhHTeEgbRvqpVBA=;
        b=D0o1XUusKrumVo8BfRxoVV5I6w6L2yWciRGZPLfcoSaZXsRANZfmeVj/7+Csx3xMuQ
         eFCaVW+a+GXr0TiM+CLO0QuKlzGMgna85MYbe0fTuF1ZV4KHfYgaHNTteAJpemn5KkfB
         nzHhFdNblq+Np2Jp8s/hnwAt8Zd8AsftBnlWubJRm0t8qTuvh7Xtp09IvhzHRGex4FF8
         VPzlTPWtrIOKvsL9Dp5Jk2D3OBK6vfuKXGukclIeawDxVB7EiBnicsKFTnDP2ALVOKrS
         hFXnoi3Pw14yvUTZmXdttS4Vy0o2fekKfwXJozNYnMXojPUhEngsR0QTH4ki1EfXjS60
         K/XA==
X-Gm-Message-State: AOAM530mQgwnfHBWGyJWLI9KalXalSCIpd751GoWB3iYxWo9iVd+nWtm
	VgWMxNeiUsksS8vl9SpS17K8TdTjuCM=
X-Google-Smtp-Source: ABdhPJxUKMOEQP/gPET7wyqdLUiDIq8n1C8BvV03ZjoqA/4+sQh7V3Tzr95XvGhBzEKg/Jk0zstTXw==
X-Received: by 2002:a05:6a00:1307:b029:308:1e2b:a24b with SMTP id j7-20020a056a001307b02903081e2ba24bmr27276808pfu.57.1627463814136;
        Wed, 28 Jul 2021 02:16:54 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g20sm6480955pfj.69.2021.07.28.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:16:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: local addresses fullmesh"
Date: Wed, 28 Jul 2021 17:16:38 +0800
Message-Id: <6ace2404be8fddc3b5a0f3287ed6895ee7b23700.1627463661.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f5e079bf977b0c9e05e26f6b90d8cde4bb9a6c9f.1627463618.git.geliangtang@xiaomi.com>
References: <f5e079bf977b0c9e05e26f6b90d8cde4bb9a6c9f.1627463618.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Fix the checkpatch.pl warning:
 WARNING: networking block comments don't use an empty /* line, use /* Comment...
 #28: FILE: net/mptcp/pm_netlink.c:542:
 +/*
 + * Fill all the local addresses into the three arrays,

And some more cleanups.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1b6c4adc5a8a..0b9fa7e6f743 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -538,8 +538,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-/*
- * Fill all the local addresses into the three arrays,
+/* Fill all the local addresses into the three arrays,
  * addr[], flags[] and ifindex[],
  * and return the arrays size.
  */
@@ -583,7 +582,9 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
-	/* if the array is empty, fill in the local address */
+	/* If the arrays are empty, fill in the single
+	 * 'IPADDRANY' local address
+	 */
 	if (!i) {
 		memset(&local, 0, sizeof(local));
 		local.family = msk->pm.remote.family;
@@ -631,6 +632,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 	    msk->pm.subflows >= subflows_max)
 		WRITE_ONCE(msk->pm.accept_addr, false);
+
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
 		__mptcp_subflow_connect(sk, &addr[i], &remote, flags[i], ifindex[i]);
-- 
2.31.1

