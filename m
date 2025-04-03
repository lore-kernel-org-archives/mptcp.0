Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B36166F29
	for <mptcp@lists.linux.dev>; Thu,  3 Apr 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666403; cv=none; b=t89O5EEFV7cHL1BWXjaekYf93TfwNRrry3dvBucQO46V5eLk9H7qGxCvVKLZKz/41jl0QOwjDmMrbfHAUlw4pWiob268SE5z0KZ3ueYBcvl8Nk/uqQSSqN/lsbZuoFH5TY792yEP0Mr1jhhGSPDk+lH/4D8896bqYsTlgP98TS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666403; c=relaxed/simple;
	bh=Txo4XQWGfg41OvDseKNrPKQZdvych9r0Xi76mBO2NVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtGvyeHokhTvRHejEM9cI5J4tx1MGKfJhqvC+6nsPXqvC6JHgwF00Mx/pzA0eoeHb6PpGh+tJTsvqecDP8mwq8n584C+5tAJD8T/3VjoxS/6kyGg2QWG5skzooLhrAPPtdUWCZSrR6myRHY47fz4e+uvXuXt/cQ4o3w4VeXw8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSS/MaAp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSS/MaAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB60C4CEE3;
	Thu,  3 Apr 2025 07:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743666402;
	bh=Txo4XQWGfg41OvDseKNrPKQZdvych9r0Xi76mBO2NVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qSS/MaApW1B7T1cxXWQj6SYy+fA3jwCCuGoJWTxpY+y1fg8mrYmm2MzCaWvuGiyw8
	 RdIjBeqbyFTT/kn9f+/07/6fK9T6/C8VPiIEFU60nhi1ztY0DFmJxuCsB25bCiTVsI
	 UUawVqzHcRPFQJH2bpHPd+d4GPcDJYmLTQPUkX0O1auZCjBmkNZ5ei/GLQzCBpcvp9
	 4IH32E7sOiPqnhjDXwk6LTbR/4czM7UIlu46R+dXHB/hhLsfsWCOF9mxeXtVlc4No3
	 xB63IJ3fTol7qEsbnTswVwzVbB3f5gI+tni5j5uAgSkVu+1thj1UWu4vrAdBCwmJrQ
	 q13715eIMvwmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: diag: use mptcp_lib_get_info_value
Date: Thu,  3 Apr 2025 15:46:37 +0800
Message-ID: <e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When running diag.sh in a loop, chk_dump_one will report the following
"grep: write error":

 13 ....chk 2 cestab                                  [ OK ]
 grep: write error
 14 ....chk dump_one                                  [ OK ]
 15 ....chk 2->0 msk in use after flush               [ OK ]
 16 ....chk 2->0 cestab after flush                   [ OK ]

This error is caused by a broken pipe. When the output of 'ss' is processed
by grep, 'head -n 1' will exit immediately after getting the first line,
causing the subsequent pipe to close. At this time, if 'grep' is still
trying to write data to the closed pipe, it will trigger a SIGPIPE signal,
causing a write error.

One solution is not to use this problematic "head -n 1" command, but to use
mptcp_lib_get_info_value() helper defined in mptcp_lib.sh to get the value
of 'token'.

Fixes: ba2400166570 ("selftests: mptcp: add a test for mptcp_diag_dump_one")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4f55477ffe08..e7a75341f0f3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -206,9 +206,8 @@ chk_dump_one()
 	local token
 	local msg
 
-	ss_token="$(ss -inmHMN $ns | grep 'token:' |\
-		    head -n 1 |\
-		    sed 's/.*token:\([0-9a-f]*\).*/\1/')"
+	ss_token="$(ss -inmHMN $ns |
+		    mptcp_lib_get_info_value "token" "token")"
 
 	token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
 		 awk -F':[ \t]+' '/^token/ {print $2}')"
-- 
2.43.0

