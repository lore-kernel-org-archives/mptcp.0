Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BC3A1E7B;
	Mon, 14 Sep 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370100; cv=none; b=OHodXZ7ziut2pCXpgZsVbXidWV4EHVQKMgqNerhRw+qQSGNsWdWOSpnho7kLc+e5IRl60i6Xd6cNeEesrR3v54vt3ZHRia8yoQBPUPRDiEiKkVfP9wk5j3WFl5Ucj7zPMmDF0I8J48poro00suoBv61FiXtT/f4g1zk9H9k3l30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370100; c=relaxed/simple;
	bh=u6eZwnr9Qog25gvbtV71AIo36IVpW+M08C6Npm5feBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmy74+1nbgBRIBn7pyLQFOcozqKHof/cx+94BzvcokvOvfDMXT7VUACshOhR/+XzC2gMYCUhpjBIbJpfY7/FQop3bcndXo6AiFAdD4xaOoRhevd1ADVpSk80TL5n9oeh7Dzq1M9j49SSQW/6/jJNJ82VYwqHnp+4P1m3YlbtTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkfzeTHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkfzeTHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156AD1F000FF;
	Mon, 14 Sep 2026 07:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370099;
	bh=FyZJD6MJ0jeHnpmG+9/IDGKlhedERJgYv0kIO2y1Dcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hkfzeTHJg5C6a3iRPW3WOm0YSFS8p2TpIVczrJix2VcbQBta+uz88z4ZHREfQG2dT
	 LooqN1J6vWHMSydHwevORasImc4hyILBY93D19pl/vVPYTDHBIQcr1PA7RmsYF/LEW
	 l6ieslsTm5aDzYFfLs84aOKyfB5G139CnKNAq+dMc2EYS5M+mey+gBwUx/z46a9OhQ
	 uQKfNuziRKxuepfVjWenenbRd/FM2bMMxEIhEbdmbbTntXGy2bgcqbMqtVqOfYTKrS
	 XjhYho2789sSt6ljl383EFVetu077yaHM8ogpjCdpv8F3UxBmSBo3dLn0iB4IbDEWf
	 qILgV02GNBk9g==
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
Subject: [PATCH net 2/2] tls: drop duplicate check_app_limited in tls_push_sg
Date: Mon, 14 Sep 2026 15:14:23 +0800
Message-ID: <d98eef55bd417f7166a30a9998a3b34e7f0b229d.1789368148.git.tanggeliang@kylinos.cn>
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

Fixes: e117dcfd646e ("tls: Inline do_tcp_sendpages()")
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

