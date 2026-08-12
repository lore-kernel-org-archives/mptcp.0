Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641946F496;
	Wed, 12 Aug 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546590; cv=none; b=rCVeaCIkpKafwhNNLUCe1F4aqyP2dpnBLteJWkweIlBYgsvb2/HroCuClH2M9IFZxeROY8EGzhfxw0buL2JWHuxhWgy77jnoFLwvqtRPCITXCcd3m3f7RH2f3DQH4qOH5o5mgSMF27hdgr8CEaMf8BKfdxLlGY2G8HEdaJ+0dfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546590; c=relaxed/simple;
	bh=cuNOESNy/WTkiZBwkZbo/pzBIRAdYpOMb4gpizZ/7Nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptwwGVTBCscuJpUAKHVSzLvbaCVgaSEkLaWHfJayLqjgHMXT4sYuWbC08ztABdV0Lrsr6TeESBpZEJXbXNgSd+Mggbe0hzCO1KIW/Mre6ehMOjyeVfXtrspf2KnBPKDbujwkST3LG4mvUfnkyfK4+4iUAbSXLmceMsoJI3tyOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMoYA6lF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMoYA6lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9291F00A3D;
	Wed, 12 Aug 2026 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546577;
	bh=eDfXtKVcaOGNG9KazWljQpgi3UNwtob5VzSegX5vxac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gMoYA6lFUa62lq/OcsusmYBlCcTvvwUcLI1djq3sXenXY7ZpPVkXDm48t6eAdF3Ph
	 nRHP2bgiOSzjN7XD4tENgZtWWd7ghkuxbh5e5iZL4LazaNpW05O0P4opyIJek2AbKO
	 ScFn3BZv0Z6iRXKPcZ/outI52Snfy3MdSE6MQ3UNE+P+yVTsKjzD9j/ALXQBXSVu4h
	 x4T5b5EFBFCtpO0vqOarZZLN8c6z6lKQKokJQ06VQPKSUtiFE4+hnKO0XIKTRoU14l
	 8Yjh0tQAzyxLI6EcpVErTYGydq6c9UXYSfK+Zm3WGF75AuDrpCU3DOA5mXJ6kuovYO
	 LIH1O9O5qoSXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:43 +0200
Subject: [PATCH net-next 08/11] selftests: mptcp: simult_flow: test name in
 pcap file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-8-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cuNOESNy/WTkiZBwkZbo/pzBIRAdYpOMb4gpizZ/7Nk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOssbpuZ7PA2Wdb9muv5dyIr6GKlJEqvkZj1m/dXCz
 7luw0rhjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkUxzMy3M+7y/B4jVV7sSp3
 vPPpq8snvV17RKeFd8JJw8x6ka+JPxn+cM407Ly5ZQfjr3tn7hz9r1h75pUSy5FVSzUylsm+4ry
 /kA8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be able to easily find out which pcap was produced by which test, the
selftest name is now added to the pcap file, similar to the other tests.

While at it, print the prefix name to be able to find which capture
files have been produced by which test after several runs. This prefix
was not printed anywhere before.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7b9aabe10170..d723261bdc62 100755
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

