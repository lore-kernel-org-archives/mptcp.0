Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C24207A
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267245; cv=none; b=oKOfyCDqtoN9kKu1rt54BqYBrjzdT+sl/IHD9GeG8ATHc4n9eE38niBLLM8oHZ4ywAKsribr7Y4cQ10IURuT4QoUAh6gH9+v4ecJFqXTmF+vFF8IfBZ5gVOqlNsqAGK0tTHB3OIo1Pcn7ci/a0BW5TUTGXa+Nd0GjBgGmBC5Vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267245; c=relaxed/simple;
	bh=EQEWyWnu9P3fBP8ACAy6PgdqSzcBNoHCF1KWEezyb+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5nf5t3W3gYn8imj3ahxd++l/6F8c+JQmTr4JVSyo9HYfcFbcdWW3WE6LruI6N6uTXzO03KqkZvjeyEz2d/GIkIiJT1OSHrBTM7ijwM6ZLubkvnjpPMlL4MZilfYpyZmmQEw2kr8d/h8iqU5E8wjqFjPVSlo3NOf+8CAdHCeZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT8UYeX/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT8UYeX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB4C4CEC5;
	Fri, 18 Oct 2024 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267245;
	bh=EQEWyWnu9P3fBP8ACAy6PgdqSzcBNoHCF1KWEezyb+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TT8UYeX/I5Z3dyQXgp0Hvb/ZuJaBI3SdUNP1HMU4bGSXsfYAvQ80/7rZVIJhXCqSk
	 NmKlV+79+20MESW+XGG9/0nAqQZDVbzEKqpQkNgvzH53rze/rNmMdg8ZkNux9E8PnB
	 5HDHVD0oYYffMlUpkvOF3SLELie6KEllj0/uUMRQmUlIg7xp6Z6NuWrsGMQzgGOBMP
	 KtQWKINwft3eAccDfVDy6C6QlABeHZdIWacFFIN1DpVdd9tgytRJpZY5QaFb1AlZAb
	 sdD3urTS0tXW1WGBqy4y1PY0rRzIO9/Dzgk9GHdlB+b9ikeRoj7ZaYELtyxeg26S2a
	 7OcgY57zCxXTg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 6/8] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Sat, 19 Oct 2024 00:00:26 +0800
Message-ID: <fa5ffd299b6349e903e84798b0ef3529c36c0161.1729267039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729267039.git.tanggeliang@kylinos.cn>
References: <cover.1729267039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update endpoint_init() in sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 0799a3c65188..be746e0fc393 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -588,7 +588,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

