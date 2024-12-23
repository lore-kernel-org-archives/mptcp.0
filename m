Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33072207A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948381; cv=none; b=VL/uxGAxGLlJCNaOehRYOJFaBOOg6V7NGq+SwESRLb2zDlNgv/uFMHHpG8ZcLkfzrntVH5L1ElPyv7niKH/cprNxowhwvd1rLP4ckCSVva6o23sLdYf5IDJa+W+ZxPO6TUQkjSuCWot8bbVgjHnUYI7/cBws0LVC3XX2FTT1474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948381; c=relaxed/simple;
	bh=U2N8A0Rut7m0u19ShzGRPoIhW+J8LxRiu3bxhLHbgDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1Jw6YdbLWT/zX7DzfFzoKJ9r+elHiC6ImNhLqIxA3NjgUYWUVk8AitVEB4O/EbiI7yOvcM3PjBK95uh0/Mns3buLjcN/54I3uRyPg5fSl22IBFvenLOHRjvQQXSkk6g4sXVKDQVCK7b0pTzESYR+DVPvX5aTEs/LA3dlrO9+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/0bAt6w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/0bAt6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53824C4AF0B;
	Mon, 23 Dec 2024 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948381;
	bh=U2N8A0Rut7m0u19ShzGRPoIhW+J8LxRiu3bxhLHbgDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/0bAt6wVsJ7r6obTyHUjjEOVVhPtwd5fUh2ku3UwNu18GLnbiWrEzTTQrVr5zhnb
	 5/jhsc+BMupbhRyGHORj47xE7NK9ld11mL9u3KY167PGpXgEHItpjTUb6jL+6lJhhw
	 M28qLkDivAH9EZ1L3PoKZam5xfoM1bbWh7jovw0OQRkpR3LH8VrEpSkfMqz13iaS1U
	 8L0nzWhY3hVfn0I+JQXYa5vZBKTuDkJXondcrrbPAZey3vOD3EcPQ/xjrlCX4g+UHa
	 lLsyKkVOD2u3bdElFsxtwoHQtXv9LbClVeNoF5FgfJ/uuFwlOlquycqlSQ+Bzwepj7
	 uiit1oB41rboQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 09/10] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Mon, 23 Dec 2024 18:05:51 +0800
Message-ID: <e1a6bd0853fa63b5905966d9b59052971d14662c.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 627502e3c851..a37390276eba 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -17,15 +17,12 @@ void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk)
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
-- 
2.45.2

