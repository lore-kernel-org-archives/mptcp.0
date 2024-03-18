Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087622EF0
	for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749020; cv=none; b=GbHuuCQDcj0uL8OLsYvk4WrTxNEd3qXW85Ozc2Q9HioZIiNtClS8yv1GzGIB1KpZ6uDMh6m19nKy5kR20G0gnHMSgZGb4yUxXjH9o4dUPJhML7ZXXo2Y8ECYYznd69lFQ3xu9FqpCuGh4k14Q6RPf9OBcgWPVM2lAeDVnIjjZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749020; c=relaxed/simple;
	bh=h1YuOpgJ5KGGAiT3kERJ39y9/AVR49h5j5/ZnylTTMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=synLuQO66UEiooEVqkrNvbYQkXD+ZVrRWTsH5x6uxwH88CXF7bFAAizSX97fAeAiOol63n5Megh1WjjeczML6mPTqkUcnrNCPICt/APX/WSS8c5GSEv3Kqe+aiNiGSkOJx7NFUimJVsFQCOoLGDyTAde+JRanWoZcW0vfjiy9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXMSw1rM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXMSw1rM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E99C433F1;
	Mon, 18 Mar 2024 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710749020;
	bh=h1YuOpgJ5KGGAiT3kERJ39y9/AVR49h5j5/ZnylTTMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXMSw1rMUfs6y08AOVyNdpHxlhLGl2ovrG9JrLU3/AcGeMWhkvbs0CCY4OL4+oSJU
	 VaF7gLn0sQmBeC4vBH7u4P34gnRmW5Owi9Ns+Wsi9tAYVVDW1ZzRE3+GqGNEzgAPtK
	 RDuBekUwYl57jKDR/NJSotqsRxQeP4fHojvimo/8a0zhdPF6LDekjAoxTnSgnwwLjC
	 4pQXFmAmx8wXvOjnWwXDTucyqbGst7wb/GmaOJb1epu/pVfe3Oo0aMvAOZTa91zr/4
	 FDsJHMRLW1yVpwpUO4XwHQRL8wJAizvdUKKmzpkEjY5Owo9b2kJPyxfMRH77waLa7+
	 S4xysNkrj9erQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: add last time fields in mptcp_info
Date: Mon, 18 Mar 2024 16:03:30 +0800
Message-Id: <a5e9b583f1f763a472ab24379ec606f0cd28d0c2.1710748923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710748923.git.tanggeliang@kylinos.cn>
References: <cover.1710748923.git.tanggeliang@kylinos.cn>
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
mptcpi_last_ack_recv, calculated In mptcp_diag_fill_info() as the time
deltas between now and the newly added last time fields in mptcp_sock.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/uapi/linux/mptcp.h | 3 +++
 net/mptcp/sockopt.c        | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 74cfe496891e..7126563542b3 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -58,6 +58,9 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
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

