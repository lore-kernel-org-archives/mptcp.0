Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A65211276
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347423; cv=none; b=LoDY4lJuKK18JNtbgBCco5RnnhpAbduAW9UWlEBTS+3+m3QXpccB9oR96KRA1RLx00WXpZGpOYs5p5MXjpWmJt1RrwPkF2tujjjrtIjRc9ar8nucgKum6O2AoSyfjjZ511kOx/V9qs7N8iQk8EJsdJ5lJAhklXDB3aYV+0xByyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347423; c=relaxed/simple;
	bh=b16Q6fSumuUi3HtDy3WcBkhR5s9z7broAKftP81G/s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWiSIUtS5GXwCGyuWXTZV0xAcdcKUMJU3/ZYIa74LWUMdgBefnAkf0TXa0OJzavhCajqhxJzikOqtoLd0k3KgH0HJ7dzuIo13V1yc5phzw5aV2Zt3xZYjbP23YnNKR7UQMBgCKqwLFM5ndzha1FG079w2Daj2XOXcm1d9lFZ6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOqKHEFk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOqKHEFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F0BC4CED1;
	Fri,  7 Mar 2025 11:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347422;
	bh=b16Q6fSumuUi3HtDy3WcBkhR5s9z7broAKftP81G/s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOqKHEFkjA/Y3sf9RX3i0+CkXTbejy9wWzu0XAzPRsTpB+wNCaa5yU1bbZ6C03IrU
	 GS7gUTODCebCJ9VsDS6bK0bPRRPVIftR5uyPzD7UmbK/eSgX1BbvYaYJM5aEDin0vg
	 31cFy7IEyEK+prbZLnrjTnxg5R0O96YeMj8DsByPXXv9DRrysTQgUpGPkIZH+p+FzH
	 j0rcR/rI2XYKhVlRexJuKhfN1TNAwBZUC3R8aG4iBtdQV8SpjpimE/lRcwIQNNIKh2
	 srEkma/vxpw1jqUk9Fb+buz6Cn7tO+dm5wH3Xiqp3pfrWkNnRk7NopUCDedRTG6oSU
	 6SjhxN9ur+eAQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 02/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri,  7 Mar 2025 19:36:43 +0800
Message-ID: <d4cd479ead6043e967b005cb13dc5409488aba2b.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c0da9ac077e4..3921261b4fd4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -156,12 +156,14 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	return 0;
 }
 
-static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk)
+static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk,
+				      struct mptcp_sched_data *data)
 {
 	return 0;
 }
 
-static int __bpf_mptcp_sched_get_retrans(struct mptcp_sock *msk)
+static int __bpf_mptcp_sched_get_retrans(struct mptcp_sock *msk,
+					 struct mptcp_sched_data *data)
 {
 	return 0;
 }
-- 
2.43.0

