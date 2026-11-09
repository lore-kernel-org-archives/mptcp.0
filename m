Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192975;
	b=h8ydbU4EUTCQZ+Ptl/B44DRh+6+eCozmw4M1acm767tAjcFlWPcaf7SHE9YSW1EX3LJ2
	 vZuUYrmgXcTqH/anRJUeUK1x6JdqBo6zBaUAi+Sy6qWs0d4qbg68YQSeSuBx4VixBxkOL
	 50fT2TLcLeTb9HRWqeRLSRsBShNCOAZ076OaF8+DS8re4UN+DpARIr4acrTmU2aW+XeSH
	 PcCNB8wBP3bU0uoDhty5bRuV6ESdt+ISHj3J6kYM4ZiPBZY0zwVS4VL+zORswrSrEmu8z
	 MgJpirWSXjCjgplrAktR/0NMrQTpPI/5203GxXVPMuGtBgec13+5pj18O1R+Akh/U1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192975;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RaQtkVcxzBk9BCoME2U3bmc9YHf7+BB9h58s0wdq0EY=;
	b=YBZcM/F7NtZqWNmOtg4CmHQndjadkuRAeFk/MFC1914Y+WANW8Nn5GbIKkStwQBN59RJ
	 8edbsx6/IJH0lDKc5SAxhJsO9KHKtnBBTvKtkpOgOJSbe2zq2S4SVhMqEnabQvRNwlUKW
	 JcLWVjQq4zftvoTUoGeMI64oRrd7JfoDuI5tVdmo0PiGVZkYifYona2OIyymzVtg+PC+e
	 vR6R0gKFmjkRuo4UKcoWRs2dNRl5l9LRQRAtvUkw0oF8QNKNlw7lAE94QZxGfh7NPf7bh
	 H3klORK1IaxrviOBLK+xEWSNYcqDiqYhuYftnB7EyTJZG9MpKg5XQR73FK7xHAfMhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FsBofEml;
	arc=none smtp.remote-ip=95.215.58.229
Received: from mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7A606A322
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 02:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B7A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FsBofEml
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=4k7ckGD6tUfxybB5EnqooZtc5aOl3FhWKSEZts3QU7E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794192973; v=1; x=1794797773;
 b=FsBofEmlRIbPlkk4ZDS8UDMWKDKHtQstweEMsT9a0++VR8XDkeu4s4aBCeZVmvwFfVTDzZXX
 rVQx/ia93GGLRIirb65+ELR85BxjnHFHA9RZYd2JA8hy/mxBQ0+1nXSSBANZlKYP/FDuL9v5obR
 wBeygGon3H0vcYLoFxiq6PTI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 07673be978d49c6a;
	Mon, 09 Nov 2026 02:56:12 +0000
X-Mizu-Trace-ID: 07673be978d49c6a
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paul Moore <paul@paul-moore.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Allison Henderson <achender@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next 02/14] inet: frags: annotate data-races around fqdir->timeout and fqdir->max_dist
Date: Mon,  9 Nov 2026 10:52:01 +0800
Message-ID: <20261109025425.328445-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fqdir->timeout and fqdir->max_dist are read without any lock while their
sysctl handlers update them with WRITE_ONCE(). Add READ_ONCE() to the
readers.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/inet_fragment.c | 2 +-
 net/ipv4/ip_fragment.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 0b8d22ffafca6..ba10aec88cc9b 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -415,7 +415,7 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		inet_frag_putn(q, 2);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	mod_timer(&q->timer, jiffies + READ_ONCE(fqdir->timeout));
 	spin_unlock_bh(&q->lock);
 	return q;
 }
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 36105dd192823..e70ef3fe5e331 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -89,7 +89,7 @@ static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
 
 	q->key.v4 = *key;
 	qp->ecn = 0;
-	if (q->fqdir->max_dist) {
+	if (READ_ONCE(q->fqdir->max_dist)) {
 		rcu_read_lock();
 		p = inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif);
 		if (p && !refcount_inc_not_zero(&p->refcnt))
@@ -220,7 +220,7 @@ static struct ipq *ip_find(struct net *net, struct iphdr *iph,
 static int ip_frag_too_far(struct ipq *qp)
 {
 	struct inet_peer *peer = qp->peer;
-	unsigned int max = qp->q.fqdir->max_dist;
+	unsigned int max = READ_ONCE(qp->q.fqdir->max_dist);
 	unsigned int start, end;
 
 	int rc;
@@ -242,7 +242,7 @@ static int ip_frag_too_far(struct ipq *qp)
 
 static int ip_frag_reinit(struct ipq *qp)
 {
-	if (!mod_timer_pending(&qp->q.timer, jiffies + qp->q.fqdir->timeout))
+	if (!mod_timer_pending(&qp->q.timer, jiffies + READ_ONCE(qp->q.fqdir->timeout)))
 		return -ETIMEDOUT;
 
 	inet_frag_queue_flush(&qp->q, SKB_DROP_REASON_FRAG_TOO_FAR);
-- 
2.43.0

