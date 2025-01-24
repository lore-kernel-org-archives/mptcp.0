Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDD33998
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702704; cv=none; b=qbJOnLaCxnCtfuoWUfjY5BONfNV65u3hCtW+bt4elZChohgdbDvnopKNInDbfkbFDkbQ1pqDoFYKkJ5YvDFmrA5IoQqcpUvF2iqUbqf22uQ7ZS47wUE/vVLGlEWnv92XFAjKyjTVHDDHg5A6VWeSFiAqtdWfljeeQGv1zVyTF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702704; c=relaxed/simple;
	bh=TiZfMyxvA7ixpSqsK46sUJnfdUrObKYYni17nSJ+4sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9z6N1Do4qcv+1XqPlP3KKWUaAVvDZfJy5QUGJBWPppfPcxfA9hjHAtPwqA+lSNDIJK2+VYa8rU66XauiU2NI5TWq2K6nGKkkWcA0GfAt262wlnu0kx598Nsk4ov9LZc8OdcKN4oHr5928DM3QUYQ9Cel2I+oPGcEgI4Ts/ZK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6fXFxw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6fXFxw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D86C4CEDD;
	Fri, 24 Jan 2025 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702704;
	bh=TiZfMyxvA7ixpSqsK46sUJnfdUrObKYYni17nSJ+4sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6fXFxw4iJ3VyZ/THVr/o9P4AfQh3zvSkiAiQaDZXq/zrj6DtA71gSRLgdWhmDmQr
	 Yl1R+VgAzh4fmqWyE/7SJgRL6YU7ZY5lZW/ayRARDaib5wspHi7EbH2UMN2ht3VDg4
	 QqfunElKtliEhBkx3frw7VGtvXTNRwy8bLTUCWRvtWVjU0TIq5YFZukgGQMdCy2qAc
	 ACrAY4Y1RLJwjBGRHCORq4iv9NsNcy3zLfFBCloswTLgY6Ymy/5IN2TtFX6vZbo1bk
	 17D4dHnW6vxFYKTW2jhjceVuZBFVmawOE7yEXnEG2LSPo8DClcw5SywF5/vZpED25u
	 mI4CJ+ewUoLqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 1/5] mptcp: add a build check for userspace_pm_dump_addr
Date: Fri, 24 Jan 2025 15:10:43 +0800
Message-ID: <ea2f44424a995a20c88587e41f1eba7989b4b49d.1737702298.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737702298.git.tanggeliang@kylinos.cn>
References: <cover.1737702298.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a build check for mptcp_userspace_pm_dump_addr() to make
sure there is enough space in 'cb->ctx' to store an address id bitmap.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 277cf092a870..b69fb5b18130 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -643,6 +643,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct sock *sk;
 	void *hdr;
 
+	BUILD_BUG_ON(sizeof(struct id_bitmap) > sizeof(cb->ctx));
+
 	bitmap = (struct id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
-- 
2.43.0

