Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF905227
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197775; cv=none; b=Ic9sXdW6YX6k+Ox1cca7yzZ1+VI32xYIidgIOpba0IObSKOqTBqmrqFfDUjDSf/8t9rXRibKVOWJ0GVZvzwpc1eBrxoPuKwKgZJphM+DwK7qgMo3x2OuPKgr+/GX5RCIn8HPmABJgu4dZ0NHjxRZTxkq8KDN+mVfBfLI7BuJG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197775; c=relaxed/simple;
	bh=p4fjbX8OKUbih1OHFyXHTZof4b3/RDY+G33UH3yUcHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtRhrdLIrY2dwIeUEKt1JzuP3yEDkQqFx6Ql9KdPd0NHluoC8RqggR1IIuwHtW5fTNl4+8ksUzMp+ZLFxjFdEhFqon2dIpoaGRfhakil572nyXJRkD36CI0jCWl1nLo9kxgTCMZiYR4wH2aFlsxzABokLOzXBFR2v1QYBWxHW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCj1IPDI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCj1IPDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2599C4CEE3;
	Fri, 11 Jul 2025 01:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752197775;
	bh=p4fjbX8OKUbih1OHFyXHTZof4b3/RDY+G33UH3yUcHg=;
	h=From:To:Cc:Subject:Date:From;
	b=oCj1IPDI/fIjdXsXrSJBvr7jA8uvgFbK5EtBXRTWkcVyWnTN/47eI8QAObaMMIYPJ
	 hfzwDi1EMAbIV3CLrUBo6VInzlv0MAwK+ck69AVNhIdrXDbIGfHwC+VpkJA3Jg7v9x
	 f/JX6/3Ib530cc5sZSBsf14VKHZXxgBVVqSJsn7hXa3WEVYGAJ0z9jwM2rjTKvTFrc
	 ejpmXOaca9sUPa9CeR/gCkf5SwWeV3nd+A5REnleOKrRZcm5mqIHdEVcuZTf1n4Ay7
	 DhULcGYar9qxzLziBFlLllDD9HAdiCKKiAtalCFyfxjmLswfJn1ZGpNJmyzU5iCLzy
	 ie8pJOS8lBuQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/2] Squash to "implement mptcp read_sock" v8
Date: Fri, 11 Jul 2025 09:36:04 +0800
Message-ID: <cover.1752197546.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - No need to handle "SOCK_DONE" in MPTCP, drop "SOCK_DONE" checks in
   mptcp_recvmsg and mptcp_splice_read.

v3:
 - rename mptcp_recv_should_stop to tcp_recv_should_stop and use it for
   TCP too.

v2:
 - use mptcp_recv_should_stop instead of
                if (sk->sk_err ||
                    sk->sk_state == TCP_CLOSE ||
                    (sk->sk_shutdown & RCV_SHUTDOWN) ||
                    !timeo ||
                    signal_pending(current))
  in mptcp_recvmsg.

 - use mptcp_recv_should_stop instead of
                if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
                    (sk->sk_shutdown & RCV_SHUTDOWN) ||
                    signal_pending(current))
   in mptcp_splice_read.

v1:
 Drop "shutdown" parameter of mptcp_recv_should_stop.

Based-on: <cover.1752045499.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: add recv_should_stop helper"
  Squash to "mptcp: implement .splice_read"

 include/net/tcp.h    | 23 ++++++++++++++
 net/ipv4/tcp.c       | 73 +++++++-----------------------------------
 net/mptcp/protocol.c | 75 +++++++++++++++-----------------------------
 3 files changed, 59 insertions(+), 112 deletions(-)

-- 
2.48.1

