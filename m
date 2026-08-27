Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E17444210C
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828288; cv=none; b=QicSW2Z9c7wyp8CSgpNqeMRY+smDDq+ERIBkFqpdcOyBaiNgAJBqfLA5jGxz4VFI75BlUh2VWrAATk2YTqZJQ0dRshM865rrqQn9Ce8xwP4aKjO/++Z5fH+Efr2OWEFWmJb4T0f0ip9zNHD0UHlzyxIWlKRlcKpuSviqfN2amY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828288; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwn67cN3IZMrPYx03QhtIeHNUiuSgDKn6RPKG2xDruSegDYWNzr9b8mlodNRYHyYXFSn/TWL2C0sUhCiK0X9RWK+IY1wLRnnpCSsYX113unQH50JNnDiaPl4aGfJmDXx3bzf6+6Oyo2RMy5+HqCFYdL4nAQ4B/SvDVmPTsnGQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRYZ5EG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRYZ5EG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137121F00A3E;
	Thu, 27 Aug 2026 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828284;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRYZ5EG0qIBY7qHaAGJ94pTrb8VBdrt1eXhpaOD2uY2WiJusMjFn8W6SpFjEA/t94
	 QgKyoBrLkuhnEASPIPnSO/PDQoUIJxX5yDExlqRA3mlv7gMyo7JMSIs5yXw8S3rHUG
	 Qs8DsNkbYe9T7UxFByKOVdVmeikm58bkSQw9MkRuwYJBdK292c8AfXIGhTQPcmtaD3
	 eOIzgZsfynZ+8FceNvUoRcYnaBazYLXyj8ppCB9n+rNRr1D3Qn50oyDN6Dk2g3iRMm
	 ybBHKBfYWU0Grg/AMcTPM9ohRI7guU0JHAPRUZcSs6Esf8gKNGGInKJfyJSlRPWObQ
	 svw7Up+Fm3RCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 10/11] selftests: mptcp: sockopt: check app_limited
Date: Thu, 27 Aug 2026 18:57:34 +0800
Message-ID: <c0fcce42a156e7da7c2cf6a710d140e8fe04749e.1787827525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
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

