Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997E127E37
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583560; cv=none; b=twbe/U3zU3Q3UKINbAJbsvG9daTwu2pDLzrgDi87L3Ud1ImHIdg9pJg2juJTz8MoneWXUWOYmztj2GU+MQ13bUvbXdA05sJiZgrgjhFMQET59IwTg3NO+NxvB7y6x7EyFenAU/vvbaBf1FNUiy8i+GXAmJLBhVbBZQd93x9a3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583560; c=relaxed/simple;
	bh=JSUmuBTwu1x4sBQbIAfNyjGcKmC9tyCHX7JskrteV14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiCna/Z416tbIVf/kWnpAzKNnCbi0noYFD2w/eU6843XwYoFN0GaTsGdADzR7+WvY+viPJkzCWs4Xk7i3q/7tJgaKR82GxVsXM3R+/Bw7JpBq8zcWKtZfhxgvibQ8OqwvkPihnxd8IEEIfx2uZ/EC28k9EoLRI077135RX/ccNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGkCy8nI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGkCy8nI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C99DC4CEC3;
	Tue, 22 Oct 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583560;
	bh=JSUmuBTwu1x4sBQbIAfNyjGcKmC9tyCHX7JskrteV14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGkCy8nIh/wJgkn3TIEyo5u3up7y/affYMXMnqDdwG11Ml6nMfQ5kxddO9NbqUPOg
	 FFg93vc/9Mor6WZ91rc3qVpTIgP3iFeP0wexE4ZbnKSraXXVFp9u8VrpubSFyfoPcq
	 3bsmnwaYFuZ8kxy9j6waa66RtjZ2KfH74Ot+GBzZPBzb37sJg27qUVwmDb0FyjoMf1
	 orOKpfZMH+ZiTwW/o3HYQ+QZlgBrgU6KQ+Ci26WwzI37biXzl3VdojeVtW7GWzuv1w
	 jpqsPwS9ihmTlLEDdN3Mp1o1b4EWo6yHkkJeob+fzJM1AX313wbTik3i9DyNuUZztz
	 1kT9AUBpEz7PQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/5] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Tue, 22 Oct 2024 15:52:27 +0800
Message-ID: <ed1c3747401c2251211e1fa6e4de63e24b4467c2.1729583414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729583414.git.tanggeliang@kylinos.cn>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..35150771e174 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,17 +20,15 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops red = {
 	.init		= (void *)mptcp_sched_red_init,
 	.release	= (void *)mptcp_sched_red_release,
-- 
2.45.2

