Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F027876E
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664228; cv=none; b=kJHEidnVGeth2MeIEyrrxVCwVrO25IXlxASf6h2BelySw/51kYlkXm5OO/XPMqeK+6BwqLEBOLGQtOnEAigYkgFdUE+1FZ9z8YEb2bnSsjpU/lZgGmUn2EEESHVoyXDsGnuidad2ADR8CElzYdO1crfqQj873NyIToy6MNSCTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664228; c=relaxed/simple;
	bh=tZOp9vcFp/Pqc7w2M88W0WH3JpVsajuVSOWWZdHJ0c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvWfmfDQHYrYG2zqkjX5lPxwWO39xr6adcJ/h6HSFsDmBoXjXU3LRWI6itRe+eJ4NOTGidl2hoUEx+I2CewDjBTy2uAQSM/dstYmS5xSHuXP5rdNtYouE+3u+p+Mfw8kwYOKqCCd57Q++Lsc076khQERKvpGXQNLYXiUqad3+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQHvaTPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQHvaTPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E9C4CEF4;
	Fri,  8 Aug 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664227;
	bh=tZOp9vcFp/Pqc7w2M88W0WH3JpVsajuVSOWWZdHJ0c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQHvaTPrYNbEMssgzwCcjysuIUhzf2bUWWjVM4X0YFOIjcMp5STSG8ZYsNQiw2i9Y
	 RTQguMW4WUL4OSeEu7qd/clnGtoZt6+93RmlOOMYYGw+3scoaSbNoyIo92YyfwXJKn
	 ufrMTXF8y8e7Vxqu8DW3Il+OCaDABrTnqV0uIVSTgF+y7ZX5bXEyoDGO1c2RFPfmZH
	 v3F9TElucIbc/4J/tfl1BkT/peJxAlaCmMpZGLQ62Xhqh4BdD0FL4idaE7mSZuh8rk
	 7ysnZyGqAWwb/ZjwH4p1krfkvLjfG445TeLVNJP87zCyDBbCmlMtZTuJd/S/8/QX11
	 HzxY5NG+Xz8tQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/9] selftests: mptcp: sockopt: set TCP_INQ on accepted sockets
Date: Fri,  8 Aug 2025 22:42:49 +0800
Message-ID: <c0c36b32deea2f3f35cf2976d2d7b712541288b3.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add helper functions to conditionally set TCP_INQ sockopt on accepted
sockets when running in inq mode. This ensures proper testing of TCP_CM_INQ
functionality by enabling the required socket option on both ends of the
connection. This setup is necessary for validating TCP_CM_INQ behavior
during TCP_INQ-specific tests.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 5ed8287a10e3..ce5d6b8c2d32 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -712,6 +712,20 @@ static void process_one_client(int fd, int pipefd)
 	close(fd);
 }
 
+static void do_setsockopt_inq(int fd)
+{
+	int on = 1;
+
+	if (-1 == setsockopt(fd, IPPROTO_TCP, TCP_INQ, &on, sizeof(on)))
+		die_perror("setsockopt(TCP_INQ)");
+}
+
+static void do_setsockopts_accept(int fd)
+{
+	if (inq)
+		do_setsockopt_inq(fd);
+}
+
 static int xaccept(int s)
 {
 	int fd = accept(s, NULL, 0);
@@ -719,6 +733,8 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	do_setsockopts_accept(fd);
+
 	return fd;
 }
 
-- 
2.48.1

