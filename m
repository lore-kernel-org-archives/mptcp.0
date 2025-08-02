Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7E13AA2F
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178753; cv=none; b=hVkWwjNXyaOscFrYdw4F3cgfe2zOosJlUOu1Ci5PR7UwpI2Wi6yKbgela4jR0olqWEDhR226frkL4wHd57OAipFWNjTW6kk1LemYa+9iJPDWi3948KGI4S+uK5/959PLV4856q1cuhqPnvgsQ1PLExjLkeyk1hENX5mSviONDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178753; c=relaxed/simple;
	bh=4JqamOJ2ckFWLindYgKjV16ep5iGfgUzHIAMtSt8IfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4A4nKeXQTspKbHj/RNtwFZZTnNo5RgxniBJ5rwgx2B5oYjli6gv9h6z57AJh+lnFn7RJCaxNbZOmPNLP3qwKyQU5ynvJAYrrOfx/Y+2okAjGXQ3Tv/b7ELccwbp6Ztc5u89AK8pXpf7BDoOAAacRGx5XJ1aHr7PtuhVmMGmS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neqsRH5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neqsRH5m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89394C4CEF9;
	Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754178752;
	bh=4JqamOJ2ckFWLindYgKjV16ep5iGfgUzHIAMtSt8IfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=neqsRH5mQ5W5IPQNpWoEttE6VX+8d5E3VIhDgO9wSrSwj9pL8f6d2mAU4rrZPlKyX
	 mQ/Mbbn/OrlaaozEsL0LTS6kbR9pZpptzpP9NSUpoCXb6FI56w6K0Ef15VBxP1SPz0
	 fQCakP6b+cSGzFan1twNnzkKChGj/HKMMlHubWUklsBpWFhkp/4gilw9hsD9ycu7Bh
	 0OZi6m9DwOiuz0F4FQ8ONiEn3iZbFq5PZmWBBHcLA99LY9z9nMgZ50B66vn1ca7c0I
	 EnP5uKJ8PYXqJaapZ9vdDx+wAyCk6DC5gKRnpzKGO56SMsvWd/HAR/VOrMeqWMsezn
	 Axj9+lbDiNkyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCCAC87FDB;
	Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sat, 02 Aug 2025 16:52:23 -0700
Subject: [PATCH mptcp-next 2/2] selftests: Add tests for SO_MAX_PACING_RATE
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250802-b4-mptcp_setsockopt-v1-2-50d4905a4c2b@openai.com>
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
In-Reply-To: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754178751; l=3352;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=gOr7CBsY//YX/X8nlYFqDWpnQ4w3KSIQzDe9v6s9fe4=;
 b=SdwAulYfjpSHTT/XgJkmFgmJ8ib1eiRiFSEpOUk1JGtEsPwexlftLG+inCyYF+wVW54LWbzSd
 2C425JNpMtNDRhGS2l8p2vAzwixQGJq8H8yOv3/U5cIiMD7XvwjLCg0
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

Add a test to check the API for SO_MAX_PACING_RATE in MPTCP.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9934a68df23708ecb413c4ab26523989e3b9f158..c7608df4cc2685478c3343646bfa1ed1f957000f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -762,6 +762,79 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_so_max_pacing_rate(int fd)
+{
+	/* SO_MAX_PACING_RATE is a unsigned long value in bytes/sec. Validate basic
+	 * set/get semantics and a few edge cases for getsockopt() lengths.
+	 */
+	unsigned long in, out;
+	socklen_t s;
+	int r;
+
+	/* Try a few representative values, including 0 (unlimited),
+	 * small, medium and a large one.
+	 */
+	unsigned long tests[] = {
+	    0U,
+	    1U,
+	    10U * 1000U * 1000U, /* 10 MB/s */
+	    5U * 1024 * 1024 * 1024 /* 5 GB/s - tests that 64-bit unsigned long correctly works */
+	};
+
+	for (size_t i = 0; i < sizeof(tests) / sizeof(unsigned long); i++) {
+		in = tests[i];
+
+		r = setsockopt(fd, SOL_SOCKET, SO_MAX_PACING_RATE, &in, sizeof(in));
+		if (r != 0) {
+			char *msg;
+			(void)asprintf(&msg, "setsockopt SO_MAX_PACING_RATE to %lu", in);
+			die_perror(msg);
+		}
+
+		out = ~in; /* poison */
+		s = sizeof(out);
+		r = getsockopt(fd, SOL_SOCKET, SO_MAX_PACING_RATE, &out, &s);
+		if (r != 0) {
+			char *msg;
+			(void)asprintf(&msg, "getsockopt SO_MAX_PACING_RATE expected %lu", in);
+			die_perror(msg);
+		}
+
+		if (s != sizeof(out))
+			xerror("SO_MAX_PACING_RATE length %d != %zu", s, sizeof(out));
+
+		if (out != in)
+			xerror("SO_MAX_PACING_RATE %u != %u", out, in);
+
+		/* Query with zero-length buffer. Kernel should succeed and not write. */
+		s = 0;
+		r = getsockopt(fd, SOL_SOCKET, SO_MAX_PACING_RATE, &out, &s);
+		if (r != 0)
+			die_perror("getsockopt SO_MAX_PACING_RATE len=0");
+		if (s != 0)
+			xerror("expect socklen_t == 0 for SO_MAX_PACING_RATE");
+
+		/* Query with negative length should fail with -EINVAL and leave s unchanged. */
+		s = -1;
+		r = getsockopt(fd, SOL_SOCKET, SO_MAX_PACING_RATE, &out, &s);
+		if (r != -1 && errno != EINVAL)
+			die_perror("getsockopt SO_MAX_PACING_RATE did not indicate -EINVAL");
+		if (s != -1)
+			xerror("expect socklen_t == -1 for SO_MAX_PACING_RATE");
+	}
+
+	/* Invalid set: zero length should fail. */
+	in = 1234U;
+	r = setsockopt(fd, SOL_SOCKET, SO_MAX_PACING_RATE, &in, 0);
+	if (r != -1 && errno != EINVAL)
+		die_perror("setsockopt SO_MAX_PACING_RATE len=0 did not indicate -EINVAL");
+
+	/* Invalid set: too short length should fail. */
+	r = setsockopt(fd, SOL_SOCKET, SO_MAX_PACING_RATE, &in, 1);
+	if (r != -1 && errno != EINVAL)
+		die_perror("setsockopt SO_MAX_PACING_RATE short len did not indicate -EINVAL");
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -780,6 +853,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_so_max_pacing_rate(fd);
 
 	connect_one_server(fd, pipefd);
 

-- 
2.50.1


