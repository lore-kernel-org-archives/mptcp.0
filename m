Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CF1953D
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:44 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f900cd3f96so50432075e9.2
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367922; x=1689959922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt+ymUwvo9qqHQ/3jV7UaSynTjxmps7sZ8GoWPOQSGY=;
        b=c2ozuX9DSj3A5ocjDva4mjW/UjRJv/E+VYtdKLh4RulP5FN8jUDK3mE4Ai4kTcqTMb
         1nmhd+Nb+D6yjq2CRwXX50810OQ/XYDKoQfbs0+2AKAj6Co1LgEPeN8DlD/LYne2ziJF
         kRyvOMBmO3FG8fbhTw+FjfL8KP6YjC24AfXJ2Kp6Dl3NNTR0QnxKOaG808epqdY6Vnmd
         Ilq0KtHXjBctxG3vYgb/P1XmLjI5MyRP9mQVKVAMVxYDv/AoCMPg4oohIYmnM6AW5/mA
         C37fJiCMUjEb4uMiQ6mTn28b7huEFeDRT5+O5UyfNamMNxea4W/tUceGU29ZjNAfJFoG
         uKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367922; x=1689959922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yt+ymUwvo9qqHQ/3jV7UaSynTjxmps7sZ8GoWPOQSGY=;
        b=Qqrw4Vzj7VShONWCIMLX6iMWv7gzcghk9aicZy3kenIxK4CN/IXYhc3jfics70OYxc
         duFhIgNBSe0Q/fMEMnqBivveVGnPb7eMEJ2PVhwc0jkCGtxsb8LdwpS1Y179BqFNMa+v
         TLo55azwtWyZ9i2d+Z5x0DKiTVUciXe+lKl1NrzUz8VGHMdWBxOCSuP4fjLe+uqlH9BV
         G7jkhF5bVPzvtbjXi3jNs3GkEtcjKVcYlu0otByIDeGTDC3X5d+iK/1PQBlIZMtMaY96
         ueNTDibpl1zTZ3L0x5FYJXLeLWg0WmgPVhijrHdntfl3oOU1nSvb64apfmIKnLKIOeF1
         XSPA==
X-Gm-Message-State: AC+VfDxE9aQTTj+oZVNiRIXjowpy9KHxKlq5p1vbWoTDhm6bg/qeHasN
	Ifp/rbyG0imM4EkHwICd+fQLlzcD6EL8yIhmY+EB6sH/
X-Google-Smtp-Source: ACHHUZ6PJ8tQhKwq8ciSmB071aqAFqX7TfSJMZBtvBbK1bZwHRw4NQZbHf5InMB8LWakinfhWNKCYQ==
X-Received: by 2002:a5d:56cc:0:b0:30f:cda5:427a with SMTP id m12-20020a5d56cc000000b0030fcda5427amr10172662wrw.63.1687367922142;
        Wed, 21 Jun 2023 10:18:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:18 +0200
Subject: [PATCH mptcp-next 17/18] selftests: mptcp: sockopt: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-17-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3647;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=eZlGQC3wXqZxnH6JSHatwBmSdSpYWEpajDWzDkjCQX0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjABF4C9di+WaF8Niw3ICtosrlo0w6+xI0z
 KJYwCpC+oGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 cy77EAC2RmRmXmsbf0F5D7RRKlAGYTrpQNQU56oLtVAiEUBF6fvfq0pRHf0k/NBiOJ+I8kbBLE9
 vb5W/hFWFgby0psdgbJ2MOfkB2t7BnxLxJzhzkzqC3tEaQFfG5rhjmo5R5LT7SMAy5E1DBQ2wtg
 aYficvuQ+Vnzu2AeuBTNRvPqDL4BtqMrpIVtso1mStbNHlyuv4WeNhYtFskVEAIr289gwG03wcY
 Q7fEnHfYKKXp5tdossGGptUY63siuWG0ZohR/I3UrDP0CRgJptEKzJojjlrLKLX6nZKi9yrpefY
 kfWAzESJjLKg4teF4gTog9KzC3NlupneV88GM38sAQHfGGjlTMBaa4qAVrYbXHgm+g7fxiu5vjs
 Zi7kvb9ukYUJoEwuVeJQ6G1j0vNZZFTiJKnBbuZALSGR2AY84WGx90DkTRI1rhwOlETsVWM+olI
 2KdChQehvHNpckbrgnevR/FrKTpnYAGrY6Wwt+5KPcQLFTCoWJlomaBLBfi43GUwWtSaaKhsZFR
 FipovVV+pD1zx5qsx0zHwooS+PgpEbKY1EfByLpN1BRNSyk95Jx8j0PuVpiSClVV/skT+r0p05J
 VqEDvpV0SdjO+4LgA2P2bVHX9u/SU/Yi6K7CTWHwkbdmyIiccJYqIr238taKDFwjTh5CZOyvyeP
 G/MVbxOzvgKt8Mg==
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

This patch formats subtests results in TAP in mptcp_sockopt.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dc8d473fc82c..8c8694f21e7d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -183,11 +183,13 @@ do_transfer()
 
 	local mptcp_connect="./mptcp_connect -r 20"
 
-	local local_addr
+	local local_addr ip
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
+		ip=ipv6
 	else
 		local_addr="0.0.0.0"
+		ip=ipv4
 	fi
 
 	cmsg="TIMESTAMPNS"
@@ -223,6 +225,8 @@ do_transfer()
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 
+		mptcp_lib_result_fail "transfer ${ip}"
+
 		ret=1
 		return 1
 	fi
@@ -236,9 +240,11 @@ do_transfer()
 	fi
 
 	check_transfer $cin $sout "file received by server"
-
 	rets=$?
 
+	mptcp_lib_result_code "${retc}" "mark ${ip}"
+	mptcp_lib_result_code "${rets}" "transfer ${ip}"
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
 		return 0
 	fi
@@ -264,6 +270,7 @@ do_mptcp_sockopt_tests()
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
 		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_result_skip "sockopt"
 		return
 	fi
 
@@ -272,18 +279,22 @@ do_mptcp_sockopt_tests()
 
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_result_pass "sockopt v6"
 }
 
 run_tests()
@@ -310,10 +321,12 @@ do_tcpinq_test()
 	if [ $lret -ne 0 ];then
 		ret=$lret
 		echo "FAIL: mptcp_inq $@" 1>&2
+		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
 	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
 
@@ -323,6 +336,7 @@ do_tcpinq_tests()
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
 		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
 
@@ -367,4 +381,6 @@ if [ $ret -eq 0 ];then
 fi
 
 do_tcpinq_tests
+
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

