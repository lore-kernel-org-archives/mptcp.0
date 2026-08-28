Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A091684B0
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889009; cv=none; b=MmlNnDj0mO3i9j97GFgqW5A23HituaPLmPkJlyZRItHdINNSvbp2OFvubpgXFP32gBHbEwb12jhDUnzA9uZOlMf78NPtNVj5oe9QDL0u2zcW71X/+JD2ZqegGvyIki7P7QaiLOLl9pnGOfs8YOMopqY19G2touZLSjByXkfIsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889009; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VivBSODtgRaTHJyZrVVQZSzOXCzPcweKgmuFIi8toLCuodTBR3VUWxn/E+Ew1mmhU1yVD0ai1Yd+M0Ds2uyYBp/51uLFHqX8IqMbTCuA3UgFRQXtwi5d6Qkwf2TO1qtZtfKIg/gF8Qhkz6iIYoMu2kQNOxzVFxYes5oYIp6H84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4+x7yNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4+x7yNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E891F00A3A;
	Fri, 28 Aug 2026 03:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787889008;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X4+x7yNibGrAIOmMkhEgaIzuVFu61Ud1GspCbc1yuOvWlU5VyqOtVmGz/TSpTNhbu
	 I5jp+T6VdhR09LZHa2xhKTIA4ZHBh1/BQscsHKU/J35V6FOy64NkZQc0Bmj/niuCxa
	 D6YkPfwjiWvHdA7k0wbp24wFhSlyvxy3SP36IXfs/+GkjRTZjUbFPyKW8lFca4KcXP
	 IQpqM+0GDOML0jbbd3H+cMbjjcwGh6SgY8UW7uB3i9VcepAVLlwyklpR8i45T5AB4u
	 LQXxTGPbaaB6Bjj6ml1p/4xFyG4tq1rOGOja++uT6tthCei5B5zlKKvkEOj/CijWNs
	 1CKci1mbzacXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 9/9] selftests: mptcp: sockopt: check app_limited
Date: Fri, 28 Aug 2026 11:49:44 +0800
Message-ID: <90391cc3e5d2728c76aeabf2a59d49078de692b7.1787888115.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787888115.git.tanggeliang@kylinos.cn>
References: <cover.1787888115.git.tanggeliang@kylinos.cn>
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

