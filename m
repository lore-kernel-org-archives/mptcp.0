Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9813AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:29 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f607766059so8811005e9.3
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773508; x=1687365508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VO13vNsQibASaYz0/KEq7RnJ1Y6pSb7vyiyDyziHYTI=;
        b=CUhzBe/j7xwHJ2unekuVtUzW8OfgRphDfW9tekQJJtgW8FqhysHR7mRrR0dQjYwxoX
         SIXEg9+xWqWjrLovtJ2RcEYy0iieVVrJXf9t3dV730I/ZwxNUIQzlR3BrVI/vPffuWiJ
         1rjZkaFM5VtR/YH0c1ilBQ/uwV/V9dKQcLHRYZtN/jaXUS+kPk1lxSnnE8KfQPEIykR8
         qA+emzujh+bg0N41M7VZpKaHqDP1uLhcpNn5pNPSs/saRne84dSVpw8fBGJY/ciXsRGZ
         Dw0APDpog9GASGkDI6uEH9U9a3+lR94SrgVEZGMq7JEDAwkCitxduY1W5O2fUbUtEDdp
         /QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773508; x=1687365508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO13vNsQibASaYz0/KEq7RnJ1Y6pSb7vyiyDyziHYTI=;
        b=PT7j3FSQ+65rFn+oEfD4u39DEGl10iK/8S+HsOiefF7N+4Agx0Pww3R/WDnYC17a0n
         Y2kzfA1GMb4IdkMHkjfdL+2Cx+PdDJXHLvJWQPHQGADXIfUNFquGuuCJxZcYdHcsYnK6
         6emyQx2AA4QdzTyvzEhHu4LkZH+TL1DKE9d/YxD87q61e3C7CToIlwmrv9VzhmBrEvqv
         Br7+PH8Kr145dywugEkNz06gedkiIToYupDhk5LVTIOlMR0D4RYkkQTH5U6sFpYPoeZt
         XaJscw6XraW3ZVRGeKs5f7E+Sd+dOy3oXdyNUg1eJ1CzIjaLNofETlljRjvlcCDuyDiU
         Hwpg==
X-Gm-Message-State: AC+VfDwNato7bJxOywa8I/t4hytmhJC1pDKEuPu/0MO7cMAxImr/2kzU
	AeIgVl9RqTeQZYLTqoM0CqSbYlKN1JxwVSo5xla3vg==
X-Google-Smtp-Source: ACHHUZ7+1chqGQXxrMk9h6AJ5nad1uomofa7cIj9MUErHXpFubwkOoHZi/tkfDG9yY9aUDMyn71dSg==
X-Received: by 2002:a7b:c301:0:b0:3f4:f7c2:d681 with SMTP id k1-20020a7bc301000000b003f4f7c2d681mr8728852wmj.29.1684773507842;
        Mon, 22 May 2023 09:38:27 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:56 +0200
Subject: [PATCH mptcp-net v2 24/37] selftests: mptcp: join: helpers to skip
 tests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-24-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ssYPH/FkF34V2hwLg74v69CAcuDlCDCX1MF9gD1eLMA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwjDuQ+eYvFlt3JICR66IJHWORmoc41V7eH
 Gz8H/FNcTSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c2nKD/9QN7wzxXOQhfK8OW5mgqcZs0tpea+ITk/E62jxolWDKHmdR08kyTseHyA+IJvTRWorr9e
 /XRLcvaLAJQTgyF33CKpJApBAVUX758hMUqzjbRrRhIa19bogKFpSYCjOPb8y9dUktxwgirXby5
 OIXgL9quPFd74VGYnSggPWj1pNTr5e0V84sJPQs/Kgo4k66kNoMtvnL83qkjjb66bxBSZcEuqUG
 Vdu7lzaoNLhjanbiGAxJyunBcipq+6Xt9EO1QElWf7/DCRvNysdjgOTo++TB3YFhTYDi1NiZkFe
 3va2hbrH6q/tQ1iC9qTIzEP0icuSXNUNvBiUx2SL8IbOSsCkaojNbg3VT/xLl73jAq9ESs0jSBa
 VP9FXMQBlpGlJHnyJJxnbC6f9WoxlHjbNlpyHQa2b6smWcrlc/hF1frbxVVFO7Zki4IVNa1F54C
 2h1STOUNi4HrX8K6fTiywD6h2SmaC1mx4Co4GnZLWn2ZF5LWwxEF+piqq4N8e+Cd2z3jm+BGqf3
 9ZyC4V/wsG7auD8GpcxFc0tua5P/fTHKo4pjcXNhm8ZH4x2gcEs0HE4QKa3E0J5bx8R0epnDKrS
 2LfbCLhAzwQ9x+wz/L1NsarRB1cNs00xawNpa29ZuKK+W0W2r9CE6ej+LNDXVDwL2MNX6/NavXf
 MJpPYhq+QnjCsyQ==
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
index 6eabde9d1164..1a8f7c6fa988 100755
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

