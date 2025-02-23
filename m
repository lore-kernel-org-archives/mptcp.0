Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554026AF3
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320451; cv=none; b=giVoG1Kwib7EnUj2lUxb5ijbWjQiuWOLnIfE42ruf8Mwsyx5nt5QMPMedpJyd6jkMjWOM2ViOTcR3jaq1TCA+e74ye2hv2vi4eL2M8hNmiUjSEEmP8vv1BVCiljKLrft76jiehrOAupsutRExJqvsbkIPBPXwb0aSV0GAEoebKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320451; c=relaxed/simple;
	bh=yvdh4YUh2x711JLyYBI1nW2uNfo9Sma+aFTx6VoJvj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3FIFm/6z8VD6C3LLJftcxpdr66aUEmSo06kL3BM1MBG8nC1J5Am/U8R8sOoVLVJtL1RSRcTsmDZhZyuEucU6ZN6B/T6M6kmF9tD+L46rbHDeK+rzz/bEldrxQoUvT8CnI+/Q9YmkJmp6H6AIbdmz3UeC7KPxLrkM/QPjGlwZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQdTvFd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQdTvFd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89229C4CEE8;
	Sun, 23 Feb 2025 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320450;
	bh=yvdh4YUh2x711JLyYBI1nW2uNfo9Sma+aFTx6VoJvj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQdTvFd8V0b4xt4fpgsZgRZWNrk6GaynfhlFZQ78P+D0Ya6ZrI5n0ybZ+epgIvsM5
	 ANl45pSUXDsTi4JGRSquip+PK13KxOWK8z4xMM3/in9JykzSWQ/SGYlvGLFMcozQ4K
	 nX3XeQYwKtudLIbVGH8o4zh60dZPdeetkP09QmbrlQFoUtKL5E2LkMtD7wwmGAAlFV
	 QdIcbA1qx9P61OiHiarB6DU7FRgXa2qy3skc23HG0SEscg0Jsg5xNftEt7HjaMyhVv
	 notxlftJYyiItwCFZs634kHa6yCJc9UeYV91PV7mjlLAIx2Fv1C6xmvFhcdKQqa15y
	 sbviIcpizMFOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 01/13] mptcp: sysctl: use index for sysctl table
Date: Sun, 23 Feb 2025 22:19:49 +0800
Message-ID: <3e40ffced396775b7e3056b6f0934c112d8e8513.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The sysctl table needs to be updated when a new sysctl is added or an old
sysctl is deleted. It's inconvenient to use fixed index numbers, since the
index number that needs to be changed and all subsequent index numbers need
to be updated accordingly.

This patch adds an "i" variable to access each sysctl in the sysctl table
incrementally.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index be6c0237e10b..030dbe46cc8a 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -259,6 +259,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 {
 	struct ctl_table_header *hdr;
 	struct ctl_table *table;
+	int i = 0;
 
 	table = mptcp_sysctl_table;
 	if (!net_eq(net, &init_net)) {
@@ -267,17 +268,17 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 			goto err_alloc;
 	}
 
-	table[0].data = &pernet->mptcp_enabled;
-	table[1].data = &pernet->add_addr_timeout;
-	table[2].data = &pernet->checksum_enabled;
-	table[3].data = &pernet->allow_join_initial_addr_port;
-	table[4].data = &pernet->stale_loss_cnt;
-	table[5].data = &pernet->pm_type;
-	table[6].data = &pernet->scheduler;
-	/* table[7] is for available_schedulers which is read-only info */
-	table[8].data = &pernet->close_timeout;
-	table[9].data = &pernet->blackhole_timeout;
-	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
+	table[i++].data = &pernet->mptcp_enabled;
+	table[i++].data = &pernet->add_addr_timeout;
+	table[i++].data = &pernet->checksum_enabled;
+	table[i++].data = &pernet->allow_join_initial_addr_port;
+	table[i++].data = &pernet->stale_loss_cnt;
+	table[i++].data = &pernet->pm_type;
+	table[i++].data = &pernet->scheduler;
+	i++; /* table[i] is for available_schedulers which is read-only info */
+	table[i++].data = &pernet->close_timeout;
+	table[i++].data = &pernet->blackhole_timeout;
+	table[i++].data = &pernet->syn_retrans_before_tcp_fallback;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
-- 
2.43.0

