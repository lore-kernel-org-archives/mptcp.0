Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7CBA3D
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173028; cv=none; b=hy9+xHQTE1L9dhJY95W3UOm7sbhAIsNDS/hzCCujXr6SQFzuQsT07edVZMsU0gTzpVkm5VRQ80cJn00CRjglEjaNSF7VDRfLwEuhyQC8GzemSqizWuseQc5j58DGQw0n9g+/reztQwOe82ICS36tg2VLm+2nmpeed/d/7T8P5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173028; c=relaxed/simple;
	bh=jaojZ4XPGoRvBnyn40YqwV4zgput8Ga9ZsKyjBdpRbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IT4dXHqtEKl3fOo6AZdNaWYOPsVskWRUJaRLraGBCyDJfAduZnbVR4khf3hfHu7WzsTuGqKa1Io3mjxmkZmnYgefATf+4ovNrwxKmi9/9oiCDP/7wcGwvYDYNbSR2mU8tHsJHVj1/v8xVQwMm7y0w5JcRYMqloU9KHLYkuizty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH8oV2we; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH8oV2we"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D747C4CECC;
	Thu, 21 Nov 2024 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732173026;
	bh=jaojZ4XPGoRvBnyn40YqwV4zgput8Ga9ZsKyjBdpRbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bH8oV2weCDAPMfirME2z6zK9nmdxVbVQ86Q23amiKcAb6GVxMkPHy3gYDs4RwZvIR
	 uz5viQzIK6QEV2M2Klx2bEMLIaJFUlCkDZXevNzICmHEQryPGzcFsg4RrNPZKCdc04
	 iEgL3S62Xg6cGKkFuG1hYN5+j3tcG5ZYMmPQQKhe0pHr7/QlmwKGNlbtz+Schzf4Xa
	 wPaW8rRHQYyl8JBnRZYVSTb+AxCJM78CNNlMnF/qV4JZs44tWlFyKCgmnaVqfxwWXd
	 u/a39QFe6FONGDsBbBVVhGD1+c8ZeRE1Y/sEWO8pC/ojc6JQuCxeYexc5aCPIRb/pu
	 0aqk9jByB62ew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Thu, 21 Nov 2024 15:10:07 +0800
Message-ID: <8e8c6d39d8de8ab2bb4cdd8965c1981a3920bc9e.1732172851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732172851.git.tanggeliang@kylinos.cn>
References: <cover.1732172851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address Martin's comments in v1:

- bpf_iter_mptcp_subflow_new returns -EINVAL when msk socket lock isn't
  held.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 02038db59956..5aaeaf641f7f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -252,7 +252,8 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 	if (!msk)
 		return -EINVAL;
 
-	msk_owned_by_me(msk);
+	if (!lockdep_sock_is_held((const struct sock *)msk))
+		return -EINVAL;
 
 	kit->pos = &msk->conn_list;
 	return 0;
-- 
2.45.2

