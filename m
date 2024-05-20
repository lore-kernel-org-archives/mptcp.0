Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E285182DF
	for <mptcp@lists.linux.dev>; Mon, 20 May 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215885; cv=none; b=IhvyrQwnFGitB3WDgJFJMuOc42s2hgxzBGGISJzNNY6+MKseKg/EN6Niv/P6uj7KW6X54GPhwj0Ilu+OuEK/m4Hozr3LFtVjj8tdNfZFPMMrzzIap90Jrf59X22wkm5E1SLKQ7MI27wX8N7Kj9W+X/zuPam7NN4fP5K//f3xE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215885; c=relaxed/simple;
	bh=2HxGpZwVK2rOGGZre5cdP6cDadrO8+aT7XaABZk/cEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auUd2eAbTGW/RlrGZW5pTNkGMLX/t074ZP3isO9zCaOYj1zYZDaX2EncSAufzACiM1CPwjvBS8gonubI0bqqQlG3rC5fVz2i3zTY8g1oOvPXaglaI48nyQGtHhqwEU7FC8GnqzXZt4PmmWvwvJpZnQ6Or1z+sLknlQ7UEHAwETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJBTRA/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJBTRA/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5907FC2BD10;
	Mon, 20 May 2024 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716215884;
	bh=2HxGpZwVK2rOGGZre5cdP6cDadrO8+aT7XaABZk/cEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RJBTRA/TUi4rDRDvi0FYcKRIR6ffFrGAuDMmODC7rpJ7ljlP2sEwOFlLjIhTUgHLw
	 vjR7MLMffwimp4jbAYyluitSYgxWUBVoK8XXJfP12Xggc3N/g5lMmbgrqMo2fLPDX0
	 yWJD5trU6zHBL0h+jzrutFpqAOVBMREs3RtS4t1g31//EtlF0apVLjHi/M/Gd1RjI+
	 W0NLxWj0PAQeY684VSMyCNvhqfzkLkGLNKR4Bmz7v4Ff5fLRa1pa778Twaqbc63qe1
	 ZO2O4NpOOEy99HSavwc1DrVvOxoWWXvF8n8/vgvs0Hdl+RcmirvNWduc5u41EnkcC6
	 GTuQqhVEYI2dg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 May 2024 16:37:56 +0200
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: simult flows: mark
 'unbalanced' tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-selftests-mptcp-disable-flaky-v1-2-02e23ba0bc3b@kernel.org>
References: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
In-Reply-To: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2HxGpZwVK2rOGGZre5cdP6cDadrO8+aT7XaABZk/cEM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmS2BJH2QYB8sIvDRpKrIhbpl3Yqhes+Y/PW7A7
 DnABxnwh8SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZktgSQAKCRD2t4JPQmmg
 c3muD/9dSYKGeMs2eW9sfxl33xoVzoAUl8X0/5JpqA+1lTp3AiVspu+Ti/ptW42slxnRbve3xcX
 wfLSLDjMN3cjmDHr9d/bDJoLciBg1VY+j9IdGqXmg8P0TYVaARwOnzxfQtz4og8zApv7cYc/s5I
 36e+QYqXGHJ7B2Kk27uxr4howln8H0u+o1qagh65aPUDtJe6N+NYLzcZOZGkpfsk1QfLSBQVlpN
 B7fvABJh79m3Ppk7M6SMRXu3gIvfxRpjyeLA6WzMi/62Vxqdpc6FO4BLaCAeCY6oL3PHjRFHmMf
 LtcUxGcKEjhYLbe/CnJqd/6nT6bOwcYr19qsXDeMUTJ8J4FsVfvfQrz6pXGbG2HFxVMWigS8KId
 MpRSYC2EY9NExbzXNBRwGjv8i4NOfxA5iHTxakw6IAYPQ1NP0FQ2IPZZsSpJ1jnDwaELgWH65Iw
 702zbhyuxtNPPKZRMXcUQfHnqqBmkbkyRl5Hi3C0ry4vjc3eQUvI1lohAWqqstBFLICSGvhcMZ3
 5aTP2xfutPyF6A9FArAK9vqTB5YZ23AkHgCeYDsZrJfWTcgZUZsb4cYASAiXMHgIuQeZVWjMWHf
 Z+k9S7l13trh12Ml8hP6IllugJ2O19Z1QMUKYeCSk6Xw9Bqv8DfP0EnxTLXHPvXErk3PZ3mdMjb
 QL7vwrLx5ZrgLRQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are flaky since their introduction. This might be less or
not visible depending on the CI running the tests, especially if it is
also busy doing other tasks in parallel.

A first analysis shown that the transfer can be slowed down when there
are some re-injections at the MPTCP level. Such re-injections can of
course happen, and disturb the transfer, but it looks strange to have
them in this lab. That could be caused by the kernel having access to
less CPU cycles -- e.g. when other activities are executed in parallel
-- or by a misinterpretation on the MPTCP packet scheduler side.

While this is being investigated, the tests are marked as flaky not to
create noises in other CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/475
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d0b39c2e38a3..b37829e0cb07 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -244,7 +244,7 @@ run_test()
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -254,7 +254,7 @@ run_test()
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -290,6 +290,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
+MPTCP_LIB_SUBTEST_FLAKY=1
 run_test 15 5 0 0 "unbalanced bwidth"
 run_test 15 5 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 15 5 25 1 "unbalanced bwidth with opposed, unbalanced delay"

-- 
2.43.0

