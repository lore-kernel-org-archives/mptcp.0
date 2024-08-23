Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C329457
	for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415588; cv=none; b=sRc6MVbOVqtwI5uPhToiEjQPpO1LEliN0+LocDtrvra0K4ekRcIOD5aKjPwvfCc0faSCYi/qIyH60U232lWa2hXc1LAjGFALwS0/VNvj7jRn9WLa8DkstudAQNK9jYqu+4djrgOeAbEYbw2Mcv9TRy/Kuh2OlNS1uQHM6GXubyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415588; c=relaxed/simple;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/9M+AnmTVp/r72Il2Di7nwfIzErhIK5hgGB2Za8jQxmawhy2KkPgcwJmcbtEyEOFuHh0VgF2uEHP3FXlf+OXeGWfKrrfES/xVrH6dKXEDCkzEw92ilDVLD0qpocsd+eu8dzeXURXOus7U+qApg9uSJHVqZ6feIqd7KB9DeqbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLjMCWK+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLjMCWK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305F8C4AF0E;
	Fri, 23 Aug 2024 12:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724415588;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLjMCWK+H8cEnBZv/pcFo/1Ufo++oK3bvP7me9F0pPQkLJdsXx0Kte8KZUPZfIerN
	 MYsmcy+WFVMQt5+yK9Tvmjb/cFBnnoot96WuqbuKRraqAwpyEW2Z1kTauiyQogiE3k
	 9QQJocSkzA/WLXBcimB8J6zrrPVaJ24BENk6uQmvQ1fpR0bbcW/YfBPS5tB8byYTW2
	 jJajPSMxu9MjV0+BMZd6YQcF6AiLatxSvHBCG+d4b9tyjnlITXxydI5E7XzTooQDXd
	 b+T00yca53oB/VwptHMSIxlvlnOA4bEyB1IzkrOStL4O5x37jUgFuo8JIGp51hEfkV
	 BsEub30KYl/Fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/3] Squash to "selftests/bpf: Add mptcp subflow example"
Date: Fri, 23 Aug 2024 20:19:39 +0800
Message-ID: <b9c8fccc2e346251b272bc18c597c3fd3690baf5.1724415435.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724415435.git.tanggeliang@kylinos.cn>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For easier verification of cc, set cc of the second subflow as "reno",
instead of the first one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..2e28f4a215b5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -52,7 +52,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
 	if (err < 0)
 		return 1;
-	if (mark == 1)
+	if (mark == 2)
 		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
 
 	return 1;
-- 
2.43.0

