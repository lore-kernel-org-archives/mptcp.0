Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214428EB
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261029; cv=none; b=c3UgUtN7FVk5fZJnY+b9dxnu6q1T/JyD20vVCI7w2DHkIwZ/ANyFB+B4Cs6g6BOpB8iiG0PJv+s07GDvUbby17MZPWbYFRvXCdDdXVxAkRhdZ42OgVbnZg5CWzuvpMX2P6p0TwT28LC4BSD5chlRrtjo6+0N+kO05NGTCveBw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261029; c=relaxed/simple;
	bh=3OUVW0d0WRCpb1hLfX3XmcTBEmsRYLjG/pnaP40SdWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X35lfGBpqOAymx6GCHOFa+4xvyqChfIrFW53wtdy67pDoLGjnbXxN7Vyx/j9+ANfISLI7qbb5pkuVnlpW0BdYrrWC5wsM8YLDN4lkx8jfO0oZ/8n+E9Z38KQ15FP+LhhS+9bbj+0w/hEA/u4PhqJ0L8Fxyitoj5toWohg6Vh/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDl3kYtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDl3kYtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5283EC4CEE4;
	Wed, 30 Oct 2024 04:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730261029;
	bh=3OUVW0d0WRCpb1hLfX3XmcTBEmsRYLjG/pnaP40SdWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDl3kYtjd9Fj5edYzQq9SpPodcZrvCekmlGf7gKR5DeZ2mU1GSHQ5GdPWbXzCXQwX
	 lutlUfR0N+LjzB1vqzDWjfou1rvkmb0qlTKGmJd+NYD9Hqr61lCpijNfmNmJgPvfeP
	 By2meCQ4FrKWGt2ftoQfk8ngFnEEkGm3hgQMaBxapluURWeKQly4DF4rEbQG/N9imp
	 DCIFbHglfnYx3nP2BZydF8bzbHtBATkuR7b/BbyaeczuIfVD5vWjeuCKs1rnFDJso4
	 Xzd0OD65MA9ivrHNl+N1eLe0/t79J8JCntaGTpp4Jes48Uie5YqzAhVfRYNa/NA0cv
	 jptANYlXCN9kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/4] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Wed, 30 Oct 2024 12:03:38 +0800
Message-ID: <3155c5faa74d04130eb8d257f11de50603b1f5ac.1730260715.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730260715.git.tanggeliang@kylinos.cn>
References: <cover.1730260715.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use new netns helpers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8db1def2e219..1d68bbda3370 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -651,7 +651,7 @@ static void test_bpf_sched(struct bpf_object *obj, char *sched,
 			   bool addr1, bool addr2)
 {
 	char bpf_sched[MPTCP_SCHED_NAME_MAX] = "bpf_";
-	struct nstoken *nstoken;
+	struct netns_obj *netns;
 	struct bpf_link *link;
 	struct bpf_map *map;
 
@@ -664,14 +664,14 @@ static void test_bpf_sched(struct bpf_object *obj, char *sched,
 	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
 		return;
 
-	nstoken = sched_init("subflow", strcat(bpf_sched, sched));
-	if (!nstoken)
+	netns = sched_init("subflow", strcat(bpf_sched, sched));
+	if (!netns)
 		goto fail;
 
 	send_data_and_verify(sched, addr1, addr2);
 
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 	bpf_link__destroy(link);
 }
 
-- 
2.45.2

