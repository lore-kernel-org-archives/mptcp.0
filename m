Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716350A73
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832598; cv=none; b=uUA5Onssy35+p6thPOl+j/Nhl5cWamsDm0l5Hpj+YP0zrZHdnlkuQfiXTuzgBFegcKWhadthEUnVkP2lfxuWD3GLfjuPIXLZEY7wsxxbN6NhrHziAZveXiKvjp0a8p3moa+v7Um8D8qKRkmfqq+l322JSrcxFqskftHGHH72XQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832598; c=relaxed/simple;
	bh=wOYdHstZBlRDixFbeYm+z2hxCkdiKiWzlQjPp4d9v7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3qMrPKdmD+z9mTR05TBht9Yb7wb+UIudisZbkb+tHXGEig4YFm+oevmkf2hl25u49yCBKNAJb4tfyM9NJ2wwJBBdD+JRxsyhEsNUNrp6vQidpM7oiCCVmAN071WoNncrHkVpzElUOI46xT7PCGa9O3d2aVyjD1CCJRMjTE58UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7a9Wn5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7a9Wn5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEBFC43399;
	Tue, 19 Mar 2024 07:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832597;
	bh=wOYdHstZBlRDixFbeYm+z2hxCkdiKiWzlQjPp4d9v7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7a9Wn5/D5chX9bsJ/KMj6Agymbe6+ThZRrVyBv+jIPDYsvkw+1+8YegzgPl6eWQm
	 JBVE3wzozETN2F51tZ1QxJJ8BLhnFgU4H2I/kEUJPApAETFrwD5eysOGsp95E+Zck3
	 AVqqIow9YzQcE5baM8QeVqUeJPm8xxCp77e/S9IZo7Szx4jiZELhX/OCAVEHlBVVzK
	 MLUWRyqsdkywV8fDM3H8Kw8o1kI7MZf3O1VCwIMMa/xc4/ctrvDzS4FVyonRFiLwu6
	 oJP+ZrPWz2x40y1i3sWOiIRCZtgOAajGPG98p5UO1IDDHEcHdHsa6JYjcPxN7hhX2w
	 fiqI79VGypnpQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 9/9] selftests: mptcp: netlink: drop disable=SC2086
Date: Tue, 19 Mar 2024 15:16:15 +0800
Message-Id: <36d66268a21905af662a8e9be80e2785c2ee340f.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
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
index f48d13081d5c..155847c720cf 100755
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

