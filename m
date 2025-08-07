Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D639199949
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534683; cv=none; b=R4BgAyWrV4Q3c9ovrP/LcL7F5PAxWyPBm08n06yNEP9O7Zxt9K7ebzBeYhh+L8jMt5wQdaJsHNCJVQ9sSjlGaeGl5ToMBj/49DeyZ8FWxJ8LE+hwp4gvb2oQfdZ7b6KQC4dXKInGs9wukuaofv25YKKAppBKSjajhiXGk0Fde2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534683; c=relaxed/simple;
	bh=dVuqUKvRkerANLS/FlgoByDVrCYfyG3jH+8pJQ2uOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeWhEOszPkF6Qs/rBRPjpEL4x0cPpNLBLi63va1KXbv+EQCHNdts3kOEtzPbcr6782FuYb7BXz8nKlOTuQTuW4ZWUsdlLa+EFe6TOGwZ/SNU8/kpsq5qZCeHuYrD6XGSZ4OPDuxHCkov9V92Cru2sv5SB9iMBw30Ekx55sSx8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr4NSNZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr4NSNZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B8C4CEE7;
	Thu,  7 Aug 2025 02:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754534683;
	bh=dVuqUKvRkerANLS/FlgoByDVrCYfyG3jH+8pJQ2uOFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tr4NSNZBKqOpfHCXZCYztdKo/popN7VRVvrBMXPetbdt1EOLoOlroZ9Lk41F27kUB
	 2qgoDIsWgU1hEexPQk7apJ5tRtMy1GgL6Iii5F+An6SNsUqMxR6e9Syu1/G5bO7Ie8
	 EicTe+gUF9029cHwtc/+zmta5RYwvigNOoHw8Tgj+qDYCDRoMx7wi5S7U2A7M3B6Fs
	 lI7BzvM1CT2XzU8+zKSyWS6sVX2LWFsKdL7nLYYqzLDkVhOVSMSPXB4XdStOk7907Z
	 +138skcQNjDMAJQ++M1pOGGJM06Lft4zGsksmw3WnX/nYPwrSEHCRUm45WAuRsjV4v
	 iupVRY4Cwh9ag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 3/3] selftests: mptcp: disable add_addr retrans in endpoint_tests
Date: Thu,  7 Aug 2025 10:44:25 +0800
Message-ID: <66f995a8ea524ccfd75528ac787b60b2de648024.1754534416.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754534416.git.tanggeliang@kylinos.cn>
References: <cover.1754534416.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To prevent test instability in the "delete re-add signal" test caused by
ADD_ADDR retransmissions, disable retransmissions for this test by setting
net.mptcp.add_addr_timeout to 0.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..82cae37d9c20 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3842,6 +3842,7 @@ endpoint_tests()
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-- 
2.48.1

