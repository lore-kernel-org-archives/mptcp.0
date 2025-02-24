Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F71134AB
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384836; cv=none; b=tik9nYH8f3UdmeV91bezRauJuJRC5XQIbF0o2v5HYIrrO/OxlYq2PiNeP+g1NbaPpAZsQR0dFdqW10Cp+tCnQesnO8xrVC6L8kmMCcjtU7jg9AIKqZtLRGh6r0ofWi/j0Zrf4gdOb6ZW7hLrc6w245edQsJ34KeStYcC9E0nIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384836; c=relaxed/simple;
	bh=N+3lTKYpkYqF/AO62aQgwdpe7jO7MvLiVRUk9xtnQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZFWl+KVDLAc4hH0zIAS+KN8YeTsSi7h6NWwqnIwNISGRu0Pwu3c+HDZb0VYrCW+2iq9rxacCmxFjLMigUe2od6XRUZjJ2ni4EoxGLilsbFo1dy6+owmlGDveeKISjrek1Cf/hE0yMSRy37zTXhRDgdFCt7tvTxYhH2XLwpSjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C12DWz6x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C12DWz6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE237C4CED6;
	Mon, 24 Feb 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384835;
	bh=N+3lTKYpkYqF/AO62aQgwdpe7jO7MvLiVRUk9xtnQTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C12DWz6x0416X2ioe9bGD0iBPy4R26iRa7WRJ9mmrpvmaMvfWwNBwUOvhpognVUlf
	 cSjbEMwoSiUFiCEOD/qntfp5qWGnJ+E4lN8FZ0JwODmREssh0w8ycnA0zaX6aq7ea2
	 OrIvYpP+uYCPgFzWFjXZeMVDyFiRA43r0owsEVSokX3VgAgBC6EE3WLsJNFGJAH4tp
	 GvovtyzuTMTuRFCyNcpY3zwzvMXNX3eOYS3Q2JqN6AFzJmM4BMC3XoAmD2BaysIZ6C
	 zajbiWwtbHEVFKlKC1GnI5P7ZsuYwfnWHCTzlG1BCGTrO9JJn4aV/uFBEhiUiLoE6Z
	 aeQIiubh75uPA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/6] mptcp: pm: in-kernel: use kmemdup helper
Date: Mon, 24 Feb 2025 16:13:36 +0800
Message-ID: <5f8d3e2b1e7dc0b91ae84288da40d24ad505f50f.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm_netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 033cba59023f..ee0cd92865cc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1156,11 +1156,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 		return ret;
 
 	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	entry = kmemdup(skc, sizeof(*skc), GFP_ATOMIC);
 	if (!entry)
 		return -ENOMEM;
 
-	*entry = *skc;
 	entry->addr.port = 0;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
@@ -1422,13 +1421,12 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
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

