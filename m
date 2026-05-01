Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791D3112BD
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656873; cv=none; b=biZc4rieO/0+9aft1sxSfHzzh/zhl6CtpZRFs+XPYBp8qdA5BgZOkZXZprLMCOsMooHWtt09IhbqT4fOl18+ybm9zhr/1c2FIA1dzgbc9zcBqszXKRhnHDLyc398ZzS4gcoVZpMvjAPXdnCVjTHcI5LK+UnC5qCblLpBFeyplqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656873; c=relaxed/simple;
	bh=wwUb3BZyMTTC+Han7DqcnDTy6V9E2tiSwyTfxfNhjeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDpGXmpsoc5J0lOvL50WgIa99FFNIE5/fGK9bDbZJt5jjINqGvvLf4OFluIEESnV/1q+p3UkvLelSbaGM9ymRH2xx2fAc3LjcqFKxoBlROpeYJ8uOug7SKHlATkN64+9qM/DsCETs1A788ME0t7qfSmWsHwrn3vKdRxCK4n7+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvMeUsct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvMeUsct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B003C2BCB9;
	Fri,  1 May 2026 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777656872;
	bh=wwUb3BZyMTTC+Han7DqcnDTy6V9E2tiSwyTfxfNhjeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvMeUsctZPxWK41c7p21bF203yjoYtSJAXeNO9qFQRss+CVQHa31827voP42gZX5B
	 qkVFoed/V86NVOm7DlFc/iz9T2vIMYhr5jZzPjtWIwPOuGXgIPWXvwf4x33SUW/0Da
	 Arnkl8NIIwcIsfkUqiDG1+H5N1kghDQmRpaQZ6d0bAXt5eEcH12b+lVyDEY8FzkM2m
	 nw1eTFPoUPpavBjowO7/zbuDCOi2NmQ7bCxKSW4mkZbIXgCdJkIuThlzzGoXs4/4Hz
	 dOmKx+ZZ/v1ziEfNUBqs3/lkU2wAXR0+vJ+HiCLBJTvQ7gt3/a72T425YSiWiGSJJj
	 UsFtP6QNEt8Yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 19:34:21 +0200
Subject: [PATCH mptcp-next 2/3] selftests: mptcp: simult_flow: test name in
 pcap file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-mptcp-sft-pcap-prefix-v1-2-27affca69415@kernel.org>
References: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
In-Reply-To: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wwUb3BZyMTTC+Han7DqcnDTy6V9E2tiSwyTfxfNhjeo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/PFHhKZ7l7L2+aHvrc8PrfY9LF4o1trXVc8jm8Gj7B
 x5RchLsKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMiNTkaG10VMXn67/+yeMftd
 5NLrS0Um3HQ1fdLf51FjICaxIO8dAyPDhZl8DE/lXRjL0zynzhfTyvEP2i60/5GqU9J2T6WUX+Z
 8AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be able to easily find out which pcap was produced by which test, the
selftest name is now added to the pcap file, similar to the other tests.

While at it, print the prefix name to be able to find which capture
files have been produced by which test after several runs. This prefix
was not printed anywhere before.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d11a8b949aab..2d26d09009f1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -24,6 +24,7 @@ small=""
 sout=""
 cout=""
 capout=""
+capprefix=""
 size=0
 
 usage() {
@@ -70,6 +71,11 @@ setup()
 
 	mptcp_lib_ns_init ns1 ns2 ns3
 
+	if $capture; then
+		capprefix="simult_flows-${ns1:4}"
+		mptcp_lib_pr_info "pcap will have this prefix: ${capprefix}-"
+	fi
+
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
 	ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
@@ -136,14 +142,13 @@ do_transfer()
 
 	if $capture; then
 		local capuser
-		local rndh="${ns1:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
 			capuser="-Z $SUDO_USER"
 		fi
 
-		local capfile="${rndh}-${port}"
+		local capfile="${capprefix}-${port}"
 		local capopt="-i any -s 65535 -B 32768 ${capuser}"
 
 		ip netns exec ${ns3}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >> "${capout}" 2>&1 &

-- 
2.53.0

