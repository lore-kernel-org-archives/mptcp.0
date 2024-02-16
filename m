Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59921CD11
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077049; cv=none; b=WjTQ6n770cb6K8NvZ3E//C/xiU0PSgxukqLUMt+ibUtPkB4zz7bDoaAw81UzP6Y60D3Z59rBRXBpOU/I8n9zcQQuhiKpy4SQyi5wU22CTYNfcumX8YQk00XPvismnISfQTRLLQBYS191X7BxM0IanvBA7Eix6bEWZ+HR4VKjP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077049; c=relaxed/simple;
	bh=lsy3LIvhqJZia+KnWNVSp/SgePLLwRZCUFDg5ixsKMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nCwr2hSM3gqJ1rEgI3OZA3Q24ov0rRT0Sf/kZSv+DzSMnP/LgNOLmBN2aMwzVr1FYr1JIT8iWlVabAB/FfGJtOXIlGYb4ccRxQb/cKC9vc4UsNjCa19Oa0otXFvP60JlCChd9TU9POb5cEnZiq4gos2ywG0ZnZ1qaaiXldruh8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrE2Ha2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrE2Ha2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DEEC4166C;
	Fri, 16 Feb 2024 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077048;
	bh=lsy3LIvhqJZia+KnWNVSp/SgePLLwRZCUFDg5ixsKMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrE2Ha2FJMEwsraDL3VcFtZeik13n7l0AJV1HrmrZP6vG5KqSN+1NQccsXBm1A5l6
	 2b445rg8FvRCkWjrb6k6PMfFriYG/PBMMPx9i9vXT+UdeNZ/dW3LfBaSCb1TOCRu/Y
	 aDiUkWFYFaWCQgVw3fsteI/h2RXBglpL8RUQa1VAv5JmfS2WpEyNUuqtDsC/qNmUzs
	 0S3DVoqO6sJTYl294xznhRwJgEuA5dB58qI50oRnGUxRqtWOvJu0SreMQshcSL9JVF
	 i8JY/lwn0PZTvwny5wsswEU+IoRoybO4QZQp0mbTrh4vV3NqZQQXiCJcE18qvycIwY
	 ynx3hg75SiLFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/7] selftests: mptcp: netlink: drop duplicate var ret
Date: Fri, 16 Feb 2024 17:50:29 +0800
Message-Id: <623ec6c806020fa46fd2c564b1e8bb9f35e20840.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 71899a3ffa7a..ebfefae71e13 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -28,7 +28,6 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 err=$(mktemp)
-ret=0
 
 cleanup()
 {
-- 
2.40.1

