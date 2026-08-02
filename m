Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C978C9C
	for <mptcp@lists.linux.dev>; Sun,  2 Aug 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692783; cv=none; b=NvjEmq5etqGATlHBDhlExdzZrOyTB3wrRps3rlM6f2zCRzHI7FF+5KViPdxDV/FIXFtZ0Ni5q8fl6A3OuHF7aq1x8ScunW/uWFjiFZwwwsNL/HCN+mk+072MGoGrqsx8KAmeLAr0mEMv7Btp7Z5xlrndFOs+gRBDk4l8900r/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692783; c=relaxed/simple;
	bh=6naE2L7vx9nK5QsOToCWVNUzelTHr6rEUscyHYz0zM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fFt8+6CuqMoSM/NC3U0ayP71rgLhxBEOVa1nMMnhdsoK5MnZu21ACB6vvgg2NUhIaMHusnwKh+nPGDYnlfk91Bu9dKuifrx79ay1GDwAxFpzSfLvXGTmDuUjUcz2zVDXW195GKdK8cPuYM1iLcpKAjW9COp+PWDhuPhh+qi9yTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlY2jTJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlY2jTJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3941F000E9;
	Sun,  2 Aug 2026 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692782;
	bh=/uqJ9haYjJjrNa2p7dmF/x4zzh0qEEHizEqZvh74I1E=;
	h=From:Date:Subject:To:Cc;
	b=HlY2jTJRFhKrOq4a5/Q8gxAUAchTmPNPYqPfz45cgvuKI+SE5a6gKCeVjaZmiLk0T
	 mlTdMttK6w0AnH98rt9xmpP7seXe5HacTI83jBWMkfPjCmkMdpE5kJn0HJqY06CZph
	 tVfdBoENihK3J86HsUmFYtCIV+SqqCxnvQlyo87V1/9YQJ+MP7bAN06mUnF4XXqPPp
	 W+lxxHpkVTFzgYpkvBZDebAn+CpDz94rlvlyZYpkJBg8dN0EPStnUtg1H/I7+45IKc
	 P8Vh1kvjiv/rs10NFvpijiwcFp2WS8GOPo6KYRUUes0Lv1Q1m9WTIOcz+2I/4g3Ode
	 SxrlquB3jQ9nA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Aug 2026 19:46:16 +0200
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: cover IP_RECVERR
 sockopt propagation"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-mptcp-squash-sft-recverr-v1-1-df5f5e366e7a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAwAf4X02SZliBp/xfiAo5OaOGc7CAnh3
 53weLncLWCswgbXagHlSUw+sUB9qMAPXXwySl8YHLkTXcjhO2Wf0L5jZwNayKjsJ1bFlqnpQ31
 uiI5Q8qQcZN7WN9iryHOG++5sfLzY5/8b1vUHBzmqgogAAAA=
X-Change-ID: 20260802-mptcp-squash-sft-recverr-5e03df173004
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Carlier <devnexen@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3249; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6naE2L7vx9nK5QsOToCWVNUzelTHr6rEUscyHYz0zM4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLym3JVH8qdM5R1UTRsaz2mv0pr2QHnO+n7Z+h/DF2d5
 upY6FzYUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJEpvowMP7zCL3q9EOy8+3Ph
 2oPdDorlWy/qG1d+2rm4adsfN+dLogz/83uEP+auvXxvbj2f7q0LPq3yG4uuGTOUa3rOzwvdWef
 FCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The CI validating the latest sefltests on stable kernels reported an
issue with the MPTCP Sockopt selftest:

  04 Mark v6                                           [ OK ]
  setsockopt recverr on: Operation not supported
  client exited, status=1
  05 SOL_MPTCP sockopt v4                              [FAIL]

That's normal, because this feature is not supported by these kernels.

Skip the new test when the feature is not supported by a kernel, but
keep failing if SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set
to 1.

While at it, also set the socket option name in the error message, to
quicker understand it is linked to the IP(V6)_RECVERR option, and not
a "receive error" type.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: David Carlier <devnexen@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 28 +++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index a51828112c43..d68515b7903b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -183,6 +183,13 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static bool expect_all_features(void)
+{
+	char *env = getenv("SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES");
+
+	return env && strcmp(env, "1") == 0;
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -797,14 +804,21 @@ static void test_ip_recverr_sockopt(int fd)
 	}
 
 	r = setsockopt(fd, level, optname, &one, sizeof(one));
-	if (r)
-		die_perror("setsockopt recverr on");
+	if (r) {
+		/* For older kernels not supporting IP(V6)_RECVERR yet */
+		if (errno == EOPNOTSUPP && !expect_all_features()) {
+			fprintf(stderr, "IP(V6)_RECVERR not supported, SKIP\n");
+			return;
+		}
+
+		die_perror("setsockopt IP(V6)_RECVERR on");
+	}
 
 	r = getsockopt(fd, level, optname, &val, &s);
 	if (r)
-		die_perror("getsockopt recverr on");
+		die_perror("getsockopt IP(V6)_RECVERR on");
 	if (s != sizeof(val) || val != one)
-		xerror("recverr on mismatch val=%d len=%u", val, s);
+		xerror("IP(V6)_RECVERR on mismatch val=%d len=%u", val, s);
 
 	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
 	if (r != -1 || errno != EAGAIN)
@@ -813,15 +827,15 @@ static void test_ip_recverr_sockopt(int fd)
 
 	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
 	if (r)
-		die_perror("setsockopt recverr off");
+		die_perror("setsockopt IP(V6)_RECVERR off");
 
 	val = -1;
 	s = sizeof(val);
 	r = getsockopt(fd, level, optname, &val, &s);
 	if (r)
-		die_perror("getsockopt recverr off");
+		die_perror("getsockopt IP(V6)_RECVERR off");
 	if (s != sizeof(val) || val != zero)
-		xerror("recverr off mismatch val=%d len=%u", val, s);
+		xerror("IP(V6)_RECVERR off mismatch val=%d len=%u", val, s);
 }
 
 static int client(int pipefd)

---
base-commit: 4cc6862c479597e623e4dab36bf9e82fa4289bcd
change-id: 20260802-mptcp-squash-sft-recverr-5e03df173004

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

