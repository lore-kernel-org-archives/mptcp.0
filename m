Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1719BAF
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:39 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f9bece8e19so11036545e9.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367917; x=1689959917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFBmb7b2BmxYQ7xgqQb+mzgY3GhtTdjwA+7V6UD1T14=;
        b=Aucjjbk7azjPwpkiiIr5OA4yX2h3OFUG+p1wGRQumS0bwhKR6aaUv/jAp0w160jQlh
         CQ8PNWC42Yvz5fWTFV8p5We6r/DxAcVQlqOW9fVM5kZ5JveWLs3eqT5MFSJ/Hv+XNsFp
         HXZ+4QzKY6YAejItMlNVdlU3s6P3EHdJYuLwICGsi9ymPvh9A5Cp700YniVUXyyHZh/h
         8cMkuB6qFXU6aQR/7jB+Mjh6QIBLBw0x+zufQLn4UCj7qpCLpzNnHN+lzfQaZ0KPTtza
         I7huGhepXmiwEvzQ4eQnl4sOEF161KAUmvyApkEOtiRtzNazXIq5osgQUntV/i68M0y0
         +bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367917; x=1689959917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFBmb7b2BmxYQ7xgqQb+mzgY3GhtTdjwA+7V6UD1T14=;
        b=cCvPuTvCbjR0U2Do1CJBrHk3O8NayZiprxHLpmQ0k9laMQO7PYVtQb7WuG3FC3eJFP
         z5pPfe1QZ0MmemiCHnXEzbK/0U6zIZKFrL5Nu9Rhu+Y11hNlpnsNOTEyyNOUXGMQ0ATH
         kfRc2AGpbRYW5Nbuhl2ZVmDFVkKw5gS50HToS7/Q5pddyEbmKsuiLDHyTSW+mIqvHAcW
         C44lh1BT0oBiVsRq0f2fRxR59xyPJQulR/ZIb3X7cW/k4GUGb2TwULXXAwcosVhleJlO
         RIkiwBa+2vT0mbDN57Z0Aw4RkEw4ZOelQB+IMC5CE+e1YsNQsV1WmOso4N8qzddWrfzY
         aE7w==
X-Gm-Message-State: AC+VfDxPtAn08k5h1wRiJvPT6SAxFCSGJlm6dFXORb+Ywc7Bk7L4Fhxi
	0w9wBvQv8/gTEcFs66VQmxsZro20DSDY6MYqEPbZ+i5b
X-Google-Smtp-Source: ACHHUZ5+62DMrPi1r2guGXH4GH6sh3FQsDLL/uOnC62Ehh0rVAvhaKW78tD+VEK4mKs4at0QzeZg0g==
X-Received: by 2002:a5d:5582:0:b0:30e:57f2:9f0 with SMTP id i2-20020a5d5582000000b0030e57f209f0mr15851939wrv.39.1687367917759;
        Wed, 21 Jun 2023 10:18:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:37 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:12 +0200
Subject: [PATCH mptcp-next 11/18] selftests: mptcp: lib: format subtests
 results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-11-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=AIydYrUPrCrSUDKDcff1/982NgIiHi5E7/OfOIzo+4k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjEh9dmTEjChRdbv7s6nnEm1g9JLa8MPkbw
 2MlfzaNPVCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 cxYmEACm7W9ico6AngLJIb5fmLFXsOb1fjq/EAmBw1iVg9SucRYXXp/OFdWdmrLxywFhZiu6vA4
 s3DCMD3W5SXfCvDzcjvltldqSLe1z3WkkUX2ymYpltIGUYketfW7+KfeO+e6Ng/gpqMxvgdum36
 tlauqX4SCBLo3xCVhpXConQLU/ix/04/ERw1q1dzPsKleytQuzxkgyYBzO9KVSl1talqIsQAjbM
 nczEEggMtnA2abT9W8D0jyTCRas8n45yLW/297P4u/zM+FGDG3oWzdUxdKfIWW4zaIH4anrFMeg
 LJI1sl5iAJmq1ZIr1UWiHfkYFhuDGOu+yhg+MVKC6DhTxQVicqTdXeyMtVXlWv5sVKXCqz9axra
 XyK6Z78ZgSlvRO9N64CAj+wwd9wJ5xwoxajIz+24pT+R6UcEE5GJtXkxmfHBqACdWk60gYhsGtx
 rdz16szczZIPWyQLvKJc/rmRxNh4x0f6eDan+nBKjUXoo71VlTEi8E2UOwXzXYrE6CbqXWJ36Wa
 Uoq7Gt/pDHY8jf2tOkMEylWSK0eeUWJ3ijWSdR34SqG7Ir8GRb0AcIB2oST3QXVc8IWB6p1MGUb
 5TxKrMk0PAYggG3yb9yMrDwrwaqZ0sj2UoIVUaeYS5hRcpLggR2z4U1AdrsRy/cvgo5XEE7v5r0
 7yRjqfUII76Qnow==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch adds some helpers in mptcp_lib.sh to be able to easily format
subtests results in TAP in the different MPTCP selftests.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f32045b23b89..b1a0fdd0408b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,8 +1,12 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
+readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
+
+MPTCP_LIB_SUBTESTS=()
 
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
@@ -102,3 +106,65 @@ mptcp_lib_kversion_ge() {
 
 	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
 }
+
+__mptcp_lib_result_add() {
+	local result="${1}"
+	shift
+
+	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
+
+	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*}")
+}
+
+# $1: test name
+mptcp_lib_result_pass() {
+	__mptcp_lib_result_add "ok" "${1}"
+}
+
+# $1: test name
+mptcp_lib_result_fail() {
+	__mptcp_lib_result_add "not ok" "${1}"
+}
+
+# $1: test name
+mptcp_lib_result_skip() {
+	__mptcp_lib_result_add "ok" "${1} # SKIP"
+}
+
+# $1: result code ; $2: test name
+mptcp_lib_result_code() {
+	local ret="${1}"
+	local name="${2}"
+
+	case "${ret}" in
+		"${KSFT_PASS}")
+			mptcp_lib_result_pass "${name}"
+			;;
+		"${KSFT_FAIL}")
+			mptcp_lib_result_fail "${name}"
+			;;
+		"${KSFT_SKIP}")
+			mptcp_lib_result_skip "${name}"
+			;;
+		*)
+			echo "ERROR: wrong result code: ${ret}"
+			exit ${KSFT_FAIL}
+			;;
+	esac
+}
+
+mptcp_lib_result_print_all_tap() {
+	local subtest
+
+	if [ ${#MPTCP_LIB_SUBTESTS[@]} -eq 0 ] ||
+	   [ "${SELFTESTS_MPTCP_LIB_NO_TAP:-}" = "1" ]; then
+		return
+	fi
+
+	printf "\nTAP version 13\n"
+	printf "1..%d\n" "${#MPTCP_LIB_SUBTESTS[@]}"
+
+	for subtest in "${MPTCP_LIB_SUBTESTS[@]}"; do
+		printf "%s\n" "${subtest}"
+	done
+}

-- 
2.40.1

