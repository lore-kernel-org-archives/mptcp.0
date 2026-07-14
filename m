Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006693769FF
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994956; cv=none; b=izVh1CoWrqMhW4hI4M7O9k0o+l+u2MFCdPNqagyn73ka3HrSPuji5R+Nj6AxjMQXRP4MO8Zb+EBCX0VWEdrb+JVwz0XT4bD9Q5NC8a5glOR9vRr3vZ+Vr27bt1sSwxmbI2tFD8FPooTvmS30NzICcdqkixEjekKcVUm+XnTRBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994956; c=relaxed/simple;
	bh=nY0nhfemzgBAfUBDzhNYkIYvReaOY7admvguETm0/S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwZC39aAvseI4gvQ7CCa1RLL53/6gjBz0pwQvqhgPwpFTQBNhWD0TJVnlX9kzAbOM+v90EqlDUMS8153pVRG9aNLG9V8XBUV+5pE7uHx+Q2huDDNlh2p0un7uJN72sVzyCwgjXAS3/kePkaMjRux4GDHkn+wRFJGUAAAgFiun7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWcs6NUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWcs6NUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C286B1F00A3D;
	Tue, 14 Jul 2026 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994954;
	bh=l2Us0jicaa2oFREbC9oh7qDh1V7BTGodvFmSVkyxxVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWcs6NUHtA1J15q2wLE7EdbA6jt5Obk3iY1ttpuJ6KiFjFzqBQqrANPrnuWcowcqw
	 NqV+dVrtBDGE9pNLx+iuUXc3uVNiWdZhQ1tC2yTCcZGZ4dI3eeEpllRZ8yzOx+Y1F1
	 wzNuKwWmhV+e8p/Msw1TupRMtaF3fJdSHPKiT0isDhvTImM35Ao0BrfT2VAIDmakKy
	 PZ5qEr9PJf5dDNDBfv9ZqfIA+eMl7EL/oLfRCrOnTOuHMUgCHEdJ2KLnPi7QmqwYC7
	 5ILfkHQ4XB4XKtr9t2eG+rpy3FvYx+lDlE8HEa7rXr62rsBjMoEJVC45v0YqjvIrmY
	 ZihFTmH7ZMlyw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 05/13] selftests: mptcp: sockopt: reseed RNG after fork
Date: Tue, 14 Jul 2026 10:08:50 +0800
Message-ID: <fb0d95fc7983fdacc7df405de8c38fb8f7ed575f.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

xfork() does not reseed the RNG in the child, so server and client
processes use the same rand() sequence. Restore the per-fork reseed
from mptcp_inq.c by calling init_rng() in the child, ensuring
independent random values for buffer contents and transfer sizes.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 7c44ea9f5f8c..241b9b82dabb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -129,6 +129,8 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void init_rng(void);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -804,6 +806,8 @@ static pid_t xfork(void)
 
 	if (p < 0)
 		die_perror("fork");
+	else if (p == 0)
+		init_rng();
 
 	return p;
 }
-- 
2.53.0

