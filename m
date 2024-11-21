Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745C15C120
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181804; cv=none; b=qvXBsxPh6YaSlG4E+F2DzxJhoR4cq1emD/rGJCZA4l4FnSZEmbqXgv7rULWb8L3hkP/EIUXAZrq8r8pRQiZefIse5PgFQRzuA/dl9Hu1Ss6aizg7X073ZHi3jjZGSfSs4G8L0tgTqGwPZCXgDtE+LlHBX3PvSc6HMmBk5FzfyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181804; c=relaxed/simple;
	bh=qwvlwQape1B11fqsgjhKvLt2UCBXoWhWEAXaOPQ4TLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN/78rqfES7EIaZl7UXsOieXFWYIzXQKsQ8JlJlVRTDJ7bdN0n+nr3opwMpOIkrpEh4fWS2K2ew7vGxjH3gdubNCV7QcoAJ0EXsAC9tlYU+tpbOZaEVdKmcVH145kPhvIF1VGXkn7eOfVJHVtUaVCnp+QnHNbsdqHGGWTGh1BHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fodo0xzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fodo0xzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1457AC4CECC;
	Thu, 21 Nov 2024 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732181804;
	bh=qwvlwQape1B11fqsgjhKvLt2UCBXoWhWEAXaOPQ4TLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fodo0xzd4Yc62OcrAmacENiabvuAoSbUsLP+b6Ngah/IzaBZvjLygH5gatgZ8GCN+
	 fvSvktyJadJ+jej/ggm4KqIcsblFHASkPNk6n7ta7qabSi52nV6FUWOSa4T89ugod5
	 +cVYuUkey/acpSSOXhs+BNOJWqqpb8Ej4N3E+vMMzELn/3Q8xLW0wgQO1JC/VWsBS5
	 cUEaHO+Si523RXNiaBu131AMV3C5OUBn5rYTcR2Mr0vjbsoBjPi770lkY47gxB3KJE
	 PbWsmqHd00DVp31759YAAy0SYSSNJVDt2x7Xb/v5IvpWb555284smL7J2RzLScron8
	 nltJEBsVzoITg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Thu, 21 Nov 2024 17:36:34 +0800
Message-ID: <c98deccb13e527c3fc120e9f6f6627db3b3cf6ab.1732181419.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732181419.git.tanggeliang@kylinos.cn>
References: <cover.1732181419.git.tanggeliang@kylinos.cn>
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
 net/mptcp/bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 02038db59956..89a7a482368d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -252,7 +252,10 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 	if (!msk)
 		return -EINVAL;
 
-	msk_owned_by_me(msk);
+#ifdef CONFIG_LOCKDEP
+	if (!lockdep_sock_is_held((const struct sock *)msk))
+		return -EINVAL;
+#endif
 
 	kit->pos = &msk->conn_list;
 	return 0;
-- 
2.45.2

