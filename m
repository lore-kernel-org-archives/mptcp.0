Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E280C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169014; cv=none; b=VqtV3cFe9rcR3c6S+pcmmm976+W0pv8/meEmPuivBJJwojExhBBXsDO3OfNk6uI88R5HyM0rjasNapFBev1/6egyYKfR9w5jUOJHaKhT23Fp9WpgzrYt17xFwTwdTxyuaAB0RVEZTZMpqVDpBAkSx3WPhhQnHHIBcmeildzpccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169014; c=relaxed/simple;
	bh=Q7NoE/4dIPBTJOkheqdFKGv24hXt5LxGUUxgYfjgpYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2rRrQKQ5ypRWiTi4swrTl2Q+XMXhXO3cfhbSKiu0hKhIc2pKtB8sMT5MZIcie3oOUO0SXQQt5QR5qlPkoW47cFMNyJcOSzV6MSd9mNote4kD8ksKVgwkYUUHOHIg12mMot/dg5/hGzwyE1gJTxtOhj9D0zK2XO3GBm+jaxZkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt1UYHNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt1UYHNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A465C4CEC6;
	Tue, 24 Sep 2024 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169014;
	bh=Q7NoE/4dIPBTJOkheqdFKGv24hXt5LxGUUxgYfjgpYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jt1UYHNyd6Vp9wAVdFzr/WCS3iup1mpmzJcOZPAXpvn2EM+Kwu8qSnx0MHcWCH1xd
	 IiP9jAPxLMxvZotKebimRQqQdO5j61p6U/aCkc0Phj9V1tvJt10yPeC5805BJ7aI69
	 KCvCvmIjcxe15UIFVwiQOHmCFcccYzqQU6C/IKOc2fy+/o/A4aMgi5nLhiQbRoSmwi
	 PZKcf/dgH+0VOJLjcR/8I0pxG2+4paBVei+YP4XTg7S/iDyf/qKCAYFW/A1oBC2PRR
	 Dtr1BtkwiiJYZTTJtobp7yNOaereBbo1H+86/0/IacqPCjWwNNXiteSgXWd7uzVJO8
	 RPFwMfc+MOokA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 07/10] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Tue, 24 Sep 2024 17:09:51 +0800
Message-ID: <9113e9a5bf3280a18417e072d38aec9101defa4c.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
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
index 29bd840422af..0de5d9250ed5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -581,7 +581,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

