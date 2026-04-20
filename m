Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA7389115;
	Mon, 20 Apr 2026 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678341; cv=none; b=miz5UI2RB2GR2Pb8DcITlECrfnxo+V4Dmxle/8Kn/sRQylRUNoNsQLjopc6q+LsUTVb5OpEoDbzUE9h/es8NVqxzl75a9UBOh4C6B8s38I2GvIU3J/q38CWz2eT4Jy0ORi/2Ik9Rbi/DhImyM22bAX2HxUpFVTu607LbdGnz3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678341; c=relaxed/simple;
	bh=IAU1bHCbQ5+FeWpXknOjlErf4fcRMW610sxyZWiIDi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRg8926AlLAWdLRNMf1FEn8ij3B442MJfDc6Tn4UnWP04a0B6NoePQWUU9x4R2z6hNauw9k5ercxQhY34qiX7LTdKjg+TR+iLixPXcrI0UDYNlet+QwBuGqaLTqs5oP9yI3Ncod1DHCvAw8S+OvZJt8LQUvXtSIyPZTtJxooUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBzf3ygM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBzf3ygM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982B1C19425;
	Mon, 20 Apr 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776678340;
	bh=IAU1bHCbQ5+FeWpXknOjlErf4fcRMW610sxyZWiIDi4=;
	h=From:To:Cc:Subject:Date:From;
	b=lBzf3ygM7PIeFiXKtHiap2Sy32giL7IQzi/IhW7yvq3UJq1RltI1koNy5j3ZYDGpH
	 S4J3cvgmGrfvxo6yl1FSEBJRLbdpRJxatl3RAgs/VqfQrNaH17482BsqCpK71c+/kw
	 9T2wLpjK/w985znPNk8kIoCtcel68PKN6HmCEBIdmSzUAXscDcbmqo2DBxQ1GKZlg6
	 F/ftV7br4NGO0P8xVwpGGl4uHcgid7Ck1OiXSg4mpHORPrhorXuzvNg3rPNFJeQWtH
	 DNJXGvHGARxNsBU0XYepWJxoGpqsmzmtQYtlHi6lVZXUrSm0uVmu1/t6OYMZXj4KX7
	 Kwkpk3W37Qprw==
From: Geliang Tang <geliang@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2] selftests: harness: fix pidfd leak in __wait_for_test
Date: Mon, 20 Apr 2026 17:45:28 +0800
Message-ID: <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix the pidfd leak in kselftest_harness.h's __wait_for_test() where
childfd = syscall(__NR_pidfd_open, t->pid, 0) is never closed.

Fixes: 73a3cde97677 ("selftests: harness: Implement test timeouts through pidfd")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - move close() directly after poll() as Thomas suggested.

Hi,

While adding more TLS selftests for MPTCP KTLS development, a segmentation
fault occurred. Debugging revealed that the accept() failure was due to MPTCP
tests requiring over 1024 file descriptors simultaneously. I initially raised
the limit to 4096 in [1], but sashiko noted that the real issue was a pidfd
leak in kselftest_harness.h's __wait_for_test(). Hence, this fix addresses that.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/ced184831757eaae9e690f65d799809ed22cae28.1776469069.git.tanggeliang@kylinos.cn/
---
 tools/testing/selftests/kselftest_harness.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 75fb016cd190..53535c188b33 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -996,6 +996,7 @@ static void __wait_for_test(struct __test_metadata *t)
 	poll_child.fd = childfd;
 	poll_child.events = POLLIN;
 	ret = poll(&poll_child, 1, t->timeout * 1000);
+	close(childfd);
 	if (ret == -1) {
 		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
-- 
2.51.0

