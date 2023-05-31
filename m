Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46C154B1
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:51 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f4b256a0c9so6618485e87.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542609; x=1688134609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kULdFKccrcxg2Up3zlHQjPHaJY4LqjHQpCANpqqEXt8=;
        b=VWz2U9fLjfyFX3+fI/sNNL6U9ZW2w4N7hHJf90DakHdHXt16PtSo325QZ7S+qwpdh1
         gp/NdOQHT+YXEgIDyyWKUVO4RN6w/kykJydcqpzJm1CquVtz5iSHEoa2YEZjlnKjTxgU
         boI3I9ieXtlSHSNfEvReAdUyVbuvZgtoeeKBrCX2bwFgerMGK/jNDguQy57Wy9Nhz0o1
         fJrzDbJP8S5m0LVCbIOk5tA1v7AA8/FXPEIc/UKp9R4cYbKINTRgmfUg7BJ/0r98f6qq
         IuH1Zqx/9n+b/FURXMpZA1i04zXhd8tl89TjGsAPS2UJj4o6ltwrlmjtL29TAUeuddR3
         JaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542609; x=1688134609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kULdFKccrcxg2Up3zlHQjPHaJY4LqjHQpCANpqqEXt8=;
        b=ln0ht4rgtkDUfHFYaS9K57vaUSgceXYMDASlbUioAGEkSw+dHfbY3YI9iIJBVEvxzU
         /i5X44arOUeEayMqi+Z0zLwUGGGTYb84ZL+UiaOwt1o5FtoCAq5jEToOY/KjNGCVm/RO
         JUov+ylNqHW6JuoUhKpA1WKLE4ptOJHNLlEVDeN9XaDmbCDAJTtoNovVDG+shWOyenW0
         esHWl167ibXKA4FIwZjDgC6Su7ODku2/KgGUj4lpOKjVH/5ITFkyDBMYC9tbyGGCxOAs
         YNG76OfVhqygfazmHWBxOh8v+JG3CTswmg6Wj1CErJGAY91va7t7XFMVSrjkOk+2VDSq
         ibaw==
X-Gm-Message-State: AC+VfDze79rzXL/8WTWQZVsmzPOt+iKS3SYSKD1XTeR3weA2v8dNax3u
	wuy7HTeeJ5q6W0ib28iiS3IlnPOHy9ClQJQwxijyFiH5
X-Google-Smtp-Source: ACHHUZ7Js7bYQv7u7riUHck/WYIwAz9DLkB4d6hh4AGYyrIRjG7OxdSJiPqXmdjms9PsFKe5DJl8+Q==
X-Received: by 2002:ac2:5227:0:b0:4f2:5d05:f19d with SMTP id i7-20020ac25227000000b004f25d05f19dmr2725398lfl.69.1685542609542;
        Wed, 31 May 2023 07:16:49 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:49 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:37 +0200
Subject: [PATCH mptcp-net v3 17/32] selftests: mptcp: join: helpers to skip
 tests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-17-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=iuZ/OGD4JDky8JWHSfam/s5e2CwCe/F0efZ7+ZyUMfM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDwOdYObL8yiJoiFkNeuXRHE5J8nbEQ71Ka
 z59e4vMGrqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c6lZEACYtzlGp9wpOtAtg79Pj29mhgh3nZx1XQrIa9KsMMXsinF0NXtANGFDrS8Mg9M/OUM9zFP
 cn+i6lcfHf/iEqlJ+L6NaR6eFZZPQ8qMBRXnaOTOSsg8hn7qwi61TlvqkyGlN0OGX9+yjkWBdVt
 x9QeUjLdrJzyzV6XKaXDnktGPz4/TYY3+H6Xn0M0rkvkSDWo6lXkf86fUt+uyeBm6N6HQYZhBz1
 85ZKttwzXPfLbK3bWvyXvF1NEiAPwrpZmO8NLi3vavHYYBGipGJTec6tlrcCY3rySbvJVQBYEgh
 U4yXmtglZh0DMx3VwdsSnTiSud1HU7qNAtZfjAgxrXyUI61TFgrJJhnWreFw1tOZfJ1kaeVxyyp
 IVy5OPKFSnKnE6Kamd6uaYcADIpi0LtRsKmu5LooidlWx232ycUvg7gPpawgP0PomMMuvMT3Pio
 QnCF89eCq+IgozGS2HhTsgIqGV7QBVTBr8tBan/ANChDW1uBiCyg67K1dcmcBq6NfY/csk+RvS5
 Yv1R6STaVDQb2vP+5+2DC0jVFeacYMmAAhzvITH2l7c9ymjU1lcDaVvQwlEcehI07wJL9+Tydmv
 1uNQicOEhKjjfLQNxZyy5/V+diBj0+FwIj6yIDopZRd3v+CljnZ/klzl0Ud7AIYFSylX3On/Z90
 Iiwy5WXfWJPjKrQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Here are some helpers that will be used to mark subtests as skipped if a
feature is not supported. Marking as a fix for the commit introducing
this selftest to help with the backports.

While at it, also check if kallsyms feature is available as it will also
be used in the following commits to check if MPTCP features are
available before starting a test.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4dc529d95da4..72bc6769c184 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -144,6 +144,7 @@ cleanup_partial()
 check_tools()
 {
 	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
@@ -193,6 +194,32 @@ cleanup()
 	cleanup_partial
 }
 
+# $1: msg
+print_title()
+{
+	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
+}
+
+# [ $1: fail msg ]
+mark_as_skipped()
+{
+	local msg="${1:-"Feature not supported"}"
+
+	mptcp_lib_fail_if_expected_feature "${msg}"
+
+	print_title "[ skip ] ${msg}"
+	printf "\n"
+}
+
+# $@: condition
+continue_if()
+{
+	if ! "${@}"; then
+		mark_as_skipped
+		return 1
+	fi
+}
+
 skip_test()
 {
 	if [ "${#only_tests_ids[@]}" -eq 0 ] && [ "${#only_tests_names[@]}" -eq 0 ]; then

-- 
2.39.2

