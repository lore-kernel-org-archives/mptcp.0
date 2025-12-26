Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BA1DFE26
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731246; cv=none; b=Fz2mGHjQ+GC/mkuvXkb8QIUajX1gpufUQxf4MeTJL0HKcKDM9yJF1/E60zl80biUHLQtb42V+2w5//vhKSshI4iBOpI2uwlK00jy/TZQj0IbBqHocrZgrWf3GaPXJtRfUAH7qc5+7HM95zM3hEmspuMtK56y76ixWi+j4zaixkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731246; c=relaxed/simple;
	bh=8EguqXF8awHx+bmrI9lqgUlarr8KMwXpgRyjVW9xOdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bq1L00DvtmsFuyhHOuIutzWgnBrVYRFoni2C1brYxJ2ZjAQUHFTiL4gXPjZtxMfTpXknCdJwzJd3qr5gt/6kiIRwsp08ntqI01kLrnZhjy02co3X5Js5yAKFvJsIbBfvccDK9s5O94fNE3SxYFnslLUYGUQ6D8APLxhrVRAH0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAU/2O4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAU/2O4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB73C113D0;
	Fri, 26 Dec 2025 06:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731245;
	bh=8EguqXF8awHx+bmrI9lqgUlarr8KMwXpgRyjVW9xOdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lAU/2O4Uinrp/2+lSgChjhpfWZ+FVpAteCLPejGd1E/dBVri7AGRe+XEkTuqYaMys
	 1i4lI5B/cc51/FvPN3q8rFebqSxGabuRjWFVj5QguIKLsG+FoR63LhrxwboLC/gqam
	 Yr7EzXDoi6GEruJu9tpCKIcalCthcJ9XVfeWrKprYBCVlVO5TFmhZiXoRtdossQL/t
	 nGmhTKDmDEroKboxr9PagAfMKZlhJ7hUxUYtL7+jnRfpIfdRfZ55SnFgVJEhMZDSWD
	 K6UvbfIgbJxfmcOmbnC43oqzBWcGSkOyIoBrcOdCYRQSketlDc9mWA2V8nUnuu4RLK
	 Aj/k4w6myS+XA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:24 +0100
Subject: [PATCH mptcp-next 10/11] selftests: mptcp: connect: fix
 maybe-uninitialize warn
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251226-mptcp-issue-603-v1-10-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8EguqXF8awHx+bmrI9lqgUlarr8KMwXpgRyjVW9xOdE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dB+7ffF/YNt0LDZh/8upVx1eCe/58T7lrO69njdr/
 wQHOLjf7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI+CmGv2LPO/Yoy1XGx+zv
 SVs352rDm5xFH60/xP2vFIz3UnK3vsjIMH29xq+7Nx9e3BN+U7O/Ndt30//M5A/rZrhY/TsVbb2
 lixMA
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

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b82df82e0594..27a93a25b142 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1353,8 +1353,8 @@ void xdisconnect(int fd)
 
 int main_loop(void)
 {
+	struct addrinfo *peer = NULL;
 	int fd = 0, ret, fd_in = 0;
-	struct addrinfo *peer;
 	struct wstate winfo;
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {

-- 
2.51.0

