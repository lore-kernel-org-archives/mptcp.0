Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED421ACEC5
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478169; cv=none; b=tKIOpQWJU1DrCUVjXXj7RtPbhY/0j42n9xCwgE0FWUOeyhye8SOn1fVQIUATXlMPpEE3Vwu7F9e6IvCQnh8BXClKWSAiBZpE/cKRKlkQiu5o6s1orD8GhCwn5mGHPNS4gWy7ENt/wlT8GsuzLeMKUVeHyptsHpfQ//KvBW4otSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478169; c=relaxed/simple;
	bh=vHezJ2cFaOUSjTOh+GZ7e3XgM+KomRSkw93pOLwF7oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEdVqOn3Y/hl3eUOIdDVTYoEaHi2Xdakis69z/SvQXGX9NSEVU7XPb/0i/pof6YRoNddybBW32qIZ8ib5DfuKxoCA31KmtdvEsbmB/Dwb1zA8CUo7Cj+q5XY6oCLasv+crt+S1LZNfwSApBeDPvpk4OAw8dvaodiT0ZmGEsNS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsaPowkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsaPowkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7307C4CED2;
	Fri, 10 Jan 2025 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736478169;
	bh=vHezJ2cFaOUSjTOh+GZ7e3XgM+KomRSkw93pOLwF7oM=;
	h=From:To:Cc:Subject:Date:From;
	b=IsaPowkT5QNDKHsrLe7Qfa/SNQRROinxi5FCu02Kgi4ffLIOeCsKFc7uQDNsba+zZ
	 PNlsxpnzf+jMpd2Hs3eLZfMJmU/5CdEPZn0+kwHcWcChBz1G1DrHbe32MlIHY3G3ST
	 Abw8tFIa+x04J7vSNLPCSPUyWCvwWe6Wj3wRV80tiLYkx5DrAuEAICKOb/yAZmoxZd
	 YkoE9XeH7lxDWOgywaWeZJBiT4zo2S7vPGG8R4nnkl31yv3m7WW9lWd3jAPugwnwBb
	 Q+ILVNvX0f3x+uSCyrxnV6gLV0sK9pRa60cJtQf9pUYvh/wdGl5vABgnx/fRUgoh6A
	 OFmU40JohzfXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: sockopt: save nstat infos
Date: Fri, 10 Jan 2025 11:02:40 +0800
Message-ID: <5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to the way nstat information is stored in mptcp_connect.sh
and mptcp_join.sh scripts, this patch adds a similar way for
mptcp_sockopt.sh and displays the nstat information when errors
occur.

Please apply this patch before the commit

"selftests: mptcp: simult_flows: unify errors msgs"

when merging it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5e8d5b83e2d0..9a78bfdc3d5e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -169,6 +169,11 @@ do_transfer()
 		cmsg+=",TCPINQ"
 	fi
 
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat -n
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat -n
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
 			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
@@ -189,14 +194,20 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat | grep Tcp > /tmp/${listener_ns}.out
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat | grep Tcp > /tmp/${connector_ns}.out
+
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-
+		cat /tmp/${listener_ns}.out
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
+		cat /tmp/${connector_ns}.out
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
-- 
2.45.2

