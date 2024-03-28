Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09161657B9
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619421; cv=none; b=nB5vhZOoYnrzw/1kwIauQWWuU604An9TSkAmrSIwAVEz7p77bbPyp1Wvm06LBqBmIfuT+0tgU4a0BbBNw7cTT15JKUJ1UWkuLTyl1chuGLCo3e0IfeeQOM2A7B+is4CT/VHyqUDArwndDWKlyp/m4yNahJ33txK1bhFxkb/umRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619421; c=relaxed/simple;
	bh=lO5T7jQBf77tRMLk10kImWMMAYko8dY+8VN+xCxnawQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8L2KFhjf51bQeokOda9SXs7UrmkIkUUfDKg0BXebOhEToQCoiRbrpyC/2vGC5k1lf5gyZGV/R6tItXCImNOiHdyA/nGFmlizCu4PUXAvmYjbh7MhF8HQBCE1O36A9gJaTb2n358MPPEUTaD0ZBXixkzOE0m9Rs29qS6bhuT+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omfiIQ19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omfiIQ19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FB0C433C7;
	Thu, 28 Mar 2024 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619420;
	bh=lO5T7jQBf77tRMLk10kImWMMAYko8dY+8VN+xCxnawQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omfiIQ19YMwjAepYK2c9E42j0UyB+DCrfwZ6XKlYdqJl7uQG1/Nb7xo+St8S1d1yR
	 SSmYuL6s1XHxvVC3Wxphv1B62AGE7hKHa1AFVV++59wku++zQFJFeokCo2njbCGg6A
	 D7BV6wDcnbAOy5vlFRk+dh2nmDmv/YT8r0BuvTVNguwcLYXG66PlTzqOjEtF7NNwIb
	 B9ia7V+cYsRROwvPb2tgiAjrKhrnntsfaQ8K+NMAMOl+m2xc4mDi51rbkYMQreVZJp
	 T0ZmAppeTT0eBF1MaLune+5GFtm4y8rqn7N34SNW8DfTbb8xOjbI/Wm41wwhvYvZs2
	 EOM71ibuN68Eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 05/11] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Thu, 28 Mar 2024 17:50:02 +0800
Message-Id: <e3c84c168445622df06c9cb4fb853324277483ec.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Each MPTCP subtest tests test__start_subtest(suffix), then invokes
test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
simpolify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ac3886983ce1..b8ec11552e2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -630,12 +630,16 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(burst_skel);
 }
 
+#define RUN_MPTCP_TEST(suffix)					\
+do {								\
+	if (test__start_subtest(#suffix))			\
+		test_##suffix();				\
+} while (0)
+
 void test_mptcp(void)
 {
-	if (test__start_subtest("mptcp_sock"))
-		test_mptcp_sock();
-	if (test__start_subtest("mptcpify"))
-		test_mptcpify();
+	RUN_MPTCP_TEST(mptcp_sock);
+	RUN_MPTCP_TEST(mptcpify);
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.40.1

