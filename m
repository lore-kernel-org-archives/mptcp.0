Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCA8F54
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621132; cv=none; b=WbV+vC/SHdzuMX6HHyaOyPUzzOPNS8gL3eBhcaXAWIIMB0j9sh4eDFQcPuXIn6DInli8oZfeS2lWAP17F2oqSArQZD1ICyjulfgAxG39pGTV096MkoiiuxxatTL1JAog8DfvUjxbA2tGOdGHAeV6eZH3uPe3B6V8/yPBfw9BONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621132; c=relaxed/simple;
	bh=jOTyncc6EWjzQ0xyqefGzIOH93ZK4g0LxFYw2/qVbWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY1dw7IBzhs7oChmR87jtGW7P56CujZKXLCh3o6zJjOa1CTGkGEKLUIpssEcomtb6adNmdKx0kbzXuRYyLg6EF5Uabx45saSIor4WfZViImcr3QU+MsboDUtdAhHHMg/Sw3h8gv1Apko8fp6s0PicvRquHNJcx7A6osxLk5IGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP3lvguv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP3lvguv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64CBC4CEEB;
	Fri,  8 Aug 2025 02:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621132;
	bh=jOTyncc6EWjzQ0xyqefGzIOH93ZK4g0LxFYw2/qVbWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oP3lvguvpLk45lKolF141G5dD1wiXGBafNmy2V3vOrsqm7uWleBA1EIimK71ultZi
	 qUqybksnvLoKs/Ke+kvc/PLugiO9CHw/C7VuOj5J29+BycLTSunIDAfnbgcaTrtOZ+
	 rob365hbqYKThq4hyK29Iyvh0bBfDsv7u9kVXVtvRLpB0EafGK3oiumbj0grb5RHmj
	 mxwLBxq3YQ7vxTSr2durXu/QH1HzqrsZarSRg2IVOd1VVgsDrafDz/6MUkULBOfQOM
	 X33jT7l4ibj1qhJUQk/VFEZCgi+ICUCMKFUJGc11LNfEOuB6iyDy4s1IwXO2iGdXnS
	 ov+C9jUMR3XUA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 7/8] selftests: mptcp: replace mptcp_inq with sockopt
Date: Fri,  8 Aug 2025 10:45:08 +0800
Message-ID: <da28b95c1af1ce0a96f32392c43431d613520769.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update mptcp_sockopt.sh to use mptcp_sockopt binary instead of
mptcp_inq. This consolidates TCP_INQ testing into a single test binary
while maintaining equivalent test coverage.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d..41201c5fa6af 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -305,7 +305,7 @@ run_tests()
 do_tcpinq_test()
 {
 	print_title "TCP_INQ cmsg/ioctl $*"
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
@@ -330,7 +330,7 @@ do_tcpinq_tests()
 	fi
 
 	local args
-	for args in "-t tcp" "-r tcp"; do
+	for args in "-t tcp -i" "-r tcp -i"; do
 		do_tcpinq_test $args
 		lret=$?
 		if [ $lret -ne 0 ] ; then
@@ -343,7 +343,7 @@ do_tcpinq_tests()
 		fi
 	done
 
-	do_tcpinq_test -r tcp -t tcp
+	do_tcpinq_test -r tcp -t tcp -i
 
 	return $?
 }
-- 
2.48.1

