Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1129134B0
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:12 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f41d087a84so26976115e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773490; x=1687365490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZe2c9klxQgmGs9w2KfogxPtZSCtMARhQSk7HFIDebk=;
        b=n1fdA+h/6GRXb3OQzuRoNUFOxGuts+WP2rF69ePVWwFXeP7KVJ78iF20cEMhX3sRFm
         aK6DGf1oRyCVF0fWwKR0ELvsXM5dxBHNsq8OdGKv3OTKVqe5vOzXtHu+CMjIsM15TnhU
         TBuBcdKMuGopgej5+3a6617EEwB+d7qjmIeVOEtnovhTPx1KxCbvwbMHyUvVwtmsBU/r
         Um8rYNnEMrZ/v9PWCsyNR4FhFgWVnA8nQ0+l54TwZu4zu1jEYBOuLsE+uhyZvsOHs3CD
         /yrJPuW/RHn+MtQv96Vpl9TMBfnDlzbLkm347ESG7NHkFXVJdqQky3CIEsiMLCn2wH7h
         8e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773490; x=1687365490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZe2c9klxQgmGs9w2KfogxPtZSCtMARhQSk7HFIDebk=;
        b=XXg+gvLOkXnSMe+oBJkO/9XeOSGjzQFVR1/mfcrNXBwbDPoknP/4hfOY1l+Z/Vm0qZ
         7PuA8fSgITc2SaaYqMa6kets5+bvMqXR08eFWyQ20b7YQPTeEYLrFgseSUO4peDIbsRD
         ZFazBMJFLeeWa4+m0JlTP0ZY2bLDVrndNCA4/b1yKnGhe2jff8zWsaxqOOnlgMFECdrY
         +2zsSbmQqlHU4w6+9tCwzwyhfZ9TbEnpy+m988lDHuCmbRk1Len9G7P6+iX6pEQvXknU
         3eR9zVtnKhXlLYyd4CZM08m6P/5rk3l/0vuqWrNgmroQAOO+EGUdyh/8oxnOCnjKG/9s
         v2yg==
X-Gm-Message-State: AC+VfDxbe3y4t9JmOFKHOrnZgpy0dMhGPYs7OZiPKt33AILaJk+2uOFu
	SOoLjDX1Bh7+9hBpeIZ5MCVCszp99K7OlZkqsu8=
X-Google-Smtp-Source: ACHHUZ5dTvi0t2SxN1weNvPpsU339M/piq9eh92zzTA+eaKDuzO7cfq5U062BfVYfRTeVkIm7bd5Mw==
X-Received: by 2002:a05:600c:3c93:b0:3f6:829:71f0 with SMTP id bg19-20020a05600c3c9300b003f6082971f0mr1058210wmb.14.1684773490572;
        Mon, 22 May 2023 09:38:10 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:10 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 00/37] selftests: mptcp: skip tests when
 features are not supported
Date: Mon, 22 May 2023 18:37:32 +0200
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyaa2QC/5WOQQ6CMBREr0K69mspWMSV9zAuCv2VRiikvxAN4
 e6WegKXk5m8eSsj9BaJXbOVeVws2dHFIA4ZazvlnghWx8wEFwUvuYRhCu0ElmhGKOQFCHsTkAL
 B2Gt4oXfYExhjtKy1rHSds8hqFCE0Xrm222nhNE8UPKphLyePxr6TxJ39+A4De8SqsxRG/0l6S
 54Gf5osOXAQpVTtWVaVKPUtbkh5pGM62bbtC+JdpvcFAQAA
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4957;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=T5SYxrtH1O4TnDRlhliSZxyl6+u5NsDXTAovO42f5ow=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pv7GKAQ4a6IeD13f4RSo7JI+XI8Q1Ia19u7
 m/IXW8fajmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c4roD/9B1jA/cFG4E/FRdy3/P8xJmlvf3iATDtsWlonm2BfRbMVCp+Pp99M+mGeet3tztbzso1T
 2V/w020GXTqQB3Qgi1hPMh9EuYYTeG6I3n/6apriJl4gHy+esEswRdh3+F6iee+sZuYIS0+JEiM
 LPrnx9SoA29TgRXn9sJNXQ0nH4JlCawNrYQXM9unMLKBLMfNHEiJt+CQnZqY/WXWVeerJSQIrtV
 bIaeo/er11qMRQpIuxR6STmNoTwl5mwi4hLGAeFaX1METFuCltnunEZJ4vCsJl8MoK2aRr5QFW7
 KMGbekxSfM9pMPDzMdrz1XQlwrcc38MLhrMdd/hARAQ5ApjE6Xi9QBdxjNkUygFOR9lhLr47A51
 U37A4r9wVT5JAAZIi9oe9JkAP1MS74u3zWYw3T09rL4kqOL9oWxNAYnL43uw82+TuydYGdmYG9D
 HqRXHWVVn8J5/r5HhPuG/XUSmIWHWIw/8xBIayGOCpD1v9Ge37jPC8ekCpN0AbtjjGe+lmABs44
 pBr4bYzGRpKdjzbMJTiTu8l4g2uIGGKeVscLksvx8jBbCyunxB8bcPZtuGxlfM6Arl1saRK0wiN
 xAifsyUo8xcjlYQxNO5X77+KJhliUz4glXOZo6upKb1xa/yxkW1GFg046T3iqRqnMYq0a8afA6/
 YIf8yHxFimaYPCw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

