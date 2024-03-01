Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1D3D54B
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311131; cv=none; b=XSesZ4j9bR/IP2hBmvy6nMTFKTG7Sr2fJynLP+wRj0+5RZ/aA8OUEhgwZLzdwasixCxZEvoA8nWOh88/jjrLofyt4dJESKCfLlgezcr3h7oE0oL6I0Y9TY9UP/mwaAv16nWZFhs6duEvP6tPXSPsISbf1opo1b7gHNd5Y3R0ZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311131; c=relaxed/simple;
	bh=dZt3yT1wnYqQMiHxCXYWFg1ce3ZjUQFJAvN/BpHXsVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG+Mg5OcaaNKTxYLXLmxkB4X0ooTrqiCBrd0X+sw868XR+OzJUGgVLC3H2VZorHwIXsUGJn2Ettch4y0RVN0XqBHHVR3MvGv/NDXRtNYIhBNotGd+oqU8nwqTR1gD2U3aZZnv1GeocGkmdDivJpGVJ/qgGNCTicuEP+l5QXujUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLx2ddcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLx2ddcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CC1C43390;
	Fri,  1 Mar 2024 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709311129;
	bh=dZt3yT1wnYqQMiHxCXYWFg1ce3ZjUQFJAvN/BpHXsVM=;
	h=From:To:Cc:Subject:Date:From;
	b=uLx2ddcBkwdJ/8KX3Qh+OW95Ca3E/x2C05syMehmJVyjUyN5BMDmySGsAWMNyXFRh
	 Gf9spjqsvRPKcmhSYJVSExNQotGUGsDcsjhLIG37T8n/Js9e9p8xwjgzkZWnXcDuQE
	 0bio8HNm/gbNqVJtl60hffCRn1QaQQmwJSdxMsr4XnFViE2P4iC2fEYy7Yz41+Z4Fi
	 /hANJ6bQc/ut5ISWdOU62+8j36bda/pSraO+BdO4MjySj1wiQym8MhVh1r/sZ+r8/q
	 nlu7Te7A1Yf420W5ZaK09bj66W5EBZy6Xjhm/9dg29u1KJfW1Bl/0Cb9+3uLJc/upz
	 1zsj25RDrIrYg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH] selftests: mptcp: diag: avoid extra waiting
Date: Fri,  1 Mar 2024 17:38:47 +0100
Message-ID: <20240301163846.1370114-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2541; i=matttbe@kernel.org; h=from:subject; bh=dZt3yT1wnYqQMiHxCXYWFg1ce3ZjUQFJAvN/BpHXsVM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4gSWy91uvJdkvcahIZTiH8uspzsSyf19lNupi yR4NXnD6pSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIElgAKCRD2t4JPQmmg c3cuEACpk38Z6ifH+BeEFymN+PSFiZzpDiwC79p+Jc2v1m8JIkO4YCdO5VvrKLV3ty5umChlMis yo1k0fD0MW5bEscZcAKYj66WQS9lSdojuKl9rDcenk4HmCPgit6jdysaNP6HjvTX5kVhAfIYzOm umbhZsf5hFIpI56HLPKzEngAz36VORcJdo59VK4whoyGKlURZQezQ5ofqnRnccMrkSmIBaIxWPk IBhaR1k+SKr4N6zPLwvjBCzOi+xKZFAVjM5OCZwcilfrzE6Ewc7pVT/LA28WCVs3ldv84RiUC9P cgJTzPysTSCSX/AOCm7fyEFG11TmFjPh4kkXstzmumNBFLskc84ihUKDXXFyS1MFxpezz0ru9NI JhzIpeELfN08gAgZQC2KZDIisVdZ6uLqrMR4a9nnecKW/RJNmZszAjAmhGea4E7H/myIcGhIqS9 6/2rZwu9IEWB9584zy8dGVgxAshycM/K6b7CVdkbuyygq2Oa17Cg+Mf6aRls+bCuA6YlUk8DLlK XbVXTen9BLnvgAZdkRHovekbfeAkntm6GN4/hJhvcrFZ6pGBe04uh8HYZKbxmmVJ08AdKAS4Jo+ IDy5X6Wh4Qg1818SXoqtEsoczYide8fvWeYP4iQIjJV5JgTwqTGjkzVaIClQx8Tt2LJav46WRX4 m1FHQn7o5a8qEgg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

When creating a lot of listener sockets, it is enough to wait only for
the last one, like we are doing before in diag.sh for other subtests.

If we do a check for each listener sockets, each time listing all
available sockets, it can take a very long time in very slow
environments, at the point we can reach some timeout.

When using the debug kconfig, the waiting time switches from more than
8 sec to 0.1 sec on my side. In slow/busy environments, and with a poll
timeout set to 30 ms, the waiting time could go up to ~100 sec because
the listener socket would timeout and stop, while the script would still
be checking one by one if all sockets are ready. The result is that
after having waited for everything to be ready, all sockets have been
stopped due to a timeout, and it is too late for the script to check how
many there were.

While at it, also removed ss options we don't need: we only need the
filtering options, to count how many listener sockets have been created.
We don't need to ask ss to display internal TCP information, and the
memory if the output is dropped by the 'wc -l' command anyway.

Fixes: b4b51d36bbaa3 ("selftests: mptcp: explicitly trigger the listener diag code-path")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/r/20240301063754.2ecefecf@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e87cf76b3e4ab..38cacfc3de218 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -96,8 +96,8 @@ chk_listener_nr()
 	local expected=$1
 	local msg="$2"
 
-	__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
-	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+	__chk_nr "ss -nlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
+	__chk_nr "ss -nlHtON $ns | wc -l" "$expected" "$msg - subflows"
 }
 
 wait_msk_nr()
@@ -304,10 +304,7 @@ for I in $(seq 1 $NR_SERVERS); do
 	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) \
 		-t ${timeout_poll} -l 0.0.0.0 >/dev/null 2>&1 &
 done
-
-for I in $(seq 1 $NR_SERVERS); do
-	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
-done
+mptcp_lib_wait_local_port_listen $ns $((NR_SERVERS + 20001))
 
 chk_listener_nr $NR_SERVERS "many listener sockets"
 
-- 
2.43.0

