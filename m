Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8CF10E3
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121751; cv=none; b=YZuJnxfSsgvYnOq3xr0leM2T2H0VyHNSoqk/1x3VkK8yQNfJqAK+LW3ulhhN+yKPyMLeVNAJ8UL6CZvtVWLkX0MpUnRkyRsb2PCXdANgNEmeEO4ZK7A8jmgglElGU+HuWyj5h3ZQNSOt31j6lykjS0JIzs/nqnQAwsGao99vGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121751; c=relaxed/simple;
	bh=DOpc9WUOYPRbRlA0LWYnheRhGEqnvqhVY/JgE2gnbXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiM/r35sQWaNR4npxmm9j/itACYXkpSP/7pOhPZahTAoUHjzQCW7WRzox5IhtW4dbLuL/A4NvJSjF00SJWVwG9jyC04ioCRryc34u3kjolmKXTlirZKA6oPwtUmwy3deZ0YMAzgEJJQclSXW19USJs1mNE0lOGQJG9lue/5Y/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRjo8ynT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRjo8ynT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118CBC433C7;
	Mon, 11 Mar 2024 01:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121751;
	bh=DOpc9WUOYPRbRlA0LWYnheRhGEqnvqhVY/JgE2gnbXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRjo8ynTIfy6gxoo5e6fcGFLTW85vyRPoW9eXCuMn47Tzxx69ub/OEB8bQpJ4e+G6
	 iRSdGRzbee7WGAxVqwVNjUmN+KlaQ/x2N7Y0UQQU83cNm6FVHc5feDooNA59usKa+5
	 5bfXrrj2cxDFQ821qjHgo4AgJrcfEmVhaWlmBa3SzM2FXwXY4X66ydT5suBBS6l2et
	 b4oIkjBvURFoUibi/9OgtTYUVp9lKbJqt1e82NOCYX584gQSTEH/1XzbawnfEcJKWq
	 cux72yKRQOoEAEqx3Br1867i44ZX91JbP+XZ312aJCeJr/1QJzurhyOC0y61s0ZCdC
	 B4su0VDWWLsDA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 10/10] selftests: mptcp: netlink: drop disable=SC2086
Date: Mon, 11 Mar 2024 09:48:47 +0800
Message-Id: <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now there are only a few of variables are not using double quotes.
Modifying them, then "shellcheck disable=SC2086" can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 5cffc748ee2f..ad9c63af3f7d 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,11 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Double quotes to prevent globbing and word splitting is recommended in new
-# code but we accept it, especially because there were too many before having
-# address all other issues detected by shellcheck.
-#shellcheck disable=SC2086
-
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
@@ -20,14 +15,14 @@ optstring=hi
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
-		usage $0
+		usage "$0"
 		exit ${KSFT_PASS}
 		;;
 	"i")
 		mptcp_lib_set_ip_mptcp
 		;;
 	"?")
-		usage $0
+		usage "$0"
 		exit ${KSFT_FAIL}
 		;;
 	esac
@@ -40,7 +35,7 @@ err=$(mktemp)
 #shellcheck disable=SC2317
 cleanup()
 {
-	rm -f $err
+	rm -f "${err}"
 	mptcp_lib_ns_exit "${ns1}"
 }
 
-- 
2.40.1

