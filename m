Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09A29CFE
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765249; cv=none; b=BOytjGY22H+uYHK+OqPcZmXia2kPLiyP6RcFKH6QfMOErARgSY9146QqpGdhTNrZZyd/JcCDmR4omePO36vO/yLUjbvRoD47IzDeTIfT5Ft7MIYkvTS9QJb0EKOO3V/adU9+pncS62AjPTamADy0oHKJLln9E55DyRD2IYS628o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765249; c=relaxed/simple;
	bh=gOqNsUvZEZDjK8CsDu5DMyfFN8Ko6EcnpPEPr+AKob8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwvat9SVtaXn/MfatuzEXitszWzjabNJOuGtB+B0V7g2lP0NQ7UfCSyEuqIXqrKAZS5IyFJJ+1fNoztEXyL/gcWPzKSSUrVRkxKzYpUSYmdT5v/OqmBcqx1ZLVeNwixVEANcBNj41nPr9EioS7vC1vAxlRmRWqU61LGwED+Uqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxaATj8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxaATj8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889ECC4CEC6;
	Tue,  1 Oct 2024 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765249;
	bh=gOqNsUvZEZDjK8CsDu5DMyfFN8Ko6EcnpPEPr+AKob8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxaATj8mi4tY2d+y2cH6olUDasEs2rwwca9XJvc4iQA5qTS5lOK5lw8Pj7kdRBzfE
	 WJNjWUd29M3YsKsh/BVRhrsz/+VCWCOPM++mMBVzeDNnXmIdNaYaq0AZlWIziq/JiQ
	 sygdMp3g/hYwEH8mK0rh3kcFOStqjWsIdD6/74x8hG4T7GWy/Q0Ffb6PJieCguQuLj
	 l4kZ6Kllgm3ye+r9hS0tZu/tbhO2QXqH+iVEBu3a/RWrx1QcC7kpebu0SevVBCGpuz
	 U+SWllXT2c2zhUq42VmoDe4gw6ZVN/31qGOSpYM36Hb/kVyduPW98pHFR2ljTGIBtS
	 I0aKjzJyMVaNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 6/7] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Tue,  1 Oct 2024 14:47:13 +0800
Message-ID: <9798b96d3e8c003e655bc1ce353ed80adf731a2d.1727764822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727764822.git.tanggeliang@kylinos.cn>
References: <cover.1727764822.git.tanggeliang@kylinos.cn>
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
index 076903680e75..64b5ce25e1a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -509,7 +509,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

