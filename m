Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29BC4428
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872718; cv=none; b=QD6KBO+ceabiggxB//FtOdwhIC3R0x2YwmmMHLyLrJS1iahC6tH6IgiQOKiaY0MtAA3t/pBim/olR4qfZhff5Covla7zJmY1PuI9OSIGK46br4NxOEvOJ2mgb9n4fDSXNinu5+iRbnX06bi6NtsZarUoItZP2bXQqPazsds+7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872718; c=relaxed/simple;
	bh=y/cwLZC6yMmYVmvpHzsVwe7l59ljQlNCIENr9QktraY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRrpVwoTP8lj9oUpgVyaKi6ExrQgeobbrekrZlpFz2415urhBjG+a2K0zB4l4PrCEHAo8FfBcl7puPZ5j5ESQuTW3S5WGCUEH5uBGNGmMj4hOY0JwDGH1R9jmurkXiJVG3IEKAWWWvOBR3qcppRggz+9nEoBwdhjkIpxATPMofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdMp1Or/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdMp1Or/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD20C32781;
	Thu, 25 Jul 2024 01:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721872718;
	bh=y/cwLZC6yMmYVmvpHzsVwe7l59ljQlNCIENr9QktraY=;
	h=From:To:Cc:Subject:Date:From;
	b=rdMp1Or/dthdA1njIN0z9yxlp0FR+/XWhILXX6zBShV8LDyt9X9RnZ8C3fsOkLoXA
	 JGjk8/D5o3EaCrq3KBM2dI255cI0qQ/sW+T0mZ6BCwA5H14M0DD+1OQoK/N5tAVGBS
	 c+WM+z1eZAdFD3liGTBYZ8GKuESg23qq9zes6CtT3lpT7REuIaQjScq2zkRvsqOO3Y
	 qngQcEnZNDAZ4Q2ZKyEiZQy8CQHlZ+G2mkbwW+Lmp6akYEcjFo3u9hMLxzbyteDuSp
	 vDLWRCHgdE8PuPV7jTuMau931FeVisgxQzWgfFGr1ssItLfNvCpKjQgL2rXKYpyjpL
	 nYFFW1lgUM4cA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu, 25 Jul 2024 09:58:32 +0800
Message-ID: <fccaccd2e7a1ce8518782c85965a6e26d37a87f9.1721872694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Skip the test with test__skip() for systems that do not
support "ip mptcp", so that CI can also pass.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 00f63f3f19f4..ddef8c61360f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -357,10 +357,11 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	/* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
-	 * but the BPF CI is using an old version of IPRoute (5.5.0).
-	 */
-	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
+	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+		/* "ip mptcp" not support, skip this test. */
+		test__skip();
+		goto fail;
+	}
 
 	return 0;
 fail:
@@ -435,7 +436,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+	if (endpoint_init("subflow"))
 		goto close_netns;
 
 	run_subflow(skel->data->cc);
-- 
2.43.0