These different patches allow the different MPTCP selftests to be
executed on older kernels.

I tried to minimise the modifications and do the checks from the bash
script not to have to detect the feature when being used in a .c file,
then pass the info to the bash script, skip the test, clean the
environment, etc. As you can see, even with this minimalistic way, a lot
of modifications have been done to support old kernels.

Note that if we expect to have all features available,
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set to 1 to mark
the tests as failed instead of skipped and track regressions just in
case one of these checks is wrong. The public CI already set this env
var to 1.

This is a big series impacting new development. Probably best to apply
it "quickly" in our tree and fix issues later to avoid multiple rebases.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v2:
- The first patches are almost the same as in v1, the main modifications
  are in mptcp_lib.sh (and in the commit messages): new helpers but also
  the use of SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var.
- Link to v1: https://lore.kernel.org/r/20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net

---
Matthieu Baerts (37):
      selftests: mptcp: connect: skip if MPTCP is not supported
      selftests: mptcp: pm nl: skip if MPTCP is not supported
      selftests: mptcp: join: skip if MPTCP is not supported
      selftests: mptcp: diag: skip if MPTCP is not supported
      selftests: mptcp: simult flows: skip if MPTCP is not supported
      selftests: mptcp: sockopt: skip if MPTCP is not supported
      selftests: mptcp: userspace pm: skip if MPTCP is not supported
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: lib: skip if not below kernel version
      selftests: mptcp: connect: skip transp tests if not supported
      selftests: mptcp: connect: skip disconnect tests if not supported
      selftests: mptcp: connect: skip TFO tests if not supported
      selftests: mptcp: diag: skip listen tests if not supported
      selftests: mptcp: diag: skip inuse tests if not supported
      selftests: mptcp: pm nl: remove hardcoded default limits
      selftests: mptcp: pm nl: skip fullmesh flag checks if not supported
      selftests: mptcp: sockopt: relax expected returned size
      selftests: mptcp: sockopt: skip getsockopt checks if not supported
      selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
      selftests: mptcp: userspace pm: skip if not supported
      selftests: mptcp: userspace pm: skip PM listener events tests if unavailable
      selftests: mptcp: join: use 'iptables-legacy' if available
      selftests: mptcp: join: helpers to skip tests
      selftests: mptcp: join: skip check if MIB counter not supported
      selftests: mptcp: join: skip test if iptables/tc cmds fail
      selftests: mptcp: join: support local endpoint being tracked or not
      selftests: mptcp: join: skip Fastclose tests if not supported
      selftests: mptcp: join: support RM_ADDR for used endpoints or not
      selftests: mptcp: join: skip implicit tests if not supported
      selftests: mptcp: join: skip backup if set flag on ID not supported
      selftests: mptcp: join: skip fullmesh flag tests if not supported
      selftests: mptcp: join: skip userspace PM tests if not supported
      selftests: mptcp: join: skip fail tests if not supported
      selftests: mptcp: join: skip MPC backups tests if not supported
      selftests: mptcp: join: skip PM listener tests if not supported
      selftests: mptcp: join: skip mixed tests if not supported

 tools/testing/selftests/net/mptcp/Makefile         |   2 +-
 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/net/mptcp/diag.sh          |  46 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  24 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 510 +++++++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  99 ++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |  12 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  24 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  31 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  17 +-
 11 files changed, 546 insertions(+), 224 deletions(-)
---
base-commit: 194dd0efe579cb5d3a746d248b3476f4b3fc0b48
change-id: 20230406-mptcp-issue-368-selftests-old-kernels-fffd69d67d91

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

