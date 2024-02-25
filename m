Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007410A3C
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866257; cv=none; b=m8qVxtI8EmEumy1nb4yMYbRz4AmYq5CCtyoVPEBcxxRf5w0s7quOgO7lvogY+oMRDIf3oLRtSq7rHXEHJKxIg7L0unTlvEziJ7fbysNLGUxwUaY0i/5vm5Lj0vjA8QjYVJQjxy0i/2bRlp0C3pkLsjj143pc9ok1W9XMepu2B0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866257; c=relaxed/simple;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raFgCIn2Yc9ttJq42Ln5bBRZWxIir9R4SZMON3L5wkGPg15n1rE66fSZMp24dLR8NceatRk5C3R0Uj7eqRyHGvWk+q18VVddRiVNuP33Q5tfL7COrBpU7deIt2tw4SwXKbnIpOSPY2nMpYDtu1CeK2otFC86LVIZbBaMK1GUsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWddSwJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWddSwJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6F4C433F1;
	Sun, 25 Feb 2024 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866256;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWddSwJHoJWTlMTAfeXDTFoCG9QQlxdbIKGZBqaUjW5suHv1ZeZAZT5TyS4CfxY4h
	 oYZttF1UKHlfK/SDriB3Ox7JiM3ABXvUExyLq29DupJXBKU1zbHMwDzoTsq0ot3EIh
	 q/nygYawG/db0braPT4pOS24BJUc/TbCANsFidZ1wk+e2BCbpInkUqI18wLjXsOxK0
	 6v2gzVlOUkYhjDTiOUNokVH6xuCB4eifA2ZXSILIKBnkmFiGxxW5v0B59bZRKqbiuT
	 a5olw0vGaD0R9ajXU+Ce24EIwAjqK9w2omjzHIxoLa+qaYqJDpBPX3yFNg4FWf+A+Q
	 vCuN/mQns0Zow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/13] selftests: mptcp: connect: add dedicated port counter
Date: Sun, 25 Feb 2024 21:03:53 +0800
Message-Id: <932e4723bdbe01f37eb0f65e04f01a40ec7dd780.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708866087.git.tanggeliang@kylinos.cn>
References: <cover.1708866087.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c7483902026b..68073b255983 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -317,7 +318,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -712,7 +713,7 @@ EOF
 
 	mptcp_lib_print_info "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

