Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626313C9C4
	for <mptcp@lists.linux.dev>; Mon, 27 Jan 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002576; cv=none; b=NcS1bMPgPtb3a//k/tpH7zPSrJT4r9cpRdN35E5GBz0ZlF/y7SL7WaQcOfp5H8YHwS9eX0vdEOPg1ykT0R4O+C7Hd6g8puI2AP5V03WnGXngjeerQH0zycG0gCtIcdjbyXT8/GxRtuEbrQmfbhiRjqZj6VlcZ2vuctbg+8qlsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002576; c=relaxed/simple;
	bh=SuS/wbAgCjfmHbhXEvfh4IQDBvU2/WKtH+153eEb+2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oM8bc6M14NE7vR7b5EjOUbkrKHlT90jUkXFQOQ5s9lx+emr+WZe0mbBRC1h3VKFb2CTTE/o3jDFV7sAbtYOUXzynZO6OmFPPR1+lc+mFU6vXLt2zeSqhj4P/h/jmBtoFLPdPY5u+F6nkRnghsSWtpVSbxNNIRvMdg17t0T5fnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4E9QByM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4E9QByM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A65C4CED2;
	Mon, 27 Jan 2025 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738002575;
	bh=SuS/wbAgCjfmHbhXEvfh4IQDBvU2/WKtH+153eEb+2Q=;
	h=From:Date:Subject:To:Cc:From;
	b=s4E9QByMaZgCa8+k3Gt2DRXJeM/SLzLMhF0LFHXHLzDNHvawBS158qulEHg/Nhxv8
	 lXyLG9ZFkQouavjYYzOdsSW997jJpXfSOaohq2OO0dfgKf8Cc3xPQQBbHjmp9u4wGU
	 fFZ8gSwyctIlbzSM/7gokFB9LMqktXs7bJidRBUJYY3goduQOp5YFpMnEn5kG8exM1
	 XLgN4xAg7h2n1FtX79JaxSKvMOCOzgZnHeeRaN458RuzEwjnm1yAMW/jSSrJ6bUSch
	 I5ySH263seWGvaQ8pkIxQ6X73efEAhnz1GXjnGpm6/8nariMn/HMYd8oMEzCuxQ60r
	 d1Kt6F7YsBDiw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jan 2025 19:29:29 +0100
Subject: [PATCH mptcp-net] selftests: mptcp: connect: -f: no reconnect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIjQl2cC/yWN0QqDMAxFf0XybMAWdG6/MnwobTIDrpYmjIH47
 yvz8Vw49xygVIUUHt0BlT6isucGru8griG/CCU1Bj/4cXD+hkobG6kpvovFghzU4rYr4bUGdpz
 SfRpnP0F7KZVYvv/CEy4lk8Fynj84kYOpfAAAAA==
X-Change-ID: 20250127-selftests-mptcp-fastclose-tests-af1fdd965826
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SuS/wbAgCjfmHbhXEvfh4IQDBvU2/WKtH+153eEb+2Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnl9COlJxsqD/VRkSN0QQG1gHxYPytIR4FbE3+g
 Nli7YjKmW+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5fQjgAKCRD2t4JPQmmg
 c4cVEACNV7sAQHTsfeCxpyE8SvCeZULa6aSO3fXFVrB2cy4E0N+mhJEw4E3KKWKovIJzXhEkD3r
 4fV18CW9BwsfdvXUwW21rvhapCJLnGB3L2vuenqDakRVOjly94UnBhhct1BW2AgwJ/eKTSETZmy
 fcRpNTpZXJeOg9UvYM6MDrUoIvwlpU8Z/QpmvQ+Hmk4+Z0lEIkJFK/qxVlU0/bytHSd/5xlqO7m
 P+i4mgm37zq94R1mNcrw8/WEViHAG6xwVM5Q2hJLZftxWxINVe85PV7QIXvMeZQBB4nS9OLJY7W
 8mYvuwEKPJpeG6VTw0G2MHXk9vpJZf/spev+iThXBu86fgJyDdcANTsTvXVVqP4VyrEsk2SaqPf
 tAyVDXkfZpLPW7jGoA6SLilzHueAeTo47Y0jpjBGZOIQ9sPd4z2wrPr8l0tFHHUpbRX9+cH9V3F
 bknMa6q0Ze5diMX37enyhSmDDOjhZfbEums5jukY7fg4AfkGekZd5tRQFvUBMh9GTv0SedDJ5q8
 2LlCQbi46m4kdrRnp7bU+RTeWSjWDybkxrkxOSAnKrz/Qn6eCSuYRZrUXJS++4grQoy0+Fyy40f
 /u5jxo/eJDDjdLQEBEv7bWpp/fcNKMCxYjVv4vAbyewGDgjApT8LJgwIlGWujGVTHKvemlClEaB
 7f8fH2FczB2JEgw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The '-f' parameter is there to force the kernel to emit MPTCP FASTCLOSE
by closing the connection with unread bytes in the receive queue.

The xdisconnect() helper was used to stop the connection, but it does
more than that: it will shut it down, then wait before reconnecting to
the same address. This causes the mptcp_join's "fastclose test" to fail
all the time.

This failure is due to a recent change, with commit 218cc166321f
("selftests: mptcp: avoid spurious errors on disconnect"), but that went
unnoticed because the test is currently ignored. The recent modification
only shown an existing issue: xdisconnect() doesn't need to be used
here, only the shutdown() part is needed.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- With the modification, the mptcp_join's "fastclose test" is still a
  bit unstable on my side with a debug kernel. I didn't try to fix that.
  This is tracked by this (old) issue:
  https://github.com/multipath-tcp/mptcp_net-next/issues/324
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 414addef9a4514c489ecd09249143fe0ce2af649..d240d02fa443a1cd802f0e705ab36db5c22063a8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1302,7 +1302,7 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd);
+		shutdown(fd, SHUT_WR);
 	} else if (--cfg_repeat > 0) {
 		xdisconnect(fd);
 

---
base-commit: ef015705ac0b0da25ea399d87f1fa2f545b2b3d5
change-id: 20250127-selftests-mptcp-fastclose-tests-af1fdd965826

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

