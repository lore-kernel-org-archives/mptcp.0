Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A17A50
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689270; cv=none; b=Xa6V8lsM97ADTwaHA8H377yp6DKLHQIkfKyGcgbuIogQQbyc9VKhWRAbONeWTeAqBvpFM4DEiQBQOMLMnGtMC6Ib0g6gyU/tdaQbriXFUoKGhoAc43AjMBmTXIRB3NCqKWx46DJjLYx4jhvWnsFoI7p4kCWr5ohZ0j01ExZrqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689270; c=relaxed/simple;
	bh=lRvyJQ4n8mZ4DG2sxqKIHcdRZJy2sdYu/xFPhRZroCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIxq8Jvqo+h9PFG/20q9gbBOMDv6+EdAR/DXuA5AptffhVcoF2H9JVoBHnvSGu5D/d4QoF6+8OqgQEbix9qsTAsPT2D6VLSM6xTN2ikDvQvIrfavuxOAx5G9d9a/V94ENLTjvpGfIcTOLIV8Z9FRvoX/19gq6AAhTeI7ICT+JDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvA1oRCH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvA1oRCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C12C433F1;
	Wed,  6 Mar 2024 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689269;
	bh=lRvyJQ4n8mZ4DG2sxqKIHcdRZJy2sdYu/xFPhRZroCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvA1oRCHsDy1cWT8kzu+r6OafBIk9qcfz8Fl3S+KtE90fCn50dqhT1hfL6aC+xBL8
	 1tObBo/yiGvDrYFThAECEKv+8ryvw+Z+zuwqsof2tnjU9SymnGRRsIYjxxpXgyNqwV
	 r8KKmyIyPofJAzkvNYlZh+INSTdL2rZJwV4TKvpa86jFjbamek5Ef1095+fMIArn3D
	 BQM11G9D8Hy+Ccd57aB+9oOAPlNplQiqIoASevlN3xEP0P9tlE8RPmjKFZqBe/ecqP
	 JAlANwuI4RcfgtmQ4C0ogWxuCcj/kJIfeJFO9DEU7MKaZrRCG/cVGGsSapcswTloE/
	 aiSsr/D+Fm8CQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 2/9] selftests: mptcp: connect: add dedicated port counter
Date: Wed,  6 Mar 2024 09:40:52 +0800
Message-Id: <d69805795b3b5a5903ef2d888d763dc135add345.1709688778.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709688778.git.tanggeliang@kylinos.cn>
References: <cover.1709688778.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'prot_base' instead of TEST_COUNT
to increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    use port_base instead of PORT

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 679e366c8f6b..c47ea779145d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+port_base=10000
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((port_base++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	port_base=20000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

