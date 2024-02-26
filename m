Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F71BC3E
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935493; cv=none; b=fIHpIxSMW+Wk0yCW4+bUjEMLRr737ieqHiT65qWCF5O//yPbWmL4xdep5oJSP2eNvIjvCCL4GHUqxMw856GJi9tR56/6sETljThebXZ/p7Vqm7sJx9LNLkuv+9tfUOyavPpw5az1pNfx8uCW9yo48xWQ8b3JHxjBay6j0CBOU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935493; c=relaxed/simple;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuOtriGU65nvLbTTi+NxrWHQrO1XKMUfEu/B8oONZ+QEPXmu6I8Q3KoZiyyPa3hyQarw2ceENRI2L+OhblWnmuvGicewJNbQO9IOl9Foinv/dUycqG1L4K8H30WT+TD74gtEBfw8jIjSS1jPXq7Fm1qr8+77M9rryHHknW71c50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttBJoQI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttBJoQI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B4C43390;
	Mon, 26 Feb 2024 08:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935493;
	bh=bFzDe6XLpSP5eoyrm0uiE68aAhpO/U+AbiYwDW/HntQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttBJoQI4LRa4CJmb9KgCaJ+p42Cg50AqUNC369ubH/o37Gi/vbXtsYTF5gHQUUljQ
	 9UX0vV7Fp4jPJj7TFte21/7d2f7C3TKuK4FakHrfy3I86a7JZPxWpOtSpsghpkn4WI
	 EjpM24br3zNtK5kE69pBl0ki4364tH2ZHHmZXN9i545xIM2AIyLsfptlbNER0n+zQH
	 XH1JZ1/XQTJheVg818jOnwFkZ7pVkJ2SnnUNl02JIlZcg/9OxolZJdqhsSolrr6+EJ
	 sBpnuAc515Tt3yDh87mH9eKWzpCM33PRz1T6ZgS1fJBQR90ON7ty5FeVL/6fvVm5sC
	 Go/8fnUzEcs5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 05/13] selftests: mptcp: connect: add dedicated port counter
Date: Mon, 26 Feb 2024 16:17:50 +0800
Message-Id: <932e4723bdbe01f37eb0f65e04f01a40ec7dd780.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708935196.git.tanggeliang@kylinos.cn>
References: <cover.1708935196.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c7483902026b..68073b255983 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -317,7 +318,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -712,7 +713,7 @@ EOF
 
 	mptcp_lib_print_info "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

