Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D302373BF1
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188291; cv=none; b=kP4FRoshelZcTO3CAf/6tNr6q6nmxjsdA7Ll7+ItuO2tgJr9fN1Nb4RgJhJrmxzv044VZAroOZ+xCgQIWFrKXx0D6+Roig6p+gAA8WYi1rZbUVw9WHICALLiVQavPXz07OhQuYFEI2YBrWySDudLx79Lwiy6wo9+tkOUr8QWoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188291; c=relaxed/simple;
	bh=ToNk3YwEnu0/41Bz65Jhmf7mP/kp7FtOhl033CMxfSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afTWahVVdUGm6GLx+ZNAT64K05PNet0fd4Jz1pJDG+x/auj6jlMrz7txee3hKIB85KvCmia25/Xo8JQSzu2uD5XEr2Y3+xiuiaKsMM8Lr6nSe9Q8nVYVwAdCn79bOHPe1a3X91yRTuFFRlNtTJH6B5oHrJmzFUc4KJBYS+TcPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTrAH/qM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTrAH/qM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438291F00A3A;
	Thu, 16 Jul 2026 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188290;
	bh=OJdlqIFmjbfcUmGYRyfiS4f033WFHYwhVddD91ohe94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTrAH/qM+uJa4LlmwoYPbEZJBOWnLp7QJPJ/EF2CvGebmE2Y5OC2vXrCra2btCGCZ
	 zUOK7hb8cI4t8ueDohNLwzHlfxy5LUPuxf6vPrDBwBR6O5YmRhE73BVZKEeXaA0esJ
	 JlsIc57EGYkk1Acqve+beoHRPMG9ZBF4x/edG2MHb8+4zxasnRrpt6B5YE3/gCpKS8
	 SornGGGqJeoz1CwcRAMY+BKWUERZ6S3Utdb5hVnKPmxpOZA9ieKfwO8o3ZRiu1fHjk
	 CheQA2r7JhJZMHH8y6uoPMNz8I/kMyroNePy5IOcshslxQ9Wv//DHk8W8nSiJmfbAU
	 dMBX+UJ9A+bLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 03/10] mptcp: widen offset field in mptcp_data_frag to u32
Date: Thu, 16 Jul 2026 15:50:42 +0800
Message-ID: <8b39801c46b80523ee71dfab667117030d2ccdfc.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The offset field in struct mptcp_data_frag is declared as u16, which
can only represent values up to 65535. On architectures with page
sizes larger than 64KB (such as 256KB on PowerPC and Hexagon), the
offset calculation in mptcp_carve_data_frag() can exceed this limit,
causing the u16 field to wrap around.

When offset wraps, mptcp_sendmsg() calculates the destination address
using the wrapped value:

	offset = dfrag->offset + dfrag->data_len;
	page_address(dfrag->page) + offset

This could cause the function to write new network payload into the
start of the page fragment, potentially overwriting the previously
allocated struct mptcp_data_frag and corrupting kernel memory.

Widen the offset field from u16 to u32 to support page sizes up to
4GB. Also change the corresponding local variable in
mptcp_sendmsg_frag() from int to size_t to prevent overflow when
adding offset and data_len.

This is a correctness fix for architectures with 256KB pages and
has no effect on systems with smaller page sizes.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1cab07b1b9b1..3acd61ae6160 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1373,7 +1373,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_sendmsg_info *info)
 {
 	u64 data_seq = dfrag->data_seq + info->sent;
-	int offset = dfrag->offset + info->sent;
+	size_t offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..7d624cb0fa7d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -263,7 +263,7 @@ struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
 	u16 data_len;
-	u16 offset;
+	u32 offset;		/* u16 wraps on 256KB-page kernels */
 	u8 overhead;
 	u8 eor;			/* currently using 1 bit */
 	u16 already_sent;
-- 
2.53.0

