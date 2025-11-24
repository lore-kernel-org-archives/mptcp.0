Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA602F616E
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975595; cv=none; b=TUBn7K7boWuv9msZZAdtqNwuuSFUm55fYPqw7mnbbCfT0aD1jPzmpdQlMjdVqn5l+h1MKATI81KTQ1weWXFhjIc6CjQJHAUtf/qwJrU1x98uuJnHLRRrfmrDRZ3c8tNqnmkFWWIJq/M+W1WdatHVQGWczkOHcuX/xOvjx5wpg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975595; c=relaxed/simple;
	bh=44gKlRmMR6ajeBEiC1QjEWJ6xMmcm6YCUrHn5I5+ad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2lnNZP2OMJ41cVNKxAE1YoRk9D+n9DcOMwW2yPzetkskt+g2wFZdmqMOkp/dJE+slfyOQTVgoS/qygdyLPxgtFUfIoY5KaHImffaRbfeZV5pWDIi+zAb1kzRy7NVBY4trogGK35nrlevjp+2qBmaMIa/l0OAw8j417uGvjuYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwihRulx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwihRulx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7103DC4CEF1;
	Mon, 24 Nov 2025 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975595;
	bh=44gKlRmMR6ajeBEiC1QjEWJ6xMmcm6YCUrHn5I5+ad4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwihRulxPG+tLcYOtlDa50GUQdEZPiaOO7j14CFbyp65pVrvFGSN78ONwgDp+VQuN
	 TaSQsSQuF84H1UQ2d44U9Gd/DHO9lUm9MSnFfrkDyeIdmHWzDzQixbo9zbiWm44waI
	 PMAmYMxES9+KrL08Q1mg2TvNKg70v0RS+AT5sCNh0Zf+cTtcNT0aOvG0EcguNcHbI3
	 W86e9yUjfQl2wMzCTeF8RXVZZX74LoUwAOooeiX6TaL2IJpTcI8vXTD6tt5WSZrKXt
	 NF/10ZtaBLLD4jsq4fm/q8jKmsIaStxkJ2I7UUVsTEKzbACoZrw+t8Bi/a5U8kIeR3
	 ywtNZj8URPEEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v14 8/8] selftests: mptcp: connect: cover splice mode
Date: Mon, 24 Nov 2025 17:12:53 +0800
Message-ID: <fb37b46fa45b91864cbc3b32349698039b154555.1763974740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "splice" alternate mode for mptcp_connect.sh/.c is available now,
this patch adds mptcp_connect_splice.sh to test it in the MPTCP CI by
default.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 15d144a25d82..30d9022119fa 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	mptcp_connect_checksum.sh \
 	mptcp_connect_mmap.sh \
 	mptcp_connect_sendfile.sh \
+	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
new file mode 100755
index 000000000000..241254a966c9
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.43.0

