Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7D1548B
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:35 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f6042d60b5so14625945e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773513; x=1687365513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctJ0lqu+kiywgLz/K9/ac0x96bWCZeXMDjIdTAGCTwE=;
        b=W+DD5E+KxJsaR9TT5p6NuCorxy7Xv2hgDRS5O7FDnGao5qeZLhfySeeZSi4oCWBmdN
         v9EpuTB+I2Mrd/iwPjkBziDtQq4/s7YT3JN8bgQBQZYNUyMH8mZCnPceMe3TQoo4y8OV
         +AGQd0mOXQ2D298sgwOXcHaWBrvTNLnXU/z1oOmJCxql4gpljOWURHZiwFtEDH0pc3Zj
         FPNOBR3wYTCEYqF4GiUDuy6yna3gIuZFkLdv2MxhODd5+tIxS8tTnJ7iUUUMeULyX/Lo
         Dm8tvdShPju11QLJFaFRytRMVYbMhr+iB0CyZzawVwlqo81ZAxGMSItHVsFHpiyam3xU
         7AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773513; x=1687365513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctJ0lqu+kiywgLz/K9/ac0x96bWCZeXMDjIdTAGCTwE=;
        b=gxdBqytUvMAVf7g8KkgdPbcjLzbxNjJWutiFYMNJcD66i8muwVOsFek3S+A6B/Q1CE
         uYTPKBi4RvMbox2t3nNCEXElxoSORll3W5YXux5qrJ10htoE4mUv87BdpOrwzVBBUPIW
         mPbCOoaVItu2XcdARqoOYS9wpYcgESuUG8xVg+ByEyE9y8Mz9/njv9jxG/3sb6auukPp
         70l91A4L+D6gJLEsgKVaiez6P9pXeNrryU0lLIn9TKJf0+rZcBCbi3YvG73fsBIo/WGk
         yU7Kg7kBm7FL14Tt0LCh8rWW/JJj6i2lyXWJNKybjx0UK21FXL8jw2Eu1wGqS2EHz9y5
         18Xw==
X-Gm-Message-State: AC+VfDzRZHiWkIYJdCB2Odyx57aZTv7B1mXTICBVIoHatuSSyvyVaiiA
	rgsJL0OXBtZAnFsDgkVB1ieq4a/3fKsJLeQiH2sXBA==
X-Google-Smtp-Source: ACHHUZ52/jg1w8PhJ9uMoNwDojo53qsB4V4HShYClzTUHVTcNf90o1zz/riOZOG5anN74ekLEzGAKQ==
X-Received: by 2002:a05:600c:24a:b0:3f5:fff8:d4f3 with SMTP id 10-20020a05600c024a00b003f5fff8d4f3mr4094404wmj.7.1684773513231;
        Mon, 22 May 2023 09:38:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:32 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:04 +0200
Subject: [PATCH mptcp-net v2 32/37] selftests: mptcp: join: skip fullmesh
 flag tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-32-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=3JE2VtmuvFYiO5+0ujCL4MkpZejN+7ivPNDXv3hfK+Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxjMrLKxcXetvWj7W6RduuVsUQ0gCQFiKcT
 xMOFB4SyISJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 cyAhEACtLolcYGBTiB58aQ3UIqUrAkyJOrfU2GJmrJVyb08vrO+vugnVfFcpJYrml/6dPz0vSx9
 1m7X4oX9pPIBEpCdI5TdYO9mHgmiFRfWeudBrr8kXA6gtnqjGuuPnZBlKzFoG0RTQx95s/DweK/
 W/EzIfUYD73ylJzzWEkaUyoDfZu7zMLx88m60DuGzNHWPzgqspUQvyL/pH7NQcSHfrBBq22aI1v
 YRqisyaH2ef5z2bLZ8et+TcCOgqBsTB4jmGAoNqg7sku7xXpPMdnfYJ7/smt2CmmQ6ZHt3NpWJn
 JxKzp7V1mCPeDqmPxnh126npnk4RmSJPcsbd75W0tiAw5TC6MNMMqkzlfMFBy17eACxQvL38gWs
 S+kEcXf/ZnDr+iqpgTx1tpjASsSlxaaE17PaI+2qZ4RLfqwFP/rbtNo3GFCm9UIzytktIfRxpQK
 hVCF0yzdD9iXscKV/dKM1ALXK5TIS/Th1ztJxIMGi5hod5KJhxcK66xs6vTwoT0CfSbHxVSRaz5
 w87fBuD4Rd9Phesknq8a0HoTQkzDusDvM0NWliYJjaskgd75hHHyZVyzKxCC88qYU0Rs2mvLPFT
 6Nct+6/Kh7VrO9eE9QatWcuEAJlMZYbpt0dGfMlxgaKAbV5qRLAN3ibb5vuyr2JBx9h4zAEjxoh
 80Um8ho7YZzjeyw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the fullmesh flag for the in-kernel PM
introduced by commit 2843ff6f36db ("mptcp: remote addresses fullmesh")
and commit 1a0d6136c5f0 ("mptcp: local addresses fullmesh").

It looks like there is no easy external sign we can use to predict the
expected behaviour. We could add the flag and then check if it has been
added but for that, and for each fullmesh test, we would need to setup a
new environment, do the checks, clean it and then only start the test
from yet another clean environment. To keep it simple and avoid
introducing new issues, we look for a specific kernel version. That's
not ideal but an acceptable solution for this case.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3453ef733a4f..795a27933e6c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3156,7 +3156,8 @@ fullmesh_tests()
 	fi
 
 	# set fullmesh flag
-	if reset "set fullmesh flag test"; then
+	if reset "set fullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3166,7 +3167,8 @@ fullmesh_tests()
 	fi
 
 	# set nofullmesh flag
-	if reset "set nofullmesh flag test"; then
+	if reset "set nofullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
@@ -3176,7 +3178,8 @@ fullmesh_tests()
 	fi
 
 	# set backup,fullmesh flags
-	if reset "set backup,fullmesh flags test"; then
+	if reset "set backup,fullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3187,7 +3190,8 @@ fullmesh_tests()
 	fi
 
 	# set nobackup,nofullmesh flags
-	if reset "set nobackup,nofullmesh flags test"; then
+	if reset "set nobackup,nofullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh

-- 
2.39.2

