Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C8156C69
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170124; cv=none; b=ERcSNDwcftxk332XH+pVtpJo3MVGnFW+IGk+KiyVce4YRN4byYIz/Cteygp/cGzp4i70IheZWMAhAnO3ZqCF4RMSNGxAOtDk6j+nN9NXvHgmxboOhDEDDT9rcxZkSiJq1CwavyhwRY16Fzo6uxaCVWsXaD+k3UF4YLUg3Q8GVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170124; c=relaxed/simple;
	bh=zBo5KdCfWf6qZj3DuxGNSoCLUBHp/tIGLuImTf1AUnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbnfU6uPvaQyqvaoWe1M+9au6jYupWoM0aKNh30LKDzmMWkHS/ZnqJRaALMVLEEBe8VZN2xnh6KiulqLQEnd0qfZWq1HMg+rvgc+iHdBTAWN4BWy19uMJGgwfHj0RPI59xQgXtPMJH9PseqWan+T5Mu+cuAJIFYnfAj21hFzR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdksYLA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdksYLA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED0C4CEC4;
	Tue, 24 Sep 2024 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170123;
	bh=zBo5KdCfWf6qZj3DuxGNSoCLUBHp/tIGLuImTf1AUnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdksYLA/loBGIOjZ9LWFykuc1I+TfBf1+Uo69M2IDsUvxiw9ZREzwgXlTxPN/kRP7
	 v6Uz2OVlrsvmqe+A+udmV6XO1owE2mjk9e71PcIR0Pw2zyzOobWuScpo86HOgpgiQA
	 +F/P4skvzLibU8F6dE7TOhWOAUfuAbHxx+0FJ/gXo2XoWt8b7XwUY5V+DMHTPpiao5
	 4/UXiyyqFtbmrmLWxVKuWhzL4f3wRu/pBY0V3BlvDL/6bhYYO4z5uaFy+01ZNjwvsH
	 g21prz78vxIGOjydwnCg78KR6mG/Q/j0C2qhQc8alXl15hpNtfOrf9GPGIR++wVj5M
	 ncxRAkJ9yrYyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/8] Squash to "mptcp: add sched_data helpers"
Date: Tue, 24 Sep 2024 17:28:29 +0800
Message-ID: <541e59823f87bf1c4c8d28310dc1e7931c06e4e8.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_ctx_by_pos declaration, since
"-Wmissing-declarations" is ignored in __bpf_kfunc_start_defs.

Rename bpf_mptcp_subflow_ctx_by_pos to bpf_mptcp_lookup_subflow_by_id
and drop mptcp_sched_data_set_contexts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c   | 13 +++++++++----
 net/mptcp/sched.c | 22 ----------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 32894d2246b2..ff2589b5edbb 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -265,11 +265,16 @@ __bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 }
 
 __bpf_kfunc struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
+bpf_mptcp_lookup_subflow_by_id(struct mptcp_sock *msk, unsigned int id)
 {
-	if (pos >= MPTCP_SUBFLOWS_MAX)
-		return NULL;
-	return data->contexts[pos];
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->subflow_id == id)
+			return subflow;
+	}
+
+	return NULL;
 }
 
 __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5257bc6c8cd6..78ed508ebc1b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -143,26 +143,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
-static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-					  struct mptcp_sched_data *data)
-{
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-	data->subflows = i;
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
-}
-
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -189,7 +169,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -212,6 +191,5 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.43.0

