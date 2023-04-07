Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835726FC8
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:55 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id m2so42792407wrh.6
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LbVrMlXn6OtSKSuj2cDj/vMRLBYoDLsgtRwlMCY8Nk=;
        b=D+Cp2WHWJ4BVylVLO6QCv2ZDTM4jCN0+bsWJup4Mwzqqd3NKJlXH8euReeLelsEtg/
         IqjO2dqTohBMHjWKdymqc+0yl5LvXAQw0Qja+l0EPObqds3yZUCALm24mjucDq5fUc4m
         UIm7WuvOhhE782L+/aLC/yeOH55gffJfF4pOWmkrAxqAnWnPPRd9OFnwFvcRkPG28s8r
         dslwdx2RM29iLqKsN3ExY7+/LsoQ1I8O/KMo/1Zt0Ff4VDiTRzMZzAeeqGpb9GtIZTQ2
         plYsmy8vVTgo97vhmdPMFAgqPjqARHrdX4QgECUg0ZemRFXChThU3dPj2Bn2mr62TyJy
         XBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LbVrMlXn6OtSKSuj2cDj/vMRLBYoDLsgtRwlMCY8Nk=;
        b=b0i5hLOCCV+zhogAdC4X10fT++Y5BrwY5cQC1aUzi2VXRJy2WVHkf2t1GlVasZrtq4
         OGjTfoEcXq1rouA44qiaEhOYdBa+nmUXoJSO/k1nY7wdKMV0s59BZCSKMoq5QLkdN9Y+
         whm9TBhsUPWueMASIr37v6xY0ZtLvH4ljqSFIf6JGgJsqKCm62FzQZIsrKXs5lrafDi/
         3pemN/Pa1+nNxLkKriVoMzXsmkUV8PAs6M/3wRfDxq+uR+LjP9hQHgQZYIISft768bmN
         1WaqT5lRPrhwlnsMgt8nwWh76KvUFBeXydZaSGVU9M6pNF3+0qyTT9/5A3x32VnXKyBt
         Nvvg==
X-Gm-Message-State: AAQBX9dmVCiKNIfodZs/6ad/SZdLKiDqqhw+Mv243X1SIXlZ443XSSZE
	C7W6kmKx6T0fOTGL0iFN8Tsa08Yri1mv+8/1bIxcgQ==
X-Google-Smtp-Source: AKy350bAtcAj+D3vpF2wBzxLr88ciRHkUyl4mzROsSes08GiO9bAz0NAoQ6iRAiXN/HrofOlBsDMyA==
X-Received: by 2002:a5d:6b03:0:b0:2ef:b257:b46c with SMTP id v3-20020a5d6b03000000b002efb257b46cmr1672808wrw.29.1680887213415;
        Fri, 07 Apr 2023 10:06:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:53 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:36 +0200
Subject: [PATCH mptcp-net 02/13] selftests: mptcp: pm nl: skip if MPTCP is
 not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-2-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=/idUvO+rOqbR7dE1Rxuj8uTcrOAR0nnW57Dj67WcElI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qQz2GWO6oAa9a++2zrNYAtLX9WDgPsCw+W
 wprYp0o/SyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c2yUD/4y1ngBlkbHkChGyo/YeYjA21C5abuufljYpKRUVadGomdhmychpRgisTI35q6AhN4HfPG
 Xl9diyHblH2Px4A42/yaKN3oa2Qf+tz/vwudmxxr2KPeHBk04Q20CaYUdhtSlGQ/wEESfvnB6y2
 z0zAk4dwJLu5CH0YWur40z9SiemgUnNtnF1mY8Pe0JRvaNw5/7317JD0UQG2AXPZ037RjORz9v4
 xCZnihZToIKrvnWpp//ftsW08YIAInXsH2ahHT0ntTLgfiP8vHtvytEoZe3SO9d2Nj5iJ71bDQS
 TsvYKi2pg8do7wubN0OyEET3x/W6Nov/gPx9xzmiC4aszBb+P8ypfRZnYBSVR5+7vvPMIe8q7hA
 M+iXX2OdpvZ+C01k+vaIL4Y2oXxpKeMVEEjoH0B/rIOlzwIzDsa6Vkt0IHVwaVA2WKhEZuKddYK
 nXMA1IiRDT21ysbOmJEcs10H2PcVYUgax3AH/rrndvN5a4tCGZC/cwyY6jc3JaeNJEfryQe1f5w
 R6omXEHZeyGxaFwiNRFGV7Im4nY+P3J6MZfi2jAaG1bF+BKBglpd2Qn6CN6sLLciHHlLBvapzBz
 bsDNUVp4K7fa7kgqSTqR7zii8M+Fm2a9F18O+GIqD43q0ayDv/mhgXmM3fPiubnnbXg1X/F6mTr
 D3oS/0bHf3BX/QA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 89839d1ff9d8..32f7533e0919 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ksft_skip=4
 ret=0
 
@@ -34,6 +36,8 @@ cleanup()
 	ip netns del $ns1
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

