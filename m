Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416466280C
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200280; cv=none; b=uIMZ91u1pAnjhBFYGPp381sDZByaHpyvnZh4orCwbpo1opUgKUmFh6thyKGRf55DtLMiHNtD66tkuba59uoZ+pzNXssTfEkgz3XgQ5Co93fxOcBRtc9Ttzaerz5AijOFO1/9K4PSsf+vrpT8fnsNefmuUWkG7ftAMo/zFzO8dzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200280; c=relaxed/simple;
	bh=svOKqmJR4D0HNG5CCkun2AVq6cEPN3cvQEIe6SciZ2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAOcyVg304t0wYUqijiFsNcDFATauZxQa+jDCUrkkP52UpZGbIEHNne4F/kWuwiIBt12SU1UbAbIaf1MPhPfvH5KrA/yP3o4RW7IjMG2iAI06wU2Rb3mAx4L1hJAW86pixEockHlzoInW+gZLvAX7x/HwA/Nie4LPfnt7F/KVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdakGs50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdakGs50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD68C43390;
	Thu, 29 Feb 2024 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200280;
	bh=svOKqmJR4D0HNG5CCkun2AVq6cEPN3cvQEIe6SciZ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdakGs50GQW/G63KHeW1i+2g4Lhyyw33IRNCCuCaxUbG23D2+jzmiCxQIjizXd7uA
	 Twc3GXkzq2htEO0gWTu/dmER00nT+jdywrbkWL9sCiz5TNLMx/QKK/lmgW1/8of4cJ
	 AOf6iD1OxSdAHH34H4ACS4Bc8uvrXpwIfQfeVhcpschrl4eiDLqQ2vIMDxodBRj/GZ
	 TOupPy96uK5AyqFFAEdt+eHPuCQALbp17sWFmyXFX8gxZTx3fvqS4tIqyRF2J5Dyyr
	 97zu+NzU2gnM0oDX3uMPrAFIgCfz7l+JRmku0WX3hbCyk9g4reFa5eXArCTEeqtJtq
	 dfZKSoOPlr+eA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v7 1/8] selftests: mptcp: diag: return KSFT_FAIL not test_cnt
Date: Thu, 29 Feb 2024 17:51:04 +0800
Message-Id: <5e46270779c52504b27c5df251fd1febf36252eb.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The test counter 'test_cnt' should not be returned in diag.sh, e.g. what
if only the 4th test fail? Will do 'exit 4' which is 'exit ${KSFT_SKIP}',
the whole test will be marked as skipped instead of 'failed'!

So we should do ret=${KSFT_FAIL} instead.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Fixes: 42fb6cddec3b ("selftests: mptcp: more stable diag tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d8f080f934ac..ff02b699840d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -63,7 +63,7 @@ __chk_nr()
 		else
 			echo "[ fail ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=${KSFT_FAIL}
 		fi
 	else
 		echo "[  ok  ]"
@@ -118,11 +118,11 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
-- 
2.40.1

