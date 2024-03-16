Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C346BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561100; cv=none; b=elvLDxX29m/JXgLWg7hpsL0KYSZKY2mIII2dgqLH/UopIkR5gmh7hjmh8SKAMUgqRoAEXsMDwmI+3UY/fL4udzHlgKdYE7FK45ccy2Vq8ANnRIev1I0KNRtH01KxIU6uCWKSxnOLutmsZ0R8iC5ECsvbnqUvZWkXjR4WU+Cqaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561100; c=relaxed/simple;
	bh=PHGgBhPAa+nMCpggIloVVILtYbouBO1V1vN7WmcEJjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGSaNyRlmFN/hIU7xWu0X31HSji1/uILDjRQOwTKyb87ul8DqEeJ57whFRpJKDD42fUdsgB7KlYRNb2dWpu7t2TslWJw+cp5wMdTOtWT+StxuXhHreZKHzbtgRqU5dXUiZktxJCbI3Z1IPt5dIdqeUHERcrWAOh+uXXZjnhVJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPOkvoRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPOkvoRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8191EC433C7;
	Sat, 16 Mar 2024 03:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561100;
	bh=PHGgBhPAa+nMCpggIloVVILtYbouBO1V1vN7WmcEJjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPOkvoRyt9zpcHpTboC6sy7HaADjP/JCUo5NsDQicYIZmVpSIEjjf8eKV9OvD9e+D
	 +BCay/JjP7/J0U8qsWSAHSJFPSEUVUIZSsU3FWw5TS0I6/EdUZlroBFJXUaAnVnqOV
	 8+z4uWHe1ssxqOgXZVNQmsoyUv9IIlUMDqK71R7FTJ0MSGylVuCY5UxO2SrrqDEaXX
	 VuXeWfwKmw6/H6j87QL/HbcMZY1eGLABdHMpz3uZB/OqIbyZNSdwX/PcbayS00BSNl
	 jF/YVCfAkWl6nraIf2C7h8WgMd3STYy4RFP07gOwhgzD/3+XvHZAsy7FKkX16FtaKz
	 Sdo24DyhGHS+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 9/9] selftests: mptcp: netlink: drop disable=SC2086
Date: Sat, 16 Mar 2024 11:50:37 +0800
Message-Id: <684b53f36e84de0281604d06045facde8b02a733.1710560839.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710560839.git.tanggeliang@kylinos.cn>
References: <cover.1710560839.git.tanggeliang@kylinos.cn>
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

