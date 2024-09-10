Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B291755C
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987110; cv=none; b=Wh0enUoiTA+AIy66hBjSPRKImIrLKuB4RIHvY/I36103EVDkwEqRy0BUfHRsRGeajoQhkgVLXiQFTb2DboG49ASqPzJGpuAvtsuNAXk5zcu8aVn9Ato98eMvQJC3XJKpW6VgtC20oYzOAHgjZh1IP2Vc+TX2q7Mk7F+j69aUREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987110; c=relaxed/simple;
	bh=AqPu88ul23g8vqXHRoSXpzTMwp8/lrE6zGfqa11fWfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/qmsSlUbCM9ml1e2/tbq7tUv/9qcoStbsCVRXrRHogquUed4AYs88eQpoD11dStUgDoMwJqOppI+Aiad9TTKB2xVzQMaTtaNduI+vwsZ5LVnwl568PLJN7V4QbNA80sAjSmcM/zB4ablJl/KFPA3jhZ+OfwlF6mi0itI8ZnaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG3qWukR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG3qWukR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF3C4CEC3;
	Tue, 10 Sep 2024 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987109;
	bh=AqPu88ul23g8vqXHRoSXpzTMwp8/lrE6zGfqa11fWfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hG3qWukRYBYMEIaepF+/Z0QRPjubreIN5aSBKTVcQ7AWCFgXRmZVzjktjAF/1mqQA
	 8NW3INQRg/AsOMCbBnyesriESsj2maIlbsH2zZ1IZnbH0vUrNk0+TC9e8QL9yolXcJ
	 +SqR63pEuCY3yVKRsDBetLPsVqqPWdXRtLuH59UmepNqGb7tlUxbTX75z+3APv6gQw
	 bU9kMzVsvH9E4bwXf6gsyTlLdZRXHg5KH/alxrbiTjxuDXxaENxJmVo0JWAiH/AyJr
	 zNMx77RSiCy9uVcJPnGUB6VjcfB308lK/i0z6I8nClUp/BzFvBhn4MxwtibnQVmKIw
	 HEEvPYUmJGPjA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 18:51:42 +0200
Subject: [PATCH mptcp-net 3/3] selftests: mptcp: include net_helper.sh file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-selftests-mptcp-fix-install-v1-3-ed1fdb92aa02@kernel.org>
References: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
In-Reply-To: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AqPu88ul23g8vqXHRoSXpzTMwp8/lrE6zGfqa11fWfg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4HkhJbHiAXd5xmNCuE5xscG09kwrDXcHkDEjl
 2onAKNxu7CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuB5IQAKCRD2t4JPQmmg
 c9jBEADr5tV3WASC79k/TstdGOSBxwCRLN1CnlnjRQa0iEc1VUcsoaJaNbgHGZ7GZD0hDLRXD3t
 8jzfBNchPYMsn9eyIyeLR093MO/kMaSZTucEjSvAMenxOoZEsf+VSv22DHpm8GkmWDUNke0GkHy
 hs8dcp8EpgjxZLZGnKjm71U7QdGY+M5wDl0ilVLpTv8LskAvAYl0FJVkuJL60VAIbkuIeI+y7QS
 shOKKi76VHlelY29JIFFWBeTep4Rdi+GTUPphrCoKMfzWUt94cECr1pYcCaJHMu7zufwgtOZ2jt
 PlkTsqNYcUVeugXbxGAQMLrUFUGzI4qlASAEZzQX2VLV5z1IWX2a42d8g+VDTnUAfJQHOgc1Jnb
 Kg1ZdJiJDDBNv95x3OI7Vj/IbrQS/9AwUkoA8rV/Z3jWWU3B9QDBFzF+DiqJyplNQihKuI+zT3J
 0u1aICbWQ84IggM73ZHuWcC5d2u2sYbyVm1uOrrdD/P3ThvwuHdLynwibx00D/M3NwlpFHV2pYE
 NkXT4YvSzVgIZ9818BFvghQQXrNcTnmJqY6tgXb8r5ObWOtHNXz1LS8g07R6B6v9wU9GhJiFZQ9
 w9dWfanhOTTdR5+pTxYPQKxsKIBDeKWvQr+OtRRtvujn6yAGi/3uvqRxqAMfEknxcHlPFnpantx
 0mq14cEQvm8xKsA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the previous commit, the net_helper.sh file from the parent
directory is used by the MPTCP selftests and it needs to be present when
running the tests.

This file then needs to be listed in the Makefile to be included when
exporting or installing the tests, e.g. with:

  make -C tools/testing/selftests \
          TARGETS=net/mptcp \
          install INSTALL_PATH=$KSFT_INSTALL_PATH

  cd $KSFT_INSTALL_PATH
  ./run_kselftest.sh -c net/mptcp

Fixes: 1af3bc912eac ("selftests: mptcp: lib: use wait_local_port_listen helper")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 68924053a1e6..5d796622e730 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
 TEST_FILES := mptcp_lib.sh settings
 
-TEST_INCLUDES := ../lib.sh
+TEST_INCLUDES := ../lib.sh ../net_helper.sh
 
 EXTRA_CLEAN := *.pcap
 

-- 
2.45.2

