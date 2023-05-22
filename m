Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEA14A81
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:23 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so62717285e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773502; x=1687365502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llfmCx0H+K5+6c0HcL1PftCFSkHkGVSLgVAlN3+m0mc=;
        b=WCFr/ezlXPSaHmNFv6bgiKT0m1/vrv+TKEUn2ar7xi/DQiDQLFcdQaTd0Mo59qPAb9
         1IFjXhlibCsHzFu9RcwSWHWFtDVwwt+bFZ3d1ZF4MQL4nAIeyGyd5maF0AmTpirWPLvM
         jQQPSRjFl+RZ9vzIkLGss6DHWvCwxbgLoZEfKrDr3rQen0LKjZk39KfNjvW8he7GBI7w
         SjzUpGnwtzM3kvqoOIiU91hHeadEHbFYroiRx3VNf4YEVXLYkqejrrt9vdHGjSSnd8Oi
         jHb3IPB5nhcR5xdSOivtzFw66D5gVBdROQfeP/bv9/g65AHMDfA0FofaQMUEYBgt1br2
         eIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773502; x=1687365502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llfmCx0H+K5+6c0HcL1PftCFSkHkGVSLgVAlN3+m0mc=;
        b=YCVDv6Blnz3gIXutjuAqO1VQWHtqfzizx8cZDfi9vEvxoRPVb7ePtLvpZqaHlZtsm0
         PSBD0Sb4w9y6tlj7cDFuyK0qsrfUtCD3buzMvm015HBlAqkHuP+iySK+BUnGpwLyXJoi
         Yx9pqe5GmhwECTuNFgmHsNl1Zwg02FJ9vrVEzhO5dwlyV7QJiPq0PknRoNPyV7FFLsZS
         QIuB5LEFIpvbQrpQPLVc3h3hCzHlyA8PediWIW+rIUmWi3tQGTmdT2OMAeJmcDHT0utO
         e17beaYh52cNawmzQa+NHH4msU2fyPiiY6517gxq+f1zQzWx0DJVR2AXhLb2R2lDNqcX
         LEYQ==
X-Gm-Message-State: AC+VfDwD6XeN/QlPnQ4iU3HD7ZJn+aN3EUnRFaQQPlL/Dt38uzzqtr7f
	dBXZZ0IvUzn1ck1bo+1TWtmTSAruQqsvJRSxA7DbuA==
X-Google-Smtp-Source: ACHHUZ6xhd7dlsnirDKWpBgfoBaZ29PDq7we7eDzJNA1z1CQFoUsrbv6HXKyZjvUx2aFS2GDlXek5Q==
X-Received: by 2002:a1c:7909:0:b0:3f4:1dd9:e9dd with SMTP id l9-20020a1c7909000000b003f41dd9e9ddmr8598417wme.2.1684773502344;
        Mon, 22 May 2023 09:38:22 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:21 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:48 +0200
Subject: [PATCH mptcp-net v2 16/37] selftests: mptcp: pm nl: skip fullmesh
 flag checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-16-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=lMstzMhzZIe0UepJhMFOkDqpC41lAx03LiShFqM5PIA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwUXKF9Sbe+p4b8bajNMiApisdU/ZeJIGAl
 jXWAWfHgK2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 cxJeEAC+WqqA5w4shq0U2qpZShY9vSZVfhDg6eZwZ1xd5FlXvLVrDLXgtsP9FtTYXdbAOkje7m0
 rohVjnRr7X3aYvfabhxoFz4+Ks2vdePmOuS9CQj1NGKtx3SAASxThJ6BE8fVNoQrD1/qKHvi3Z9
 am6Xxst1u2nIid194LS4xRi/Dr1+vtN0EK+luaCvGi4IINH1gffyoZ9TNklxdbMdAtD35ZjqyQq
 c+P3LFCjG4Rw9LR0guIFP4rtcFm2KT64ku7Z5m1H/04B5soWkuKFVB2L7QecjpNkj5/JBTuWWYw
 yLq9CNhJS/+TvwDcjg9B9KhpqCsRcFPXz1qv2JLJwxpRwBH2/0zV3N3WNxaNNktCVeTXIa+K+/I
 fGTbPJlioncT7Od+PKye4jX1XcLCOH+ak3kU//iDlGbYFZdF+ku3YbzApWclCqUlh9To4pg5k0g
 IebmvCspjevqxmXvidRpiwsP22uFwjm9NCcjOT7Ob9ECqSR/cgG78Q9psNA5pvOIKnPg2+7Hudj
 ehNglh5FbnJkz7JccqQWlYXuHdXp1Ecku9s2Opu8F8ibTjPXZsXZQXWf16DsiV2MDM2+nHWrT1j
 wf+Zf+0qVYTRONzIp7q9/AJUGbSQ5e0YYNMBk/roXDkQzVesjLIFYrZ5KksNaYKvxuKaFfaBge+
 C6EEWkn1kmyZCpA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the fullmesh flag that can be given to the MPTCP
in-kernel path-manager and introduced in commit 2843ff6f36db ("mptcp:
remote addresses fullmesh").

If the flag is not visible in the dump after having set it, we don't
check the content. Note that if we expect to have this feature and
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, we always
check the content to avoid regressions.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6da1dfdd037e ("selftests: mptcp: add set_flags tests in pm_netlink.sh")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 664cafc60705..d02e0d63a8f9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -178,14 +178,19 @@ subflow,backup 10.0.1.1" "set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nobackup)"
+
+# fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+   mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,fullmesh 10.0.1.1" "          (fullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nofullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+fi
 
 exit $ret

-- 
2.39.2

