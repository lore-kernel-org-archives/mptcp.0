Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A43914EB;
	Mon, 14 Sep 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370093; cv=none; b=nIv6wXk3WLAE0lbXgPIBmejVHv+jsmNf79Ip5SWjGcob0cS7hJP0lo8tWtMxCEfJ2RBLHKzDeKogXb6C+37/Sng1lpZXN6gKGDz1Zm9eyjg3EVu5QF8q07KjsEuHc8arNibDtj8D9rALr0/kGeCvCQHCLtDzwuNdz20e0A1RUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370093; c=relaxed/simple;
	bh=f/bc3PN+0K/cYJyiGkb9OET7EzoEE92IRxkxeIAzMco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmjKQ4Pna6BGttCry3iXa1Y2JyfBZahKR4NHeUw7Q8C8xphUgb/a2HTWkrWiukYYODpFSdvFbe8Pc9or+jy1sqD1VYP9PHQzwU7Z2D3nZspFWsWtI2Wcr9uQBNYEoYbZtq4KadnfVbq7MbwPuIkrMQBKXYDTDdCVtv/m7WtW+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os5ucEJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os5ucEJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F621F00893;
	Mon, 14 Sep 2026 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370092;
	bh=I95PlH1csWQb1mPfm/MPcbsz3Lc8y++FwVfm6lJbcAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Os5ucEJvV9P7XEF1yXwbl9JdrsEu1JQqAVfsKOtjZeEzwapuPbSwHwUWDDU6vFcRw
	 CokZUwdbbF4sd45KeACL3iGsDV/GFhu6pEnbs/979p2lMZfgHPPjYRn3LgEY955Y1K
	 StIqJe4xGDKsCIVTtjbIEvXxIcrTFh2Vggt6C4jwy9E2Dc1NEqL1vjbZVwbvnrx/u8
	 sw7KYZaDCj/s24+mk2+deOkIOVYZmhZgnF+DuZQzmQT77SrIHIdD/2iKEdvK9Am5wF
	 lRmggIwYoQFRhttUXn/MOARJR2ryycXy6NGHngF5H7cfCJ2pf0AtGaTBxFB/TmiTLm
	 ABkQR0AgNGBfQ==
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
	Sabrina Dubroca <sd@queasysnail.net>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf 1/2] bpf: drop duplicate check_app_limited in tcp_bpf_push
Date: Mon, 14 Sep 2026 15:14:22 +0800
Message-ID: <f12f1d886c8ff2b6f6e48f797ccc861037eda685.1789368148.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789368148.git.tanggeliang@kylinos.cn>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When the sendpage->MSG_SPLICE_PAGES migration series replaced
do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, callers that
had used do_tcp_sendpages() kept an explicit tcp_rate_check_app_limited(sk)
that was originally needed to cover do_tcp_sendpages() (which did not call
tcp_rate_check_app_limited()). After the inlining, tcp_sendmsg_locked()
always provides the check, and the outer call became redundant.

The site changed here, tcp_bpf_push(), is a MSG_SPLICE_PAGES loop that
holds the socket lock and only iterates when size > 0; tcp_sendmsg_locked()
is invoked on every iteration with state identical to what the outer call
sees, so dropping the outer call is safe and behavior-preserving.

A potential benefit of this change is that it facilitates future reuse of
tcp_bpf_push() for sockmap support in protocols beyond TCP, such as MPTCP.
Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
is a generic interface in struct proto_ops, this change allows us to switch
to different protocols via sk->sk_socket->ops->sendmsg_locked() without
carrying protocol-specific assumptions.

Fixes: ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
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

