Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883D1E7C12
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028998; cv=none; b=JPQ+js7UfsAUrKQQdrMSpJUM/9cOv4usEY6AaZ7n60y7UuRRiencVjW5rF7/JMtCOcyL55Gk1RKSIwmtjfXjG28B4nTGRA3ufEbwrmGcEsXCNuUdC1njTDJNxALsiKONkdgoHfuoPIvPOpSYBTtbJm5euyDYgiq3QJ7Wni8FJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028998; c=relaxed/simple;
	bh=nSkCWhEECACEimkAzU2A48riHFQie4uOGMSXdBxqgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhNX+TKgdLygTWPBDb1PA4UDk+a40fE4hQvCpTOh8UoZJfPbtf9LmfcVy0qcJ/GV+XZB4QfxWQ4133+VvPQZMsOVENQtSMzTtIE+8SdsPCq0LdekkUuNhZMOLdD2+WHkNzb+Cskx3vX13vSC+LO/hXWvlTcKDI9QeoPjSCPIdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inMFuO1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inMFuO1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B4AC4CEE7;
	Fri,  1 Aug 2025 06:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754028998;
	bh=nSkCWhEECACEimkAzU2A48riHFQie4uOGMSXdBxqgUo=;
	h=From:To:Cc:Subject:Date:From;
	b=inMFuO1WcipwB4aOca7L9dVz5saT0QpRSV9wae5kalpYTqhIjHdysR0qqdkoKk2lq
	 YtTNYJY8pVnNjIl8fWkE5xjOSqrUxo8jcNpzAet7QA6hd171FXETiqAA37oTehl2Nd
	 WsF5v128LbOyBkZ07Q51eQzMROelrYPyMR+Elz/uMIYlEgM8wa2iunByoPL+UITu+X
	 nzT+468xIMqHDH5Ke7yPPQDJQDS2P3+69dPA5nmPh/NfUn0G17FDuY/IoV5kfJ+clM
	 e0tJd5JVucmfiPJvwMSUzMMClD9NbeD/SNs69GzODhO1ZCMaNayEjr2gS2QBYvS1o+
	 MjbjUKrsokCgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash-to "mptcp: setsockopt support for TCP_MD5SIG"
Date: Fri,  1 Aug 2025 14:16:32 +0800
Message-ID: <684f802c11ee237dd54b4922edeb5d31a2d364b8.1754028954.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Based-on: <cover.1753946671.git.tanggeliang@kylinos.cn>

Please update the commit log:
'''
Supporting TCP_MD5 socket option is required when MPTCP is used by
default when creating a socket, to keep the same behaviour as with
TCP. TCP_MD5 is not compatible with MPTCP, and it will cause a
fallback to TCP at the connection request, if MPTCP was requested.
This then fixes a "regression" compared to TCP.

This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
The implementation:
- Allows setting these options (getsockopt remains unsupported)
- Applies them only to the first subflow
- Forces fallback to TCP (since MD5 isn't compatible with MPTCP)

Setting these options triggers fallback to TCP to maintain MD5
compatibility.

Note that TCP_MD5SIG and TCP_MD5SIG_EXT getsockopts are unsupported for
TCP too.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
'''
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3ffdeca694be..55925ffc9051 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -835,7 +835,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
 	case TCP_MD5SIG_EXT:
-		__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK);
+		if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
+		    !__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK))
+			return 0;
 		fallthrough;
 #endif
 	case TCP_FASTOPEN:
-- 
2.48.1

