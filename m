Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610623483
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 11:45:11 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d17so6627090plh.10
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htTXDEZPYb6TNXpOv8Z51bQa4fPXd04xYIV4rZegHRo=;
        b=aC3pSmeS4Qf0p8BNoTmfO3BCZf1qK1lmL9rBvb307lxtI9VCup2gPC1LADISqgF8vr
         94qTcfT9s62a91CWax/20u5wWuI64WYS4shtLcCPlW5WUisXSmnbx5eYLuJnw3FT060Q
         0bwyOfWmsg4jO30NPZ0BKurTQrCIzz/DsZXAb9HJXlwLL3Yl2cI1DK/GJph1qssu/CXo
         LWhhoMl4MuedPsdWzUm3Irs1K579gELGBRyZxlVmpgNDr+46XY6WWHwm7J+liQXPneMI
         XGKnyg8Gk63/HA++upoeRWwaniNEuLNeDiQXDbKkfakDXfxjqcNmatlyiAmVDbhCVU3j
         WTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htTXDEZPYb6TNXpOv8Z51bQa4fPXd04xYIV4rZegHRo=;
        b=IayqCAD+CbgSn18SFAYWms9V/pKC+R/0kmW6u9GoNf9YHY6WXXPPmEjMlIw9DKkzDw
         5aoau2RlFZdijUpcznacvZ5H1pEGlaZrDiCBgb2tTwAfEg2HODMhtv+oEwkrMpp9p3/X
         qrftZXxDN2JFoROYun62JqxPBKwbC61+ideNIIYZBEkYOvS7P9sVAComB3pYhiHVTswg
         zv2Cu2Zlnj4tRFLZiT0RIhe5RasT6mWd+TvDqVMK9XpsexuNh19pd9IFgP0MIWArhYCR
         x38imSoRgqsU6pG+K7XLrKouScpSpcmkLPDbSWRF3suL98UgbMXn9gcvyro5pbjC/cPj
         CMSA==
X-Gm-Message-State: AOAM5305hmepRm7Dot7+V52fielevHztoEzhC39Qdp3vKfgX8SMuCk2O
	/we7T611IV1SyMz0lmPH+9ytwO2pQ3M=
X-Google-Smtp-Source: ABdhPJxfvpL9sJhPrtubcEXV4Hwh2Q+zMa6ao4JvO6pPiyhTRnIx9Iblw1YkfO4SApR5ydRokMYz8A==
X-Received: by 2002:aa7:8593:0:b029:32b:c173:cd96 with SMTP id w19-20020aa785930000b029032bc173cd96mr4597615pfn.63.1627559110827;
        Thu, 29 Jul 2021 04:45:10 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x13sm3165207pjh.30.2021.07.29.04.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 04:45:10 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v4 mptcp-next] Squash to "mptcp: drop flags and ifindex arguments"
Date: Thu, 29 Jul 2021 19:45:05 +0800
Message-Id: <7353b0ca7f73188dbbb24b9e1fcb0fd4620a8d25.1627559076.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Fix rcu section and add the non-zero id check.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 94c68d6093de..47200ae451b9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1107,16 +1107,17 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	rcu_read_lock();
-	entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
-	rcu_read_unlock();
-
-	if (entry) {
-		*flags = entry->flags;
-		*ifindex = entry->ifindex;
-	} else {
-		*flags = 0;
-		*ifindex = 0;
+	*flags = 0;
+	*ifindex = 0;
+
+	if (id) {
+		rcu_read_lock();
+		entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
+		if (entry) {
+			*flags = entry->flags;
+			*ifindex = entry->ifindex;
+		}
+		rcu_read_unlock();
 	}
 
 	return 0;
-- 
2.31.1

