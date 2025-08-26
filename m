Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97A2F99A8
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200591; cv=none; b=uJfodj/jmZ3B9y7xfM80wc3kC5ofvC3Yfiq+JSC8JNMWx3+ul5MEcBVeNnwK3yYTZJr8YsGQ6NuCJGbLEI708zn2IdfefWB4oZ2bUlkCI9SI1NklDK32GNVU7wEnCtn2XGis/Iydp+VAbdrc/ho94P44E+4GAw6HSSp2X2g7V/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200591; c=relaxed/simple;
	bh=ut0LZqG+bpXm01iCKmp6mOogHMIbdycntYYmCYxtPvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA5UPdgul+0IOKG6SOXOcxrjDXCjhPljxvLiniNcNIzIZQ4CEipFDTnGEr0u3BbIKFkXqCae7Nnl7dOJ1Tsv2xotrMEjiRpTyv4KLV9GzMnFyVHANCQ5Be/Idumq+LlS/zEJoQdPxdlBM3ZUucwHWIKdj6h6iFTzXf5fn27XrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/b8+ysQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/b8+ysQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BBCC116C6;
	Tue, 26 Aug 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200591;
	bh=ut0LZqG+bpXm01iCKmp6mOogHMIbdycntYYmCYxtPvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/b8+ysQ6dNGj4R5o8TEDgz8GuGtYnX7SKulZdxpE7JsY0L/uZ52VSyG02eEV4Dpo
	 MDBd+V4YZoMw8kO69qK2zxkOFteWrDRMVzoAVuZwbsGBT7KahRCYh3Cu5QKwqNEd4j
	 bONrO4CIEXMzisBf6j1XdhMQafRnzSgo3M1b0rSe7ublmGnIRxqFqOwe2geLtEqycJ
	 3aR9mONdsaZtA9tYkQXvfZJ6tJ5KFb9QMSN9tUkTNovmIEDt+G3sHJDReD1yty8M7O
	 +iOKzs4+cGBtVXqPTnzaadBed7yz7U2HJoK4UeFWaJiJQ8drq2Ct2VZC16tInOxI9o
	 HxGHjgiImTNCg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 04/14] selftests: mptcp: sockopt: set TCP_INQ on accepted sockets
Date: Tue, 26 Aug 2025 17:29:28 +0800
Message-ID: <434baf239967e120a815419972c5ddb57453ed75.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index cb3d8dc34997..366e4aa4df0b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -715,6 +715,14 @@ static void process_one_client(int fd, int pipefd)
 	close(fd);
 }
 
+static void do_setsockopt_inq(int fd)
+{
+	int on = 1;
+
+	if (setsockopt(fd, IPPROTO_TCP, TCP_INQ, &on, sizeof(on)))
+		die_perror("setsockopt(TCP_INQ)");
+}
+
 static int xaccept(int s)
 {
 	int fd = accept(s, NULL, 0);
@@ -722,6 +730,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.48.1

