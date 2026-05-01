Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F743112BD
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656872; cv=none; b=tIedZ7aNwyxiXpfk5CRnpi0Oa/JT8wCCBHz1tYbXOpCDp3+qpZiQdRYuCF7MC4DMP6xthzz3BK/FRucaeTi3/grOWH7XLnBHAwmWG0MOssRHd7FOKb37r9z/6xyhTq5E3iNBkVdLT+J49UmvQdKH0gjlUU5DFZHw3JsDgtWRmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656872; c=relaxed/simple;
	bh=niaY+FAzSqhTDSuqgiFnjRSQP8WL3tuWBm04LgGYpjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYmY31ezJAxL7KvBqCmo0PbNKahB5o0nM4Dldu+3pRsDB5R/L8znQZU0wcW8gUbzvH1Qy87ZVrqffqOyIAvFGpE7fdjIpk3oMWZY8GKBtBOEFkcFvk80lXzI3lqQmsMJjGMq4+l8KeByn3UPbkhYisoQOFrzJNWcgV4tWiFkNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INzieP5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INzieP5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93665C2BCC6;
	Fri,  1 May 2026 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777656872;
	bh=niaY+FAzSqhTDSuqgiFnjRSQP8WL3tuWBm04LgGYpjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=INzieP5CAtlSvV6Vu7RsUQp4KQJ07PO9vM2aFEuAjw8JKXwe4TrILKXSS6SzL9T6C
	 nYLYIZK0LHV/buB4flrOc4Ad7BCbU6WFEhQ36dKrlh+r1cZB0CKpeNYvSepCOZW57j
	 ouBaKVnGqn6TEqdZiRUOkB/it4S+OZCCgkRO42b5Ljng44oOf7h8FaiQUgePh6aYrH
	 uoTXo9Z2IevqaPBawV4IMNT4M3Ags6ciB0pekH6yqTlgfoueqBT1uHHhcsYvo/kcKF
	 5bUmRp2CEgZnL/mRO35w8mGg+jFUK5hiuPBTCiXqW/DmVYRhLugNz0cSn1vVGy1VmS
	 hhU6UCSJQ/jsA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 19:34:20 +0200
Subject: [PATCH mptcp-next 1/3] selftests: mptcp: connect: test name in
 pcap file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-mptcp-sft-pcap-prefix-v1-1-27affca69415@kernel.org>
References: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
In-Reply-To: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=niaY+FAzSqhTDSuqgiFnjRSQP8WL3tuWBm04LgGYpjU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/PFF2s+LgKJgqurL3h9WHDV/ae4smab8vfrTdhDPwz
 IrlrI9Pd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykKJ7hr1wmj37OnjX8CWUV
 87OVTnCoLf5VzjhDe/OaY1EiB2+LijEyrJSQ/eTV0mR+81PE+odPnbo3qm2bv3Z9GuvL/KAIyfk
 xjAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Even if the pcap prefix is printed in the test, it is clearer if this
prefix also include the test name: mptcp_connect.

With this, it is easily possible to find out which pcap was produced by
which test, and easily delete the right ones.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a6447f7a31fe..091edee9a7bf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -212,8 +212,8 @@ if $checksum; then
 fi
 
 if $capture; then
-	rndh="${ns1:4}"
-	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
+	capprefix="mptcp_connect-${ns1:4}"
+	mptcp_lib_pr_info "pcap will have this prefix: ${capprefix}-"
 fi
 
 set_ethtool_flags() {
@@ -372,7 +372,7 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		local capfile="${rndh}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
+		local capfile="${capprefix}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
 		local capopt="-i any -s 65535 -B 32768 ${capuser}"
 
 		ip netns exec ${listener_ns} tcpdump ${capopt} \

-- 
2.53.0

