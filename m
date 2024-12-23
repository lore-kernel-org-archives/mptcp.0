Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26D19006B
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942630; cv=none; b=N4wqrgEWqU6neBL07bZMUF8tXCpL2nCi+YqHurnn4VUG4lrN/RvIx1gihher/t+jh8OjrmQWmG220MIfcG2nI9D9FA3JNoB9LIjhM5balDlPwtmTGWI61Qj81ru7xPQC7O5Zxjg9who031TWdj0ss0V61cbiJjBu1rVT4pZ5Wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942630; c=relaxed/simple;
	bh=Aja8Gq3oBQp7l+XYoK0YGV++xr/0opdmGfhXrHOSM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5rA5N4vz86WsOyP94JPPeyGGmT5z4JCzLHcWsIKqqxZhSTLk0xzmmO1xJekjL4IgUof+7AdpVdQXistkONmFidUFrApIRx4SSQwbS35WH5jn/LdO3VhNiOYXQ4GsiY2yxF70ywYv+Cefk00J6z/ckcMuJs7bOG386ysDz4SYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fofKe28W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fofKe28W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2CEC4CED6;
	Mon, 23 Dec 2024 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942629;
	bh=Aja8Gq3oBQp7l+XYoK0YGV++xr/0opdmGfhXrHOSM4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fofKe28WnbAsgitBVCsmktLDLRnX+sxcm45HlhLPRvP+1lshYWaXquNZxl3W95Q9q
	 SOqR/+PrRGWtNqYdodQ0YaZ4djdb4pI+dvRzHdJz8bDC4ySrlNzWN3KMfnmYHs5TGh
	 44xNWW10DqexmObk8KeZlQf4cS1JoFWIyVBAjwLzjJA1JWlEtDcd5ffZ9rht466PXR
	 UGisr3ioR+47gr1dnlwqBY/1SoBgIvpj3K4ykcfOr8aDDWi61H09PiAiPmFvuRSt1C
	 xEWlIytxCe32OUOb7oQkIEQYgdsNVkw6PHyyTh3jCsQJooLlnmi43YKWfNAF20ER7L
	 5yTPDNE67t4ug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Mon, 23 Dec 2024 16:30:10 +0800
Message-ID: <2a87550e79b18aca1d0f6f6caf265b9f04b5d8ce.1734942318.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..29be67e2f2ef 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -17,7 +17,7 @@ void BPF_PROG(mptcp_sched_bkup_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
+int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	int nr = -1;
@@ -47,6 +47,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
-	.get_subflow	= (void *)bpf_bkup_get_subflow,
+	.get_send	= (void *)bpf_bkup_get_send,
 	.name		= "bpf_bkup",
 };
-- 
2.45.2

