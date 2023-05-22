Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE013AE5
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:13 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so62715635e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773491; x=1687365491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il6Mx6mIQwdj1F391cLuCTEpkmtWQ4rCbVhgT+9Fwg4=;
        b=HSAkosNv7RSXASvhIvHRqNOvT78FASUae+MVDh5L3zh0BLlonJaVLa0pmMVhBXlDTZ
         pcnMHolIK9hHacyjBXof9sxWdWfTk/kMwVdymWaHHmD+AlxPuKx4OphlWe0kiPXfZcea
         at4TFSeyrP4BBpnCWuyWHbOqF5NhTYlpwBSBeXnP/VHo5PQHZHVUUr7qXz3hG2+zVeld
         7l5KlT1EFTP+AIzeIXgadc/TogXdN2vA+R/oEKXNosW9PsvwuWMe41mn42XgAE28NQZf
         Tnf889rPUvHD3OnYixqIIHjkDLiekiQzZjruT6Lsw0XvOvTkiBS9ZVfaC5ugQyOGcO+K
         i/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773491; x=1687365491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il6Mx6mIQwdj1F391cLuCTEpkmtWQ4rCbVhgT+9Fwg4=;
        b=MDRRkGcY/McsqNoHQtlrZOlBjyQRxLj7IxE6QyvjMYp5aRgZ3CJxXiAT+RW/TxTYBP
         Y7Z5OIV6ZbVgLdhPOj5DXO6aQXeVekEgZbOyDjqBvNBay3y9YiJFkdIBLnOpFso+yw9B
         5h/EiLrBxYX794geL9z44SGz0BGWIjlFxRYJAvQcU7l8bysWLjZet501DV8lWsY8xt5W
         V8IfBs8yAhz+WYwXqnum//GFL3T7SEz7Nkoha5U/dLcWWdF6l0yk4KBqZu9u5m8viDF5
         3e6v4gVJ2rGdBXk7jjyCgA6YRsL39EyoMp8tVBWX3JmCFeZCg8CuO1KLOcrYQEV2cfPv
         /tqA==
X-Gm-Message-State: AC+VfDwZ8aiPSPSIItzc8aOw98N9FoScRJMPtuiRNya/nvy1pw2qNxWd
	+snnYItI0i5zE4OW+aXzd/A/YcynD+ujnN9vMBgyWg==
X-Google-Smtp-Source: ACHHUZ4/EwhdhV71+R/0Vv6VEo919mxMTJlTC7c3hJMXNTYVTcuyxLIm5QJwtckL6/vEWqC91Je4Lw==
X-Received: by 2002:a1c:7c0a:0:b0:3f6:683:627d with SMTP id x10-20020a1c7c0a000000b003f60683627dmr1678535wmc.18.1684773491286;
        Mon, 22 May 2023 09:38:11 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:10 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:33 +0200
Subject: [PATCH mptcp-net v2 01/37] selftests: mptcp: connect: skip if
 MPTCP is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-1-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3302;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5gqCteOZN6pbAwq5DMJ3LCjNGJYrKWS25ksOvWJOrzo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pv4ZEzEHQLJdDir2s8NTOmK4xANlkWjwCe8
 MNuIxrB09+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 cwjlEACvJrWrTzcCtSnNuLkk24bkxIwIn78z0djDOuXYu5OFTmRHmikrcVIuyC1+PrktYz/XDqu
 mni1F85NGym8UxTFhnRGEHW59mSxMovm9FkP3Z/BjE9zdhTRvMaZoYxbMIoggbBW8b3alXJA8do
 v7yyufQBTQ+dMTlkrAXvdhjGlmC5wm419fK/GSqRXkAwV6Cx3GYPT3gRcHdJOhgxLH9PwZWNCwZ
 ETOtG6jGvz9cn7rm6os4PaKfVxb4TlonHXO2uy7hzxCo5EhRdhBrtszoPo5BE63DpDEvoyJuib8
 TE8L8ZC+WdPO39uVm4+tUjDyJqCZ2eIJEvb7T5b6ZRew0EHslV6hesV2KD7WgQIUfu5ZbbmUQkg
 VhGhD2OsSzWrjKxmStqelb0/HtUJ/wwq0GqhRAae47ZrrznRSUo6b4IUDPaPq/1yC/2RiyysY3G
 w6I9POYMKdv35LIhiDceZCasMTyR2ovesIj6QbAXPXz2nXLLtl/suu9ySa7D02HakHKHHsupBLt
 Mb7chg9KN5u0vNYZ/+5dnzKO1rGDlPgTdJLmAg0gqazCDZw1uvOZcK8l40z7G8zRJYn/mvdxt06
 Daf2WD2keiHtqUdmsFiBpB1YyZkMAgpuROQVkDKN/KpvBMprPhxL3LOhug0O/rcBA4pYxOsnOZF
 YETUmpQAGoTDpbQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped". Note that this check can also
mark the test as failed if 'SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES' env
var is set to 1: by doing that, we can make sure a test is not being
skipped by mistake.

A new shared file is added here to be able to re-used the same check in
the different selftests we have.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/Makefile         |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  4 +++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 40 ++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 43a723626126..7b936a926859 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -9,7 +9,7 @@ TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
-TEST_FILES := settings
+TEST_FILES := mptcp_lib.sh settings
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a43d3e2f59bb..c1f7bac19942 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
@@ -141,6 +143,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
new file mode 100644
index 000000000000..3286536b79d5
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly KSFT_FAIL=1
+readonly KSFT_SKIP=4
+
+# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
+# features using the last version of the kernel and the selftests to make sure
+# a test is not being skipped by mistake.
+mptcp_lib_expect_all_features() {
+	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
+}
+
+# $1: msg
+mptcp_lib_fail_if_expected_feature() {
+	if mptcp_lib_expect_all_features; then
+		echo "ERROR: missing feature: ${*}"
+		exit ${KSFT_FAIL}
+	fi
+
+	return 1
+}
+
+# $1: file
+mptcp_lib_has_file() {
+	local f="${1}"
+
+	if [ -f "${f}" ]; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${f} file not found"
+}
+
+mptcp_lib_check_mptcp() {
+	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
+		echo "SKIP: MPTCP support is not available"
+		exit ${KSFT_SKIP}
+	fi
+}

-- 
2.39.2

