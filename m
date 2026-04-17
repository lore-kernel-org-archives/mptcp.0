Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00737DEB5
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467212; cv=none; b=INlqIrFb9ToAIiAy7DLxvpc5e86NFXgHoFGxyS1o5qT5bhM4/jjH+nfVcRzsO9qjPy4ACwoComVsceavd7N+U9tanEFGBDr3TS89r7HyJLJcuPnR3lCFo2tANGTuo4ei139JMiWwDswHvVk2V6c/q9e4+HAnxQ/xAOvZSWbUZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467212; c=relaxed/simple;
	bh=D92+IkrAl+fSRyt9zNw6g8h9W5N9h8rh4xSH9hwRfXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koJdYVATzvRgGrjzcHaUmMy25Z7rvKxytft/IoQKoFFRbA5nbtRn9YZmJCkUrubWrsbxDUT82A10tDl6L9zqvynM+js6AIuosOo4rqRCwmiKJqpKxTppmNFNr95arC2QbQ3+Zb5LrgRdva8+yUJE79YLyas12IV5abiveK0hTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQk/Xltf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQk/Xltf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4BCC2BCB5;
	Fri, 17 Apr 2026 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467211;
	bh=D92+IkrAl+fSRyt9zNw6g8h9W5N9h8rh4xSH9hwRfXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQk/Xltfq7iY2tBzW7XW4u11C42oDiPodeET4LGQG9Nbvph19agLjyDubrw4BwAQL
	 K6f4SyQvdQYV5vi8Bu0VC2ht/bkJNflGmLTfngy8pHLi3wEq5dQjntYQ8PMGwoU8vt
	 jYsGz/w1YiRL2PRxB2o1eJ9WPj+yWzkQCNYBqaft/0X9ojyggfHNZy3MHoTrKsxpg7
	 6zaEaxjP95csgyobCfQh8MjjNK1VQflJzTh1Rrl8G1Af3MVQQ//OivWeNtdaESwoaY
	 SD9edeZ+AbhbRWCylx11a1cNwgM14utdsndcgZ6XJtSbBhIcu8rbytRgQgwgo2pUgl
	 tBJv/YZir/dmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/3] selftests: mptcp: join: update userspace dump_addr outputs
Date: Sat, 18 Apr 2026 07:06:23 +0800
Message-ID: <386dae09d4e6123a8c941ee9d594b2dc5bf5946d.1776466833.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776466833.git.tanggeliang@kylinos.cn>
References: <cover.1776466833.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now address entries only be removed from local_addr_list when sending a
REMOVE_ADDR by the userspace PM, they're no longer removed when a subflow
is deleted.

To make userspace PM selftests in mptcp_join.sh pass, this patch updates
the outputs of dump_addr.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..9802a991892d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4034,9 +4034,9 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
-			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
+			$'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
+		userspace_pm_chk_dump_addr "${ns1}" "id 10 flags signal 10.0.2.1" "after rm_addr 20"
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -4064,7 +4064,7 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
-			"" \
+			"id 20 flags subflow 10.0.3.2" \
 			"after rm_sf 20"
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
-- 
2.51.0

