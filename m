Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169D18953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676439; cv=none; b=Hj5S5ZVtkkZFSNIhZmgT0vns5M5yw04c/H9VFGD8JnlUgCuMl248ahsUa6zG4mJDogaKvVo55cgSm2+SDNMKOG0to5xRzyErQm08h8aUc563W69JwQ5IkloVTO9fiyCRqWRgWg1FQzN/yAx5q3LuwL2/n5Ff2yZAiiSFkalkpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676439; c=relaxed/simple;
	bh=DoURruBuepegnGa58PbLvdXlpX+zM0NSIkV436otezQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hK7yBADO9nZn0i7a3lEmDj97OPgrEyxHXOke1VZvTgP13BQ6sGYJBaWuPdfaUm7gXicYgsH1WeY4RBdMHcpLHej0aOxMQI9K8VtORxWJch+tvppnvRX4EDXImqKl9soI6Lp+shvSCUcqDs0FW19SGeLMlMosvwV99GjT3lMTYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM1+EtX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM1+EtX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7870C4CEC6;
	Wed, 23 Oct 2024 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676439;
	bh=DoURruBuepegnGa58PbLvdXlpX+zM0NSIkV436otezQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gM1+EtX3UOx7sUp8tW2CQe5K84FzwHRW+/6Eg5DRuCteFi5KFF8m71Gb6WZMpQAYs
	 FzWujeQrXY8il7u2OUXq7U4KtbdIns606Og2iQsC4SkCeMgpUbdvLh/mPc5P4jGyso
	 eCLSMZMJbcoll6yrYzExK7sMgSaQfZbeqBbFP535ahny7zHyiqypaklYmcaUnjDJrV
	 9lhY31wEzSu/6bFi18ef119MgVwe24gdX6XspnrAhfrzwhvISbGSzkmav16gQLVEqt
	 MhpioKIzpwmiOZe3HzEegfl27slB+bxz5wsES72xAEvTaCPZ/eX/BlEY02yWbqsIdH
	 R71KxhKLQLX7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 05/13] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 23 Oct 2024 17:40:15 +0800
Message-ID: <0eab9060d945d4b3150fabb7bf61e2748192703f.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A cleanup, move create_netns() out of sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index be746e0fc393..9758ee83c81f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -580,23 +580,16 @@ static void test_iters_subflow(void)
 	close(cgroup_fd);
 }
 
-static struct nstoken *sched_init(char *flags, char *sched)
+static int sched_init(char *flags, char *sched)
 {
-	struct nstoken *nstoken;
-
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
-		return NULL;
-
-	if (endpoint_init("subflow", 2) < 0)
+	if (endpoint_init(flags, 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
-	return nstoken;
+	return 0;
 fail:
-	cleanup_netns(nstoken);
-	return NULL;
+	return -1;
 }
 
 static int ss_search(char *src, char *dst, char *port, char *keyword)
@@ -654,11 +647,16 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 static void test_default(void)
 {
 	struct nstoken *nstoken;
+	int err;
 
-	nstoken = sched_init("subflow", "default");
+	nstoken = create_netns();
 	if (!nstoken)
 		goto fail;
 
+	err = sched_init("subflow", "default");
+	if (!ASSERT_OK(err, "sched_init"))
+		goto fail;
+
 	send_data_and_verify("default", WITH_DATA, WITH_DATA);
 
 fail:
-- 
2.45.2

