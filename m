Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919A242D84;
	Mon, 20 Apr 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668712; cv=none; b=sPI2NP5PXG1flRyfdtWBhMgNIaJJg74bXa7IWSktddI1K/fGjBaBxoTRisf5GXSiFN+LwuaiiQ9QmMG+EKh+Qo4cP7SvIopFoRC5tfOJBWr3oX7bLopndzN8Hhad53nuDiZEevmfFSymWaNNRqRFD1yltEGRUdxRHDDDgI+8bUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668712; c=relaxed/simple;
	bh=/mTdgqMKSzVERAv+PGja5d4B7gPbLYOKOK4qUPAirGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzNC7AGTsc2v358YARL+zZJe50mYic7BX92o3+w+7AV3Q2fCgMmWYxkEfRK+EauJeRWgK0P2KYvmrgsAClGHt3ZXjJM/4IoOJ3jDwZ9ODneoFgSFpLmPeeUrm32Qs0c72oIhJLNoD8WkGoou+xaHUv3IV/BShsorxC49HMrbZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDVAZaaB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDVAZaaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18EFC19425;
	Mon, 20 Apr 2026 07:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776668711;
	bh=/mTdgqMKSzVERAv+PGja5d4B7gPbLYOKOK4qUPAirGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gDVAZaaB/0CztH229VfAiEGUznX/jJkbRdvOhLDl7tO/nh2HGHS/0Bor40PreqqIU
	 r/hlZobYB4lokvSoWgiCyTB8l3NAJk+YHg6WRW+CU33KCF2dGvWjbAqEiQDV+lvLZ6
	 JQZo3gFX86NZijdI/2ignBZJSay9aL948Dmx9oiLpoII2Q4wqcB3z5OFpxu8c+Nrx1
	 DT3FBi7Z1RHDRrF+qeIDVipddrU2c+zwfjYsozPRBtoPq79BshzQsxOzKxVWrKAJpl
	 Bj0LYIXE/C/jqPYvDZgPOSNhLDe14XpmE6FIzq97Nw6VUebTxWdystAPGvijcPxaPk
	 yE63ADpzqoWxg==
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
Subject: [PATCH] selftests: harness: fix pidfd leak in __wait_for_test
Date: Mon, 20 Apr 2026 15:04:57 +0800
Message-ID: <f6a4cf56c8c361d3e7373d83fd3930bd28600b4c.1776668161.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/kselftest_harness.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 75fb016cd190..b12bc4dc3230 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1001,7 +1001,7 @@ static void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: unable to wait on child pidfd\n",
 			t->name);
-		return;
+		goto out;
 	} else if (ret == 0) {
 		timed_out = true;
 		/* signal process group */
@@ -1013,7 +1013,7 @@ static void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Failed to wait for PID %d (errno: %d)\n",
 			t->name, t->pid, errno);
-		return;
+		goto out;
 	}
 
 	if (timed_out) {
@@ -1066,6 +1066,8 @@ static void __wait_for_test(struct __test_metadata *t)
 			t->name,
 			status);
 	}
+out:
+	close(childfd);
 }
 
 static void test_harness_list_tests(void)
-- 
2.51.0

