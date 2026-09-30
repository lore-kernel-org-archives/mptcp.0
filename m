Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAB36CDE0
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735323; cv=none; b=XGzjLzOavlG73MyxLIklcEs9k3qSe/GThXS27MDxYFhprmFptSjD+ATFl1vQnX94dbaI8VK0x6oM3igLYnWSdjj73ivSf5+reD37xHq5gDUtjlbw1UoEKvM6rvOzUJkmmS44/Zw5i5fakbic1R1SE3qfIZfmXu9VAe94vYQGoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735323; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/RQfI53mB7NvENRRfKqhpCRLHNEqRwO04MlnKFHk66yAcye1aMPwYC88sYVnLLZf+X583EMfJ16RnrIpB6TzFz1bFRqyx4u14N61ZMRML31ovCcMvP/geDbpBpA/fKScGJUZGoS2n7Ci0843pnBGLgqNlWUVHv7l9heF8iWeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBgXsSo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBgXsSo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF37D1F000FF;
	Wed, 30 Sep 2026 02:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735322;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBgXsSo43cY5Q0GmcUMDCL4y83siN3Kx0Nfhe+pmiO1PmeHTCAhr2i17r1ex4n1TF
	 KP8pelzo+uDlLk2vTuvQDtbuVIOxRuiNKd6NPIlnCL7OH73upc70CKFszvBBmt66pY
	 E+fCFbqA5njvETElPxDvJN6JzeWVN1olubzuGJWyGeVVC4W3UHBuf3iu1suMRAkuiC
	 uZUGOp31BEvB/LupIF5ObqyhYEkgKX6Wld6UkfQhFekKUt+CEggNclW2xsk0yEMjBL
	 1KBBo7qC9eiwlLlwV5jLJExDNTP2XhhaNQEN9LvSHS7vCfHVzgG9fQDPl4eCbX3Gue
	 QfgQ/vI/vPdew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 10/11] selftests: mptcp: sockopt: check app_limited
Date: Wed, 30 Sep 2026 10:23:44 +0800
Message-ID: <bfe557770e77e6122a343dbfa3a7969e10606c48.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

connect_one_server() in mptcp_sockopt exchanges only a few packets between
the client and server, then closes the socket. After such a small transfer
the application has nothing further to send, so the connection is, by
definition, application-limited.

Extend the TCP_INFO readback at the end of the function to assert
s.tcp_info.tcpi_delivery_rate_app_limited == 1.

Without the preceding commit, mptcp_sendmsg() never updates the per-subflow
app-limited state, and this field stays at 0 - the assertion would fail.
With it in place, the value is forced to 1, turning this into a regression
guard for the subflow-side application-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d68515b7903b..8d712bdb4325 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -640,6 +640,7 @@ static void connect_one_server(int fd, int pipefd)
 		total += 1; /* sequence advances due to FIN */
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
 	close(fd);
 }
 
-- 
2.53.0

