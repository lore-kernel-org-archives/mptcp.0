Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384B3DD84D
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791856; cv=none; b=qkdM4t2EBg+SUyCSupJ2Fc+EiGPdsIlusCOkdnaee8FZyFAlLHzTTtyZuUV5MKWwi693dz7x6agMtAz05x8inWnWnqxAcZ/c2KWIDdg1E21irH8HqaNGaDAmPOPVA6sfLq5tmvaZNypZq2ldZEIu7xDxISb1iM8XVe67mmrsU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791856; c=relaxed/simple;
	bh=hmH/Oi2QGIFlJjYEODLTNxKSoE8uGKTAa7XlIDgZujI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJbDBn1HIcOvqxgmO2UTMj0UahfwSlWyG2c3fsfzVjl7OpQSamoO5fUOfEMchVOO6/VrU/vFUp6biXRwqeOOK2qUNEDpLlPg+yswXP3eI7NFIhyfWpVO1aooJ6pzqbjejM2jtAAX8fbOg1gwjxgULzssrzWULp2eHfD4KU+RSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB/yXvT2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB/yXvT2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba0714574fso56118605ad.2
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791854; x=1780396654; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn626pqSlYfIAr1r5qlNKqjBQBwqaIvW/F1bEAQ3UM8=;
        b=nB/yXvT2QYS79jdo1/LA4dQcfLWu3oNHV2PDJ6TKHZ58/dzTgrSgBKPnIqWXZ5FBql
         ihEHS6Kw3H3INZjZvARnq60bKtYbimOprdC6SrmcL0dt9R8TEfOemAKbacdhcVlWyVI+
         71XgPFeVfOvQrbDaMs4HAGlVSLvZ5U6vABWsUGO0uDxhTdJ06IUyZ2rEFq7dN0iyl53t
         DCdX8Fa30O1fQ5TDIr8n0yfFjs6Gk8qRQLTDU2OrbH0LJnmWR2ShKv3H7cpnHghY1TJW
         6vrDtZLI2LNHd8LbGqwraKek93UREmZjNfq1iDZ06/OFm8JGBOE6+3As1fYFZyfxTWJr
         baUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791854; x=1780396654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rn626pqSlYfIAr1r5qlNKqjBQBwqaIvW/F1bEAQ3UM8=;
        b=arMhlNatOu8mVXpYJrC5x7W65VCnc7EZzk6EqemrZTBlDKNsNzlqJPCh9kKzLEki5z
         FbRW7npWAhGnmo5zc9zYRId695uzjvr2+HYyXHZ/CZwjfZeSJ/IcWvB4sNts00A4xrQC
         UxFkNHMoiGNxwjkdtfE7WDLGbOaU0e3/or9/EjVZRms+wkfYaX4HEqQDAaEWre/hGN6r
         jDT6/HnoyA7e0p5s3v07qOP/v3ujCIOpB0OXNr8DGck6cPxBJ1ekZdYKfcrwZLiv453W
         piiKeUrfRoapM9+WieXMa7LZVZuA5dfdKYpAhz+vEbhHdkcXafiB12xRHr5UZyzBleCO
         1OgQ==
X-Gm-Message-State: AOJu0YwCVWvXa5PGZYApKRbY1hMuN2Q3Slr1IimAmNKzg5HmNYOGQ0Uy
	pFXJYQzAmXfTWVVp1UWJFYNHwn8alOdrsGZWOP8k/Jui2qgqA0CPKPfDuLQ092ISu30=
X-Gm-Gg: Acq92OHycbdkvcMgql6+GXSsgIHt14hkH5Rmjl9+4dH/+HYhtyL7LNQKtcBUQGzsLbS
	mOqy3DKhq9Z3je4mJM6lOeJIPDuJ1STyyayIB2gH2veuqMhbNXv7eDwxIkHDK6TFfMf30Zt42ft
	zT2DetBosHW+N7HiTv9Qy8TI8YuRSkeq4xDjce76oda26Wy5oQZLMiQoY69tdymzAaHaKFuaosH
	ko8vFRIXil3fjK0j0o7msf/ZyHtIri7Bo/e12YGvlMNdXvMeztyzzvJiZ34BvOHJ9ZE82xuMEkN
	RY5avDUnzR3+kjwz5dUtRpiRcgAi0WK2BGhg1mJuEmQ7k0/Vz4vO3bqDfoboHeVgItUpJ3nhGWa
	+GVgtjZr77zK4HjgRDGi7B/7WgvjBnIr/SA0ONe5hXcgbUVY946rk5Kmst5TRfzHyrfCO7bCfoP
	Hd4dZ+oyOWmS+86Tcw2Q56Fqjjzf/r8Cc6BQc7u7+QAeey
X-Received: by 2002:a17:903:b0f:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2beb05e2c2amr211974435ad.23.1779791853796;
        Tue, 26 May 2026 03:37:33 -0700 (PDT)
Received: from iotshare.. ([183.159.55.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c49b2sm115615235ad.60.2026.05.26.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:37:33 -0700 (PDT)
From: Li Xiasong <xiasonglee@gmail.com>
X-Google-Original-From: Li Xiasong <xiasong.lee@gmail.com>
To: mptcp@lists.linux.dev
Cc: lixiasong1@huawei.com
Subject: [PATCH mptcp-net 2/2] mptcp: use sk_shutdown_timer_sync() for add_addr timer teardown
Date: Tue, 26 May 2026 10:36:47 +0000
Message-ID: <20260526103647.732350-3-xiasong.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526103647.732350-1-xiasong.lee@gmail.com>
References: <20260526103647.732350-1-xiasong.lee@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

Sashiko reported a possible use-after-free in add_addr timer teardown.

The add_addr timer callback can re-arm itself on the sock_owned_by_user()
path. In final teardown paths, sk_stop_timer_sync() only waits for a
running callback to finish, but does not prevent a concurrent callback
from re-arming the timer.

Use sk_shutdown_timer_sync() for add_addr timer teardown so the timer
cannot be re-armed after teardown starts, preventing a possible
use-after-free on a freed add entry.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/623
Fixes: 5cd6e0ad79d2 ("mptcp: pm: ADD_ADDR rtx: fix potential data-race")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/mptcp/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1..cda3efb2c206 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -424,7 +424,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		if (check_id)
 			sk_stop_timer(sk, &entry->add_timer);
 		else
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_shutdown_timer_sync(sk, &entry->add_timer);
 	}
 
 	rcu_read_unlock();
@@ -483,7 +483,7 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		if (!entry->timer_done)
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_shutdown_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
-- 
2.43.0

