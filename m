Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C18537E8
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572023; cv=none; b=rMoPNSA4KlXNyKyGlU/c8LawaVCmJRA5c+Q6DD6RprsVZK+9AYs8XeehJiVLPR/C2hcQA+PlnuJ9le6Lz4CTG0jV7mpsnXQizvOdwos9xqqF0l6g9FmLOrDpD1CW2d2Tag7GvwtXGE1FGFdUQhV4qB9FQi7z0vKcb6e27Cwr0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572023; c=relaxed/simple;
	bh=vOAxFH1bJADC2IqhAhz6QPC91chOGt/8Lkv6C4PokFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QX4L2XRvLL40n58yP/MhWaMOB9NQbmUm2AGBN9BebfF68+AviyjFxoRmCSk+Z4CT7l/XqojSEpN1RrGQiAFvHxHxvjjD/Rp31ExmCinycdQ2nlcaiBIXrrh1Ap+oEk/xdaz37yt7Ok9OoPPOwOOqRMl4dGlvrRHxaf0RYS7KO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEfYj7wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEfYj7wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8138C43390;
	Mon,  8 Apr 2024 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712572023;
	bh=vOAxFH1bJADC2IqhAhz6QPC91chOGt/8Lkv6C4PokFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEfYj7wcQosOXyzSS6v40XzDIpbapELQLrcUpHA+A+0OFdQJXrUupdHSMERV6ZUEY
	 Np2sy3sk0P8iv5HF0yUwSvysTvGBbkAHBYTLRlpDUNsdNpu3Gj9oMLvHlbs1Ac6Slo
	 uu6zbEMk7cQOG6gPgC17z4WJsITFCKEO4uxvCKMdzWtXPf4Mcopp/eGPYefJlBJN03
	 /a621a3U22Ng5XncCnUWQIbhRysitlWHvyUcXby1jEDXRYhNlY2Y73WZ0Nm4BVNtAN
	 E/JtGEV8RhLvQtUD29uY+RESL3TyQn13kHUY6UcTe2IAcZmB87iZWaWC5q5phUbbfK
	 NaNTbuxCAE0NA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/5] selftests/bpf: Support nonblock for send_recv_data
Date: Mon,  8 Apr 2024 18:26:49 +0800
Message-Id: <395f742e39fabb601e6eb951776bfe98a93cdb65.1712571740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712571740.git.tanggeliang@kylinos.cn>
References: <cover.1712571740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some tests, such as the MPTCP bpf tests, require send_recv_data helper
to run in nonblock mode.

This patch adds nonblock support for send_recv_data(). Check if it is
currently in nonblock mode, and if so, ignore EWOULDBLOCK to continue
sending and receiving. Also add a new helper set_nonblock() to set the
given socket to nonblock mode.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 19 ++++++++++++++++++-
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index d0579bf1697b..dac40307b032 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -507,6 +507,7 @@ struct send_recv_arg {
 static void *send_recv_server(void *arg)
 {
 	struct send_recv_arg *a = (struct send_recv_arg *)arg;
+	int flags = fcntl(a->fd, F_GETFL);
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
 	int err = 0, fd;
@@ -530,6 +531,8 @@ static void *send_recv_server(void *arg)
 		if (nr_sent == -1 && errno == EINTR)
 			continue;
 		if (nr_sent == -1) {
+			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
+				continue;
 			err = -errno;
 			break;
 		}
@@ -550,6 +553,7 @@ static void *send_recv_server(void *arg)
 
 void send_recv_data(int lfd, int fd, uint32_t total_bytes)
 {
+	int flags = fcntl(lfd, F_GETFL);
 	ssize_t nr_recv = 0, bytes = 0;
 	struct send_recv_arg arg = {
 		.fd	= lfd,
@@ -571,8 +575,11 @@ void send_recv_data(int lfd, int fd, uint32_t total_bytes)
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv == -1 && errno == EINTR)
 			continue;
-		if (nr_recv == -1)
+		if (nr_recv == -1) {
+			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
+				continue;
 			break;
+		}
 		bytes += nr_recv;
 	}
 
@@ -582,3 +589,13 @@ void send_recv_data(int lfd, int fd, uint32_t total_bytes)
 	pthread_join(srv_thread, &thread_ret);
 	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
 }
+
+int set_nonblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+
+	if (flags == -1)
+		return -1;
+
+	return fcntl(fd, F_SETFL, flags | O_NONBLOCK);
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 06baa87549d1..6589cf2013ca 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -72,6 +72,7 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 void send_recv_data(int lfd, int fd, uint32_t total_bytes);
+int set_nonblock(int fd);
 
 static __u16 csum_fold(__u32 csum)
 {
-- 
2.40.1

