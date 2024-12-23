Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281E1684AC
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942635; cv=none; b=EgidPwL+fz0j14kgNijoQ18XC06VvVr6okyPZGjMfuxha2FUDHPflhGVm5jV5RN++lMAgzUJxbje6YqnEYaQWevBMpdADWVWgGgZRO8YQxMxtr8d02KgW35hCUBKRspw2yEUspviEgKY2s0A3EkXJqzZQ46YNc1/7vZQg2gZlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942635; c=relaxed/simple;
	bh=I22WxGzRgJLvDeIB27h8KOkWLz54eilPichDgTyoYzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIBLx+lIzE3b9IFZ5Rz+aEU8JmIvXLf6So7rjnFj0owgSX2Y8k/oD0xEK/B5K86sOSiOYoGfa6r8o3tTg/wn4WufqQmWW1OpeMJtp6qnWBHaYgGHbsNQEesqi8bBbqssy9TP5Pj+LQ9FpLlsNkauw3JF9FydAS7WVJcyZKvz0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/5vCp2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/5vCp2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CCC4CED3;
	Mon, 23 Dec 2024 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942633;
	bh=I22WxGzRgJLvDeIB27h8KOkWLz54eilPichDgTyoYzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/5vCp2Df0wtH8Vfj3smDmfppcc6NTNNplguQuM1Bbs6JjQj4GxN3KK9T65dnqXz0
	 Zqq7Xy8zBnQ/mdo2r1GAMynmCJjNzyUvF++uBXyzeEAjUnnwIyOEfc89alCBfiIooe
	 arsYcSy2o+L9SF5VExRvBsAOZtyhtfdIkJ5sXzAqRkyb2oTNFDCWD5EAYsxs2jRF7+
	 0ujudHH8E19IoSM8mV9GV3MwWYH9zijJtRLKFmNU4a8oQ+87TA1WwyrjmIYNZn/VQA
	 2SJd8FTE336+IXdItOjEmVzXnKuA/iuh14Q3lYXAXrWHBBJz/jfZ2qZh9yWck9nBxv
	 DOL9nbwZT8PGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Mon, 23 Dec 2024 16:30:12 +0800
Message-ID: <b89bcd006941e9c88c07b47bec410313fa77a022.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use new interface get_send() instead of get_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..627502e3c851 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -17,7 +17,7 @@ void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
+int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
@@ -34,6 +34,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops red = {
 	.init		= (void *)mptcp_sched_red_init,
 	.release	= (void *)mptcp_sched_red_release,
-	.get_subflow	= (void *)bpf_red_get_subflow,
+	.get_send	= (void *)bpf_red_get_send,
 	.name		= "bpf_red",
 };
-- 
2.45.2

