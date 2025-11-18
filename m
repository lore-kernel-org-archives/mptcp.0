Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A219ABD8
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438524; cv=none; b=I/QlxHP/AJMNxKDa9MJgl/pbsY8aIL75BwKXrW+BonbZ/7Bos3fvt3xh1XM8Ji/YNgC9RYcG9jUJ7rCREjl9QI4tnhQnci3Qeerna5h8llsz6IucPgIQN2QgZQROSe2MqRmTz96oqi7khAKyyTJHjfx21C0qPRsjBkcEbpwct34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438524; c=relaxed/simple;
	bh=Cq4iW++W7oDhQsSm0kqGrrk2eLbzHmcMQKCoPRF/5QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+wRerGN4saDz09QjHBFYOI6W44EqWkyvZ6LxZy/CLAG9cKEje+mDoLkTR5yY2EeoRO4Htt8DGPGl+dbz9GZHTzg057C8yYDGhk80Ee8E5ai1r+uV/OBZShjjL++5G8RpTRKqKRil744OhVWYz8w7JQxjYh1nn+mKpN+zSPNh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnR2sz5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnR2sz5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20623C116B1;
	Tue, 18 Nov 2025 04:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438524;
	bh=Cq4iW++W7oDhQsSm0kqGrrk2eLbzHmcMQKCoPRF/5QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnR2sz5ZOxPyOtIemW1je/UiRCeJoVswmeFesUZ0oe8ddddf+HFu+cxT4HHiyXug4
	 wyvXJfh0MoqE0PPxIaQ+YBKtwKoJTT2BLXlf4vcvKDKy/yE8HdrlAIod7CWqyCBRlH
	 BJsU8H5FpwQaQ4X+I8YBDjtEIdwZiOaWMIHeag115Q7MqIdMMGBiw9NQAzNxyuZIFw
	 5wFlapcRQ0cQ+wrwdB64+fbj3rSkESTYFHoCoDz4onmuvRP9hDjUCee+mH7IUJkUH4
	 bJykFiRViW0shjvgBtGc8unzsijqagCOQFvg6ESDIr3Sz2nFGLPxRqK9YhUHAiETdI
	 SAuhUlqDZz34A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 08/10] selftests: mptcp: connect: skip TLS in disconnect tests
Date: Tue, 18 Nov 2025 12:01:29 +0800
Message-ID: <0f303e07ce390055d0e68195530ae30ac33a2a5a.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Modify disconnect test scenarios to bypass TLS socket configuration
since TLS setup can interfere with connection teardown validation.
Add cfg_disconnect flag to control this behavior.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index deafcff7a2c8..e43874610297 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -79,6 +79,7 @@ static char *cfg_input;
 static int cfg_repeat = 1;
 static int cfg_truncate;
 static int cfg_rcv_trunc;
+static int cfg_disconnect = 0;
 
 struct cfg_cmsg_types {
 	unsigned int cmsg_enabled:1;
@@ -434,7 +435,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	}
 
 	freeaddrinfo(addr);
-	if (sock != -1)
+	if (sock != -1 && cfg_disconnect == 0)
 		SOCK_TEST_TCPULP(sock, proto, is_mptcp(sock));
 	return sock;
 }
@@ -1381,7 +1382,9 @@ int main_loop(void)
 again:
 	check_getpeername_connect(fd);
 
-	SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
+	/* Don't let TLS break disconnect tests */
+	if (cfg_disconnect == 0)
+		SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
 
 	if (cfg_rcvbuf)
 		set_rcvbuf(fd, cfg_rcvbuf);
@@ -1540,6 +1543,7 @@ static void parse_opts(int argc, char **argv)
 			break;
 		case 'I':
 			cfg_repeat = atoi(optarg);
+			cfg_disconnect = 1;
 			break;
 		case 'l':
 			listen_mode = true;
-- 
2.51.0

