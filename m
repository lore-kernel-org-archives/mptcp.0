Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4122907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227348; cv=none; b=KANa7ekfMcf7KO9SOyShA1NdW9gbcxZu/3RnVuLJjmyBzNB83Hmr1fjA1EyqaN8TqhA3trAqFw9XUVxSTr34f+/8ZNeKfn8pgDOvmlBK+78gl3/nJsGYVa8NDuqJOHlW9nCr/RZTWIsowMUi0CheY9PE4Iy/l2rq6j5B5YFALys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227348; c=relaxed/simple;
	bh=sy2ykk4CvM/BCsT+KNpg+wIKvtZmG+owjA7SYmfT4hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG+ofpNBTndRORL+Kzyh5hJw6btL5BIKif4WDNTKrJ2HIHopJtZhQozxM7nWq7waK89clwkP4eClzO05uDVbgS5OhGXQTEb+xK75YsBsjXAtmEvvLVA7CVGEWU9EJh2LoUPd/q3uy4IYwk5k1wm9q0kgn6caJFtnaFPfk685bO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAqA52US; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAqA52US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B4DC4CEE2;
	Thu,  6 Mar 2025 02:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227347;
	bh=sy2ykk4CvM/BCsT+KNpg+wIKvtZmG+owjA7SYmfT4hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAqA52USouHrMwem453x5Inl5+q/jqaytrHpmwLty0x5na33iqLHAlodyuaBejF5z
	 QPnx96Y+fUYvCGJALrIbfH5Wflc0P7gHggx3vFKtkZvyTdAOHgVyFtNIM1jlU1iGWK
	 9kpf5XuIwc0ul0hRVOVEzbJuj93fijAl3XS8MEMqtvEYwE+bigACgVQCRJaI8KTFrJ
	 RcA2tazQectiKrCcIioUft5Eifjl7KIsUUZ9cnnlye3QSDmVWVSW0sY7CY7g72SxQt
	 VZUEsMN6eZk82Cz9ED4EQ8Awktp/b1Qyt+OjQ/H2BrLzcq+TtAQStoKVpYmOwRJjAz
	 7yKbgXwznSdWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/8] mptcp: add mptcp_validate_scheduler helper
Date: Thu,  6 Mar 2025 10:15:33 +0800
Message-ID: <01f14f2e6c9ba32887af1d52e29753dd6b85e544.1741226722.git.tanggeliang@kylinos.cn>
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

New interface .validate is added in struct bpf_struct_ops recently, this
patch implements it as a new helper mptcp_validate_scheduler() for struct
mptcp_sched_ops.

In this helper, check whether the required ops "get_subflow" of struct
mptcp_sched_ops has been implemented.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3492b256ecba..77b4ec0b0dd8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -740,6 +740,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_sched_init(void);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f09f7eb1d63f..1e59072d478c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -82,10 +82,23 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	rcu_read_unlock();
 }
 
-int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_send)
+	if (!sched->get_send) {
+		pr_err("%s does not implement required ops\n", sched->name);
 		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret;
+
+	ret = mptcp_validate_scheduler(sched);
+	if (ret)
+		return ret;
 
 	spin_lock(&mptcp_sched_list_lock);
 	if (mptcp_sched_find(sched->name)) {
-- 
2.43.0

