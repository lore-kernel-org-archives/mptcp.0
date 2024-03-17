Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137867F6
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637153; cv=none; b=OzlqFcAFcPeZ4my90o3PukB/ClKVI8H7wdDinB2KKfCYG40ZjnRglSAd+oG65Izjch4GirQvbhiR0vepRn1nsyOLdSljMg1QSciNOMdj8P+xLqZEYii6LGe9W89OHaaoXbpAYSJWE1JuErkR95Pu0dhKCBKcd7wk44OKpfTT37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637153; c=relaxed/simple;
	bh=PHGgBhPAa+nMCpggIloVVILtYbouBO1V1vN7WmcEJjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ern6D9XtPpKT28xOQRikzGczlCuAskpi0O2RTJF1S6nFkHOj+triaiCnBymPPuSZq77B86hwDAo7BPtwkUo0muhdTPqU+eVbW+xkVzJTah0+rqxRLl9DlFN/IpyaQqxAnuCKGkOwRn69dAA94jgzAJY5ul7dmrlYZjZEcTtGYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lREDn9J/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lREDn9J/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF80FC433C7;
	Sun, 17 Mar 2024 00:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637152;
	bh=PHGgBhPAa+nMCpggIloVVILtYbouBO1V1vN7WmcEJjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lREDn9J/30jj6q1xURiOyu70cYVla9HRhasulkTMWKp/t420/dF2MDBIGg8mj7Sss
	 dGQsmIJRo1zZXeCo54GlSD2jrNhoWjFlvTul8T6coHgapd4FexaIV7gDXrvYebyS35
	 pQru+4zVO3oYkw3wzrGLUDrkgOFUhoxkbKU7/aD/jGXfJfLTXeL1DgNJw4CSUzCGFt
	 2PEbdCB7GNDdLbc87rCV9o5wQP3NHD89fX92ReF+uo4vXDCdn+B+7q+GX8Xu7hi1Cp
	 fGMZiDf+7PRT0UXEYirEpTw45yJOE/IisS952YyApr+b2GK0XFFjTNaNAybnTxNj4D
	 LCM/ytBAkR+Zg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 12/12] selftests: mptcp: netlink: drop disable=SC2086
Date: Sun, 17 Mar 2024 08:58:11 +0800
Message-Id: <77abb354cfd4e6e519a9e40c66b2caf9d400bdb0.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
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
index b48476d73e9e..e4f5f1f9ab95 100755
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

