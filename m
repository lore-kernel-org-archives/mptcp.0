Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACE1C0DFC
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711784781; cv=none; b=Gan5grmSJK6STPmQYIm3PqQ0MkP4TJXwegz6pckB3ukzTCtVLj9r36i6SABRH/pcdk/hlJRTa690vzEXGqCbeyAgIMUsDcyoTK2L/SYxy5UVDIKEvJ4ishH+ILrKrNkT/o3xXQUNsCWAfE/18d7XqwnneuiVnQC1dQLj2PmfwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711784781; c=relaxed/simple;
	bh=vMMYevMUlNNQAJot//JBI5DCaZ77/LieHP9Ci+9MRmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ml4du1lmPgDpiVcM/Z8tpBAy28kNevKCpJq6t7bevxgNjf5FaEjJFCRXCfsCyr4P/95n2n/BY+nJRxD1/SBws1IrdGa4v7XToRQCouna9C+oqFtGhQwBV9G7z4gML+JDZvXscwbxD8+HfS5F3DoQupqHETteU7azLcnJia3QhNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te9kv3kG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te9kv3kG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35D3C433F1;
	Sat, 30 Mar 2024 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711784780;
	bh=vMMYevMUlNNQAJot//JBI5DCaZ77/LieHP9Ci+9MRmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te9kv3kG1METbkvnozFT+pNmcsaYluOxUjQKm5kH3lQPF1rgLkyE5HaAf6FPWMayd
	 JBujlh50uyc4u6QOYhiVhaBB2v37/4gM6mraYoahlpTcKm/4lklpNAjDTz3S2uqE8B
	 FtOlrAhZ/E3tF+LRndGoCkdt+vKymD79mHCSMdljwCvl/5KhjEOxydtUkgtLJYJGSU
	 6Uhoi7sG3Ix16Hr0sT8BZfC4Ckk8r043HcqwkY03Mwxzzv5k35Vp+4oIRotTy8Rtk3
	 IJC7Z4VZaIwciyQIFcRTC1NIqGQrR5/wfi9m769VCNokAaH36wxDiqu6dVO0tsM7in
	 4V6Tfqlwa3/0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/3] mptcp: add last time fields in mptcp_info
Date: Sat, 30 Mar 2024 15:46:09 +0800
Message-Id: <cd7e6214f3e6fd6928c674d6759964d111b4f444.1711784619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711784619.git.tanggeliang@kylinos.cn>
References: <cover.1711784619.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_recv
exposed with TCP, this patch exposes the last time "an action happened" for
MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv and
mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
deltas between now and the newly added last time fields in mptcp_sock.

Also add three reserved bytes in struct mptcp_info.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/uapi/linux/mptcp.h | 4 ++++
 net/mptcp/sockopt.c        | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 74cfe496891e..67d015df8893 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -58,6 +58,10 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
+	__u8	reserved[3];
+	__u32	mptcpi_last_data_sent;
+	__u32	mptcpi_last_data_recv;
+	__u32	mptcpi_last_ack_recv;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dcd1c76d2a3b..1e74851614e8 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -898,6 +898,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	struct sock *sk = (struct sock *)msk;
 	u32 flags = 0;
 	bool slow;
+	u32 now;
 
 	memset(info, 0, sizeof(*info));
 
@@ -942,6 +943,10 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_subflows +
 		__mptcp_has_initial_subflow(msk);
+	now = tcp_jiffies32;
+	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
+	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
+	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
-- 
2.40.1

