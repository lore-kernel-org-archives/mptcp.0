Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E8113AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f42b984405so39343655e9.3
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773510; x=1687365510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nF+M3ZjOkUA/Blm6GPxinC2EXLC8jrKOpFo2scCAerc=;
        b=w9jDQyxl2kbvQbf3VcA8nbOPdoBKd6PPx3H3ad57U8cpSXk2A+nRMFzMNRidcm7If4
         03vrjd+MdQ4fADx6ah5N7N4pAwZzm+yA0wxXsrlFGePjvHPePtZ4AMrMQL7s69fgrDWQ
         yG4p5ml7M9xa4STrEWxiMXdPea5x506KM4M6ca2o9teDEz1j4R+OW0tFZGva/4YVEuA9
         fk4eW36JaW7X00lmG/bknZMu599Nhg0CSAoNOUA+i2+7LpamoH7O35F5vCHMc/DpK6Gn
         bA3kccHrzh8csgCT4+86gMtmS2XbFR2tyrsyUprR5aKFOWPuLLJ9e/tl9MANpxTCJWAG
         aSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773510; x=1687365510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF+M3ZjOkUA/Blm6GPxinC2EXLC8jrKOpFo2scCAerc=;
        b=cNZIYbn2xd++BfDSpT5wPE+8U+FXKq470iR3tfQOKae2RvjyyL0bCPaYaEV3P7Yg16
         3fl7ZYDG1CuoqWVDoQ2gBzAa1ZeFuUepqq5Ms7aHTK3v7tMhcwfQ86QBz+E2EYAcWzN5
         T+NoZT9m7M5UIiA60/V+SftCIwlHGMPV2REoYyYX7Pq22dTJb8wi7L0lVtGXLw9ZOqHv
         25F/si1JS4BoCR8X47ou+HOyvLYBUGJZWShUX68L4Qx3jryaJqhSnozsinW0jqEFEKZD
         EdYbKWpkpQ/uUVvPh6/bjgMrYRB/StFTlOT1cpbl87vrjcNnEQptv9M8FGyD47FI0D1/
         vVPQ==
X-Gm-Message-State: AC+VfDzwTksgZ3UPM0x/9CCkTjtGTocTxLmQkTXWQ4QbifXungRjfqIv
	nV4v+TCOVxQTGoXjZwXtdDPBHAeTlIIlbzrqZMgm1w==
X-Google-Smtp-Source: ACHHUZ7QOTIoe4Rbo0Crbmaek5wg9BE52KpfKYLLdAFT7zLR48ducxwRn6lcjcp7zRAsvogeYcjwJg==
X-Received: by 2002:a7b:c7cb:0:b0:3f5:d313:db68 with SMTP id z11-20020a7bc7cb000000b003f5d313db68mr7987137wmk.5.1684773510477;
        Mon, 22 May 2023 09:38:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:30 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:00 +0200
Subject: [PATCH mptcp-net v2 28/37] selftests: mptcp: join: skip Fastclose
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-28-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=yTdZWzvbBbFBjvlE5ahZiXW0szIC/Ztk+v9SQvA3SVE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxG+E9Tbyb8fRTb7nCpFgdpNU/Ug/KS3zs2
 3oSIu7x5Q2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 cw1RD/9DVJ+1HHVkek7a1zsFe3gu0yjdaK5EC8pvfngZHGQ5wRIeUmVXFHCSWY/DtqbJqUKWwf/
 hl5U3rHJQP/QVMJDdz16s0WM10elmoZQtySbS+vKYGyHcOjmjhPDhNvrA6y/UlUOHYGjMF3x6ZJ
 7HZvWJYh6KeMF6eVtKXh0omSxmh1K/kUudraFiKZBS66Y25UBbRkzBN543VFCyt63eid01dz4tu
 2FzW42OyZ5J21cxnIVIo2lwFdqHRln3fV/Vy4cNulhj42gKuv0UDLQv3CUTxpIAh0Bgh8u81zdq
 0O5B9Hs0qQoi1v/RI2gJilxj0Ak5leG9XtX0r43nKCXO20+1NduesTFbmwYz/hXdDxAgg2Vg4zh
 L1SCvVP/rwjyS6+5raQetxw//9DLpxxIxUT2VdAhyceI12wOYFnIYgDOJfPAb5SiAZVKCX4C8hw
 YAU/gtGJt9h9gfSAVSxoe4PYfpvstnOef/ckCn6jK8sfe+NKXZmKxX/ZNXmtnP+15igcDClQgg+
 nlkB0l1uxOG5On+RznvXhVsycH6KqaOIsVgBUIlqAYg6EOUd/L1jtIlW19ohOXwVsXmh4wIJeTD
 J/HznYcuHV3bvmd9LVXBcUvy6rw3X7WW6ZjkuTobEj302g4I7NmWgx0Rxs0hEzIEvYaJSTHgtmm
 Ye/vOq8UNX+VPZA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of MP_FASTCLOSE introduced in commit
f284c0c77321 ("mptcp: implement fastclose xmit path").

If the MIB counter is not available, the test cannot be verified and the
behaviour will not be the expected one. So we can skip the test if the
counter is missing.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1f24495308f9..ccf52aba8a1c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -263,6 +263,19 @@ reset()
 	return 0
 }
 
+# $1: test name ; $2: counter to check
+reset_check_counter()
+{
+	reset "${1}" || return 1
+
+	local counter="${2}"
+
+	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
+		mark_as_skipped "counter '${counter}' is not available"
+		return 1
+	fi
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -3179,14 +3192,14 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset "fastclose test"; then
+	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset "fastclose server test"; then
+	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert

-- 
2.39.2

