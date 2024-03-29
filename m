Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C434CD5
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703231; cv=none; b=qQS5430aRRxBqG2iOmW+bocPcooURrLpydQnsJUDWJMXXauDrKTyL0dL88+pUhkUqD0M4S0jxAbNHzOJXQRtU+N088xlOPS77MWG6JcUoOM0c0T6qOm4ljcIgsiboCHTly5qXCw3rAOmQ642o4F1n5uPvenTV8clp8KRmQ/QaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703231; c=relaxed/simple;
	bh=vMMYevMUlNNQAJot//JBI5DCaZ77/LieHP9Ci+9MRmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukwVrY958JdDzUzz9RMCCzzybXRUzuwpZDDPne5E9y6bKYSCPVNZeZ9IH5kCooJzY3PP2+v1Z8G5FWpCjGvawhjW+rmKUTLkael2UMp1KOsdN8T07aXa3fVZQfuGXfnvTNg8bPNGtjmDAKDqI66Z+Fack3A7WNgSsZqOl3oq1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeG7Kan1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeG7Kan1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367FDC433C7;
	Fri, 29 Mar 2024 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703231;
	bh=vMMYevMUlNNQAJot//JBI5DCaZ77/LieHP9Ci+9MRmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeG7Kan1VuMCjd+BeEEFpt/Ncne9b9kP4HC1ZG4RUFyuwYWWSVmjbNz19D//ljSXY
	 BnlRYhETbfcoOcqul6lE+lMtzY3t9wPYdqZeHP+NWfjYiBt1jN0VS43+H6kJ2gvLNR
	 gU+qOIfFYQBEGKriyveZm73VHyPhXYTasNsxDL872qUeMBkEDQkBubCtHyqeavBF+8
	 7ZVRNscPk7RiwKqqWgMBXnAT71TTIaO2L+qa54Xowx+PG6wyejx1T3crq3CTP1sfBV
	 nuNhfeu3xQRKojoqv2K6yo1671V5mO4WlM38wg/X7fk9p6p0E2BZKwRNviMbElt09J
	 DTD/iVsTGSW3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] mptcp: add last time fields in mptcp_info
Date: Fri, 29 Mar 2024 17:07:00 +0800
Message-Id: <f255cebcbb77caa3944c01c510d1e1bd62815a2d.1711702915.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711702915.git.tanggeliang@kylinos.cn>
References: <cover.1711702915.git.tanggeliang@kylinos.cn>
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

