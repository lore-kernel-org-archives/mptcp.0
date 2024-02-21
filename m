Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790743B297
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496612; cv=none; b=ByQDCf5SXTILfHXOHb1cwSwStw+XSAAIncJo749NQ+ttkE/3X/Y3GHz0JyiUW6lfssxrqsCNgsdFJ8jGywvreKN3N1O+vdqeBUzWuP5TtbTgJTdOL5lLVOfSUnmrrD3b8AGHJlExZWLG9kv6CS/SaEOcydLkY20K+XDfZp9jeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496612; c=relaxed/simple;
	bh=hFDmwvYqLJ+IXscibcUN069qhKRMAEVbtEXrUs1AQMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HINmEVJHteSNK/JbZSYvTUMmDqMaiu/4fDKcbR7b/Hz631VIFEGYVbo4iJg0xoCpPnUeDVKyNXeVL+SWX9wx0JLZkTJaOVJTDwx0ZttDuWa2IJvm4grKNTOSpDysouMbn2e1Z+baDVBPVY8XwGFKGtGBxhRJVQ9tfjxx+zk7CEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCg2i7gB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCg2i7gB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F26C433C7;
	Wed, 21 Feb 2024 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708496612;
	bh=hFDmwvYqLJ+IXscibcUN069qhKRMAEVbtEXrUs1AQMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCg2i7gB2j7PbIYw8UbDwxAowEAf02uSz9g4F8xY1+KL51mN9tKwivgTn8WqeP+iF
	 +4uXlO301s9/FmZLwZXmcvszL7XNgYaYx+DAs1EbvtFyVSulz5mEL3PhMGQMsqMpG+
	 RMOY7m7GtjDIwN1SE5iVnAURvgwL44/F6oD93JxSjHRqzokm99cy+StRRCP0o951tz
	 qdyR9YYwLfbbsQ5LTxrOKiDFZhTpA+f40yNTIwoc/EwqNj9j7Jl8AE8UTAbW6yTiZw
	 am4XpTt1GB7Jx/krVEOQTxJyCaQdPLfEG21z5WekN+fRs14/Z0XBvPwSCPcjS6yOwJ
	 VWZCF/3oSeXIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] selftests: mptcp: connect: add local variable rndh
Date: Wed, 21 Feb 2024 14:23:22 +0800
Message-Id: <988f6a8a65c7332c33ec722bb43b21b78a2d7345.1708496523.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708496523.git.tanggeliang@kylinos.cn>
References: <cover.1708496523.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a local variable rndh in do_transfer(), setting it with
${connector_ns:4}, not the global variable rndh. The global one is hidden
in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ea52110c3fbc..b609649311f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -348,6 +348,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
-- 
2.40.1

