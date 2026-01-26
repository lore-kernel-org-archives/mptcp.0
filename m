Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608EE27877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455497; cv=none; b=HkfUTEA6Qbfi9Wl4wu18YK4AFu9qOBYvno5J9ztE0bYf+gFKJhUlSt8DvRi3GRIbtgcykIg+UQO0qFgayCuLMKgg8Knr5y9eNt6uKJE8ye+63JAuWOrc6iULgbCKSL2Gy9DmKr5wNHwpwRZ8ZCuQoKEDJ2Hy6rkPXpJ6SxczKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455497; c=relaxed/simple;
	bh=hK+yDv0v7+KVb+xYAFsvnyGIUmuxWx2Pvp3fAPsLWGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqPaqFU2je66zfWkGeQCTkcRkFPcqd5TXakER7/7wWORUQE4Vd704l+yPjrTe947b9JXO/dKZGZWuMQCTlR2pe1FCwisnsta6CG1Ou6Y1PwfqWdmfOHtCMeoshQgy3fXXUnlHCNHoSaXV9me27JkLZ9EeT9ylzFZOVY6jIyl+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/xVRBXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/xVRBXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E954C4AF0C;
	Mon, 26 Jan 2026 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455497;
	bh=hK+yDv0v7+KVb+xYAFsvnyGIUmuxWx2Pvp3fAPsLWGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L/xVRBXu2mWOptUbz9VZSVSPQYtjNBYWU0y2SGwv4ehg0zUolMULXSFzmFuLA3Ve7
	 cIHvXppOdzcqMHmZgk4kjmbm6IfR+iE0Vec8TdHYYCNVLTfWQ5sLcN0v4fFt3SPMot
	 yrFhdqcoYmJMgVNBjn+FqVGeijAIFdGQRgKsD0dTR3PXGRexA2+1GxFhYaZNIo1Kha
	 xIByglfd8GVOZX2CHVUuEq7RlNYYJRBCN0Fvoovg6zj6gAXEf/fk//n4rcKRlKnJlA
	 oDEnv0yUtBe20fYGAhj9AM148FNeDcCDuAHiltAdc0kabbw4TTn4UvFjPUWRm8DUgQ
	 xuGFyxiJhWoGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:47 +0100
Subject: [PATCH mptcp-net v2 10/11] selftests: mptcp: connect: fix
 maybe-uninitialize warn
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260126-mptcp-issue-603-v2-10-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hK+yDv0v7+KVb+xYAFsvnyGIUmuxWx2Pvp3fAPsLWGM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL99fFeKx8Ff3rh8zXY3w/ry7i0L47lcVXf/WZ3wcr/
 /+3n3pzT0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEvJgZ/gfH7OQ7x6/sflRY
 NC3YeZot6xLphb+idSZJz9PIMphxt42RYZL7UYG7pm3Rvuk7nj3+fkHAO/mGNoPLGqbYQH1Zjf6
 PzAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This warning can be seen with GCC 15.2:

  mptcp_connect.c: In function ‘main_loop’:
  mptcp_connect.c:1422:37: warning: ‘peer’ may be used uninitialized [-Wmaybe-uninitialized]
   1422 |                 if (connect(fd, peer->ai_addr, peer->ai_addrlen))
        |                                 ~~~~^~~~~~~~~
  mptcp_connect.c:1377:26: note: ‘peer’ was declared here
   1377 |         struct addrinfo *peer;
        |                          ^~~~

This variable is set in sock_connect_mptcp() in some conditions. If not,
this helper returns an error, and the program stops. So this is a false
positive, but better remove it by initialising peer to NULL.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 1c4fe60089a2..554886f23d6a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1354,8 +1354,8 @@ void xdisconnect(int fd)
 
 int main_loop(void)
 {
+	struct addrinfo *peer = NULL;
 	int fd = 0, ret, fd_in = 0;
-	struct addrinfo *peer;
 	struct wstate winfo;
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {

-- 
2.51.0

