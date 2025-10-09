Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F723B61A
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031217; cv=none; b=SvMD1KCpzZwdy70opMloFC5aIBGaLlo/dgYVV5LI70KqbB9UfeWdh3XiQZegetIu4ijwlbV3KFWy1P2KUJDL7F/bn6rqyLT1glF/48BFuqnKVE4dSeq3TkIBjjhazaWVZBtoTao8p/EbA3EpcRykv2xxipnCfGhO3oXK+s/E+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031217; c=relaxed/simple;
	bh=4SR60wNa0lg543fvKyJACtQSqreohiulh7LcVAyNZ7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqArfsMN6ejLmjLxb+mMigphsx1WlEh5Czj7ised9Bda/I9tq9Vlk5GRjtmKbrYykVn5q5ypDevio1fTNS7Z55RhLNBF/V5RB8HmVJ14ELytavbqnFsZXquPGHfbGuRDydzh3fe1IgnDlrlS49ozIYqFV9zNTTMCZmj/0eKt/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RODxGMPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RODxGMPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE22C4CEF9;
	Thu,  9 Oct 2025 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760031216;
	bh=4SR60wNa0lg543fvKyJACtQSqreohiulh7LcVAyNZ7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RODxGMPGGx1boPDRJCw9W1mts8PVpRgmRf0Tgkk3AYnzMQqXwckDrSFSD/83mU+mL
	 thh9Y9rFwQR4uK7U2O+Vm4m9xLiBNa0dvp0fPo58OnjngDL8w/7C+OK1ljyr2bodHO
	 kL6e19jB6m1PFBxSZpU9oV0CDN3JrND1O6WvDLqQU2i8L8dcs6SB2jCqr1BvUA/WQS
	 125blqNuVFkjpfpKIYFsQcDDXC/IyycMa9NxAZreLaxl0Q3wa+6vCSNpQCtrMub1AZ
	 i6Zt9hodOdEIDyMqj2p7jxkUtfTa7eUFH0cKSl7Ob6aAcYAkYymb+f9m4qIyPQ+Uyc
	 A4Q3iIk25iNKA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Oct 2025 19:33:24 +0200
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: join: do_transfer: reduce
 code dup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-bind-extra-listen-v1-1-5ad2077d77a9@kernel.org>
References: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
In-Reply-To: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4SR60wNa0lg543fvKyJACtQSqreohiulh7LcVAyNZ7A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKef3yjc/n04ti+xF2XLl/7e3/fetniCZ5W9wuNfY9Nb
 muaV65g0FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARHQmG/6FvrnM4ZCS+vyQz
 xaxgyZUDcx5cvmrdrL+ZsTT85tbWs0sZGR7sWq9UtkjPZXuJ88vXJrseTGn7eMJkGRNvz+U7og4
 3z3MAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The same extra long command is present twice, with one small different:
the var for the stdin file is different.

Use a new dedicated var in one command to avoid this code duplication.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c90d8e8b95cb..c5169020a515 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -951,6 +951,7 @@ do_transfer()
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	local in="${sin}"
 	port=$(get_port)
 
 	:> "$cout"
@@ -999,16 +1000,12 @@ do_transfer()
 
 	extra_srv_args="$extra_args $extra_srv_args"
 	if [ "$test_linkfail" -gt 1 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${listener_ns} \
-				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args "::" < "$sinfail" > "$sout" &
-	else
-		timeout ${timeout_test} \
-			ip netns exec ${listener_ns} \
-				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args "::" < "$sin" > "$sout" &
+		in="${sinfail}"
 	fi
+	timeout ${timeout_test} \
+		ip netns exec ${listener_ns} \
+			./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
+				${extra_srv_args} "::" < "${in}" > "${sout}" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"

-- 
2.51.0

