Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090813AFF
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:17 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso10096085e9.3
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773496; x=1687365496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPzeNz4zKaIRLJUttjurYcvxC7ulBEdHQ6/xxbF5bsM=;
        b=SRLamyhbAFsZSIQ0fqdqY7uweIWabt3KHzAsqubyCAZh8SWd94AhBaP8FpFrH1czCS
         3ZruHapILb6wmnuP9iClJ/KDnxudDoChtbogLEiSt7YcIV/NU94a/2I8M6cU1Vvobhcp
         sQPoJD8zdEEwHQ7WquETNWcx6WlgsMC7ZQpEHGEVCfUr3UtlUJ16ZkCHFgmcuugLU2cE
         twH/RFiQrQgPGRry447iVW4F78ew1fbS9btESYkZ+jpRI5m36UMISgELKDBRviWTb/uO
         F+/1xS28JPDLa5G6WyNp2dgUkuUcn7oih36W1gphaFSkPekSRHHHPwl5xiTjWbMBl6+q
         jaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773496; x=1687365496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPzeNz4zKaIRLJUttjurYcvxC7ulBEdHQ6/xxbF5bsM=;
        b=W7+hHeRXxtNtNL4mS7cSUgaQRyoHc92BTJncCxJtjCcptfFjAt+/raLvPwqdh0cgBX
         x88e5Rah1oigd0vTBfp9JF2/6ursEsSgCy95nYRtIQnZ0lm0mjiwLEX/O8fYhJqlEwD3
         ZHm9M3+QaboXvuTrUykiBGBcZFffPM3ck/MbFjZyO06hX6bHbjvJhU1qD0ReQcObYFmq
         aqgjZZTenBMtDppaB/0c8unZkvX4G09M1uDP0b7xfRL5NBk60/PoDO7dJ5Qs4PJjtW9F
         3vxMK5pq8RdQKG4u2fNi1OcVUxYlPmHTiSkEW60P2ebdNBAtv9Eew6J9q3s18CIyvbdm
         cveQ==
X-Gm-Message-State: AC+VfDxWj8z6OkSJKmEwzsqHKOomrTV+aixtKUMeOoE/sub8wihKCTqO
	sgVFTPcFk8dy5VNwSF6+pigYI5IoYIZvIgRJO98nbQ==
X-Google-Smtp-Source: ACHHUZ7fAn+3lXpMcFBayCUiZu+AFW5S9zeORrfxeNqJzutXaasIggeZLjPdDTgYi+Yury/ZHflNQg==
X-Received: by 2002:a7b:c843:0:b0:3f1:979f:a734 with SMTP id c3-20020a7bc843000000b003f1979fa734mr7687749wml.11.1684773495873;
        Mon, 22 May 2023 09:38:15 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:15 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:39 +0200
Subject: [PATCH mptcp-net v2 07/37] selftests: mptcp: userspace pm: skip if
 MPTCP is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-7-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=zg/b+j2ljOqZD0PGnYAJtZaieQpiMecPLbX5LAyS7oI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pv/2CahPAKun8P3PphR62C/xWQ2xqDLl5CP
 nm7uzTekCWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c1+bEADV+iEuyvSxhAMvZiokMMg9YfAUqYASrRIYcwwHUpJ6nq+g0TX2wUpjUrEZp+pap2+paa9
 wY/chyKub5uXf0nNR39M5Jy0ryOVLnSzC5U7vTJ54BQyqgv7LPaNg7vEp0FDSwSjbuGPERJgCwy
 wm/FeA+C1ebIy8THxuHeMzbvYZ+z30jBDqaCf6JR5mDMsfEqcbs63tt3jgx3wJXFYF4WzYU8JKk
 KfQnjNsZUaOdBAwNevq13SwpoZgpLts68wD+5EXf10sItdQ4ESn7RMx0w7ouWf9KsP+dvUEaCmr
 r+CNNUgvilLQJp/dWuFAegiRrT8Q3MZTjLoXWvsdxFCKjx6ywTbh8lPMUGQv3ojGOgNqM8t8c8M
 35CiC6KdQxNQ1QkYdiISS38qV6aq+mxRRVTCPA9eCZxV0o4BwL6w6LMlhUkt7N8YUibI6o9JCgc
 sZoJZOwr0/FbsjOmvYo3jrk/PYRcOIztPXEF9rZw8ZCQJpo9tp1T2HDKjUqLVjZ3lxtGPoKLvIT
 q7La8I9ddp4pabkDaC1MxZtVeKSo0Yk3zGXZVfR1H4XFymJjaoIZwHpqR4sg2D97kTLQUK36tja
 9Ln43y7uXapiWrFVSt0KwdZBS2jCkmUhwPmnEu+yIWQ1rLBjuXhZss9ue8Ajt9w0eQYQKLkb/lm
 3BCafRjlt1cgb4w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b1eb7bce599d..8092399d911f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -1,6 +1,10 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"

-- 
2.39.2

