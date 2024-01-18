Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157A2D058
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602481; cv=none; b=scBB1jeybFXfce/7WMCPrJrTA5AeLpm3DB37LRn54oRTVSFVHYyqSa4os6vNjebFEpUSIZ6FOuXhCta0duoMJW0ykkRRnpwGv02fRSROzAADNavJvVlgVp6jA4eNSVbMw2+0KATI2Mbj9Ny+s1FfjMthQGkmCMcv6byg2tDU/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602481; c=relaxed/simple;
	bh=TaKW0dPOmIMHHiuk/y6q33mLFQ5s6XutEGm6y0J4tBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiIJx8iub9INHjSsiWB87NSK/Y4zq9+1mAu6z1fIWMHrHHBSzrWeOqDpwoVQqGsmItqOZtjmPOIv+bBpDtvGjsSbcX0Z1iPV5fRf/sXyptheIi/NnivyBVJHG0aNtjRXrei9c+ncEJ2z9RnEOz9GwZ/CL2lDBE4/yh1V4UBYvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKiNjvX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKiNjvX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49983C43390;
	Thu, 18 Jan 2024 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602480;
	bh=TaKW0dPOmIMHHiuk/y6q33mLFQ5s6XutEGm6y0J4tBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JKiNjvX5Xgt5GR4xeUPKPgUmAp+AN7OuQRbmBiaZPQD7cVR9/rl+EwHulMo8oQygR
	 WuZt4FPqJyUbUdYGBel6K10/XWq8Uo6XAD0S+HuMWc7np00J3XGDnHWdeIh4Uiju3k
	 NvBEKBuTQODOkSDfp3ETQp8iVG88+fTxqJWUBH8/fVlPE6cgfhrhFPagTAIZpsbaIJ
	 Ff07na+Us5WNKBF4iCJ5djo0pguIxZoNKJNbNoFSlScUNDTskT4UVOkTGKgDOwMopw
	 9NomQlxXf1QRj843d75SS5eVz4Hzg67fx1fxVyLwRj9gsLgl67gNFZIWhiaM9HgAMX
	 WmZHkzUBHw5Gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:36 +0100
Subject: [PATCH mptcp-next 6/7] selftests: mptcp: allow changing subtests
 prefix
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-6-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TaKW0dPOmIMHHiuk/y6q33mLFQ5s6XutEGm6y0J4tBg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pkvLLubMhy7niPJG84cPddEuKfk/8pnLSP
 RtA4mCpb1iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 cxRfEACPd2+hmW7WU2rD9tIBGuofqH/tCnTR0gMZobpzKVXP27a2OkJqH2NaL7YxV/tIVPt8xFU
 TG9gEzyk6PYnfL+IJDNfNoLYiqSLMJREWf63Ms0KO1P5SF9jC1gQXUC5+mDi7wt/YwCzUY72WGY
 uKCegLrvak3JdnRFfpkZVYVLPYcAoQuZchApzCKzF298U41kLYlZ+A8WfYKxRgZHn4qJK/ycqyl
 wtsDr/htvQAgWUX7jaJFNxCvquv9FxHRJxV3LQzNqYEUCI8siYWyWnjE7HYA7FbWyPIztB6qSYC
 uHjkssZRNUPjm6oF6rh9hwDUsN6hK8IlWV6vOr1a0UsNhWWJEk4xzF971DTOYwvroImGiFpkVf0
 XhAqvILY1JvIx7IsS3b+G3g3HtfQuLF1bEz61G1h/b37CJxLqyTd1o8wwV2i6/+8yaFMKaC0hFx
 l5HPgselJHKCXLO/jR7XEX6dZj7cVkaZNprhYSGLoFNLE3yn7st7xUeo/P0Gka4lSZ4yrgLOv3m
 Uu7CIcBXPORIQ5PzDuzYq6o8P8+5Iif0yPytrM9KC7cEs87jmrUt7VwST8u5bi5YOMpF3SJW6V+
 eQt6ba9goW06dQT6ghk47VbHqja462mdkGgNEJPNfZxIo475vfOOIQNustrHR+zhJZSfhv2bej3
 28uIWbW+YXLyX4Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If a CI executes the same selftest multiple times with different
options, all results from the same subtests will have the same title,
which confuse the CI. With the same title printed in TAP, the tests are
considered as the same ones.

Now, it is possible to override this prefix by using MPTCP_LIB_KSFT_TEST
env var, and have a different title.

While at it, use 'basename' to remove the suffix as well instead of
using an extra 'sed'.

Fixes: c4192967e62f ("selftests: mptcp: lib: format subtests results in TAP")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 022262a2cfe0..3a2abae5993e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -6,7 +6,7 @@ readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
 
 # shellcheck disable=SC2155 # declare and assign separately
-readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
+readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 

-- 
2.43.0

