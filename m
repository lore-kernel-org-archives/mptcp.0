Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4527711
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 11:33:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so70076045e9.3
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689161606; x=1691753606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTnGCvClkDP0cRLX40YuT990FHVmLq5kBf1AWDC57LI=;
        b=V9XIdLUT1G5COmmq0X8Qyrqz00L01P4C2031s5Pu2l+bpOB/LAHnID0PK+6emQyRut
         V8Xwig97sZVzQyJywi/DOlda/GZyJxKnIRegeYIjoNHxDaNAn9jc/c0zJWSThgna3heM
         4fn5EuhuL03Q+/2ohyQKd4QJ5qJKXJ+3k0D55L2BSIbKEMjNb7BWRbAoNwBYCEJ8F//Z
         gDcqC9874/Q6LAt/B0+tBBpO5KXvDtAQwOt2gdhflP/z5sdhrl5VXsUsXzv1m2H1MWeQ
         gIj2nK3XkLDaNuCbORxGNQM5LervT7Ry0GAWuYujD79MhEmfCY+siXhw4TjBDA52kDX8
         HB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689161606; x=1691753606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTnGCvClkDP0cRLX40YuT990FHVmLq5kBf1AWDC57LI=;
        b=E0NkQfJNc65LKOmZV+gbEVzQI2d0JbRKg0UraiUoxpTk3FxA9q6VTLruuBjFTz49Ov
         j2GtUQc0Pthw6hgtj2X864KLUnl38BUFSxfNcCL9VFiMx02QaLPv3kphOdDWo+YgvLWr
         zDJhKwlqeJGNgoD3ZlwwZ4qHC/6bGOD9NtHxlUUmD/3qfXjOm4QRnGu9lvGK9pDEjKqT
         tR/f3qwBqSOIu7tU+Lk2UWhLP/7+LRvxcoR1AmUJTomGJawUNNJ1/94/wP5eWecZJi/Q
         7ZK7oFpW7erS7lC7R/zh72fkCBW1TdYq4tAsRmKQbEZrSxGjR7Dmp2dsq7eYfEjD6s6V
         EPDQ==
X-Gm-Message-State: ABy/qLY4IVOnNAVUBPwTDDluZIj3Mknboat+cXetHtc2TqWotxbiYlJl
	31YxmE6oOp9BX5+e3f+jCQFORjmcdnPclXdxq9Omkgov
X-Google-Smtp-Source: APBJJlGdCOBe/d/mAVkx7AzsZHzwDC7I1vFq0WHk2e8Cn3fi/yh/hmIjZxDHaVIk+Dq4bX3mZ95fpA==
X-Received: by 2002:a05:600c:b56:b0:3fc:175:ade7 with SMTP id k22-20020a05600c0b5600b003fc0175ade7mr14736939wmr.38.1689161606072;
        Wed, 12 Jul 2023 04:33:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id j11-20020a056000124b00b0031417fd473csm4892673wrx.78.2023.07.12.04.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:33:25 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 12 Jul 2023 13:33:07 +0200
Subject: [PATCH mptcp-next v2 2/3] selftests: mptcp: join: colored results
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-mptcp-issue-368-selftests-subtests-v2-2-c8b174c18f93@tessares.net>
References: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
In-Reply-To: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=7eyC5gG5Tp7c5ydt8+CKmFbaUG/D58qylAS7V6WMK5E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkro+DOW6inGsSoNEbt5bUoUaK4ppjFcNxrAZqw
 Ph8Y10FLmWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK6PgwAKCRD2t4JPQmmg
 c3nGD/wNGoy3y2FBslwBSglJbQyWfcVvQ64cFUGkhrXn0PxGqZO9Mv0y31KyltVsiJoOtJQoALh
 TN8EYj8yp1i80QCWxvC6SdqQJ+Ux6jn7Ptfxv7GMLOP9Gy2VFOMdwIqDMuoIUAwam0LYeaP/54w
 1c10Fe4BtEsWulONjbdJLxCOuG7NGyIeUxgQlSxNrwyghMGmupLPCWqDsf4ppjdd77hjZQSxT8i
 cMmGTyVeaa6uDhMiWAPUxQrdtY/UEqS97oQzLRwbJ3a6ScyWzYEtQSUhrRHZ1UE8CqVW/g7oMWn
 SnMCiDNqhFVjD7EpcAd3ZrFxbpNFSiFQaCB/EkdY8Ix4mIu8aFNpQvkuouofEMLQn6kuJJb7ABd
 fc8hvPk4LBYLM2CjRMb2yAJPxIGwYFFHNXUW8Tne4cT+3YRkgwMEkkPd1/0yUz4fLlRHmm2d7+I
 TnE2yueXEtZqaRpE4gHcLezx7uC/YnxVC8cIF2ck4UUHhiGlaZPRbWB4pCRE9Ooxx7/d/Iu499i
 EzQYl8xwP97po7ZrDZ0lwqbPEn4TjWFFMuQnKFnQ2wsThfKD9uWqxl7qXc2vKIVFTxGcCqm541P
 yt6r6GkazgGmbcq3sFIriI1k6x8IqPJnRYUBJen/aYUPxbYDS8pFvIpkdQTT3+yk4RnS+gEdqJG
 rqSLL+Pr8EVtiyw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks to the parent commit, it is easy to change the output and add
some colours to easily spot issues.

The colours are not used if stdout is redirected or if NO_COLOR env var
is set to 1 as specified in https://no-color.org.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  8 +++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 38 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6bd4816cf74..2f47686b6214 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -217,22 +217,22 @@ print_info()
 	# It can be empty, no need to print anything then
 	[ -z "${1}" ] && return
 
-	printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
+	mptcp_lib_print_info "      Info: ${*}"
 }
 
 print_ok()
 {
-	echo "[ ok ]${1:+ ${*}}"
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 }
 
 print_fail()
 {
-	echo "[fail]${1:+ ${*}}"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 }
 
 print_skip()
 {
-	echo "[skip]${1:+ ${*}}"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b1a0fdd0408b..1080d5d2430b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -4,10 +4,48 @@
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
+
+# shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 MPTCP_LIB_SUBTESTS=()
 
+# only if supported and not disabled, see no-color.org
+if [ -t 1 ] && [ "${NO_COLOR:-}" != "1" ]; then
+	readonly MPTCP_LIB_COLOR_RED="\E[1;31m"
+	readonly MPTCP_LIB_COLOR_GREEN="\E[1;32m"
+	readonly MPTCP_LIB_COLOR_YELLOW="\E[1;33m"
+	readonly MPTCP_LIB_COLOR_BLUE="\E[1;34m"
+	readonly MPTCP_LIB_COLOR_RESET="\E[0m"
+else
+	readonly MPTCP_LIB_COLOR_RED=
+	readonly MPTCP_LIB_COLOR_GREEN=
+	readonly MPTCP_LIB_COLOR_YELLOW=
+	readonly MPTCP_LIB_COLOR_BLUE=
+	readonly MPTCP_LIB_COLOR_RESET=
+fi
+
+# $1: color, $2: text
+mptcp_lib_print_color() {
+	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
+}
+
+mptcp_lib_print_ok() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
+}
+
+mptcp_lib_print_warn() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
+}
+
+mptcp_lib_print_info() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}"
+}
+
+mptcp_lib_print_err() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.

-- 
2.40.1

