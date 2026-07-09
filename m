Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677223DC4DA
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580824; cv=none; b=KxSEehmypdYTH5kxH7QQq72ln484tFis/k4PyFF9ryNXM3V5e2Ypr03ZSotQQ3hTVY0EnikFn4YlhavRvNAE3W71zehhPeK5XjtfmWmpSWUIGHc14te89gcbVYotwY9oWE7s1F50df5/jTGc6CE7m2PL3OA5deFuIGMtR/36Okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580824; c=relaxed/simple;
	bh=JUvA09XmgNXXYWzCac00mDcWliNE+6UkoO9DrbmCJqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV1S6lsbdTQGeVMxPcnGd2Fx2x5oL5YQJx1V9AuA/fSqkaUxXBQcVf/kLEhfZjLk4QfBhla/xA3nO+FzGGRF1a3v9MFKKGlaHzkDuLP/a7qnF8AAcXNkybvMmzVK4jeWnNNIngUGHR91bIlnO7TkpBjR10T3O+xc9wiNfDsBDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfRaebGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfRaebGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515131F000E9;
	Thu,  9 Jul 2026 07:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580821;
	bh=3su+Upk+IbKVZmWnvk7iNRdrlKbXNwKevsBEw0RoxA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfRaebGy636CrhKLyn/rPTxz+Rdp3Nz4AUVG+mWS26wasQKnl01mqTPZbOW9PF5BG
	 q8BTYQwqk4xU2BK6yCFGN3tM+zwdRtN6wBbXQ2R4guZ/ZXbpVPayEjHGj7pzuprBmJ
	 +28XeWBm0Kl9Ygn1vU38n0d6WprdssPr1fvv4/S+c6hVaN56Y0fCFObJxt3SzuLzxj
	 yDk05ud+NgGu0Cvk/QKpkSnxxtahFYD1KQO/1eNmcvMOAGk2ByhVih2wH6k9kymrYE
	 tnhNZEx/D5bxvTLDUrgihpmyHBvarf2md5JdEsYZkFf+VHdxaKFAauK9pckyRU+DJQ
	 iC9UrILKuNncw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/12] selftests: mptcp: sockopt: set TCP_INQ on accepted sockets
Date: Thu,  9 Jul 2026 15:06:12 +0800
Message-ID: <4365a32b22b7bb1364b3f5b5c0c038adaf99c722.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
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
connection.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 45dc85d10519..c6ced79e5814 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -718,6 +718,14 @@ static void process_one_client(int fd, int pipefd)
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
@@ -725,6 +733,9 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
+	if (inq)
+		do_setsockopt_inq(fd);
+
 	return fd;
 }
 
-- 
2.53.0

