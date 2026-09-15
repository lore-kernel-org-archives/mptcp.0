Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6154921B5;
	Tue, 15 Sep 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471200; cv=none; b=AB64cKhlvh/Gte155vOODN5PwiHNwwFZyNpkGRqXXcCXuBNFghWWrdkLtgmI7I/jNwMK7qTaodEHQGo3LQ2E5D8hFFjlAu8W3VYgsLR70ce5fe0cFa35mRD9SKNmT6Qtpfi2kP8ePpDjiNe2/KlpIKVlGe+sIapWyWBtZDURARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471200; c=relaxed/simple;
	bh=9ep/406Rb8nnAOQ9JDsuFzpTP2x1PWLPr3y6tACJdFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZWD+sJYMaE3h6WkIiQ4OBAxDZmzrDILJ0qT3H0hEse46WXAiy015bW/nwimQObPC8oi6py6zROvUrbrhKSdoP7SxMdxsoKFPhsSC5ucnRRswQFqE5hFDuQX2hzgd58fkhEZx+l+3KgETk41lkxhq1fqK1jRZsM141UOi2Tbwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uyvsl+9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uyvsl+9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811F91F00898;
	Tue, 15 Sep 2026 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471198;
	bh=QiA+5cZ8KyMykVw4PN+8CaI6Fu4uho+z9OgsW3ypx2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uyvsl+9iiUHuA6fthqcbIQDdk92In9KiRj5+2jOroEOPsDuhVAmj9MvmTu7CqoS5k
	 R5+/xMvUy7UwC4jdyb3Fu6k3EmvJq9gwavsxn6AMxEz/3AOsNt3GD4ryt1NvH905LO
	 IHHZzrR5GgiGOvS774uRPBFik6SUo4Eyyru3aQnEAn8IqzFCLu6vAfSTLx+P9hTOBs
	 ttkgtQ+k2DVNc0YhwxnVCMqlYQZpf4aDwNJSgutSKVjNeMMy9SaSi5sJsOS3QDF/1p
	 +U/+NviNV0ElHZT4YA3/84kqrNI6K9pJPRt5AwFAe0TAtQamUbpIAf+LWjVM+qS8tc
	 zC3lh89lrcQNg==
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
Subject: [PATCH bpf-next v2 1/2] bpf: drop duplicate check_app_limited in tcp_bpf_push
Date: Tue, 15 Sep 2026 19:19:31 +0800
Message-ID: <87e00ef420af81974b590f9057cc08234324d45d.1789469930.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789469930.git.tanggeliang@kylinos.cn>
References: <cover.1789469930.git.tanggeliang@kylinos.cn>
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
do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which always
provide the check internally. The outer call became redundant but was
left in place.

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

