Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23B182DF
	for <mptcp@lists.linux.dev>; Mon, 20 May 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215886; cv=none; b=qDtF6fnqMUz3/Y285myPX9pGdd/6GWBBow6QY2e785/VJLzN9n/AE8ozJmOP9h8PzNte8piEqZg24AwRdpkP7AJrmbIuuzN8ux2jhV2ZTX7SPV5uuxDmvYeAlXLkdDqRHAvBQxUcTj+Y+ASIjeW24OQVEj502vXObhD7/3NmKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215886; c=relaxed/simple;
	bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKOxAgCWbJGaxgtlOMDDXogNELvlMbkku6LDT7OAtiC1bMxpjZ80fXPHdaDxCAk1ALzqhaSUEA8md0ojHIaf0BGJje5wHRpna4/5rnupqze9Bm6M3+MZP5VzTCvlOR4zIYdqwpWkE1zSyGQ0lxnP5JvlyC2oNgrM+WjEuUhysaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJMqkHTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJMqkHTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E953C4AF0C;
	Mon, 20 May 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716215885;
	bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hJMqkHTT4+qiaUkIZ2wBomlnNT2l4Fh/99QturqtrDijEWDk81awGY0DvnH02dtak
	 PU4Essaa5aO5DdBgQwebXTW7aZSIsBmMKdDsP83KJUsfQJ8eU4sqA+8oQR8CQ3I7PJ
	 wXee1pQlqiXIu0axCsUA/sLkXY/TguEYYbVnYVsT/VGY2JzeAltlH/V6V17Nawkhh7
	 DSVWpAuq9jZVCjQ4fv0TKIJ1EofbT7zuVAscONUCxVHt95zcEEsbzGsIe37llfgedt
	 moQYGMwMe6CRk4MWfusedUSbfaOcPtQHOKmiL/onWVHlRua87drzqGht7rmM4rtfWH
	 fiMAyUV7bW7/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 May 2024 16:37:57 +0200
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: join: mark 'fastclose'
 tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-selftests-mptcp-disable-flaky-v1-3-02e23ba0bc3b@kernel.org>
References: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
In-Reply-To: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmS2BJO7F8hEBKU57xZR/FqDqIwAvDpH7VNGSo8
 T/KaUCTNvmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZktgSQAKCRD2t4JPQmmg
 c/bHD/9sCNXhwo6ffmFnqT7DPkn5FucWDOzob7GkSXPxyEHUKJUSh6Eb+mCDw//uWXrP+SsBR68
 wKco7poWeVRpN26xwpbu/iDwfSgic0OMvgEVYs84ri+PukBnbGKbHelc6sxdf52uaWiY1H6MzSj
 C49Vhe+O7/Q7+GhHMWw8w4KiSFuCKcQWMS1NqeidZ0o0QmggdVEfP2nOtuIHuocu3bLAvvdUtam
 54D5t7HMuA05apCBYXT10UQk7srMhP0V9gPB+Cpndz2wMgy3zz+1jsEtxah3Mne+zM7y8KHOyTV
 yjU0UTMyBXahvTFeNP34gNKp5nqbTY1RuRYukuLHexnQLr3sUnD5og2sm+RnEpdfpO7wfG6PSXq
 PkYqxqTtgOAciv7JqLb4VhMqClLf57KGaChRw4TKug93/n9TAc5/+0xX5TibLOb/Cvf5WX61Kvr
 whlX8QgmT7AuUzJrdXAZQObiL/Wt7PE5FYUXb2Utk0/k9f5OhJfgDMuuHUlb21vFtY34xm05Rp2
 rWs74L3Gtf8RIlclbgEEzwviVMNEC4yJSrpGriu53Uj/zCaP79M6JxKBggwCbEnX6Ys5id717NV
 jrZb5vLvpAGmPC+63KYFV4HkfExgNVl0igYGNZtFiRGl5RI0m8YEx6azGxDudK4zl73mgo8drFL
 4hjcg7ki3j9ijgg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are flaky since their introduction. This might be less or
not visible depending on the CI running the tests, especially if it is
also busy doing other tasks in parallel, and if a debug kernel config is
being used.

It looks like this issue is often present with the NetDev CI. While this
is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/324
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fefa9173bdaa..b869b46823d7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -261,6 +261,8 @@ reset()
 
 	TEST_NAME="${1}"
 
+	MPTCP_LIB_SUBTEST_FLAKY=0 # reset if modified
+
 	if skip_test; then
 		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
@@ -448,7 +450,9 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=${KSFT_FAIL}
+	if ! mptcp_lib_subtest_is_flaky; then
+		ret=${KSFT_FAIL}
+	fi
 
 	if [ ${#} -gt 0 ]; then
 		print_fail "${@}"
@@ -3069,6 +3073,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3077,6 +3082,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 0 0 0 1

-- 
2.43.0

