Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DC38E8BF
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295921; cv=none; b=hJrkq1Bp0wHr+nhsk2HxYof5+Uu7fn6nQMFCVwp+6ExxDRmnK5lA4DPY9Ry5wOaSNyFKPAw40c2fiqj3PK5wdalVth852EgI+DgVdCePemrIisl5wUwPynebYiD8oW7+bEas4Iwo7N+GISqJtckKuvANeNmuO4M5sl/GAGKkgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295921; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKGxxNxfOLlNQvja5r/52IWG/UzW0OFBrC5vcDQdy1cHEaMGv+900zSeUoNbZZmHBuq43miLmiGSxC7MbwSZ2NBBzZPWuNbABw2sOc08XrYsa2kJe1YX+Dtl+j5F7QN0Ey/q5vg9YR4K6mYM/LixsytZMzOVdHl3LocddyET6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRil560N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRil560N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85441F00A3A;
	Fri, 21 Aug 2026 07:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295919;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRil560N5Zt2Fv7B1JLnZeYHVp4gFrXbZGgkQc/YkToz6qlKqEYK8c9GSyqVKV8Kj
	 mcm/AboK6GQDPn49SmpzHMipP8T/IlaHnS6j0m59aPN0Z1Z/2643WTXZEmJ/uM51Zq
	 DbHCWHEi2BgfKCV0edBr52vawhiRpu1b4pNHEdjVl3AYm8QdEVFDK55tMYp+8Y9vlL
	 Jgs00FJUTj6u8PbhvlP53dJOg1hRQ6LD7UL+KxUw0K8GBaS/2sx4phMgdgL3s8eeKj
	 20hrPSFuJMf83hFI8n+L9GyLmi9+NvRw2TjNYbl71URjPDHAaEjAptcgb0GbZoc7wl
	 QYAgdIATubuLA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/7] selftests: mptcp: sockopt: check app_limited
Date: Fri, 21 Aug 2026 15:04:28 +0800
Message-ID: <e05f16bdab48245a2e7cc1a3a5fbc6f78ee39636.1787295147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787295147.git.tanggeliang@kylinos.cn>
References: <cover.1787295147.git.tanggeliang@kylinos.cn>
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

