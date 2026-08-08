Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738E2F3C1F
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786158568; cv=none; b=KjD1yvCtH/SMz3hls033w+pHew2aaaAXbMPt8Yjmapej5kH1Oe3Y5kAUYTh1+a8SQ2CraDB+VC0yBDGwVPR07EJCDzoRyLmdnBquQSCM1XHtkPRN2vd79Xpm1dHIM2sJczn54YX8Do8rFh/5IWapa8BarJvujFs3PsSkP0ABDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786158568; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMYSwvzWM+UtJA6FqANRAxWur1vL2qCnRLCZi9CRSXk+GS9Ol+5dGk+dyBzbRAiKUtwyyDTnWJ9YZ4/5RadOoJ3BjTgYUkLEMMazWh+tq/+vPc6ZwwPeiFc6WDFjT0CQj53t9HtRxWrM2NVL/eWSnGU4H5Rws1YKAPSmEFCJvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A81BEbl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A81BEbl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DF51F00A3A;
	Sat,  8 Aug 2026 03:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786158567;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A81BEbl7No4OQsk2Y3uIJTeZw8BcPmuqnP0FBnaeHc7fDsb81WrP6xbXyQA48UTNv
	 gaqdOfaWbeV8vWLsOlfUnXAIsHHDkRIneG8ahoWx+gDwWIjwlrvb6fWhM7onfmHXEK
	 LDW9Cy+mUGa2OGj3MaixuhYbrNEjFIbuZ38ujS08ezUjLt8m7KPFRiUSRZGMEfVGet
	 QaD7tH3/tXxdy+jcbt7t7p/jB35Z37zW9fsccV1WAcYSV/NZXjNLoqqba5BxAznyg+
	 RwvbqgMh85gcoaK14YjD0wTx+pP5KnTKICF+qcQOdubpMneOaeQnEEzMtZDFj1cS6Y
	 M1ZXDQT5fZ5dA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/7] selftests: mptcp: sockopt: check app_limited
Date: Sat,  8 Aug 2026 11:08:48 +0800
Message-ID: <eea01f063ef8f0d1451b03a1c9e53480eb7f1240.1786158416.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786158416.git.tanggeliang@kylinos.cn>
References: <cover.1786158416.git.tanggeliang@kylinos.cn>
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

