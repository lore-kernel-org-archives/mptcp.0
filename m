Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B1C2ED
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 14:49:42 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso606911e87.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687963780; x=1690555780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtF8kIx1mIzHBYWHQrOlxLaXnfySjnDe5MdXabRiRhc=;
        b=mz8mCdKwoAk1jL5DNJY37tTYvQO0Ww/uVHSqI6NfqJHjr6okFtJ6dlG8Cmco4eV5ly
         u5xiLF/oivYUNms79ov3Wd9kO6MxSz71qsW5gxcYyL6iQI6YVb28iwkFliUiFsUD48CW
         /vxYbha1fIGqccASWG42rOSsZN6jn183W22dVAZ+21IsOhYQ3IOv7e/9OlzXxgMmHfk5
         R0tCD2cxUxM3WUbXWVFlrjAQnRDxYQ9kUo+lF++Tw2NG3lw4oqVxoPsRi+9z7HGwQwvK
         Be+qCEfO7NddyzIIj0qxTNSFR84bvgtFVz4hQ3lM7tvcgupVePoplxsO5cGlnaZBMOhi
         C+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687963780; x=1690555780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtF8kIx1mIzHBYWHQrOlxLaXnfySjnDe5MdXabRiRhc=;
        b=KWXcyObpIJUCBoeggUAzcUriZ/qjOaNjENnm+nj9IEqj3Z5xxIOQtE2Pwm0PD6dGOb
         K1vGfSuos1tW0lISGO73yOPsvarc3AQbdMTdZ/PYUUrt/k3yC41DAuqd6KL+StLvYD9O
         5DysJatzK3A4lm/L0HW4bvD/YaPH+ojqV2aWgmr94r96bJ0hM1WaDVmwJAEJOdPb/GlE
         pOur8DBwQQmvcDsEwoeqU6rPrH/THwS8FqH5BGoGJ693J+bcf+9EkLy+LRvkqn3NwaYJ
         Uq9tnWKwXOn7mJARVtho09DqheEO49yocjNlFFSloA+/jRFHgeyJkqkdu92uH10ci0Dn
         Zi0A==
X-Gm-Message-State: AC+VfDzPW4u6N1iLW11ao14pbOgp7P/goMR4BECGojnMwM8rqjTWy/FO
	7taXyw+r5yebOaTAQ8fchgkd5rd3cJlxurFiRdt65DI7
X-Google-Smtp-Source: ACHHUZ4JZF3kUdtmChCRe4+5d9i2rBXktpUuNTwOXaXCFuO1UTgdMuUhkqYTRoc58sEIDaoVxCNNng==
X-Received: by 2002:a19:710f:0:b0:4f3:d682:7b1c with SMTP id m15-20020a19710f000000b004f3d6827b1cmr21456891lfc.45.1687963780099;
        Wed, 28 Jun 2023 07:49:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b0030af15d7e41sm13713300wrm.4.2023.06.28.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:49:39 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: join: colored results
Date: Wed, 28 Jun 2023 16:49:27 +0200
Message-Id: <20230628144927.828117-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628144927.828117-1-matthieu.baerts@tessares.net>
References: <20230628144927.828117-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=XQYYeZqK6hGHazyO1rMDFQdTy51ysXS+HNf3Eom0qWM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBknEh3b4K7psY5evbBqKJOjogPbjpVrRx4Vecak
 ZU3LzwxvECJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJxIdwAKCRD2t4JPQmmg
 c/VFEADiX+rOllfp+G9rPWFjF1iMA6UrJDTMJZT2rgj8AIrv1NvYGd/EZG3cMtS14Xm3HACX6QS
 xhYMQzboa1ChUWjFEE4OPCmz3sMwgUg84ejbUNE0ZRr7LojaA8MVRhmjbJLsKs9io+elK83t8Hd
 zsbtLbVEC59u7nbQNEUt0akTlV56XTibf/PlKnngY2M6q+xHDxYNumTcZ/EqL/ir29cgiyoXMKB
 rnqdYSt4xd3AaJsU4WUgQogtNxQqwQppRJ50K+uD59DvLVE0+Qa5SfmYanN7QC1HLUNPCSoAvWi
 6JAdXnGQelxubTGxr+7L0Z+1jr9EDkrqkdetY+Q6AX/cNshNF3GlYwqleAcag5sqSYG0ccucBdQ
 wt/g1DBpTTq3Dl9qsUB7g7AT92T+oxr2KZv7sZ0ix0LxSEWNTc7fDEZ86LuOdFMYKuoDtL4hl2q
 1GEYoNckRihQ+SOf0n+UwRJ3VIPjPYpz4SkVhXnmx/e2s2ViiEDpKrUV22C4xM5XL1RMr59zMbC
 IoieuW7A5trtuq1xTrr+pPIw8kFT6QAykMDOFrEcoCwJLalmYRsj9Pt+J1z0X3+X/YWcvrc8Snb
 k32CldYaXsMDDsKK2xzI7e/yFD5Y9HnTe5+GNh7J6fT+2+r8dGeJaqv1AiPRk4C8kTK7EhAifIe rtHwfCwo1IcBDsw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Thanks to the parent commit, it is easy to change the output and add
some colours to easily spot issues.

The colours are not used if stdout is redirected or if NO_COLOR env var
is set to 1 as specified in https://no-color.org.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  8 ++--
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 38 +++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3a0e2fa7754b..e9a3e85970fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -209,22 +209,22 @@ print_check()
 
 print_info()
 {
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

