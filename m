Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4543CE59;
	Thu, 17 Sep 2026 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634550; cv=none; b=mhua1MTNdfx2KsIxIW6bu5hcFGGKAXxdsUUN/sRrPEylCt8boub2CdvFIfPK6lCp2otEHZuhuks2EUklBTR5YaI6zYl0EHzEC6/YyweEcLOvn3iUpGLJsSJCyGC++sBq57zxC9AeL3yPj1FB2zheZ0q3i1KVj1ZeGoj/Z2omvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634550; c=relaxed/simple;
	bh=q6HKl5LtjKuaoZ6SXHAUMkZedUXZ9cKfXJ+5gvF4DIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O98QCkFBoqH3SYvuflDey6ptrfdoS+ZrOquvvAFUtTVf6QL7Bh5rpLHbe3ST6wO8t4cXUH78Yf0aUUIoCEZc86BgPVACA5l/yUJRHN6tHT0IV8N8Tje78N8wETKWiRpKdt8v1Y/KZqFinGdoLU/gcidZNuSkzageyleH3kUpxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOLy/ev3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOLy/ev3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CEA1F00893;
	Thu, 17 Sep 2026 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634541;
	bh=veuI4Ecxd1GG/nHtTshN78zjGaDMSwbi+RzbA2u15EM=;
	h=From:To:Cc:Subject:Date;
	b=nOLy/ev3hCOesGlqpGnWMsTpdorPVis0ELdts6LYNqiKmmKWjJ9taVNzUGI2XDBl7
	 Q1Ilz8BZMZJmuqjto1s93REbULq9LdKsJ4XpF8OcQ0PzyjhHWy02jLMc23G5tR8CzH
	 zTBH8ExlZ2L5HmAKSlKiC/BEUyMh6MEFFUmZ0nuiro8+w4J0lkb900/26xWUPlaWKm
	 ln2jyAQ9I3bFPQZaX5LQLCJ15PSnGDmA8kdQYVrXkWM4NZ6ARM/v816q5s+DW647L7
	 PR+5hnxyqFiGdLxXb/9MaZzChrODyyC02af8BrsJ2m5wLCxgXBWGRL2Bohen7+wOI2
	 ePeTyr/3U9IAA==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH net-next v3] tls: drop duplicate check_app_limited in tls_push_sg
Date: Thu, 17 Sep 2026 16:42:06 +0800
Message-ID: <5bc803abb4e27054eaffc8b26db7812e6347b0dd.1789634247.git.tanggeliang@kylinos.cn>
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

The site changed here, tls_push_sg(), holds the socket lock and invokes
tcp_sendmsg_locked() on every iteration. The early-return paths in
tcp_sendmsg_locked() that skip tcp_rate_check_app_limited() -- the
MSG_ZEROCOPY allocation failure and MSG_FASTOPEN branches -- return
without queueing any MSG_SPLICE_PAGES data, so there is no functional
consequence from omitting the outer check.

A potential benefit of this change is that it facilitates future reuse of
tls_push_sg() for KTLS support in protocols beyond TCP, such as MPTCP.
Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
is a generic interface in struct proto_ops, this change allows us to switch
to different protocols via sk->sk_socket->ops->sendmsg_locked() without
carrying protocol-specific assumptions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Note:

The patch benefits my ongoing "MPTCP KTLS support" work [1]. In patch 9
of that series, I had defined a check_app_limited() interface in struct
tls_prot_ops, but this interface is unnecessary if we can drop this
redundant call.

v3:
 - send this patch separately to net-next as Jakub suggested.
 - update the commit log.

v2:
 - drop the "Fixes" tags and update the prefixes and commit logs as Jiayuan
   suggested.
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789469930.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789368148.git.tanggeliang@kylinos.cn/

[1]
MPTCP KTLS support
https://lore.kernel.org/netdev/cover.1782123118.git.tanggeliang@kylinos.cn/
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

