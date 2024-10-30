Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011D3398E
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268662; cv=none; b=SFjLlPWYpc9xNA6zBrT14upmgch1qCbV1StpmkcUbijdywpuzSeoz5Tr+9d6MbY6JKsJQd1vI5+vLnqEf0iivYj2ooBc0doyT4dttlUatcvcfnCqcSGjujhFlSAmFm/yLpfkm2SSBj2A9K8TOKj1GPeLYmoToO38VeKeDAfQPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268662; c=relaxed/simple;
	bh=UVCSjBGP/+cKzmmPkyzOqkuWiLSr68m8qV2V8UJdsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOgw7jUw+xdri59+oKKujc8/F59MVxfrkgfmPOplJWnG1PwUXvq6JLNHKob8VHaaGrWR2UEissV39jf5qd9YZgJLRAqWjCPM/T6fsCAfJygvaMe3hvpFCzVffeQC70JjTcjWu5swzzBWJzG9wt4CJrlBx/wuCDyumzDFMBQv1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcVMFyrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcVMFyrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E116FC4CEE4;
	Wed, 30 Oct 2024 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268662;
	bh=UVCSjBGP/+cKzmmPkyzOqkuWiLSr68m8qV2V8UJdsms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcVMFyrfZ+hG2oQaRVgtMwCr6K5V9jMrfgxNKrWJT/2X52gOuVigi0K0hmDrPRNvo
	 8ahs0ES9So3pTOGsXoUfBxt2KL5nx9V3+aPvONoeU8Unu1QVuc5Z01diQVgsem7rRT
	 2wiQPcoBeemUJfx+i/0Sp7h7zcKvR3dTAM2siAVl809Rzsw+XQZ+mRIYAu3f8dY7cs
	 BaeE4M1oSMQD4fdYoZomWa7bid8A7rWz2b5XaXhvC5qRIpDbCWmVr9bN/vrjOsHW8i
	 oxPO9BJ7YL6Qvvt2FBHthu71mKS1oEvX69jbhO0xHYCrxD1hr6VK4TQoqAAA0SfY7t
	 JDJLHPhVfoe8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 05/13] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 30 Oct 2024 14:10:29 +0800
Message-ID: <8641dcb7e7de4d503a82b3bdcde27290c3ea233c.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
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
index 1d68bbda3370..b00af99c5c9d 100644
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
2.45.2

