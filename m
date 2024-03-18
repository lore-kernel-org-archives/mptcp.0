Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484822EF0
	for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749022; cv=none; b=daNXsT0yv8lw1ToMwM3cwbbM5xBX2wgA+v+GJF4lcdBOUoJyWkvoGv5t++cKzdvdL/zcgMlr5lGlnlexlZN6cNe3m/G3BB5pCtpmdHRdHgi+sYEZ2wTMv8qcMU8Tx5q4rsOqYS011sD2KQn2rmbj69swdEXh3R8pmF+zlUeTo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749022; c=relaxed/simple;
	bh=EgChSyf+Z2wkPW0yI2D4O2z4kgzarzLeZmuW2ONSXO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HwUb45FxDX6n/c/An8NXrg41oOojPVS1iW3graTbTHvhSrFtfGgA7myuQo7QNGBSDFqFSOX5HclS02HYtESZONN9E0YmnNF6QSTRpzHJiEUrpTHt+cscUIl2Vy7Qt6Fg6ZsTwXOfWWCE3KYGUGzMmUhfIs85LmYcVheoxanDppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAp+404v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAp+404v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAEFC43390;
	Mon, 18 Mar 2024 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710749021;
	bh=EgChSyf+Z2wkPW0yI2D4O2z4kgzarzLeZmuW2ONSXO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAp+404voNMFId9NG584gJuZH1+Bqq4Ju7HwO+G3Q2xTr6B3tfi46If9Kz+hyWSBg
	 Zld2TmwzdXWlCNuiLD8jdarjmzmYDo85k1j9QN6sppixK2wep4S+VF0akWhKsLy1ZZ
	 sXn9Z/0JNCyLQmfpNNDMjVR+F4KFG9r52uw5CctuRo0+PMIMG+jdGuVI/xITV83fLE
	 SMWVoqaN740ClQMB3Au057c7KRoa9kcGYrMDo+wAxtj6c0GlVZc5mBdMWqhY/NZkgm
	 b9tpOJsSbsFrTz4VgAAPXcx43vIMJIC3bCe8imrl+U2+LYdC4XB7MJl61IfPPflUw8
	 Obj1cqNLJ1p8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: add last time actions tests
Date: Mon, 18 Mar 2024 16:03:31 +0800
Message-Id: <031f4529f5e9daf33e4818b48693e1b0eb25814d.1710748923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710748923.git.tanggeliang@kylinos.cn>
References: <cover.1710748923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper show_mptcp_info() to show the counters in
mptcp_info of the given infos. Use it to show newly added last_data_sent,
last_data_recv and last_ack_recv in mptcp_info in endpoint_tests().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 70621cbbab09..6a6caf472d68 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1855,6 +1855,25 @@ chk_subflows_total()
 	fi
 }
 
+show_mptcp_info()
+{
+	local info
+
+	for info in "${@}"; do
+		local cnt1
+		local cnt2
+
+		cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info" "$info")
+		cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info" "$info")
+		print_check "mptcp_info ${info:0:15}=$cnt1:$cnt2"
+		if [ -z "$cnt1" ] || [ -z "$cnt2" ]; then
+			print_skip
+		else
+			print_ok
+		fi
+	done
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3589,6 +3608,7 @@ endpoint_tests()
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		show_mptcp_info last_data_sent last_data_recv last_ack_recv
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33 2>/dev/null
 		pm_nl_check_endpoint "ID change is prevented" \
@@ -3612,6 +3632,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
+		show_mptcp_info last_data_sent last_data_recv last_ack_recv
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-- 
2.40.1

