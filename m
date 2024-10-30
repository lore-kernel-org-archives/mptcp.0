Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201283398E
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268657; cv=none; b=jP3JrDqxS1bSPC9pxDDb7kkKAx21DWOEpcaeuaCIsHGqoIoBMSRaddLWhh66swKSRmYSZRQkbtuNv+Z9EtzmioSNEvuO8RP9J5AlOkl7blrxhjgwuHe5StzZvEZ19A6HV3JjcpL6sxYx91MRUXqorTFyQ+GhiRZASvxCDcPI6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268657; c=relaxed/simple;
	bh=XnuoyV7zowI9ZX1VC6hl8pO8+ML3mKOfidjIwBJeyTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d10PrPFnJABWMz8GFvOYZg6qpTNLYSZ1lARSkRPehW6UdYC2Vgq/CzYScFLrAu9T3W1DP/5DfXPsM1ojI+pl67wHalyjc/j5L8GDaXRleoKXLF0JRrmmpKtlYu3PRBBe2RNBWRAEfdkopJjXVp+e6PXLFmDne+iRUCYYgsl2Dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTON/jhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTON/jhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2814C4CEE8;
	Wed, 30 Oct 2024 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268657;
	bh=XnuoyV7zowI9ZX1VC6hl8pO8+ML3mKOfidjIwBJeyTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTON/jhWXfLbFRfEaw2D+lFFV3wIKQHf2S0+EN12Bt9P1dC/nzrkfCghG3nr5LHrG
	 hnvhF7oDwDIzcvYB2bFdP6PG+o7swmcqKl54OK1xV4OeMngZzsE9H7nXEmuosA8Lvq
	 ayUK+0wYqPL0ANW8oPWW+GdqMJHf/l4pFy+tee9htvG3yc6gIwzl/HAqsaUtCTL/RE
	 IRHMsUU5fUlFUMNP4dsdBvew8vscPD7U9MM6dfZ5567E3aH2Snkan0oHmLJq78d7Rj
	 SAGLXiC3nBCAfLzyuwdPh+5ytJ2yDXi6CnnBY3x1w6UMvpr2pta5o5Zz9d87OpZ1e8
	 l6k+siRdp6PtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 02/13] mptcp: make mptcp_subflow_set_scheduled inline
Date: Wed, 30 Oct 2024 14:10:26 +0800
Message-ID: <e197d4a85b6670d1ea1d9661709449cd4ac3a864.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now mptcp_subflow_set_scheduled() is no longer used in BPF, but only in
kernel. A new mptcp_subflow_set_scheduled() helper will be implemented
in BPF specifically for use with BPF. To avoid compilation errors due
to duplicate names, this function is made inline in kernel and moved into
protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 9 +++++++--
 net/mptcp/sched.c    | 6 ------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4c72a73594f..ab4e88b40efc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -750,13 +750,18 @@ void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
-void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
-				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
+static inline void
+mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+			    bool scheduled)
+{
+	WRITE_ONCE(subflow->scheduled, scheduled);
+}
+
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6da60e35932f..73a24b9c96ff 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -135,12 +135,6 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
 
-void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
-				 bool scheduled)
-{
-	WRITE_ONCE(subflow->scheduled, scheduled);
-}
-
 static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data)
 {
-- 
2.45.2

