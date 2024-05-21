Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C04F5FE
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276458; cv=none; b=sOkdFQi2EbIwSaQ+rmLJ7+pmGG1kQK/ltYisQl5H1El9kyanrWU6CapGZ5XkgwXk+9X6Koehy+AZPAhqh7ePADK6xHrNDNJKgD3bW2LuTcVaFICop/0R3jQj/+t7AVWqdHmbSXIZcBfiEI7ngkDN+9JJFb+Q/Jg7aeZ7u/YZNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276458; c=relaxed/simple;
	bh=Ggy7iYS0IsFK7puQFPQ7OdbUwg1pe5OIKJkUZqeKNe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMIFixDb6zdb/Bmi3t9rBIDeW41edT+/sg8wcBnETSgRj7YNOEh9lucYwY+t0ra/bTy1dIKsNW0ATBvu1jFr4fkQbu+hJ4oBuV7fO8b8DxLdToEWw3Qo42VL4QMfSywaIIBlca6okt1PakWaLJsJ1bgobQtMF0FXaMAwuVPzvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k18+sLH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k18+sLH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C10FC32782;
	Tue, 21 May 2024 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276457;
	bh=Ggy7iYS0IsFK7puQFPQ7OdbUwg1pe5OIKJkUZqeKNe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k18+sLH9EFWSkN7+U6ZREa7Pk5z8RRhUzaOlRonoh8DfK0n/nQF/OGIbTPBIlFXgm
	 Bc3bFbgjOw1/BiIWPkbFQbZlwCfa7CebX0/LFgdb6YNcoj0XC4m95So/UJKjrRHG2l
	 zB0T7Hzi0Qr+faGzowgc4wZ514XbAb3G3KNNs1HQPLQSTDPI5MhKSmzeBXeTsVgrWJ
	 gVsUcT9NVPqL7+y9IPFMX92EB4HgjgJ59LC1gBUduDldbl6EhUtmZX3dj0u9wzEOIH
	 sBU6b6FriWx6UP9kVhu/b4NEowAeqq92bgq+yApyYb0EhEEdsbbuXMNVYlvfSK6Sna
	 7GIvKmzmAz9+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 21 May 2024 09:27:31 +0200
Subject: [PATCH mptcp-next v2 2/4] selftests: mptcp: simult flows: mark
 'unbalanced' tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-selftests-mptcp-disable-flaky-v2-2-eba143bcbad0@kernel.org>
References: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
In-Reply-To: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ggy7iYS0IsFK7puQFPQ7OdbUwg1pe5OIKJkUZqeKNe0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTEzmvMa65fwEU641YCP1h5zYDn8etB+yjveUj
 cH4cO/OVnOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkxM5gAKCRD2t4JPQmmg
 cxuTEACrnpiHy2e/W3yfdrtJVM3oLMxrHoeysJGGHaifqSR4q880GgO012dkQZMKmq+3A3YWvtH
 AGdMbbbGAVquYE0VMGtIcQEDZEGdYGdvH8MJX1EuR6D7kmUDWyxbM/pGNKkeHiRWFmf88ozfTZk
 sCLIa4SRUk/Q5wv9hlkT5ofBSKjG6K8nJa2iSZThPM+N2mlbJhyFHQgcEehMK5846oxMXG5Xs7U
 BPXidc0VUoWFOeTqaR7GfG5neGzrm1vGTrXrNHI3EyfxgkccIjkgX2JBQAGQY6b50wGbliXSdjX
 6pYVxetQmYjEc45LU2qEubn0v5fvBCNIWwVXMgYsoJjYnI3xmIOtCE5tikZj4kkgA0x93qBuk30
 JJr7UMOrQBy4Oi3b7nmvsgtwzST9Dixo/CKFry3/iXVAwm4kjMzvg2De7kxI/OKEIT10m1zOsKw
 nCJBl9Px13XNtbrHKpuWvD6hNRZ6DSXwm6r2wulzytFrTftIyDRk6LuimhDBnSy7kDP/uo7iXDy
 0bELjvmn0uhIkyOZyN3tnMOVFVdWMj4z2EWYkSwNGAoxCED66hW8PGk2ZhinUtgv+KUbmCDylsS
 26tdSJvDt8lTHB/IvmhYowVfZRQZnsLsgDtTzpMe3CKGl7niU6MM7P2RSVon0Q9WJJXe2hU9uoL
 S0maEcWRe33kq1A==
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
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d0b39c2e38a3..b42d767246cc 100755
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
@@ -290,7 +290,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 15 5 0 0 "unbalanced bwidth"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 15 5 0 0 "unbalanced bwidth"
 run_test 15 5 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 15 5 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 

-- 
2.43.0

