Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D012442FD4;
	Thu, 17 Sep 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634226; cv=none; b=oY8/fBaF70OUq8D2G8wTIIcWqfLu8Wl62uM0mUY92HilCnsCuojlBxN91WdbecJjSSdioFMkyq1+s6iBg5DjN7rRAHb7pcm0B2BpzANQ1ImyMnIhKiQxXtYtb2FIfZkWAx+naSVq//hzxstUTEVX3zmJyM8++V3XiFnIZptUMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634226; c=relaxed/simple;
	bh=9FeaKZWi5iQOkFBE2tpEl9kMwPNQJRYAfnZLWehMj30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kS9uGrgN8jAkDFY46TcV6n6X9Rqsx1E4yyhRhbnk3AIL/BuD2UVEXybv0o7UVOs/znNhL8/Y8YAWbXwWyUCXFsRK8AxgpvQYsmhhHigo59OeBOlbI+yY/KYMom/BjLapw72XKkoIyGeG9mRZH6Ra7yUcCYVD9CDB3nLtnDlWGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWOSGRo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWOSGRo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033C81F000FF;
	Thu, 17 Sep 2026 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634206;
	bh=ymAdn1uTwYrM1RdKi+vWWG9q1gx1PN4qRudV/xEDgB0=;
	h=From:To:Cc:Subject:Date;
	b=cWOSGRo5NGfxnaDr3eUZn3GEFLA9LJ/drcncv2xEpZ0161ckk/wJyahKQ9c056Zgq
	 jKM5xbkxRDciMGswjN4YpAF+Tj3eugjkn2u679RDAP+uuTJGLL4QYUjcW3wfvAaxmh
	 Fy9NnBMDUTwjw31/RKsmfFUbwqP2FCKcbk8AmwcnRUSsAEL4Hn5qmsrw3a0DTuQ2e+
	 cN8z0elhM3sJKCk3EWefK9v89V4l6U3lE0lQfNrRy4J7Y8rrY33GBo2hHPUC+yEJye
	 ySKcE9ppojd/Ldd0XVEeRaJkKM4IZwvgsh8njuBVcQJPHrYMLTvqjkMLeths47s0Nf
	 6zDqtRzm6xibQ==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v3] bpf: drop duplicate check_app_limited in tcp_bpf_push
Date: Thu, 17 Sep 2026 16:36:34 +0800
Message-ID: <85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Before commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
MSG_SPLICE_PAGES"), do_tcp_sendpages() did not call
tcp_rate_check_app_limited() internally, so callers needed an explicit
tcp_rate_check_app_limited() to cover it. That commit replaced
do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which perform
the check on every path that queues data. The outer call became redundant
but was left in place.

The site changed here, tcp_bpf_push(), holds the socket lock and invokes
tcp_sendmsg_locked() on every iteration. The early-return paths in
tcp_sendmsg_locked() that skip tcp_rate_check_app_limited() -- the
MSG_ZEROCOPY allocation failure and MSG_FASTOPEN branches -- return
without queueing any MSG_SPLICE_PAGES data, so there is no functional
consequence from omitting the outer check.

A potential benefit of this change is that it facilitates future reuse of
tcp_bpf_push() for sockmap support in protocols beyond TCP, such as MPTCP.
Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
is a generic interface in struct proto_ops, this change allows us to switch
to different protocols via sk->sk_socket->ops->sendmsg_locked() without
carrying protocol-specific assumptions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Note:

This patch was originally part of my ongoing "MPTCP sockmap support"
series [1] (patch 5). Matthieu suggested converting it to a fix and sending
it directly to netdev. Removing the redundant tcp_rate_check_app_limited()
call benefits my subsequent MPTCP work: in patch 3 of that series, I
implement an MPTCP-specific mptcp_rate_check_app_limited() function and
call it in mptcp_sendmsg_locked(). This allows me to reuse tcp_bpf_push()
by simply replacing tcp_sendmsg_locked() with

		sk->sk_socket->ops->sendmsg_locked(),

without carrying protocol-specific assumptions.

v3:
 - send this patch separately to bpf as Jakub suggested.
 - update the commit log as bot+bpf-ci suggested.

v2:
 - drop the "Fixes" tags and update the prefixes and commit logs as Jiayuan
   suggested.
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789469930.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789368148.git.tanggeliang@kylinos.cn/

[1]
MPTCP sockmap support
https://lore.kernel.org/mptcp/b5f9e8d7-b738-1df6-3b5e-1d54cbbc663c@gmail.com/T/#t
---
 net/ipv4/tcp_bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e..d5fcf3ce4861 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -108,7 +108,6 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		off  = sge->offset;
 		page = sg_page(sge);
 
-		tcp_rate_check_app_limited(sk);
 retry:
 		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
-- 
2.53.0

