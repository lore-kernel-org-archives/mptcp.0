Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B666FCB
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:07:00 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id l12so42766081wrm.10
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9DcJ49MlKj9JbprI1uzw60BSGsuRrqduARrxsQ6a7w=;
        b=o9aiv+87YYWn4TmAgyTObloz11V6M7BL9FHsBf9puALAGmTUv6+UUlvVAwaYr29zzo
         el8Du+qTUwWZnt/sJIo1vR6Haz+8wNzlVVLjXo+L15l+O3umXq1XhTeLTyofttqLQNVJ
         99kelCrjHAj+6PJOMdioGAHYTI0J7VhHGbJ5iUlyIHB4rCCcQEEF/W/L0O2UuPjB60BR
         3kDdFjGTenMT7pwgx+4bxNNf9ybZeGEE3VLBqRKSi4y09JvYUiwfe52k16xMoj/g8zZT
         9NI5fLtUa3T0NdJJ+xzrgBPKwVC0KO2l0fDdDMqfJjstLjQa8Zv2x/Uib40QwzRezAgh
         iYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9DcJ49MlKj9JbprI1uzw60BSGsuRrqduARrxsQ6a7w=;
        b=WcyZyNPQYnJ8KX/udcO55Gi1NaNQGf6DQUoHCyTFuBlJ7VLKDaXpxTzvzyAisQe6FV
         2euXaCvt9nuQrw7d/bNd6FsXaRoZQGG9Bg6rCcgh1yS61WYIReq3ZE9G3kzGW1bXJAWl
         bCwSrnzdj3SPd3LoGNONFC+ER3WykBOo3pMKcSIn6628kLqchJhMRDKgaRD7ISvMREks
         FM7/sM44zDNRsUmJcWbY7n9RUwMNV8RxmTSBm5k36qdknIgi8jAsC/0ldq8sZBLR9ZqH
         3QmNCd3aB8dr7l7H0lQzUgX41RTcK2jS97ouNhLCEAtc4m5s56Db1A5bbPdyRgDE740u
         DFNA==
X-Gm-Message-State: AAQBX9eq0GfISnW9d8NsHy6sA8PsX/Tgf43y3/DOSQZHylOzlxtgirnk
	50TUJyWl7UliGb5yFOY/xIRlDWvBPR7DoRYQRnjauQ==
X-Google-Smtp-Source: AKy350ZB4zd+O+E22NljVp/nFBVuzjqz/lKJ2hDHmGmJahrfYsM5fPA4CfOMRyb6vUxUaQM1gJ0unw==
X-Received: by 2002:a5d:6948:0:b0:2e3:a506:e348 with SMTP id r8-20020a5d6948000000b002e3a506e348mr1995546wrw.62.1680887218339;
        Fri, 07 Apr 2023 10:06:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:57 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:42 +0200
Subject: [PATCH mptcp-net 08/13] selftests: mptcp: lib: skip if missing
 symbol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-8-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=X3Qtn5Mvdi8jBddUbxBOXMpzGF5snM/Xi7gN1HYSbgw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2rJhwemuC49BHvAikqmf1pfmICGme1/Ucfi
 zBNsEZ9FM2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqwAKCRD2t4JPQmmg
 c9noEAC1dya85xiaOHAtrrMUExPILCEj//6F6TtbT36FMhoq5NAW1F5BqMRM8MlwNzxs+My5CUp
 7Oh+yFNKkpQyaLm6Yr+Icdx2g9fLwc38GjJY5+LaZdhk5tIGqJB/uUKNOWAPqUU2Gp1iV2rF8Fb
 0Qjo7mXj4HlZuTo8NgNG4tqrmdo6iozWkX2UJqVl3ZAs9YZNfBQUmcFIriKItmmLZzfVEe1lznk
 G4ulvM3MzwBg39Ea1RXQ3R3aLU6WqFLt3viIMc/g1K0pxOMcegEsdVFpEdbdkHriTLRX9KsA41l
 sJeRijySWEK2DMrnnuD6T+G2vSYSBiBQcQvUK4iLvJQKEw2w7pXpjCSCWBs+G13OHKYUIMX/VCG
 aoekuiCGqg4TazgizSM6wwKcJvz/FAWSfD5Kwb/1SyEHwjq45VzoGFapSyquaZwfT+AqiM+5Ta5
 6zz3LfnkkN9Qa5mvMJ7NvrIH0ysX/vZ4hHylfmNeCiEUbXla/Mr4LFg/suERb0epukUxcllD05M
 AOaS+vbzS5qP8ebkEttYSG9DhT+L8DfrraEFqxBQc7DXbCxDCObU+f4vCq+C9cHeyHFdqBeZGWv
 5kCWLdR+KDcsz+cW31Lj5ZxidyoG4xFswQzAPybTEXxQavR9/GRd5ebpalBHt1Pgc3VRe2d5wcH
 3D554l1WPDqRoPQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

New functions are now available to easily detect if a feature is
missing. It is going to be used in the following commits. In order to
ease the backport of such future patches, it would be good if this
present commit is backported up to the introduction of MPTCP selftests,
hence the Fixes tag below: this type of check was supposed to be done
from the beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config       |  1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 38021a0dd527..6032f9b23c4c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index eb0feb76e2ab..c84eb40abd1f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,6 +1,7 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
 
 mptcp_lib_check_mptcp() {
@@ -9,3 +10,25 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if [ ! -f /proc/kallsyms ]; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if ! grep -q " ${sym}" /proc/kallsyms; then
+		# We want our CI to complain if a symbol is not found
+		if [ "${SELFTESTS_MPTCP_LIB_EXTRA_CHECKS:-}" = "1" ]; then
+			echo "ERROR: ${sym} symbol has not been found"
+			exit ${KSFT_FAIL}
+		fi
+
+		return 1
+	fi
+}

-- 
2.39.2

