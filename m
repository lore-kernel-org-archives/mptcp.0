Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E263D551
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755474; cv=none; b=B7e8pItlU6nOEEmX5TPFwKzvsD7P+CmvSLpD715LErdqbalqchwsdWMFlkIIb/g9s5NbmGCc0apYxB4puhBRCbnPjM+JbYBzYjs8V4hWX1mwN2bPmuuncEc6k60c3OgBILIBxvO5wWsxjjFtxuuqcvO32fvzndK56dlJ9GPChcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755474; c=relaxed/simple;
	bh=fwioNH5HhE48LN7rMrbpuKVb52W01ZEVcJdkcOLSq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu65CndtvTFoL74cyo1cNdFF7J9t+IZSLmkhQBInDKXnOgRdcgdcSTopnp1hMONNwBXD7aRv2UbbMIGpjr++S2V7U4Hv4BnVQnp2reAOeI10PvZvxi5qxKoa2bhYkYjstvd1vjT5YwdY3ZzojYN4UzVmjYkcuyWUe1WAqkBv2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev85alCK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev85alCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1EFC2BD11;
	Wed, 15 May 2024 06:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715755473;
	bh=fwioNH5HhE48LN7rMrbpuKVb52W01ZEVcJdkcOLSq/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ev85alCKPS+K1RCVuI+JmDIF0Dij/toy54hdToNlupC2btL2+0HUecMuDocu3VQIC
	 fq9nn2brExmg7WJ31TbXuRDpVRw3lNESDqlaV0oo1Cotjvh+5aEfk5hrLSWa7sSZiC
	 kaClLlTPoMdwfdxTVRBAVNUxHGUKealum9YxemlwYXC4uEovichCElWeJFXvJXu9DY
	 FQwB/pq2zihiTMyXVzVB1sxQChUFBbcFmaGurAvr7tkoKGcRj7cSjX+Pyq8fyJNIdi
	 l8y2L+6DBA//EMXhEh0OyuSTU06XvbCWi3vSGQMlQQ5O0jbCGOZUxuuR3Yga4GodO2
	 Ri6h/dxyUGciA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] selftests/bpf: Handle SIGINT when creating netns
Date: Wed, 15 May 2024 14:44:21 +0800
Message-ID: <8c4198e7855045559ab746be7d90f72fd550a857.1715755275.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715755275.git.tanggeliang@kylinos.cn>
References: <cover.1715755275.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to delete netns during BPF selftests interrupt, otherwise
the next tests run will fail due to unable to create netns.

This patch adds a new SIGINT handle netns_sig_handler() in create_netns(),
and deletes NS_TEST in this handler.

For passing argument to signal handler, a trick mentioned in [1] is
used.

[1]
https://stackoverflow.com/questions/6970224/providing-passing-argument-to-signal-handler

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0b25b008f4f6..7e233b8c75d9 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -519,6 +519,16 @@ void cleanup_netns(struct nstoken *token)
 	close_netns(token);
 }
 
+static int netns_sig_handler(const int sig, void *ptr)
+{
+	struct nstoken *token = (struct nstoken *)ptr;
+
+	signal(sig, SIG_IGN);
+	if (sig == SIGINT)
+		cleanup_netns(token);
+	return 0;
+}
+
 struct nstoken *create_netns(const char *name)
 {
 	struct nstoken *token = NULL;
@@ -539,6 +549,8 @@ struct nstoken *create_netns(const char *name)
 		goto fail;
 	}
 
+	signal(SIGINT, (__sighandler_t)netns_sig_handler);
+	netns_sig_handler(SIGUSR1, (void *)token);
 	return token;
 
 fail:
-- 
2.43.0

