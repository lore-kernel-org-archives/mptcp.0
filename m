Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711F626AC
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803779; cv=none; b=hUNoXjpDfBXiy+b0yKRKmumMEwKS7xZw2Q+KN80W1JmuxKwgy/aC7GW8s+l8nkPHASLxetUamJE92N35zkkDupWyYC5uLlAeHLij2w9WW66MGA9jZe2pZvEZ9aaxO+hYhk9lqqhNSseuR+guCKfkgajqM/2mAwmvuc+i5h3cdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803779; c=relaxed/simple;
	bh=2p0ikRhI653ZDIOjbhndPv7Hs64z5OCdoL0ZV+cAHtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0DurBWjf3nG23ooGWrQYE5by6ULLvZ+bVPTHSLv2KXtg2me+3J09wnMFrU7TFhgLP6JXfG/uAkrZYMOc33ukE9jf78kLDMcFBPxvEamL8oebmeI2UIHtMDDtrjE1nD+MYNi5UVq8Jk5KE76e/OHMTuVMceQVyQpTrFqkVb8OWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDV8qh8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDV8qh8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEE2C433C7;
	Thu,  1 Feb 2024 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803779;
	bh=2p0ikRhI653ZDIOjbhndPv7Hs64z5OCdoL0ZV+cAHtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cDV8qh8XNVEE4sS54VI3a+3lQBMlvHJ5/9bW8mmD/DJa5tsV/vJ+iSUbEhdHuDpRS
	 lG97aUAM6+ep0PThJ6aSgNIBM1E+KGHLBqDbc+G1RBNdaR1yXWBNFH4AyLtiT1LDD1
	 TWSoZnIThWsHR/we59bfyUhhyfGAduAikSYyaYO7qAr9vLoMB1R/pKFn7qf3cE74cf
	 k3EHp5a3bbfYOEcgl5aDfEIrtjORNJtAGNwDKvSXZVfJvBwbtu+yku+8WN4OusS/rt
	 vF9oxd3hb3KBRCt73Hgo49x9cAld9mvLmeAoQ3MmF9IZCk7wsbaDVFIR6ML2sCkR5b
	 0p8knxrkDfYrQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 01 Feb 2024 17:09:30 +0100
Subject: [PATCH mptcp-next v2 2/3] mptcp: check the protocol in tcp_sk()
 with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-mptcp-check-protocol-v2-2-1e253ef51990@kernel.org>
References: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
In-Reply-To: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2p0ikRhI653ZDIOjbhndPv7Hs64z5OCdoL0ZV+cAHtQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlu8I/dJn/bwu+LWmim5q+gk4VGQK637VMGNSEx
 oA6j6XVyOWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbvCPwAKCRD2t4JPQmmg
 cxYwD/9STxoyUAQ+G8Wy+q7dF9RFKh9h4jfR1DOUb8/sYQkoJePWGF00QrmR9wM9E5gNr+JIZ3S
 bRp4e7GdhcqfWBlw53WUixjneMRoPRMaYlXymFe8kd98H74QG+SQkAI6SfdL54lU6JnkYqAI7b9
 VUa1cjhwximhcDd21390b1Pjml7ANSVKj2nqTI6g223UaZnRE7TglekVZOqe3jDNWs1RtmvFkbw
 XwwD6wHSOiJgy87DzGBBvSDC7ztE/dxPV591EkTCXE59hB+Xn4wyOCWvutw3QEBcXG7GIZhBk4A
 FUNOgJBqXZDhcj5gwgfxcPvfj1NpJBOscz7EOZIOesrtdDN7UaOYQZiQO/ZuKHYIN9N5Vxp9hYJ
 ve4fECb3YfDvCKS8p5T7387AK9bcrQ4SxZxwTL1kfYLAwLUY2rSdfHRJ5E5o4rbWHSmRaTVQmPj
 ZwiAl+mNQQKldTjJIxh0RTi8irm1dQRx9YUWPdnxWO5U+FLM5UMgb/sFEH1kZX56Xks5Dw3Ixbo
 NZduBs405p1IIBDzcRYN7n4TgBqZ8bu4ztMOxqBLmeIbnkEHoDgkmiT0XVO9CivbtUSMQXpi8Z8
 F8XYLo5wjG2tTS+HsvdsIC4fj6pWeiz5kFTwFwYWwm1nwUlXX7qPCpeS6kbmS+nqbnMe/kgpSDP
 OBr61iyF+W10Ykg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when tcp_sk() is used with
a non tcp_sock structure.

This kind of mistake already happened a few times with MPTCP: when
wrongly using TCP-specific helpers with mptcp_sock pointers. On the
other hand, there are many 'tcp_xxx()' helpers that are taking a 'struct
sock' pointer as arguments, and some of them are only looking at fields
from 'struct sock', and nothing from 'struct tcp_sock'. It is then
tempting to use them with a 'struct mptcp_sock'.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-TCP socket is being used as a TCP one. 'tcp_sk()'
macro is then re-defined to add a WARN when an unexpected socket is
being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2:
    - Move from include/linux/tcp.h to net/mptcp/protocol.h: specific
      to TCP (Paolo)
    - Use a macro instead of an inlined function (Paolo)
    - Adapt the commit message after the recent changes.
---
 net/mptcp/protocol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eefd1397106d..f2473d9acae6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -348,6 +348,15 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 }
 
+#ifdef CONFIG_DEBUG_NET
+/* MPTCP-specific: we might (indirectly) call this helper with the wrong sk */
+#undef tcp_sk
+#define tcp_sk(ptr) ({								\
+	WARN_ON(ptr->sk_protocol != IPPROTO_TCP);				\
+	container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
+})
+#endif
+
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
 
 /* the msk socket don't use the backlog, also account for the bulk

-- 
2.43.0

