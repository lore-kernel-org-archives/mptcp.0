Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E70413220;
	Fri,  8 May 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262044; cv=none; b=Azdim5Efj/DJnDryG2MzsSpaAkvrrmp5q+oCcdYvwyrmrIR+rJKwzL9M51sC8xjfSujhWglxJ0zpS4bzezUTvkCe9S7kow3OGNIBQdxVooL8rjIbwWeLuKFeER93aqs51OFx1xnFLA/yp+XXWqeDO6k6SbPxhMXg6WOvNZVAyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262044; c=relaxed/simple;
	bh=DCMzHqpNNEb72AP94gQCQfS+gUtiYZvhaMQbUzjl7eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzhnUeqz7gJet9DEGUIdirDheB+UAGVRxVYZsFPYcCb65sbd4B++u/Yf2ZO+ni7w3GmTQcq4y3lY0EAGPJtL7CvMfw55YcXxI5llHBqrt78Y8xUhS7GYSIshPgMbLba62Xp1EyvkA2dKd3vLiWKPYU+TyCAVmxT4C9O6D5jmQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2CF+L3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2CF+L3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494FDC2BCC7;
	Fri,  8 May 2026 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262038;
	bh=DCMzHqpNNEb72AP94gQCQfS+gUtiYZvhaMQbUzjl7eY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F2CF+L3llyxvsmMflMfJ7XV6gh0LJ+8yTWhETFLeeBCcjBA/r3QQHw7AxtboHHO+E
	 OIQqUqtLf8VbJC+9coJhHMPUeX3GvX6PDddrCN0aPxxuzHe+2Kzwzg8ddO19KhVYd+
	 CE+P4xOrMYTIxozQNdr+VpIzi92xOnK2SHcM8xl9TdhP574EMxAC9iWKC/6PfZQeVd
	 2j3r5w78rYrr4skxk+t02++FwXIrqVVJ6Bkt7wlo+xyhC8/3l4staWtUdnVWGRw0Ot
	 M4uezGoSpScwPBUOnQQypKOVOJeX0AguCnnzU6OXmauTamRqteEJXIBhX9Mh9mfege
	 hjxQO8mLyeeXg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:51 +0200
Subject: [PATCH net-next 6/8] selftests: mptcp: join: validate 8x8 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-6-c84e3fdf9b6a@kernel.org>
References: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
In-Reply-To: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DCMzHqpNNEb72AP94gQCQfS+gUtiYZvhaMQbUzjl7eY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KbDw6r8o8pSXCC+xm+H6Y3eIA/8sy8JDPrZbOBe3T
 42Vfb6to5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCInJjP84bJMLDgYcm7D//fp
 SemiItd5o6au5k8IMviZfLDzp3JeJSPDVwfThVsmvi/puXRtxqRPt2PXCotPZZTbKnn8xpGSrgO
 RvAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The limits have been recently increased, it is required to validate that
having 64 subflows is allowed.

Here, both the client and the server have 8 network interfaces. The
server has 8 endpoints marked as 'signal' to announce all its v4
addresses. The client also has 8 endpoints, but marked as 'subflow' and
'fullmesh' in order to create 8 subflows to each address announced by
the server. This means 63 additional subflows will be created after the
initial one.

If it is not possible to increase the limits to 64, it means an older
kernel version is being used, and the test is skipped.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 28da9df797ae..c6bb345d056b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -513,6 +513,19 @@ reset_with_tcp_filter()
 	fi
 }
 
+# For kernel supporting limits above 8
+# $1: title ; $2,4: addrs limit ns1,2 ; $3,5: subflows limit ns1,2
+reset_with_high_limits()
+{
+	reset "${1}" || return 1
+
+	if ! pm_nl_set_limits "${ns1}" "${2}" "${3}" 2>/dev/null ||
+	   ! pm_nl_set_limits "${ns2}" "${4}" "${5}" 2>/dev/null; then
+		mark_as_skipped "unable to set the limits to ${*:2}"
+		return 1
+	fi
+}
+
 # $1: err msg
 fail_test()
 {
@@ -3670,6 +3683,21 @@ fullmesh_tests()
 		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
+
+	# fullmesh in 8x8 to create 63 additional subflows
+	if ifaces_nr=8 reset_with_high_limits "fullmesh 8x8" 64 64 64 64; then
+		# higher chance to lose ADD_ADDR: allow retransmissions
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+		local i
+		for i in $(seq 1 8); do
+			pm_nl_add_endpoint $ns2 10.0.$i.2 flags subflow,fullmesh
+			pm_nl_add_endpoint $ns1 10.0.$i.1 flags signal
+		done
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 63 63 63
+	fi
+
 }
 
 fastclose_tests()

-- 
2.53.0

