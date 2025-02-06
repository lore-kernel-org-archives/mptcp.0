Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8C226165
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832708; cv=none; b=WFNwQqrBNY9DiPgtvFQk6uj1MudrwTHP3hBQq3++wKtcXstAn1LRNaKDogEHce3d1clp3DL8R9s1BvV9qKYYVz05BdB7sCjF7hnHY3Z7zL8EgB+Mymi9gQ5uQtEnmjtsWUmHh5DXqKCqwY5+89Ds/HFUPNSTYBkjJREf7OrMT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832708; c=relaxed/simple;
	bh=ZmUi+Hu4+KCl5twoWAZqKOBKxfzJ+JWFal9xUmOfOVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4Jsrx/3Hrki/V4orJ/bhCF3yMJU85Re6VCAkhelswci6EJVIw4z/7tENztXtbE/C49vYm82H+zOLLuEleDDpF+/RkL9pV3z4jDPn0mD8/ZUCDj79EnYRXpAQ7HVfTDuZsa3fEuduuKnLVpIW2PG2zfwa7oyb+swBMNbmjsqZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhwHNEU8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhwHNEU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B538C4CEE0;
	Thu,  6 Feb 2025 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832708;
	bh=ZmUi+Hu4+KCl5twoWAZqKOBKxfzJ+JWFal9xUmOfOVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nhwHNEU8nasuclKepQzxZEVNdEvJNTCrGx8XJ7TuHClGaimtIEESJf9jvxRirS/kT
	 LI1w1aykN2bXcw0a3LoFdzcKfslIy7jJ4XZikzymqXOQWLE5TZH7krJ/HzhEc+OdSa
	 8a0mKvZ3BDQyUy/HOCJAWpmuadj2UFz+lc8MXLnaQBOHoyrgn6o5hiKHqH/v+glVHB
	 57bz890Fjqd5dPBYkSovmBurz3N4Oj1haKGYNZAtFI2VI8xRoj7cVXOtaEWEEkDu1F
	 MQKuD1FvpF7AF8JIqzocgnS1dMVhCBzK/wfu58r7bcgn5MKWRilA4Xh/l0X8TR+Cf9
	 s7POQRa79uDyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 1/9] Squash to "bpf: Register mptcp common kfunc set"
Date: Thu,  6 Feb 2025 17:04:51 +0800
Message-ID: <caad268606d9a2a08fa7bdfdd08902bf0a85eefc.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Instead of adding a new BPF function bpf_mptcp_send_info_to_ssk() in
v12, this patch uses a much more simpler approach, which using '__ign'
suffix for the argument of bpf_mptcp_subflow_ctx() to let BPF to
ignore the type check of this argument.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a74173cc8998..c09d5526d976 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -224,11 +224,11 @@ struct bpf_iter_mptcp_subflow_kern {
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx(const struct sock *sk)
+bpf_mptcp_subflow_ctx(const struct sock *sk__ign)
 {
-	if (sk && sk_fullsock(sk) &&
-	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
-		return mptcp_subflow_ctx(sk);
+	if (sk__ign && sk_fullsock(sk__ign) &&
+	    sk__ign->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk__ign))
+		return mptcp_subflow_ctx(sk__ign);
 
 	return NULL;
 }
-- 
2.43.0

