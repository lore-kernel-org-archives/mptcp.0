Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F326D4D4
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096358; cv=none; b=i5yJ9ftiFm5lnGHelLz3emuUtB8y8WBUOH+qdCqpcMeePCLAjs8l4QNbPCXF8/RpkLsLTyO12Ttmd+KA9boMOiAsh93Pr7AhLG1LmUX62vT985cPtLL8+lqGPQ2/gSQYxjeOwJ7jVvfa+DwUHjlvdc7d11dMedoH/xZEkg87Zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096358; c=relaxed/simple;
	bh=TMdldyvLvCde8aHH3evkvxxwz/C/7SndolubxyHXYss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfjfzxwQ5pjzbVnx15/8aLldDzBarm4qvQFfEDJGHnlvB21JWiTGgXdmD7bnQEVEJiEh7n4xc1r3IkDp1AhTY3mTmVnkSCdE1yC1lSZK0bufqa8jBu2+R27zZhGR+KZKYsiMnX8n4hlsEg4yDGWoHjbdFM+ERPksziPdTsY3a7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkrAdrIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkrAdrIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2D0C4CEF1;
	Fri,  5 Sep 2025 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096357;
	bh=TMdldyvLvCde8aHH3evkvxxwz/C/7SndolubxyHXYss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BkrAdrIK78DjRQ0gQKCaF5r8Q9dLxEYFD/ws+7gGSsWg3XPi4a/qztRnywkHFxoRB
	 9lXeKl00CYbA7GjyUtOuViSo2focJLR35K8eoc7YSGovDJd11vvVfic7kxs7LxSuKR
	 8kCJEhheC5iNj5wDT/6fiu+SXyZm9Cj5rrWaxzygT7/dOwGrDeQ/1rbTvuKvznMU7n
	 z/uePiOUesAeKkgJ5nrR11GUpXEivw5jYStFaGboKA0XtSNHcuOiq+SVJZSwFBK+wa
	 UQHuw3FJ25JQZOuT0Kmuj6SaDZwoCWmZzYie87uDgZSKaobRNZwKoC1EvwBfMggvtZ
	 d5hkRbs9UHhkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Sep 2025 20:18:51 +0200
Subject: [PATCH mptcp-net v2 2/5] selftests: mptcp: connect: catch IO
 errors on listen side
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sft-mptcp-disc-err-v2-2-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TMdldyvLvCde8aHH3evkvxxwz/C/7SndolubxyHXYss=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2a86/uupYycyjj0+vbTQ1Xy70TJx/b5+ypFXP3PwnL
 iuiHH+bd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE6RXDf09Ne8sv83V+LuWK
 MLE5+uzNrLJzn2yKLq6UXbnP6VjpNnZGhobLJzftNHhoyn6pimFjUHDSFf6WlxVrZ4sKLpucmrz
 mChMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

IO errors were correctly printed to stderr, and propagated up to the
main loop for the server side, but the returned value was ignored. As a
consequence, the program for the listener side was no longer exiting
with an error code in case of IO issues.

Because of that, some issues might not have been seen. But very likely,
most issues either had an effect on the client side, or the file
transfer was not the expected one, e.g. the connection got reset before
the end. Still, it is better to fix this.

The main consequence of this issue is the error that was reported by the
selftests: the received and sent files were different, and the MIB
counters were not printed. Also, when such errors happened during the
'disconnect' tests, the program tried to continue until the timeout.

Now when an IO error is detected, the program exits directly with an
error.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4f07ac9fa207cb08a934582b98d688d0b9512f97..c1586a7286123a509495ac319fd624b98f0bfd18 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1112,6 +1112,8 @@ int main_loop_s(int listensock)
 	salen = sizeof(ss);
 	remotesock = accept(listensock, (struct sockaddr *)&ss, &salen);
 	if (remotesock >= 0) {
+		int err;
+
 		maybe_close(listensock);
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
@@ -1125,7 +1127,9 @@ int main_loop_s(int listensock)
 		SOCK_TEST_TCPULP(remotesock, 0);
 
 		memset(&winfo, 0, sizeof(winfo));
-		copyfd_io(fd, remotesock, 1, true, &winfo);
+		err = copyfd_io(fd, remotesock, 1, true, &winfo);
+		if (err)
+			return err;
 	} else {
 		perror("accept");
 		return 1;

-- 
2.51.0

