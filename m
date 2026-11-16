Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811150;
	b=kXche1Ux0fobQ5B0/huhyGdc0x6AHDdOpyPbtCtHHSRzAq+kALoYn3Dl4iP3EexxWUKc
	 /qucUlUIGnkKaxK0soE5nnM6Bq85Sew9ZCvzn6tcslIvHYzddY+L6MBStyNDYdMQyut8g
	 Tsr2JFLMOBWLwPI0t3KiFtUb6LYt74/AQsiq0Z1wTkBfQGGcRCwu63ZcvxbF6Mevd1pu/
	 NKL99pbXvq1qBQBgpARNUJ+kFH6DDWvzHJ7Ps1110o28cwMlfin8jKUm3aV/ZFSb1KAli
	 QzY7NOtqgcbaL8rp9OJUyTMGpeUk27acDiaFb8N3E8mZBa6gDBzdHt3vZMHAIIyCBPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811150;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=osTE/+9Jxwo1u3nbdKbq28GqIZe9m9AJ0cg4LPRjrAo=;
	b=gu2h4szIZYUkcC73GU1yd1U7OZ6xj07HAEHaa/L0hchpNtDFbnV6rXiyXWOk84lpRcdm
	 FFR+pGFA2l4TX3KVbTKICU/XGO6PXvLuAWQb+rGIu8WGLTn127+oG6CSEEc2/vphMHhbY
	 mAlhHxstcP16hmkUX8QYXswlwmcnEaJpDto6euAxs5l+AeIkmkmkb9L7JfO382UmBs++d
	 kmVEmO1XbPsHa676FCBR4/Bk3XnaqrJC2OMFylyyVhzxiLQmcZA4HX9XOFqVEnDjCUA3m
	 +rSJJqmf5vDWoLeiN5x1Bsvos9G4/TTgRQmvUaoN054R0vWmaT7qlRh+b6RF0/5ubyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9berdVp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC84606A331
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9berdVp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84481F000C9
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811150;
	bh=osTE/+9Jxwo1u3nbdKbq28GqIZe9m9AJ0cg4LPRjrAo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=d9berdVpkCsOaDM14fRwLq8a448SYxhlJZnLpAWuimCwW+SZmpkpQruuSDQM+6GRv
	 5uqpe36a+j2yO6rR+Q8J2j6hSlJ1bouU5g+Bfwd4QkIyBbLIVSapnmgKMZtk/330Sn
	 FqegpCzItcDdLgK2ud+1EHVSGI9pyGHF1iR5Y9zcWCcRjLf9J6sYZsXku6xEHC850w
	 L82imWNPxx3zo+ihqix8QynqlPwrnZjnFCdM/ddw411Pfg4vgAOcKvIYrbBez4teIw
	 +XrBRWop4hfJdc02q8LdRBS6I4HmfCIzkoqLYP54iP9kJnZhobMZPmzFdSko/gZfGL
	 Xc+4QaHrQVI3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 02/11] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Mon, 16 Nov 2026 14:38:55 +0800
Message-ID: <b10fc6fab784ca954d079569f58ed19155961e5d.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a SIOCINQ check in mptcp_connect's server mode when MPTFO is enabled
to detect TFO SIOCINQ overflow regressions.

Wait for MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED using poll() bounded by
poll_timeout, then check if SIOCINQ returns INT_MAX. Use poll() instead
of usleep() to detect dead connections via POLLHUP/POLLERR. Add SOL_MPTCP
fallback definition and handle ENOPROTOOPT/EOPNOTSUPP errors to skip the
wait for TCP or fallback sockets. Skip SIOCINQ check on timeout rather
than failing the test.

Add MPTCP expect_eof branch in do_recvmsg_cmsg() for new inq semantics:
set expect_eof when short read consumes exactly last_hint bytes and
tcp_inq.last becomes 0.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..3ae018a2a215 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -34,6 +34,7 @@
 #include <linux/time_types.h>
 #include <linux/sockios.h>
 #include <linux/compiler.h>
+#include <linux/mptcp.h>
 
 extern int optind;
 
@@ -43,6 +44,9 @@ extern int optind;
 #ifndef TCP_ULP
 #define TCP_ULP 31
 #endif
+#ifndef SOL_MPTCP
+#define SOL_MPTCP 284
+#endif
 
 static int  poll_timeout = 10 * 1000;
 static bool listen_mode;
@@ -571,6 +575,10 @@ static ssize_t do_recvmsg_cmsg(const int fd, char *buf, const size_t len)
 			} else {
 				tcp_inq.expect_eof = true;
 			}
+		} else if ((size_t)ret < len &&
+			   last_hint == (unsigned int)ret &&
+			   tcp_inq.last == 0) {
+			tcp_inq.expect_eof = true;
 		}
 	}
 
@@ -1176,6 +1184,48 @@ static void maybe_close(int fd)
 		close(fd);
 }
 
+static int wait_for_remote_key(int fd)
+{
+	struct mptcp_info info;
+	int timeout_ms = 10;
+	struct pollfd pfd;
+	int elapsed = 0;
+	socklen_t olen;
+	int ret;
+
+	pfd.fd = fd;
+	pfd.events = 0;
+
+	while (elapsed < poll_timeout || poll_timeout < 0) {
+		ret = poll(&pfd, 1, timeout_ms);
+		if (ret < 0) {
+			perror("TFO: poll");
+			return -1;
+		}
+
+		if (pfd.revents & (POLLHUP | POLLERR)) {
+			fprintf(stderr, "TFO: connection closed or reset\n");
+			return -1;
+		}
+
+		olen = sizeof(info);
+		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
+			/* Not an MPTCP socket (TCP or fallback), skip wait */
+			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
+				return 0;
+			perror("TFO: getsockopt(MPTCP_INFO)");
+			return -1;
+		}
+		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
+			return 0;
+
+		elapsed += timeout_ms;
+	}
+	fprintf(stderr,
+		"TFO: timeout waiting for remote key, skip SIOCINQ check\n");
+	return 1;
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -1207,6 +1257,25 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+			int ret;
+
+			ret = wait_for_remote_key(remotesock);
+			if (ret < 0) {
+				close(remotesock);
+				return 1;
+			}
+
+			if (ret == 0 &&
+			    ioctl(remotesock, SIOCINQ, &avail) == 0 &&
+			    avail == INT_MAX) {
+				fprintf(stderr, "TFO SIOCINQ overflow\n");
+				close(remotesock);
+				return 1;
+			}
+		}
+
 		if (cfg_input) {
 			fd = open(cfg_input, O_RDONLY);
 			if (fd < 0)
-- 
2.55.0

