Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18974E1C8
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276458; cv=none; b=PY2GXP/OtW2Mx/gT65Lkv8yL0n+dnHad7STo+ynGO4eQePePTcZpWnHjXtbvNmFjHXaaWZfl0+RBk+o8CRK8y7vo4BDmjkNUftBXukNnnOuAK6Q3gDRZNxBMLfmWmrycoJq8YX4QmjAgt1yzQYlrgMYCVpxHZ7RTCZUZOnAEQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276458; c=relaxed/simple;
	bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AmkXz2AzsXj2S2kSA5tdTu2DaR1r7y2qUAKogPKrHxuh5QvzWkl2NkCiueLeEnEjlpDazPCVCVbgv+GtnEqPNUnhFzj+vme4lBc5hweq0iFQVjRfbVLDTO3jfw7TQthVikYziNlUhswH/xlOTyLYBDvcC7sF8631ENs5P/RlpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbctvYyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbctvYyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E48DC32782;
	Tue, 21 May 2024 07:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276458;
	bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HbctvYyTELPXoUed72us3zMd1JHaPX3/UKTZ057VyPScNPaOvNjIA3ZfPIhuZgodz
	 /Ml9r5R1ojmyLMGlfAl/R8kBUVu2B0IsDe20KChqAerVqISZHfhOjTkmtg4zy5z0gE
	 RBKj80hs9Z4izBnk1NWbozICQVksmocbd6Em2oR/sZySa4aG0HrYAI90emA67EH005
	 unTH76iY4KBgfVQHAR57jEan8Wzy2v/caQI33Lv11520BgWTyKtfspphjArgMy5xtx
	 AAT0tGzfQJAGxTCnTa8aNO9n/fow2P+fe6IV9IA16rFQJXQgLbNSVo4KfkbD8y42Or
	 ZMedo5ovOY3Yw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 21 May 2024 09:27:32 +0200
Subject: [PATCH mptcp-next v2 3/4] selftests: mptcp: join: mark 'fastclose'
 tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-selftests-mptcp-disable-flaky-v2-3-eba143bcbad0@kernel.org>
References: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
In-Reply-To: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTEzmAACObjzZasMp0kEGDvJal86R+vnOqeJnD
 cl6Vs4oRC2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkxM5gAKCRD2t4JPQmmg
 cwBMEACxBJyey23s13JYiQmAuWmzKZZjKt4utCozYotsiXNfCroW/p7uW1TtAOhJCkAZOdxF/EP
 KhGFXgW+2ABwaPFVCIiHUdDmc4VxRG/D5BZlIm+ZMgLhEBDc/brZPxPYYXbSaZryKB6sjd8k2Ud
 qBWU5klqYsyCrk2aNaKqB5Z4jTHtUNYx/yd9c10Hy5rJfmPECGeODR9KVZL5X3OBJJcgcSTfLUi
 fIw1+9ZoBB6ndNA3CmVJCBUeoc61+JDZ57C8jZWOEo2bz6NOkXnKwsK2blmEopXZCfLrjVr6KnO
 WdCtKXmOhLcHyiN73ltbldwfi6hHPyGy4uwbrmdnU4b6QWfbbG0lwOD2oklAOCg7RxyJxEm0jz4
 4Te3iOOwuyNYgRZVYWLgOYLN/+BUjJ0gfCRURZdv/fNBXAQExlDU2s84NFNQHe4wMWckWWeEtRL
 MVvg6FksPqZgWnYKqrMsRB6pVWH/e37D917R9FQqVioXgYstdcqwH36sS3UaNsvZPN42uRkmG9j
 oPgOqnE0s60u2Pu6IT7Nqb/iLsGzM8B6INJmjbO2dJKxiCUTllJRwjryDcFpNeoCBo7iCCPYYI3
 fAI2+g7ciZ6O4T+gSF+S7WSXTWDL9PDj3GvKm91BxBF2Htg0Kq3VTRErFst9vu2/IosLdmBCeWP
 s43abTyUEm2bjug==
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

