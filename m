Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103571
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 11:59:15 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id s20so3252756plr.13
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zg7Zr4c4aSwX5XhyqMxd9qrbrvqGLfOePqkRem4JydA=;
        b=riMKknV6+csYsjQwSGnmYwdxnHPEjcmiDJgRQoClGgvYccjE0Zm2GzYIHPthzIxqDi
         0k2xLgAYwNnzfidww605Cwm5869nsO0hkfKC7EvPxYwAAtqGbKLm4O0pnIgMxkvii048
         2XiyTrAXGXx5FFGOXgsHACbZ9xqesXboWDtHmF4V5jOgyNfpgK3JJmrU0Va/StKS+Hcy
         hmwdyHzN3Ey2QaeMBJ3xVuyZaovqj+P9ClLs+SPbhLplSaJwBHDfKHLx0tOxnX0lYzhw
         44theI9rCu/f3+hw97CMctLm0G/ELFkbHoIcxjnSZG6TYXj8zNL+H7xX/Qf5tCyPHoF5
         Rxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zg7Zr4c4aSwX5XhyqMxd9qrbrvqGLfOePqkRem4JydA=;
        b=XNtU9av270PhIzhJrOnMR+y3VpSpK4f2fOiJaEILX0vfPTIZijO1Fqbln94Adj9+hw
         3hWqANmek+bYB/NiX1+qgioPvu8KuMVfxRs9R0VfSZAN3AIiC3mHELsSHwR7LbbAwwKf
         pcT6+0Ef8e/El87tAUf31jWoCbk1n4L6MvFZFqxPObD7yovoJRJcvRgpbvWVSkk0uq2n
         j+Ug6pU9TVupFfh+HxMb0o1D9R96duSQ1O2qXsgAVbZnVimxMXweFJCdciCXfpB3bQrL
         0USDWZ6PttNYIhQA2Pm/2NeVScJ/5RvczD1JShGf7Nnu8Tu9quJAAltySxU4JY3BI+zT
         gzOg==
X-Gm-Message-State: AOAM531r4M6dei9k39GEUavLiMNoEsYbPoBBm2Qhc6kSgtuw34U1YurD
	j1ilB/2sAYj8NnMo+Ec3pLDmDxad5vY=
X-Google-Smtp-Source: ABdhPJzWzR6HWK3YKmqp17V1YnY/2Snb1H/0YebxtH+Zx+t3zmBHvMrvjRWXKMxCGf3leGCHEQrlDw==
X-Received: by 2002:a17:902:b408:b029:ec:e879:bbd8 with SMTP id x8-20020a170902b408b02900ece879bbd8mr3997133plr.65.1620302355280;
        Thu, 06 May 2021 04:59:15 -0700 (PDT)
Received: from localhost ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id i197sm1793273pgc.13.2021.05.06.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 04:59:14 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add sysctl allow_join_initial_addr_port"
Date: Thu,  6 May 2021 19:59:12 +0800
Message-Id: <40ab45efbe6d6089015ff846a88f4e12a1225813.1620302190.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mptcp_allow_join_id0 outside CONFIG_SYSCTL to avoid the compilation
error without CONFIG_SYSCTL.

Apply the patch (Squash to "mptcp: add a new sysctl checksum_enabled")
first.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/ctrl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 431c1989d3a4..7d738bd06f2c 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -47,6 +47,11 @@ int mptcp_is_checksum_enabled(struct net *net)
 	return mptcp_get_pernet(net)->checksum_enabled;
 }
 
+int mptcp_allow_join_id0(struct net *net)
+{
+	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -56,11 +61,6 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 }
 
 #ifdef CONFIG_SYSCTL
-int mptcp_allow_join_id0(struct net *net)
-{
-	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
-}
-
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
-- 
2.31.1

