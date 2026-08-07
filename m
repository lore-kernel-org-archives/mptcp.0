Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627041835A
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092129; cv=none; b=QCkDPKqnQp+lEeiLD/7JYLLofBuZtjiKlwWd4vNXNpT3zDx2CilpvhALcAIprwHjFY+sQ0ghPK6Fu4PeZW33wCceabSV72dzcIujsW1GRcTbK5UAdXuxzSovhiDT9NQSXMQrFDYo0X/rUKwUwmlWO2Sby1uNPiGjCfBPh/neWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092129; c=relaxed/simple;
	bh=1l2BrGr9D/QMBsvEatr2e8K8+KHsAP3MHOIJ7Ihr8S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEQocHmL8CrbGlWs9gvrHSuGmUsctUbXPX/94v44ynqBOb8kav4UTAq2PXCb6I8ZkgqkI95SYTigD0Satsa0MRE0Q1Yqoeo6y3DGs+QSiaAcNbyl8BYVOGxdwog2CSFjJnKlc9DjQaqldvPrhSUJHGSnsOWaKx74uf4kRuEluT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhvnuaTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhvnuaTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EA81F000E9;
	Fri,  7 Aug 2026 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092126;
	bh=sHPVh6MsIT/s+4EMlZhmg8CEKL4NWWGYMsxIK5TzmKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HhvnuaTfaYlsZji2Byc+XsWTjDUkeOUnkqnqCOCQ5HbiUi1/iIwprRciz0aVAFMQ9
	 fuJ/q1I8TFlqoTE7/5FPIvvUuUFaUkMVW5qYqXVS6P600RNVvoSBASXIDy4kF0yKef
	 HR6N4RaEpMVIi22AfDmWCnsD1Io2hhZnp41GibNP+igQ4Tbx/vreqkz3fwLCfy7tnE
	 zgwMcOWyM5qaA3X9gQsJeI3WHPV8Mrx35imv48hhZGoL8C5g4pfX6Nwc98C0MxPABE
	 i7p5w75kKgGiBk91mEWtCElXUrBSWlqCJLcJWXbuzZhabFtxECPrPQdKu3NX22M4ba
	 gHRRlNC064PRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:54 +0200
Subject: [PATCH mptcp-net v3 7/8] selftests: mptcp: join: new ID0 subflow
 from the right IP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-7-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1l2BrGr9D/QMBsvEatr2e8K8+KHsAP3MHOIJ7Ihr8S8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZ4WJ8NSI6X4oeFK7X6bec3v9kuVvzSUyDpn6vxVry
 nIQzj3VUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBF3NUaG3WsnPO6RPpLIHicy
 5Y/wFrN93ct8DPZ0eB/Yt2ttsUzzNUaGNadmqxkxxibPYVHgeWUZX8927pyriHnEk6mtD8LtMri
 YAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

Hence, this is not correct here to try to create a subflow with the ID
"0", but from a different IP address. With the first patch of this
series, this action now returns an error.

Instead of simply using the right IP address, continue to also use the
wrong one to check that the kernel is correctly not allowing the
creation of an ID0 subflow with the wrong IP address.

While at it, fix the dumped address: the initial address is not supposed
to be dumped, similar to what is being done with the in-kernel PM. So no
"extra" addresses should be printed there.

Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2413c832af03..0dc81eeb0636 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4143,10 +4143,11 @@ userspace_tests()
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		userspace_pm_add_sf $ns2 10.0.3.2 0
+		# from an IP not linked to ID0: failure expected, no new MPJ
+		userspace_pm_add_sf $ns2 10.0.3.2 0 2>/dev/null
+		userspace_pm_add_sf $ns2 10.0.1.2 0
 		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
-		userspace_pm_chk_dump_addr "${ns2}" \
-			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
+		userspace_pm_chk_dump_addr "${ns2}" "" "id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2

-- 
2.53.0

