Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516220C476
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638856; cv=none; b=jzSw3/gsU9kELuU2niQ4DDenVfm6XJJgkwRVALK8Gn27bOZUmrhQqQAMG8PsRR1h1jGxLqwO8fqDP0XST+DUuXSha8bB4Ne3CMaz3v4cq57CNVYa2BOw2V6mblliK6jjhvbQD6L66tqvLKZ6HMJENpHywM/Kw/6ZfO0QFoQEBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638856; c=relaxed/simple;
	bh=LBbhZRE7O7iOP8AKfoYUNWYs3cuAD5rsHQ/AU3RUl5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK4o5zf2WwVphyQF59dtUN/GlRceckithjYAZiIdI3HD+i8oyN+mOuxaPnbrMFMvXtpFtOeh1/YjKCxgDouOvk7SLMDpANQxtmZXMKDeNXFEKO1rUAB3WoY6IYRfzU3aiTRp8+WjXl8S4Md3C15ZZoorn6ilMPhuTe1ljkdGOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFUuTKHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFUuTKHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F91C4CECD;
	Fri, 11 Oct 2024 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638856;
	bh=LBbhZRE7O7iOP8AKfoYUNWYs3cuAD5rsHQ/AU3RUl5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFUuTKHjROqcTTfJz9RNSZKn1cUh7ysQGHaJSizyKnw/LihcCQ67xViK47dfYnuyb
	 WN4PAraT9vKssB3zV0430SpgP2Wi984yzgG0767CVlKR3Jdgq/72JH2aihsu+aKOZc
	 Kl1whKCl2W/EU1JEvgChX4aDh8LBPV8PkFkU7dyMSPoaW7Gz0WYCNB0GX5VKGUOorD
	 J4zhoCn/NAtPvyLxXp74PeYl47+7DQBabaHLJpyvZeZj+RB999w2BKxlaEgj/uM7HQ
	 I1dB4xILtN+GYoTcaFJIKdui2WRCEKwc1MxIwxlBjDcWoxMd9rHaWhqcTl0b/VFLDn
	 aPcqyYvzJeprg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 04/11] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Fri, 11 Oct 2024 17:27:16 +0800
Message-ID: <97864eb1d930372274275801a85dd674549931bc.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index e18796361394..260bc239655a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -55,7 +55,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..807685b3ab97 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

