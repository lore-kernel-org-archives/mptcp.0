Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786615491
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:45 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-30789a4c537so4179710f8f.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542603; x=1688134603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llfmCx0H+K5+6c0HcL1PftCFSkHkGVSLgVAlN3+m0mc=;
        b=bcpFOrQ8WKp0TO+ljdLzeVt3Z8Y8wE4qfM+d/yqVdfg5y6HUd7XN9iMKnDFgIM+BDT
         DlxrrhpWufhUcqjg/cNuG3rL+B3nsnz/3rcwr2HX/51MXdRKsPQwmIc+82TMkFHBAwmh
         eKFtiW4USmDKImZquMWvOetPgId+CwYrVpmS8/0Hj07sg8nfCnVJPi99ARC8Vv/oPsGl
         HVgSUukpcp42WC1U3c+AyFHdMXtIjgWxBlC+9X+eVEfmx4cxHpB/XjBKI/yt3hB5EDtT
         /2jPX8k3y9T5IL/cnfcu1QcnW3Q+Ej1TFwRp0eSWV2Uya29XaYmJEOgxyPXdUqgUSbq7
         fT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542603; x=1688134603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llfmCx0H+K5+6c0HcL1PftCFSkHkGVSLgVAlN3+m0mc=;
        b=ai4za/LyYDczx77OL+A0T4Dz9LQe7UIifN9xwxUVU7FQCEboUJa8iRUgMJdRIOMpAk
         UXsy6iQuw8ZuG32AZqWBUNvHvinSrSY2OQtZ3hBKAULs5dxCnmnAr+u125uh7Zxn7tSD
         gpHinWJ4B50kq/zoUpVD0tU/QEaLvQNBlsWErrI2rB77z90TjiHpPZooBA7lqNgmou9K
         UeGJW311STUzgemj+tbpxKRt5JeyDriqK86lhUhsjhJRCCwpZgBowDXvtICEpzqmUBB4
         ybjJ47RuzEXhPiPs8EXfTdYJHBa4oSi6qRruOoDPuOE6XPB3/QQLSUr2cS66c5LKq2VX
         NK+w==
X-Gm-Message-State: AC+VfDxSuUFibNVrBn3JivHwDk7T8HUFP11i6qBaiJBQXVXVp/CmnAe/
	AFEOSOuYTwURN8/2YWywzBDJsuf15aJM6VA+C6iWnUJY
X-Google-Smtp-Source: ACHHUZ4oXbf8yYDoQZV2lnY6ye539MBLgrM+4b0mnLVdCm9fHntv2xG9RUcUFrWfFLEjExs6M4Vehw==
X-Received: by 2002:a05:6000:1942:b0:306:368d:8a1c with SMTP id e2-20020a056000194200b00306368d8a1cmr4219110wry.45.1685542603566;
        Wed, 31 May 2023 07:16:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:43 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:29 +0200
Subject: [PATCH mptcp-net v3 09/32] selftests: mptcp: pm nl: skip fullmesh
 flag checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-9-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=lMstzMhzZIe0UepJhMFOkDqpC41lAx03LiShFqM5PIA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCFbjyxHLUyL1faF5zS6OUjyKl2sGiX+nwt
 K8wPu9SucKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c/rwEADehnsUsvZVjeLDwqNhwOPRXVDMHjk726gnNA54j2PoO/5MBsJQCGC/qMUkdwvOtN3Nv7u
 dZ140ZU3KFPf229ulUu56TlDt1gkkMcgqPYgThuAi8kdrNC36acmIO1KOyBgaU+JA2dgLhmYQL0
 nGoVsrwCC+0c/QXK3S34ZUggk4BD+8a+gBDIrXh2XzW6eaGoyrQDOEiY8JkcvI7mdR0ze7Gplq2
 F8kcry1h3b4zUCwKjlORPREHwfmOY+QaIqMVYM3hrLMjya5AymY8BcrwvS1GtEii7ApuN4iH3XT
 5oXUwd2AyJ40T64v6bhnuUO4MHsyMsR8nK26HwBM6O0rV98e5A/Rrlb5Bq/4RI6IRix7ft5Bbxx
 xNc4gDRD9E9sa3rh42WEu6LNJ6hn/2bBlZqFhx8jPH3HrYvMw8ApRiDFwCtywqnpGTp2uqsmglY
 9OuLjlDPaeLX6fIcETFCdbxvRdSys/+Zhk0JsGc+HQGIBEap0qW5L8N/cYS8ek9yp1qWu+EZ50t
 TAQdi4GdI4ZIJ907V/7yVwgAopMj/XaNgkM/2h4+OIxE3XvKoaAfz38Oi9ttwB47t8apD2dkWq3
 Kh8KOgKPN45etAMoqC+qINwPaK10wZezQK/pgGCH8pEh7kLufMbdi6nnRZOkZAVhlvLko0RUt5d
 3bvlsn58fomU64w==
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

