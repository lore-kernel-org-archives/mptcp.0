Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD22D4B57
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083023; cv=none; b=gn2bykVEz3MPrm2IFgQNLayWIfeN0xoY1y5prEKTIIj5z73v1OsYDeqTJDtcEbRzxAN+ScmkDHY0+4R+e78FR+xBHicHsIvu5JqfqJlKmaNRaLR2eBT1VcUXcTX0PJ7xtZ88U+tzho4TOa+s3zzRYGv6/L8PPP72ix/XCTZaZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083023; c=relaxed/simple;
	bh=Z/5W2x7rJRFgws1zoyWeVLKH2bwRKGy6TKM2NYw94wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7QUc6pQfJ/AthjCpxn7vIj2/hokHwNCZSXZMJ+adP2Itu6u00kfeFrlZeJrzvKHPCE5wTvNw3rdLzChNI0Ngjh+PVRGdhL5hwcHjLbQsjAMBckIqNWravC9GNqSRpn8Zb6K+II6LCEK8KFA8IiqJiwDmuy+EvCeTrsVZQKIRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anot0GBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anot0GBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494C1C116C6;
	Sun,  2 Nov 2025 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083022;
	bh=Z/5W2x7rJRFgws1zoyWeVLKH2bwRKGy6TKM2NYw94wY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Anot0GBDSdlXYTOkcRPHd2Bt6lec1Ljd5UELH+fpR2No5bMGWj675OnBVHfWozFli
	 rPVJtdE/JmgYvO6sN6NAx6qX5J0FTcEC96t/y+gvuhYdmsnJn7YM1DFP9WnwiRF7cQ
	 gZj9YG4nXZU7Y1QPm31aLKBLzP+t4CNwh8JqAdvBQHdNnhelwdYkRBevd0umfxq5mQ
	 QOWuP7Ndatfpx/bibtRjXpvx3bCr/G/3VMY33yIbrHFx8w8D0A7tOOwBKFaNGn8VRX
	 4f4/1RxnWJmwFMLBOnDCKKoP7L7Ruhg3Sm1LErZBZ9vFTWtayN+lJTC3Iad7dbNoIY
	 y6FuMeCPeNv6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Nov 2025 12:30:03 +0100
Subject: [PATCH mptcp-net v2 1/6] selftests: mptcp: connect: fix fallback
 note due to OoO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-slft-join-inst-v2-1-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z/5W2x7rJRFgws1zoyWeVLKH2bwRKGy6TKM2NYw94wY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHY51BRm83R17Q/4yy6mm81UC/LYBfEYX1p5a96i/Z
 oLlKyGzjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImohjAyHFDLkd7i/ofhy1nX
 BWtmn1lzSszweCLbRf2422/tKk0jmxkZPk04v/fCryktm2VU/8+1e/QlxuOJK4d/u4lZxpp/Dgw
 HWAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "fallback due to TCP OoO" was never printed because the stat_ooo_now
variable was checked twice: once in the parent if-statement, and one in
the child one. The second condition was then always true then, and the
'else' branch was never taken.

The idea is that when there are more ACK + MP_CAPABLE than expected, the
test either fails if there was no out of order packets, or a notice is
printed.

Fixes: 69ca3d29a755 ("mptcp: update selftest for fallback due to OoO")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 47ecb5b3836e..9b7b93f8eb0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -492,7 +492,7 @@ do_transfer()
 				  "than expected (${expect_synrx})"
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
 					  "than expected (${expect_ackrx})"

-- 
2.51.0

