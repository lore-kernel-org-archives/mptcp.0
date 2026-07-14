Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441B35F60E
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993291; cv=none; b=dkEyv4E/apg8qtLUZ1dtK/LdwfqamnmIqRKO7jzwEJ1AQWlhIrPqH/INSmwceT1NpKuA1PwMOqWLAyIkHbzHlT/DFOfwHcAcMDkuWr1Qvr9EFTKVudgKwi6EpkUQsAhSY+b6kydTUyunjH+yB0yKZVNbcG1LXX/I4aDQPev/e70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993291; c=relaxed/simple;
	bh=OPDPE0HhhgP1DXo/LUUvORoh4kwkDCv76PPX+zlGhT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ+yoJ0diX//6ICareRFsHO+ZiXAvF69+FjWTONXtCVyUk055w7y2dD1uUGqaBiOHWAmQTQHfQdQI30m1dVr7TsI035FHwxyCEgaS4kcay2vG1VhvaBrYCEdsPURVFvad28waGkbdzS2QctO5fVY1z9iX5qgpSgR4v0NSZHTrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb2L3nhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb2L3nhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A9F1F00A3A;
	Tue, 14 Jul 2026 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993289;
	bh=4J6yRMd9/KhFkpLpWB4GjEihk1/CkkQS6sGiW7MxVcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zb2L3nhyw1gJe8JG5GDhda5wvXyXeqkTxrQ7RIcC2NxUCum1Z/xlooGDIh5ZHG7Wh
	 q3mzWBvSQnnIVIrk3eWiilIFrbkMOWGbF1OmdtIu3DPzoQ2/a8qZJQleMwyzQBiOfN
	 aKe48KdQ/gujbOrTvdY2DiC3kkD1KeqbH7lbJoZt+k6aIZjX3SqXcV9VCqYsEIRDz1
	 0VGiaOKKsnDJYi1b5Q1M2OcharIhZMN734lSE0T2n5LzstQ/FrHXKngO3gM6NMCfej
	 cZQS9wNBLghKI/ltVzqcf4ggTM1lSxMzTC0B3EvS8C/sl6VLimlKM4yD6WX1jAYf02
	 Mju0BQSgroQlg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/7] selftests: mptcp: connect: close listensock deterministically
Date: Tue, 14 Jul 2026 09:41:02 +0800
Message-ID: <4bf6678946cab7f6a48162a69e2cac493d2629c1.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In main_loop_s(), listensock was closed nondeterministically inside
maybe_close() during the accept loop, and error paths closed it without
tracking, leading to double-close or leaks across repeated iterations
(via goto again).

Fix by making maybe_close() return a bool indicating whether it closed
the fd, and track that per iteration. Funnel poll/accept error paths
through a single 'goto out' label and close the socket there only
if not already closed. Reset 'closed' at the 'again:' label so each
iteration starts with a fresh tracking state. This ensures exactly one
close per iteration in all cases.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4a941a780620..ddeea23aa00b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1282,12 +1282,15 @@ static void check_getpeername_connect(int fd)
 			cfg_host, a, cfg_port, b);
 }
 
-static void maybe_close(int fd)
+static bool maybe_close(int fd)
 {
 	unsigned int r = rand();
 
-	if (!(cfg_join || cfg_remove || cfg_repeat > 1) && (r & 1))
+	if (!(cfg_join || cfg_remove || cfg_repeat > 1) && (r & 1)) {
 		close(fd);
+		return true;
+	}
+	return false;
 }
 
 int main_loop_s(int listensock)
@@ -1297,27 +1300,30 @@ int main_loop_s(int listensock)
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
+	bool closed;
 	int err = 0;
 	int fd = 0;
 
 again:
+	closed = false;
 	polls.fd = listensock;
 	polls.events = POLLIN;
 
 	switch (poll(&polls, 1, poll_timeout)) {
 	case -1:
 		perror("poll");
-		return 1;
+		err = 1;
+		goto out;
 	case 0:
 		fprintf(stderr, "%s: timed out\n", __func__);
-		close(listensock);
-		return 2;
+		err = 2;
+		goto out;
 	}
 
 	salen = sizeof(ss);
 	remotesock = accept(listensock, (struct sockaddr *)&ss, &salen);
 	if (remotesock >= 0) {
-		maybe_close(listensock);
+		closed = maybe_close(listensock);
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
@@ -1333,7 +1339,8 @@ int main_loop_s(int listensock)
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
-		return 1;
+		err = 1;
+		goto out;
 	}
 
 	if (cfg_input)
@@ -1342,6 +1349,9 @@ int main_loop_s(int listensock)
 	if (!err && --cfg_repeat > 0)
 		goto again;
 
+out:
+	if (!closed)
+		close(listensock);
 	return err;
 }
 
-- 
2.53.0

