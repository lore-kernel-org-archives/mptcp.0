Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B0210FB
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363452; cv=none; b=uh/FqHpOg4o35r6TvW7YX9YOtEqXf5vUMzMDZ3YeaSr0mLz8OJTMabX++VPzm6Kb9dhfU6A3hLe1jIcmkPeUJ9nvr3P67PYfFO/UaMvOLAueSo5b8pCFyv5Q+ddmzag5zebRtxlu4NQXb/CM1EASgWgucQ8REirSEzvi3AQZTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363452; c=relaxed/simple;
	bh=w9mdhUacAZ5MLTGoUwdNnUNHKHQ3zFkogRRjhtDQo+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkMcKTKQLJPqYdyO8GLr4l/PDEzmAOa9FF74BjM6d3QfX/J8BJK9G998VHzuuwJj18RvUBByGELO3Ji1yKApLjSk4Y77Y/xAqM2cESJYGhpx9hgfOXUUMrszWJH54EOh/MKQigz+yRu8QWieAqcRB5TgdOu6AVLrFTPg15OMTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvrSb8a1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvrSb8a1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974ECC433C7;
	Sat,  6 Apr 2024 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712363452;
	bh=w9mdhUacAZ5MLTGoUwdNnUNHKHQ3zFkogRRjhtDQo+o=;
	h=From:To:Cc:Subject:Date:From;
	b=SvrSb8a1nLalQd3cwqMWRY655cnj7hNtlftILxE8EjsJJ3cZ4iiFKPMF20cHqIqrJ
	 JfCWC4hOEIDUHMF53GD0kIf2nDfMWx/BAaLYTn6udvnQAq0Uje0D2QP3A4TLwBeIX7
	 qcuN/7/+G2+MQuoRYge3NldbE0AhqcJn/8U3BygWHMK4sAIJPTf6sNxcwO61iv3uwo
	 +nLJPfCHOsYQL1M4/Vg0aKC+xsiDuM4a/EA6nZTOQKGEP1tWuGzaOtjLDM0w0M1KRG
	 vhuUr1YJT8wgtPcHVYKRQzOpxPg49TH41vIEkDP8GuJmCYp2IQ4DTV+lJwgbv2PUBl
	 dyEwpLQnVaxDw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: add last time fields in mptcp_info"
Date: Sat,  6 Apr 2024 08:30:07 +0800
Message-Id: <0979b4df687213cfaccaca526ad74958db8f67cf.1712363381.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Reload now = jiffies32 as Eric suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2ec2fdf9f4af..17223da5436d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -944,6 +944,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_subflows +
 		__mptcp_has_initial_subflow(msk);
+	now = tcp_jiffies32; /* reload it, lock_sock_fast can sleep and be quite slow */
 	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
 	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
 	unlock_sock_fast(sk, slow);
-- 
2.40.1

