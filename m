Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444622EFB
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940618; cv=none; b=kV1YkAbE7n4agV0C2ev6xfRtgKfV3pU0FXf/CzOZi6P22RC3pr4nO0K9v5akDKaDmAyhP/2g1BSlKG5knLT7XYo4m5JQivNa2F44PMHM2glFHf2evJd/oyhiGUZG7oIl8puqt2uk4tCT0VtHeXWJ1QIONkU4m0q1t+hYthLv4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940618; c=relaxed/simple;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9s7Jn/10Fjtk41SRf1qye7QUwryXBwlXFOmiUauzPGPF3UjsEMY3JYYmAaQ1D/O5CfdHBaOfNMxZIU2Xm5iGgTt48KTMvPfhZvVcG1Yl04XRfrpLqhK74MRNh7IF8S4QWtTL3Dh5F0+H0f7rmgeOPeWP2OGcQ+PBeL9JLXl6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAa5xido; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAa5xido"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B32DC433C7;
	Mon, 26 Feb 2024 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940618;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAa5xidoR+OBdNjjupaBuRHV6CFp4Ddto8CNYV88BAv+NiCCJDNyiLIp8yEfNLKN9
	 KTCrwzSsqb6xvP1IrsZ2EaFLCuxz8meKeLVZ2BRPGFXgy8i28AX8IxTtpwZaKkL7Jz
	 pwobIpXrnO7dh7HCpqZzMnPw/InZbJNeCuTiC/g5GzjhZTA8ploM8VEmt4fNAVPDE5
	 rcMi3sKp681vSFXHfTfopfbpSvykmBE+qmt2cxALotwiPkNsBHrfbC8kFow9SFqLuf
	 urUneZsEvXR+uVtIpC7oJmSzHBBh4eFDVKEPHrGbaX7g+yiTJhw3f7P5kbZ5RIZ/pr
	 Ugb2fy4+vPQBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 05/12] selftests: mptcp: connect: add dedicated port counter
Date: Mon, 26 Feb 2024 17:43:16 +0800
Message-Id: <932e4723bdbe01f37eb0f65e04f01a40ec7dd780.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
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

