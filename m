Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEE1FCCF6
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072588; cv=none; b=Sge524BC4l277wpF9K2E9lVaBx5JqmmwFeQnAhukT1Vmd+89cZf8605frQffhOP9zguPkrnTDJY48Vtrp5GdunEI/ANI5nTnan3O4jzn4yAfX8uuztjx3eF7TsHFK844JRFkdJnSY2SJb7vRWzXXNPTp7Y17pvwutu+2ErXLfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072588; c=relaxed/simple;
	bh=XqgnWgMv/XgsuZQzX/zcofXdmTonkUB2TbiHqAVnZtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+l3WP2VYo9H/Kl3vyS7Qhu6UHYTqsG4KiVNhIU+IgzZtOf/SYPBXgeXDA8LLNXefSDWwIRH2vPDFjrgbkF8yfnj9dpWLFPtMdpklMV08uGJoE51M3nv4JAy7roUe82qCEEtl3uqXhBIDXtkZ4kJ/GQNDoPPiMc031OD8zrwhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3hgKG5e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3hgKG5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB248C4CEE8;
	Tue,  4 Mar 2025 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741072587;
	bh=XqgnWgMv/XgsuZQzX/zcofXdmTonkUB2TbiHqAVnZtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3hgKG5e+JNH/ftnKA8d0WK212ON49s8tBYlivX/DJBozLoGWO91TFE29jGnPN+2u
	 2mhiukc7288X90SHRjzpneBb+3J/1Nj0fMyf+u+IzRpLRu4ZkLCB+aLhvBsLf8NuQl
	 r+8Cf54aAN3N/UWimo0/8G8MTyKIpIYZfmAKwWzhDkfsle0sZA4ThyTeW46aOACGLJ
	 wglE2BlStO2TgZ2aFqrDDe9dbKB/D/mXmhv/1qcaLlU0QywsFAsry8ZydRXSRSLLFY
	 iggP9LGsrpIp7gxrZ+mQyjtK8Vxjv1HV9ZskqAmTdxCUcOhJyG8PGxauxj7LfVt1sA
	 JuKo55uzEV7dw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/2] mptcp: pm: in-kernel: use kmemdup helper
Date: Tue,  4 Mar 2025 15:16:16 +0800
Message-ID: <52adeb78ddc4d78345fffa31b6926b59906dc8c4.1741072099.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741072099.git.tanggeliang@kylinos.cn>
References: <cover.1741072099.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Instead of using kmalloc() or kzalloc() to allocate an entry and
then immediately duplicate another entry to the newly allocated
one, kmemdup() helper can be used to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_kernel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 62ae68abb2cb..806a9b5b3c07 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -710,11 +710,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 		return ret;
 
 	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kmemdup(skc, sizeof(*skc), GFP_ATOMIC);
 	if (!entry)
 		return -ENOMEM;
 
-	*entry = *skc;
 	entry->addr.port = 0;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
@@ -817,13 +816,12 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
+	entry = kmemdup(&addr, sizeof(addr), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
 		return -ENOMEM;
 	}
 
-	*entry = addr;
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.43.0

