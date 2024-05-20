Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14152182DF
	for <mptcp@lists.linux.dev>; Mon, 20 May 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215887; cv=none; b=OkzuCtsTlbuPtSV/FgtDKtzjDMSMTpoCu4PM2ncwCOy4VnPmPiY0me7fpTZamV5HXc0KFz52fmLe1laiRIjGNBLiHZxSBcp7RVBonesmIJDyLPg+Yv4jefgdLKXdWHZG6ZQ2yAdQkxtQvoAIQUMtCNvm6Qo30tCCUiG3ND6ZCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215887; c=relaxed/simple;
	bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tt1gLWaQ/qHmgZJRMSw+SMOIJTyXl3BBOrOuZ24/sBXT9LGRGbZqp3i8jhOWobPB/X9ShPypSpC3IzzZNQJ01RVEFK692rcy2QyMw6wLlaSxTQmMg9xdcc6N0jysHmf1A+8+P2jVtbuP84IRuLbWist311X68KyWdy1jeWl+zxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBe6hWrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBe6hWrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63338C4AF10;
	Mon, 20 May 2024 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716215886;
	bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hBe6hWrLUzUX5BhwPfrUnj755GLSfQyVqCK9/+SaOMVyjscdHf4lgZbWRbQGC/ZG8
	 VMt9yHTSZrXVvnCGxu9VZ/8O6W7YGiUAUCCe2PUK0XGmwm6NMFPt97yg5vQuEgl6CV
	 gPOavMndQr1OhF/YSm6OPYny5uEGJEoOpDx4srh+SDQjcLTWQ7BvgOxfPzDd+i2xJJ
	 QH3SZnc5N1T0iHehPQGkLnQFyNL79oBiq26lT1ACnrVBtBfajbFDG1Cj7XalvY7F9o
	 pKNlIS4aVRkcBb1GRDwvRo66CSrFqJYoT21sijBF3MOGHj6Gd3b9tAt+igH+FJ5MSE
	 dB2KtPmmqPfNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 May 2024 16:37:58 +0200
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: join: mark 'fail' tests
 as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-selftests-mptcp-disable-flaky-v1-4-02e23ba0bc3b@kernel.org>
References: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
In-Reply-To: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmS2BJ64PICjLfSqZKZdM53UkdGdbzPgprxR5Q3
 4Y8oTTKPsmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZktgSQAKCRD2t4JPQmmg
 cyASEACDDpeWsX7Zv0C+fLnjOR+D9+6sgj3PN/tOL5Z1RoFbsfgL7Z9nMyJ2BKnrKrTtFYmxnWQ
 sUzDNXnu4m6UiOIzkewS5cgcZ0nj5aiowdH3WIa+VHy5mUAv6n5cNUNychmPUgCNH9FKIOTXkxY
 AoW3j55Vjf1sYPgPwX69PDI50J00ew+YunlFzoWmmQ35ZkfAJDG+l7XrG8fV9ZO98lqJSQEbUYf
 IhnxX+0CEalZJJIty5TwxZkC6bTXXakAmD5qBXfAqRQ7z7p/m2kBKeNGCNSjhwVVA9wAtPIaK4/
 mAvCa1VBfVR2BwnGy4Jm6B1KUcepkrJF6DsalR6lNuu2n35SNXTyVW1g+MOLtNWGj5kRYg3p/Ne
 OB7O4U6tkXd8opOdj4oLPhp/oXHM7Q/Y0YjOvEdqZyUlzh5nbJP7emsTVKlqvi4a5XqTS59FrI+
 Be8qyka2XyVVFspBqs375j1c2IBcYNHFnq+3wr3Ai10QMQ7rMxbg/bYQOp88NwWJv5nXLYmzh07
 2XoEa+N20TvWUnlUN5KtxkQdH74dewBX6nhqVdvKapMg6+gjZEhmZQAnxm7eXpW5mSRa0EF4Bu8
 hEzBNVmhJ5fvSVyNAdESQHidzSnJh5IhkzwOlA9k54PwCguORk0ZP6HwvZmkNd3jYFWUEVPYYff
 x72xF84NZnEwfQg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are rarely unstable. It depends on the CI running the tests,
especially if it is also busy doing other tasks in parallel, and if a
debug kernel config is being used.

It looks like this issue is sometimes present with the NetDev CI. While
this is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/491
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b869b46823d7..2b66c5fa71eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3101,6 +3101,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
@@ -3109,6 +3110,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1

-- 
2.43.0

