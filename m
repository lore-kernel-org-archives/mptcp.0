Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD40B64A
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709466786; cv=none; b=SlTj51jzZuhuwLMdzLVFlv14yu25HhJPoXjRmWCuGfgnxIE7Gpw45VhtGhniXo4bIY7ylxoGEXv1sOYh3tSvu51QUR4pT6WNCr3eZZDZ1Jlac3isLVmMbAKHFPzy3+yUWresf23yeDgBTsskWgc5ZQwqFKZ7KHw2UVloP8XiMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709466786; c=relaxed/simple;
	bh=m/ng5Hmom9GXRQpBtfcUC4cEsGR6YaD99kANdvrQIG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mphTkiLqzAJXpninR45Ie3SN5eikr+mJZxhALKv30JCN9QU6225G/Smj6bBPIBPmLZc/kkhkbbNLWZLsaUfv2OQrEA6OG2tPl4vssxJB57TKfQUXmj7aS/0wyjPZZi4o5VB2Sd3A35fHddKpADgTy48UZCGlmdDY6rH6kaAobEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmqLCZg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmqLCZg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBAAC433F1;
	Sun,  3 Mar 2024 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709466786;
	bh=m/ng5Hmom9GXRQpBtfcUC4cEsGR6YaD99kANdvrQIG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmqLCZg/JEE14xFCL1n1JO0JhEiVLEsNf3IEkgjaaJ+Y2VqzpgiomM3DBqFHuEXQq
	 p+a5L4AnVSPf6OC+ZwokdhvOSr4IhVFFUM7RohpasnUHB4wSihV3bguHfIxEfP1QN+
	 D9KsXJ8NsalNXrPrfbTKxPLs94CI1Wsd1oPO623YlI6/FwKvfMAf492hZ/XwvXmbtT
	 sFaolQCKG3NgksNx6vBywuL/XBpaL5jVlHolHZ8vaSITHhWzwhOft8aWixN4pcPCTb
	 y6hbpQg+SjTRhpuMHslnNbvxn13NFUf0rII3CCtz0WalqpIt7ehDVEdiI6lzwBCTNE
	 gyVkBBAY8weQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 2/8] selftests: mptcp: connect: add dedicated port counter
Date: Sun,  3 Mar 2024 19:52:51 +0800
Message-Id: <b810e5d5afb5821caab1c309898b93da909f11cf.1709466624.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709466624.git.tanggeliang@kylinos.cn>
References: <cover.1709466624.git.tanggeliang@kylinos.cn>
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
index 679e366c8f6b..30f44900ad38 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

