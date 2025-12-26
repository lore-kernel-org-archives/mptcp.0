Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713A1EA7CE
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731247; cv=none; b=mvDxr7swj7RAV3JJzAWHWU64AVvMQCsUo2xiynvStilsnLSXrPME9DERtSDUZo0WUCu8zld4zeS4oW/rTjlqzKMXpDK+GbKgHsGiS597Qf5S6m3JGDtkvCv1lOI+GKxpMOQaebIkKJdvwTvn+YmDdea+/cW15kD5ebQE2t/GHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731247; c=relaxed/simple;
	bh=HFVAqDyBP9sSm69PwR05P5ImCpLotJfJ6PgW0UBPzlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enzqwtpZiLsft/nthXgIBcHndJ3Q1A/1+y/3nxbjPkUoXlmzmIQ5wNFgiV6Xy6+ynPDignl76OrJK/GB/nlFXXYfKZO+UxkKq95Pp+9NDfOwgihLKOhPdUhEdgcWDow4P96Jmeed0fs22QPHC9r6vlmiBLdDyzi3RI0ZQnBtQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpJq7Dwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpJq7Dwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D875CC116D0;
	Fri, 26 Dec 2025 06:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731246;
	bh=HFVAqDyBP9sSm69PwR05P5ImCpLotJfJ6PgW0UBPzlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IpJq7DwokQkXbq+qcnC8CiEVvxX3IXgCK2dr3sq1QUNSCJzLI0jAIc8ROdS4DXek0
	 +imBAuoZYIWCTeEbDzTBW37AOh48LP4S5LtYQDD31rO7iO+sRUr3kTERy6nnJIRqsO
	 mWom4z5YQ2ELgLfNFDya4ppTMCJMzXejH3Z4/VkjxzU9DCEm8Ms0+Qscu4SEXx4lq+
	 uYVOmdeSUtrr2b95A1IPq7kUogwwPsoB83EXNCxDUNyCnMu849D77c3viUmq0cRrlX
	 y34PW/WAjwQ5FnpbuEn2i6qEpfUGAnbEt66N8vMPku5H/JcYsOqkvTIK2biAO1feTl
	 oPacQiJPhvdHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:25 +0100
Subject: [PATCH mptcp-next 11/11] selftests: mptcp: connect cleanup TFO
 setup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-11-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HFVAqDyBP9sSm69PwR05P5ImCpLotJfJ6PgW0UBPzlg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dJ8wy6RbmnlW8LoJrdv9SSPbVTWr5V96bNThfUYcO
 gYqPqkdpSwMYlwMsmKKLNJtkfkzn1fxlnj5WcDMYWUCGcLAxSkAE1GSZmQ4JXX3cnDllpLss7aZ
 z9b951DnMmPMT/LsfvMrwjGg7WAYwz8lCy0XhasCK3kEpwe9CTi79HOd2b+G79Uv31WUH9jilcI
 LAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To the TFO, only the file descriptor is needed, the family is not.

Also, the error can be handled the same way when 'sendto()' or
'connect()' are used. Only the printed error message is different.

This avoids a bit of confusions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 27a93a25b142..6d2eb5cf8539 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -258,7 +258,7 @@ static void set_transparent(int fd, int pf)
 	}
 }
 
-static void set_mptfo(int fd, int pf)
+static void set_mptfo(int fd)
 {
 	int qlen = 25;
 
@@ -335,7 +335,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 			set_transparent(sock, pf);
 
 		if (cfg_sockopt_types.mptfo)
-			set_mptfo(sock, pf);
+			set_mptfo(sock);
 
 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
@@ -406,21 +406,18 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 				*peer = a;
 				break; /* success */
 			}
+			perror("sendto()");
 		} else {
 			if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
 				*peer = a;
 				break; /* success */
 			}
-		}
-		if (cfg_sockopt_types.mptfo) {
-			perror("sendto()");
-			close(sock);
-			sock = -1;
-		} else {
 			perror("connect()");
-			close(sock);
-			sock = -1;
 		}
+
+		/* error */
+		close(sock);
+		sock = -1;
 	}
 
 	freeaddrinfo(addr);

-- 
2.51.0

