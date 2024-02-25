Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30800DDC9
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852408; cv=none; b=W1jg8YYzIcS1QjE7grvxPqnMDxhei7DgjP/NFOZTQFS2PZ9is50SLxOtNDPIdInngouJizRql7HG9JmXDTSplsjQcEOA35ZISAMaj6tc8Tbbl7fw8ZvJSxYXPtgWYyVknGZcmdOdtW202uFVR5M2zma2ZmOZ9QWcxTHo1vBgTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852408; c=relaxed/simple;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdXJG/1+s6fJURFKoCXnIcqw6qO+OO7UYLGCHG0HtJIn5U3tfuhtpFZCoKuxucUoYyLBLaP4tBUrf7mrz8R33t19ikiMSMMVO439jfNfGRGkRwn4GICzMX+6a76l1DEUxGNjS/vt2rsJ11ewbQ3Ccst+UNU3UZcacpyTuNBZuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6MkgQLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6MkgQLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C720DC433C7;
	Sun, 25 Feb 2024 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852407;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6MkgQLAwXJrsjFt0TZI/nA2Vu7WgpIZvm5/FICU98U8QVYJdi98pWdJ/MCkxyQ91
	 Qs9W32lpocBp9n7U5EjpzF7xQ55D4jUFvztoth4VbvgoYKMriEYlYj5T2PvBlt6sFS
	 SAY0N0lRY+HRYgz/bCQDOutz988k8GrRr/A74vn73JcusQHqsUap3zInnjc5gFBXiC
	 H4mGFFPMMeRDF/bPggu1wNz8Dev1s091Nn73hRSngkmGXj83u1ngCuklWQ5ucVAAkl
	 QygPgP3nlyJMmIZ5+58T/W36J0vZmlr14DeNdAu92GvSsIkxixxc6gHRSLq5W4CvMN
	 I4UV3RSSwELoA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 05/13] selftests: mptcp: connect: add dedicated port counter
Date: Sun, 25 Feb 2024 17:12:26 +0800
Message-Id: <932e4723bdbe01f37eb0f65e04f01a40ec7dd780.1708852208.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708852208.git.tanggeliang@kylinos.cn>
References: <cover.1708852208.git.tanggeliang@kylinos.cn>
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

