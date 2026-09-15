Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B73496D3F;
	Tue, 15 Sep 2026 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471206; cv=none; b=PcXr/A1NlRATTDu9Xqt/AJaD+mPHPNF8rwMMfWv070UoqhS5ZUnmjVvd464smrbrfSR45Prm/Oi2ILlquP4R3Hf4vuQh2gVbDJ6yDVhq/NGgU2zWz84DRZyR1G3TS4B6DXJuW7Ozlb790CwcyqST9z2nxu7s0vhHile6FhIbxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471206; c=relaxed/simple;
	bh=vNUdFCVgdA62Cf8qEHEufNJbGZyIEnbO3FGfBJdJzvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7x5oZfIZspiBWhn6BlSuUcZibcLFb5NniBHK1MIyCj0Lwm1ck+4hC2Y43dFXpLdhPMTc/6JD/QMu4kCtYrfI7X+BucUmWW8VgzzahUOBRSgOmMa11pfnpFf+swMvnw+mb4IfyEBkOk4Rb2Z3aYsgGCvUuoYqnHHb8oCPkpaIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7Y3SWkM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7Y3SWkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFE41F000FF;
	Tue, 15 Sep 2026 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471205;
	bh=oacHrx6Ec/7yCmjpaG4M8wdAlOdhWbEJKeTsZaf8RgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7Y3SWkMZBCdk6HlmUnV7N98Ow6iZfAme4Jp8MwPEnyrA8ISr/bGKT56eOM1ZMFjH
	 3mCkX8JIu9jS5oVTRPM85NVlV9IoL4zIE+10xzy06zbdNBAffsebC2h0Ui/8YEvqyX
	 BfAY7AOcJZFlZCObRDEzLHncUNNs2E60O2/xmxH080v4qSLDzPTbqFXG5Tbs98i7kQ
	 QI4mjFTllqKL9zZD+zndyblYILQK4vCd7pSnAaMpCDGgiNQtFbkgtqdr5U5vw82of1
	 uj8ta17EuzDvtR69ASKurwiLB3VFTM5ZKQo0NB0XQunzhSKXDUVMsTUPDVntTBE21L
	 Pm+sR12T6enRg==
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
Subject: [PATCH net-next v2 2/2] tls: drop duplicate check_app_limited in tls_push_sg
Date: Tue, 15 Sep 2026 19:19:32 +0800
Message-ID: <34d03d3fcb5a953c1d5abeb160a58dc94465db3e.1789469930.git.tanggeliang@kylinos.cn>
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

The site changed here, tls_push_sg(), is a MSG_SPLICE_PAGES loop that holds
the socket lock and only iterates when size > 0; tcp_sendmsg_locked() is
invoked on every iteration with state identical to what the outer call
sees, so dropping the outer call is safe and behavior-preserving.

A potential benefit of this change is that it facilitates future reuse of
tls_push_sg() for KTLS support in protocols beyond TCP, such as MPTCP.
Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
is a generic interface in struct proto_ops, this change allows us to switch
to different protocols via sk->sk_socket->ops->sendmsg_locked() without
carrying protocol-specific assumptions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287aa5..8bdb78718a8d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -185,8 +185,6 @@ int tls_push_sg(struct sock *sk,
 
 	ctx->splicing_pages = true;
 	while (1) {
-		/* is sending application-limited? */
-		tcp_rate_check_app_limited(sk);
 		p = sg_page(sg);
 retry:
 		bvec_set_page(&bvec, p, size, offset);
-- 
2.53.0

