Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C83016FB
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644697; cv=none; b=VW5VnivWKCJVvhQIUODz1eiSv/vKyKmbowSKPwXT4m0ewrg1fOo1Z+OVDIVJtiOY4qUL8Ew9LZ+w7LK4xZKTqREDBfTcHNRWe6cJezKBR5iBd0RHf0KPAr/BO70BttVcmISvhudVkmBao0sUFtv9HlIGusXEj2IOStD0yrxqXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644697; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejhZtoZXmVM0GyFPivJJ1YXR2nd0ci/rLIWNIfXjfClhWAu6Db/ENPlkFgIP6JXgqRDC7kzigXvSIBX21RrSGCWz+r+zzcOpvrf+klaVuBB7gbtMjJHbuo67ot76eaB9XkfwSMSAwQtbc/fj2RFjvVnFSWYVUQw7+uvsVuqLOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6KXp7Ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6KXp7Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038A1F00A3A;
	Tue, 25 Aug 2026 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644696;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6KXp7Ipcd0aQT2MBKhchSEJqu2GE05m1RDgncNVT1yLr8A3T3gMZxLH9vhOzFQ16
	 P19+GzuTtnfmdoDgRMVe2KX52WPrx4fnX/pDi0E14hu3gCP4KoNOBmyOxUb9sviREd
	 nKrb4GtgI7+AtsvoyyCh07bNuM1EsOFmOv0sWsCf8S0/bFyOQekoKO63X+9XRBPlAB
	 ZBlfae4DWqU0iR7vhUDXg3DOWhtB0YJ75NG1xEXOVQFmqXfY8Aa4xIdtmhqKzyX+w7
	 7WG3H1VIN/q8Su/bzHq6VDmMIVSHHdHK9uS2I1ktUs4OlWfxEVcKOpnyUwibzLSCLp
	 CIfexdh1c4zSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 8/8] selftests: mptcp: sockopt: check app_limited
Date: Tue, 25 Aug 2026 15:57:36 +0800
Message-ID: <80feea7cc270023c6a00be77cbd82fb120e86241.1787644449.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
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

