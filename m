Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FE2D0C98
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173664; cv=none; b=j00EtazfjqTeoXI/0W7E23Q7c0pN8FY4Igdt6ardDzuF3w2wujaFiyjjPHrWxDAnm4hDuZLdukMkHEqTMQfSHWnby+e7cBDBK6vzP03SU8WehEjpFWEBMfq5dWdtah7TAgTvCEx9WwUAFSlx2oZbF8HxVvz/yaltiBVPB3Z+btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173664; c=relaxed/simple;
	bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PU5TQBHG4hnRZouu49KkWag7cPp/uSsUHruh/lqtNLIv3zKrOUFvPiSaHpLZXMGDZTJ/+HdRCBHBA88cQvBxS4SOdHiOjSDY0m/UDmqV2tOdQA31plxP88APULkImFeaI+VoJ4T2QG0z4bNxf63iCglBIm07XUKCgOBzrNW2DHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcYV5FGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcYV5FGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A480AC19425;
	Tue, 14 Apr 2026 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173664;
	bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pcYV5FGOprAmCIESN71X7GKQm318+K5NXUaEP7hzVmeTfKODPt29NRrrJIc+QdCI2
	 f1gvjw+ss+i2qEF71ZbKxA+6Nck5AOX0gAZi1uCjDfkURYSi3ZyNbsYGzMT6loMmVv
	 tZz+OCgcyeZldRWpE9Csqcb9tfoOmS24vzSILK37N+zmeT1Bzz7Gi10ccHHLZhyqjR
	 MvPZ9LxVsjrSROfLj1sOvafASBh2s8AgDTY2lEf/DjCahQ5zeFLctHs02d1M2WfCuo
	 QqtQDz0upCMORwdGmc4FaAKXQOfI4A9urjfN07lSlvDi9aa5R4L8VGNk5ePrGTRQva
	 tzSh63HEH5AZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:09 +0200
Subject: [PATCH mptcp-net v4 16/20] selftests: mptcp: join: allow changing
 ifaces nr per test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-16-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOQXc+RcjavFq0fR7M4x4Qtcs3KcrMetXcuLNW9Fqw
 XYlLXvud5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykXpqR4eCX1FWmdlerJErL
 zqcEH9+7/cDS64zcM7yXXNC4d6nR5hkjw4zA54uYaq5s6jgUubbqa/G9zt2zn/PV7Mtu2nu1hnV
 HOhsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By default, 4 network interfaces are created per subtest in a dedicated
net namespace. Each netns has a dedicated pair of v4 and v6 addresses.
Future tests will need more.

Simply always creating more network interfaces per test will increase
the execution time for all other tests, for no other benefits. So now it
is possible to change this number only when needed, by setting ifaces_nr
when calling 'reset' and 'init_shapers', e.g.

  ifaces_nr=8 reset "Subtest title"
  ifaces_nr=8 init_shapers

Note that it might also be interesting to decrease the default value to
2 to reduce the setup time, especially when a debug kernel config is
being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..28da9df797ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -63,6 +63,7 @@ unset fastclose
 unset fullmesh
 unset speed
 unset bind_addr
+unset ifaces_nr
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -146,7 +147,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -165,7 +166,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done

-- 
2.53.0

