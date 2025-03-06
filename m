Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9C2907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227351; cv=none; b=lktpKD8wCizLMPFc2vtMJ+iRqGr7mYyS6PfwFvsd+wmC1TTiE9NbH2DT1O+qgz+l6qJR3n4lYLkj4cx3puSp1UfAtrayzqiFP2+f+jEBBWufpKoGpl6EObg/NNvh6eqEP+w3aa7eU0+Brm2BWJ16Yu4wn0AZeINHun5tYOClQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227351; c=relaxed/simple;
	bh=k9Yv+OUULCMOXeLDcvFQ005iVZVLREREivHBkQB2hUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYuoIvpVghA0HBvGSl/MwE7752efBHymLED1IdbKva4YUriKM+u6+kZI90Z6o+Q3oyeWTWpOpi/H0ZzHruZewA5sfvDCVWqhmyuIGwJyZ7Z34BnXNVaMoegRs+lpTz8Yyu5Gec/ZxNoWAqoqkytTcjOmFe6Xq0iyMlioSZSjuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1zsbExd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1zsbExd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CECC4CEE2;
	Thu,  6 Mar 2025 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227350;
	bh=k9Yv+OUULCMOXeLDcvFQ005iVZVLREREivHBkQB2hUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1zsbExdiep2FOzXwxRsrExXywXmh4Ls2bT2G2tA4sA7fnGv2t1RSdhoUB71CQN66
	 hK5FOerO+g/3ssz6jXEJLUi33qnns/PlYlvoX/J/Qc7CbIehe1JjVj3DnCm9a8bKC3
	 BbFjLMFIY2ZqcXnHKpLW3cOzCBLwOBAjwvPG9IXeLPxFtHpBk6M11t10Jpg8+9ntFB
	 Qqt6sT3vT9oqLTjbyLphcGNgdvJRpR+o1Ri+73FSchfTIYa1isK3+Y6GImyNyGhTTY
	 Wt8lXosN9qxh5TUp88uoaUtvHfX5SgwN08nHavJ24Hv6+FzWEVHiPNfdPZ52bUl/MV
	 drjHdqtP+sZeQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/8] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu,  6 Mar 2025 10:15:35 +0800
Message-ID: <c02d0f8555c7427d58155d34709f2c8250c8ee2c.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A cleanup, move netns_new() out of sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ac6f6a6f7700..bd824b19ee13 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -562,23 +562,16 @@ static void test_iters_subflow(void)
 	close(cgroup_fd);
 }
 
-static struct netns_obj *sched_init(char *flags, char *sched)
+static int sched_init(char *flags, char *sched)
 {
-	struct netns_obj *netns;
-
-	netns = netns_new(NS_TEST, true);
-	if (!ASSERT_OK_PTR(netns, "netns_new"))
-		return NULL;
-
-	if (endpoint_init("subflow", 2) < 0)
+	if (endpoint_init(flags, 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
-	return netns;
+	return 0;
 fail:
-	netns_free(netns);
-	return NULL;
+	return -1;
 }
 
 static int ss_search(char *src, char *dst, char *port, char *keyword)
@@ -636,11 +629,16 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 static void test_default(void)
 {
 	struct netns_obj *netns;
+	int err;
 
-	netns = sched_init("subflow", "default");
+	netns = netns_new(NS_TEST, true);
 	if (!netns)
 		goto fail;
 
+	err = sched_init("subflow", "default");
+	if (!ASSERT_OK(err, "sched_init"))
+		goto fail;
+
 	send_data_and_verify("default", WITH_DATA, WITH_DATA);
 
 fail:
-- 
2.43.0

