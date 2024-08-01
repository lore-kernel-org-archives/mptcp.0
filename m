Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0618B489
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504113; cv=none; b=BeTzVsIKvdkNjyuIu80934cpGb2Fwvk+0Iwb3/GoRPke8/iDwOa2MdpudH9gc7FVStVg7u46o5eFhl58MiRW4v/hYJWDSzWnPMTae+mVETlfCgyjEm8xiddSjtQEpVc/BUD15Mh9tJzSmXJeuUKeMfEsmGfW5ujygdgUqd/1ISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504113; c=relaxed/simple;
	bh=P219Myx4oW/sivfPkepM8i1gWrkjmQvByhQh8DuwL0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaWKyj2SHQztgHiIin/KvklHntt/+CjKUoBq1ZYgtVPUVniqzC3S2ehHqelF4ud3nuVjY4iQHKP7mdc6+opnM8qDvaqavlyXAcD+irNNsaIWb3rj9n1hGLT4GGWRajSTGPmlgojvuKGceh0Ok//j8eIiBGp2bVsKUkQb653pCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdU1wLxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdU1wLxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0399CC32786;
	Thu,  1 Aug 2024 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504113;
	bh=P219Myx4oW/sivfPkepM8i1gWrkjmQvByhQh8DuwL0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdU1wLxinS4Y0Ph5IvvPGIp59q90frrnmaFMyAisSrmAGU64YdfnkYBDlaSL3HTgJ
	 neplxcjNp+U2IrsbXTKyKlOn6ipqhBVc5pmP4kgw8RhbZ2Pw5wEeE7VsoCMh4G5bV/
	 7Z1VokoQ0ncJxX2eg1VQQyDkD8r6UWJSaF5FE+23nLpcS2v4/hOZTEl38aG6JVOzPc
	 lsghxzkIQV9YClKuE3+avylMXT4OwaNuSmoJJraoGEfwql3/5tGdLo4X8FBr4A7ruz
	 FTGAJMkwYrRn2m3SdsGR16qlTQc9jeyjSLkm8CXq9iy7ApPDJFYmTOnFkw5oV1G3mo
	 j0FAYnBmw8zFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: enable io thread mode
Date: Thu,  1 Aug 2024 17:21:41 +0800
Message-ID: <fde5c2d7de9816aab48637225fc2c9a9df94bd20.1722502941.git.tanggeliang@kylinos.cn>
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

This patch adds a new parameter "listensock" for the client main_loop()
to support io thread mode tests. In it, invoke accept() to get the peer
socket and pass it to copyfd_io(), then to copyfd_io_thread().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 477969ba9653..bd61cf203501 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1372,9 +1372,9 @@ void xdisconnect(int fd, int addrlen)
 		xerror("can't disconnect: %d", errno);
 }
 
-int main_loop(void)
+int main_loop(int listensock)
 {
-	int fd = 0, ret, fd_in = 0;
+	int fd = 0, ret, fd_in = 0, peerfd = 1;
 	struct addrinfo *peer;
 	struct wstate winfo;
 
@@ -1389,6 +1389,19 @@ int main_loop(void)
 	if (fd < 0)
 		return 2;
 
+	if (cfg_mode == CFG_MODE_THREAD &&
+	    listensock >= 0) {
+		peerfd = accept(listensock, NULL, NULL);
+		while (peerfd == -1) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+
+		if (cfg_timeo)
+			settimeo(peerfd, cfg_timeo);
+	}
+
 again:
 	check_getpeername_connect(fd);
 
@@ -1407,7 +1420,7 @@ int main_loop(void)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
-	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
+	ret = copyfd_io(fd_in, fd, peerfd, 0, &winfo);
 	if (ret)
 		return ret;
 
@@ -1430,6 +1443,8 @@ int main_loop(void)
 		close(fd);
 	}
 
+	if (listensock >= 0)
+		close(listensock);
 	return 0;
 }
 
@@ -1630,9 +1645,11 @@ int main(int argc, char *argv[])
 			set_mark(fd, cfg_mark);
 		if (cfg_cmsg_types.cmsg_enabled)
 			apply_cmsg_types(fd, &cfg_cmsg_types);
+		if (cfg_mode == CFG_MODE_THREAD)
+			return main_loop(fd);
 
 		return main_loop_s(fd);
 	}
 
-	return main_loop();
+	return main_loop(-1);
 }
-- 
2.43.0

