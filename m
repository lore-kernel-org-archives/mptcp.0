Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9663D9529
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172101; cv=none; b=GDEz/pJoch3UZOBdh0RgVMO4535P2RH/KJxsobp5eBuuINxyUm6Q7jK4+kuwPWIJ2UlA1wcrVcyYweKGqA3Sq0QEE/m2hX4S4tafuGWAciVuFUzBxA0psRqYXL8bdxmlqnzsHz0SWTW9vkKKLfmVK2SSG4fi7IzClbuLabUwSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172101; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWyRzjh3PMbrzMlQaJTOSp6oZkqFAn7IBEqjofIbrFiIBduUl6WkPNxXQG/XE1pmN9gM+JYjyS0nLwrOUsbCbODSP0v0kBk1Og2xMXQ9qcvonhfzcg7ZBznlNEG3iRZoU3lg9jJWsA8hsMYbeln0OtPFB9iERmwMESvXnUcDZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjcZCRX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjcZCRX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C051F000E9;
	Mon, 31 Aug 2026 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172100;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjcZCRX2ASR5Fhv/tnawK6NqMokUAzsl5Vvn8Q2wTfIZbeAA0K1aKxj9j0So+Ouok
	 ghci4UV2H1AcullL0XF5pU54xhfd6GW+qrtPC9xMyldO+ItELwcAPq3KZpAndY45Ec
	 dzJgB+q4R+uLi+6Lip0SoXGsijDHQeHhzt7uWW5dS5PuYn2NcTRnq17Z9l3MEDGSsb
	 RhQXwfL8y2I9nogEd6uBSgeg4AWjzrRFilBqUtElwhc1oZRq5H1PGpFKhIHl5wdIhu
	 nK0XvLNqCw+LZICAvKLdtMveo26d7qJl1529HbTJzExcdjzzoZpeewls6qTl7/6cqa
	 +jbWgm3NyQV8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 10/10] selftests: mptcp: sockopt: check app_limited
Date: Mon, 31 Aug 2026 18:27:18 +0800
Message-ID: <00a2a65e5a531361ed5b0b3562027de179e6c942.1788171508.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
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

