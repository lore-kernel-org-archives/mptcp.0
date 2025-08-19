Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7124167B
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626736; cv=none; b=tEsqN4cua8Tvg5GkoFwqBaGuloRxKAgKtwzCUdOTikkmdurQahTP7DvjRb0Q4rDuEUcwL3v/1QnsZB2dnXhhlQurkII3lmwAuGPStU4o3I+WaKTcN1Yk5n565TtKgTXzE9zJoEhpHk7G6s50J5iachqd6tkXQrwK8zaApfNi7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626736; c=relaxed/simple;
	bh=bwqiHDo59aLWTqIGmAjdVp9Gs2B6ml5/S4ZCOhwBcFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bbWz3yWfrLUMVFJGh1M4HqwCf6z0A54YCR6RKGzkF5q0+mYoKyhW200wdu6hn/ymElBp1Wha00YAUDkJYe3K9ggJHD2+K/KDXv5tbQhZp6XE7xlsfBhbQUurJ/sLubB1XCvYvf3Qmkr6du0Ks63t8azpO0l5uF+cvU0QS6u2jgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+acDqlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+acDqlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083A0C4CEF4
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626736;
	bh=bwqiHDo59aLWTqIGmAjdVp9Gs2B6ml5/S4ZCOhwBcFs=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=r+acDqlAlhePVxS+LkPdDnNYdXOjizU+4+LAurlWsvB+3FF7QF0ttf8qg8Uj6PJD3
	 588i/BCJLT5WWRJdlCIxy7CWxwWFWjWjyhcbhWnS2sA10T7309FyPK4U4SNec2wG6b
	 EBAJp74IrYb98U7+uE9DdCkwl+IEtFcTT5qwi+uyfr/6nC4j7nkqkfZpEWGuaL2WCI
	 34RTr3MOhh/nMzDCQ4K1o2IfyCJ8QFuRPWn0D9W+xDOXiTRR4Ge+tLDrfI62boeicB
	 H7P7TqU4kb3sTrvim0/VdOgNGTWarXJPpK3rmsSIus6PFdGLcEHFoWaOLVzx7OI/wQ
	 YuPajrcZynZKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Aug 2025 20:05:21 +0200
Subject: [PATCH mptcp-net 1/3] selftests: mptcp: connect: catch IO errors
 on listen side
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-sft-mptcp-disc-err-v1-1-9d0cf296bc13@kernel.org>
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
To: mptcp@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bwqiHDo59aLWTqIGmAjdVp9Gs2B6ml5/S4ZCOhwBcFs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKW7HlzLTPo4cYvhyZ+ZbpyOUP8HLvti2iZklLuX2sZL
 NK1uNgyO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSXMnwVyQy/exCnejvLzk4
 t/Tf8np+JMdpU8Vk7s43m/qmb5hSNIXhr4y824bI5N3ntnKmbYhtr130e9t8dXNZXitvD7F05sz
 7HAA=
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
2.50.0

