Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7413D75C3
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089538; cv=none; b=P8dFFbqpESfzrjnD9PasBLiDlNWupPc9odpItpwub/e5VRgp0FwSJV0nNBD17yuMRQ/tDJ1c0x65zTbSqAQZ+LAbrkSJtFn537Grc3ErclwMC/2Be3snvjnNM21v9WseJ5DDEHt+xsAKTBgT78fdjQbelHpUlqARnFMSy3zsV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089538; c=relaxed/simple;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naPAk8hGu/xytYVXtDRvdcZxkW4hu7BWETs0MBX6X+hv9FkfuUOx46AR+PLmCqWJuO88Fg02kIbUz+DTQJIAQreD5MQaFaLM9z9ePU1Na9gt75mh1tDziCQCNgXf+3bWgG24Nqdw066Obp9A3W2nedN8rtg5wReOsSLvDDfVsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syGrLJEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syGrLJEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50635C2BCB6;
	Mon, 13 Apr 2026 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089538;
	bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=syGrLJEvv8uXO076uWMXl2eO3+bOLvXtJaVTAaP23QmMP+r05dsCGjO+SwZ158KJU
	 yXfMpZJ9tW/bwJi4ctA325xUl5/G/u70E6j5l3V3wfxXwt8zoFQkI8zfQNcWtoz3zj
	 CS3baqkhDml7hAY0JovRGSmYcpdDjnYXHR1+TU5l0f2zXXuYvqSZTchjyz/RksePxy
	 rVrvjZnfS9Mg7QX2W7Lek+0kmU0d4GCwuRnSS5TYH5ErW6SVoy5UwkrCTA6bZiXa7W
	 F38OELprs59zhQdVkenuF8yMStqP+ZA8SOTgo98wK6CVpMAx210ce5Q8p5aVIS/tOd
	 px6wKj5aXLGgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:12:02 +0200
Subject: [PATCH mptcp-net v3 16/19] selftests: mptcp: join: validate 8x8
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-16-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+qaBdb9rEAmToN4IiTNcZrtY6yqx3a4Lvoh95OjNc1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Nxs5h2eeaP2lLxz3mLfbW9tJVP+qTfmT2Zx3Bef8
 GR+t5prRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETezmFkOFj+s3nq9BOKkf3P
 5jr+e8L/p0bCRDn7Dd9Te97+qDopaYb/rr3X9OXfPPqXsiHVzrFw45SCaXJfd1ixScecSXCTNDB
 iAgA=
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

