Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F218B482
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504112; cv=none; b=tiVeFxlkP/JrXs8kdwLK07by7hHlZpg7JnRDAnn4T2x/dDrYXBPzJWE7iGnawWslKxiyWAjbSLJqpFDpBIoT3tsAI4FbtoCbpuVBViD4ih8iNFlLi/1V9w4dElmDeZkUSD2vmIk/oCAmlCEEq0vTy4CTJqxIfwOLo4JGYYWV8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504112; c=relaxed/simple;
	bh=j5KRxO4c9ioLsw+4TbFylU3IXiH9SkqnRK9GiS5QbAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+02BkAUOYCKz3ALWk7pco+g5/g7Fz3JuGEsRzHZayGdtiP/uiIPsJhnIuSHvRXiUWrL/ss0pGxSpv2zFuxAHjWxlcR/leLYgGEU0A0n9r+rBwGgnYr0cWTTd8doPFkD9/zSX4Hntcu5jQtvA6ayRwfJKnezrwvfzdPdIvxqSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFYGnR6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFYGnR6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C140C4AF0A;
	Thu,  1 Aug 2024 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504111;
	bh=j5KRxO4c9ioLsw+4TbFylU3IXiH9SkqnRK9GiS5QbAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFYGnR6SrIA6H2R8oHMdzGGlw9WSsakEKbSVf89K94Z1vueapa6a9L+oLlpuOXd63
	 1gWQ4KXs/uBK80F1GGUx4SXgvrIHe0IeHQwXZKfG204B3VEwI+zuVYW377KlgGwkOZ
	 3epPV/qZz0DVtUei/JgswSRq4qMbDBm57DOE7MrdJAkiEjB5BhDhDuJK4rINKqYlXk
	 IB3Jo9We/wQodqFEPdkpRW57pqPAKt28vS7kWiwdHH9qAV4bSPtbhRp94BfXWFcb7N
	 qdqRNDY5ZhfVCLNHq6YkRSlqKzZnRWIjX3gpobeb/agtmvoP1zj4t8RdWyKj31IMnc
	 NgQY5R7weIpYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: add io thread mode for mptcp_connect
Date: Thu,  1 Aug 2024 17:21:40 +0800
Message-ID: <f9916421f696012669a02d200f91a904df513cd6.1722502941.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722502941.git.tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new io mode "thread" for mptcp_connect, it creates a
new thread to send data meanwhile receiving data in main thread.

copyfd_io_thread() comes from BPF selftests network_helpers.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ce261a4bb324..477969ba9653 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -15,6 +15,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <time.h>
+#include <pthread.h>
 
 #include <sys/ioctl.h>
 #include <sys/poll.h>
@@ -24,6 +25,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <sys/param.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -49,6 +51,7 @@ enum cfg_mode {
 	CFG_MODE_POLL,
 	CFG_MODE_MMAP,
 	CFG_MODE_SENDFILE,
+	CFG_MODE_THREAD,
 };
 
 enum cfg_peek {
@@ -105,6 +108,8 @@ static struct tcp_inq_state tcp_inq;
 static struct cfg_cmsg_types cfg_cmsg_types;
 static struct cfg_sockopt_types cfg_sockopt_types;
 
+static unsigned int io_thread_total_bytes = 10 * 1024 * 1024;
+
 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "
@@ -139,6 +144,11 @@ static void die_usage(void)
 	exit(1);
 }
 
+static void *ERR_PTR(long error)
+{
+	return (void *)error;
+}
+
 static void xerror(const char *fmt, ...)
 {
 	va_list ap;
@@ -938,6 +948,94 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 	return err;
 }
 
+struct io_thread_arg {
+	int		fd;
+	uint32_t	bytes;
+	int		stop;
+};
+
+static void *send_thread(void *arg)
+{
+	struct io_thread_arg *a = (struct io_thread_arg *)arg;
+	ssize_t nr_sent = 0, bytes = 0;
+	int err = 0, fd = a->fd;
+	char batch[1500];
+
+	while (bytes < a->bytes && !a->stop) {
+		nr_sent = send(fd, &batch,
+			       MIN(a->bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent == -1 && errno == EINTR)
+			continue;
+		if (nr_sent == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_sent;
+	}
+
+	if (bytes != a->bytes) {
+		printf("send %zd expected %u\n", bytes, a->bytes);
+		if (!err)
+			err = bytes > a->bytes ? -E2BIG : -EINTR;
+	}
+
+	if (err) {
+		a->stop = 1;
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+static int copyfd_io_thread(int peerfd, int fd, uint32_t total_bytes)
+{
+	ssize_t nr_recv = 0, bytes = 0;
+	struct io_thread_arg arg = {
+		.fd	= fd,
+		.bytes	= total_bytes,
+		.stop	= 0,
+	};
+	pthread_t thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	err = pthread_create(&thread, NULL, send_thread, (void *)&arg);
+	if (err) {
+		printf("Failed to pthread_create\n");
+		goto done;
+	}
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !arg.stop) {
+		nr_recv = recv(peerfd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv == -1 && errno == EINTR)
+			continue;
+		if (nr_recv == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_recv;
+	}
+
+	if (bytes != total_bytes) {
+		printf("recv %zd expected %u\n", bytes, total_bytes);
+		if (!err)
+			err = bytes > total_bytes ? -E2BIG : -EINTR;
+	}
+
+	arg.stop = 1;
+	pthread_join(thread, &thread_ret);
+	if (thread_ret) {
+		printf("Failed in thread_ret %ld\n", (long)thread_ret);
+		err = err ? : (long)thread_ret;
+	}
+
+done:
+	close(peerfd);
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -970,6 +1068,11 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 					 &in_closed_after_out, winfo);
 		break;
 
+	case CFG_MODE_THREAD:
+		ret = copyfd_io_thread(peerfd, outfd,
+				       io_thread_total_bytes);
+		break;
+
 	default:
 		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
 
@@ -1352,6 +1455,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_MMAP;
 	if (!strcasecmp(mode, "sendfile"))
 		return CFG_MODE_SENDFILE;
+	if (!strcasecmp(mode, "thread"))
+		return CFG_MODE_THREAD;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
-- 
2.43.0

