Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064338D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449916; cv=none; b=YoIIH05sWIwfA3nLsdkpGraSV+HwRuu10LB9tfBE/tn/QqDe3PpueLs4dQGGUssEtZPB590gbTCF/YuW9oy8zjyYhZYu5KpTMhRZTV+3o4/oOauQnhYpR/VHz4bfsOVjXsoJymj+nB0/TScLJ/KYiccQizWd/cd/WpFl+EMnniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449916; c=relaxed/simple;
	bh=dVuqUKvRkerANLS/FlgoByDVrCYfyG3jH+8pJQ2uOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY+eSZi2MaC6FnzDhDwNFbcH4Vz09ORgVJ9eEUK+ZHtG9K0ZTs1auYMm7Rir8DTSGltsSnrcGf9PQotjmWGjkcq1AmgPpopeecE08rksqr2Y9wUVSSmgB2y+gTE4fAUKbggk5x/9DtJ6a5mCNAt8g1E4hln5jTkeZfBqUA8MIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxAcxQ7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxAcxQ7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C5C4CEF0;
	Wed,  6 Aug 2025 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754449915;
	bh=dVuqUKvRkerANLS/FlgoByDVrCYfyG3jH+8pJQ2uOFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxAcxQ7Ff+Rpm2XNb9X33Z0DpoDkcuKcCEEgqxV22KGiPeC1HlfKGZxdib7AYom8t
	 TXgDLQxO/IQpbzmL9dNW8cr7MNFg0NKUNuVyPoizJWHM3D1746hdpUARmgYRty4GO4
	 ddj/G2jbYVIUdkjz5CfQ06zIUbObeR3TyBDhpek77dBMxPgXFQMO7e5z31JJZ/ZS5g
	 FDNcIX0LeWszwj/N5Mij0p3a+j1/SsnOykzAKnYTa4NDxdp1QMqyRHcvcl9xDS6PFW
	 33B7MQdEMryYckoulm7aPPZLj403efUfHcVm5ONBuTXNohCH9vlDfQCNdYdVur+j9C
	 iHCjolvVS8toQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: disable add_addr retrans in re-add test
Date: Wed,  6 Aug 2025 11:11:44 +0800
Message-ID: <dce281f5567343f9038d6e4f21288df8a0b91672.1754449726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754449726.git.tanggeliang@kylinos.cn>
References: <cover.1754449726.git.tanggeliang@kylinos.cn>
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

