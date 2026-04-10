Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906C3CC9F2
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831538; cv=none; b=lzIy0fwIG44kuApMcpMDb76tedVlHPlwWNjxakAveiOm7FOP6WDHCf5Ylu3alY6KDVyK8aS2s6Gp0WpmNd9s3E7qG6wfAM1yyJc8aedGV0JrXjEzJYO6DHS3M0UlZa2UMIwJAkEhEjxKiaWL6oyuj7Uos0t9n+/iVEBTwdhN5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831538; c=relaxed/simple;
	bh=uY7l/8VcbTjpIuAX6tBgPiQtu2FmTTYndMyn6LRBHHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2SObZxj3Ej2Qbzwf8U3vkC+E3O2ktEKnZ3W95FiRQXSHAAhR7BJ3ZtASNgZsXy+FiZxqFK7sj9NR0Cz+uJ7RgKKk/r0z8ZXHT6DhXdEU4gQ38Wa0flNllbVGSfHtp3qu0OUzU5ePPHQF4uCQy8EBiDCy1QW2zhggFVmqrjPS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpkbOMG8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpkbOMG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CDCC2BCB1;
	Fri, 10 Apr 2026 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831537;
	bh=uY7l/8VcbTjpIuAX6tBgPiQtu2FmTTYndMyn6LRBHHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KpkbOMG87X2JwtVJw6aakD2q6NWc3aeHd7Z0qW3iuJpZ4OL9GJYjm43Q39aMlW2WZ
	 gwezKlRJhoFklctHv9USRVsVtjmlvs31l7RmKRiSSOV/jZbMgIysi4MhZX6wvwGulN
	 7mxxxwOmxCwrJXNiU8DbYhlopCyKcyyTcdeECGcPDQQj/SIStSkuCtRgUaKqFRplY1
	 T7hMoOPnHuTGan9I5hKzAJ6zCT+XU0E8UMSMuXO3tSMv8x+zOSMhz8BwqBJSJV4szQ
	 +MJjmDexvmOILkMoDyGt7kn/nxyzfJng5BJ6uo9DjsK/eq1eW0xJNYiPWgqw2+xrnG
	 /nTE+kpwfPVdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:52 +0200
Subject: [PATCH mptcp-next v2 14/17] selftests: mptcp: join: validate 8x8
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-14-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uY7l/8VcbTjpIuAX6tBgPiQtu2FmTTYndMyn6LRBHHg=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGnZCeShfc2msN5l2PS68447zAYQSbHrmYZ2KG/nqmYsytk8v
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmnZCeQACgkQfCLwwvNHCpetjAD/VNku
 tXtk+64tuD0e9PNkX5PJeJU0h9m16osITDMny7ABAI6oTLOeSb72uLBnlq+y0ojjhvCkXF3htU9
 qqCSBmJcE
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

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 28da9df797ae..8d6a9c031e0e 100755
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
+		# higher chance to loose ADD_ADDR: allow retransmissions
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

