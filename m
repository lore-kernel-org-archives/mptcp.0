Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480119BAF
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:42 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so67645765e9.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367920; x=1689959920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NbLALgfwHIeMVZ0r+je60GpDXE7rJFPts3WgkryIs0=;
        b=R7h6ADpNtPGy37Gs3Nj87FM4V6lcS5gOf3RQrKPtv84Wb1/20VC5ZA1E7fI+fvUkZ5
         lq+S7vs9bqNFxIYqoVJqxWKpk1iK9G5dbvBI5aBtNA534RRXC2BQKola2L1nhE5Dw92D
         qXPNv1BEIzjELmQQcXT4uchbgzQQ7VthN8KtsnLpBTluzZYSw2mrpEDY8UGXDg7+dskV
         a8DxunysUL8R5ZmGpHQ0QCwS21PesvyBaqFGwIy329zFeXUxl6iN53KPyaS74GFRqy3z
         1jjsk/VaiZc9f41QqTavG8qsyVUGPotO23WU7BVQxKsXroAWNMKrLOdzaXns3Hyh2DTR
         jfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367920; x=1689959920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NbLALgfwHIeMVZ0r+je60GpDXE7rJFPts3WgkryIs0=;
        b=gWfwXxs+oDdKcOezCQu549TdEqvx7h/OsOQekUsPJEBBy2AwEtORHKz8dhMg9SOWGX
         t7l4FShyZbojj6zR6ElFQnpnKVM6UV0bXVnWOSd/kJIkpn0dEiH8bsM/BCcATRJuIorE
         0qp0va+Z5r1hq84036/nOnYg6aoUN7qAIh4ZGG2s1uvYwcX64hwJnxwxKNX/8uDsjNK3
         d4g7KFKFgbkja8QlkhRTjWuADpB/z6yuXuoq0jedvxfgMYjD2KhCXPRZX6mFCkN5xOCc
         gnNlninUlniqsOCWPBM3xt2tBYPDxAiNQVc4fVDywlANj7UsE1QLdSIWjhIelwgmfQ4z
         OywQ==
X-Gm-Message-State: AC+VfDxims6IStVelzlCy3CDCgxMjycrYLwEzGE0qJABNe5MhvCHba+T
	YcbMJxp0EYm1hNwMXGj9DfRLupOzgOubrgUktGwbKzxL
X-Google-Smtp-Source: ACHHUZ6iDHLVCm0uXcr/ZelRoUscXcLp5EVXGfu3+4pxaeJ7TwphpUjZ/saFEpifJxs10+AV200ePA==
X-Received: by 2002:a1c:ed0b:0:b0:3f5:fff8:d4f3 with SMTP id l11-20020a1ced0b000000b003f5fff8d4f3mr16658803wmh.7.1687367920636;
        Wed, 21 Jun 2023 10:18:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:40 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:16 +0200
Subject: [PATCH mptcp-next 15/18] selftests: mptcp: diag: format subtests
 results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-15-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=l7OGId1CGHiu8wr/xvGHQRND1SnvhiGo/dy0dA4Fqco=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjq2nV0FJ1iSz+KYJeQXiFaZB/B1RacuLHu
 RvsSsKdJBeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c4zdD/9wQIkYgTpuVNfCIMZyP9mzJowbRjf4hIiJprclNnU8PtOVDg+oQftH9nLQeXrP6bsoWcq
 MPgllbM3EwDpSJBPJaEI/GF9frUC2gVFMV8zWP/jhE0Dyg+7+/szaJnrUFXgbdXjJXWfjnGOa4O
 PHVDy7/TkaK2it0vRuxco2pIMNAyzt5tG3Sy39SFfcR/uydtQ7TobyZLX4TC02DTaS3wWZ765lU
 I2hXSb3q9sxfr4Zh1L8lfMl/sdF/BfNw5jYA7i8pTQ0uq+zqvgPAaTuRqioCWXvdcfnUuDzxL1j
 sLNyu8kW9v8xqQq++j2aRg8F5La1yJpo58iOvirFRabiWPDpXXYawn79fIylbaXDmzI0VBOTCMt
 MEb1yKT+j6Zrz3RAktvkiqswg8w1f9sOKvF7oQGKSBujnow6UEMmvkGzKM+bmmSooB8J+v6NKsC
 WUX25V4lx/Awe7BOB/yI2TPWf69dKOJkuwMON4cdLlgH3npFGCeFH3bzlfIvoGhJAOe2gGyRJpS
 i00dCfvz3sBPrODevc0WgaUXFCIi/5g0efXsdzlOTFgpxbHyDMMlEIml6VGatL79Pjon9nRE5zr
 4qoL4OIf5uxRe2IyyXGSZGu0Zwhkb11k0Of77D3sXpitDKnZEliFO7U+5a6iK/Kdo36Hs3WXYnk
 JXOsvwlOw4sJihQ==
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

This patch formats subtests results in TAP in diag.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index fa9e09ad97d9..85a8ee9395b3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -65,12 +65,15 @@ __chk_nr()
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
+			mptcp_lib_result_skip "${msg}"
 		else
 			echo "[ fail ] expected $expected found $nr"
+			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
 		echo "[  ok  ]"
+		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
 }
@@ -111,12 +114,15 @@ wait_msk_nr()
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
+		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
 		echo "[  ok  ]"
+		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
 }
@@ -276,4 +282,5 @@ flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

