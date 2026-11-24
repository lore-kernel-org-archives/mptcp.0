Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525681;
	b=rHeOJ7ju27BuQ6w0y+HcAIVdD+JQdcgrD4uuuwRnky3LUFX2hiODuFiJGjr7bptcQ3vV
	 rEdKrGQhntqDtVkW/KQYU1pBCib89wGsEHCV2M5QJIfTvNqJCPrYwg03dSOA/5+UFBTaa
	 FlhgAN5KDOUVxrlEZggm42VAaGWKYKXmeHjqr+vkhT/qcFGI3SsAfptxhs/dCh3VvMCZI
	 kpl8lIMMCmj6zb+9QvtMUhbNya/UvnMrdD07QtGGx2WWhoUjRwXjhvCPsN3/oNaWgltW1
	 5b2qanKeeH9tmCExvAIrZwFyWI6kPSt/1AxrCR4sHhVbLwWTnDLwMqB4BkJSZ3bizUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525681;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f/G0Fc0+8dzWPDQzsPiAzYB6o89KWN828G+K+hRqFNE=;
	b=Fy0eno0Xj1UECUWYzxP2+ZS8JqYHQXl2SMWAFdnMeA8rgddcotYf+U23dfW9qpUOZvYu
	 yZF4jAEhnRxpVUhj7NsntvzZylVyiz4J61Lxl+gVtolEu3FFutdYjWxypLAim6DGWQC+7
	 cF7LJpbA/c8oWsmF/CpCzEe20yTgSJkm0XGtF8BP8hzuvSSTotyBCHMFAGCVXBEx8cX5E
	 omRIvzrDxmYRF+N/WKNFa3xmmBYWciAwKg3GnadNEHbOr+fPIFIpcw37uW8ijbCrwMfJJ
	 Nf43uAeyWZzUJndBtSxAFF3f0GAMWHYCF5H2MXVyu/iCJyuUo5uIWdizueEFd72C3bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ODaOGWoN;
	arc=none smtp.remote-ip=95.215.58.190
Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD63606A32E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 13:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD63606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ODaOGWoN
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=e+WlsO9K9EpVleBqqJfkV1jawEX8Hcz/qMi1mhljrKA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795525678; v=1; x=1796130478;
 b=ODaOGWoNUu0cAybXn/jSPkqAUi8eNNegbM2E0oe1c19JQEI5xygj1/qwB/O+nCqceXM4NhwL
 58ll2NtAUJqPxAxbN17eEV6tTmsG2tou4nqGn8sfBh30SpEps9xATGqxdmXHMCEirT1Ksdz/kLY
 jkfjUOxzp5AUU/CSpqtE/yZc=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 45409a6f410f3181;
	Tue, 24 Nov 2026 13:07:58 +0000
X-Mizu-Trace-ID: 45409a6f410f3181
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 3/6] ipv4: raw: do not use skb_header_pointer() in icmp_filter()
Date: Tue, 24 Nov 2026 22:06:28 +0900
Message-ID: <20261124130631.1886963-4-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

raw_local_deliver() is called for every IPv4 packet delivered locally.

icmp_filter() passes the address of a local struct icmphdr to
skb_header_pointer(). Once inlined, this forces a stack canary
(CONFIG_STACKPROTECTOR_STRONG=y) into raw_local_deliver(), although
only ICMP packets matching a raw socket need the filter.

Prefer pskb_may_pull(), as commit a14d93179045 ("ipv6: do not use
skb_header_pointer() in icmpv6_filter()") did for IPv6.

skb->data already points to the transport header here.

skb->head can change, reload iph pointer in raw_v4_input().

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-95 (-95)
Function                                     old     new   delta
raw_local_deliver                            648     553     -95
Total: Before=24068073, After=24067978, chg -0.00%

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/raw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index f33a9dfc5309..f72163699040 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -140,16 +140,14 @@ EXPORT_SYMBOL_GPL(raw_v4_match);
  *	0 - deliver
  *	1 - block
  */
-static int icmp_filter(const struct sock *sk, const struct sk_buff *skb)
+static int icmp_filter(const struct sock *sk, struct sk_buff *skb)
 {
-	struct icmphdr _hdr;
 	const struct icmphdr *hdr;
 
-	hdr = skb_header_pointer(skb, skb_transport_offset(skb),
-				 sizeof(_hdr), &_hdr);
-	if (!hdr)
+	if (!pskb_may_pull(skb, sizeof(*hdr)))
 		return 1;
 
+	hdr = (const struct icmphdr *)skb->data;
 	if (hdr->type < 32) {
 		__u32 data = raw_sk(sk)->filter.data;
 
@@ -166,10 +164,10 @@ static int icmp_filter(const struct sock *sk, const struct sk_buff *skb)
  * RFC 1122: SHOULD pass TOS value up to the transport layer.
  * -> It does. And not only TOS, but all IP header.
  */
-static int raw_v4_input(struct net *net, struct sk_buff *skb,
-			const struct iphdr *iph, int hash)
+static int raw_v4_input(struct net *net, struct sk_buff *skb, int hash)
 {
 	int sdif = inet_sdif(skb);
+	const struct iphdr *iph;
 	struct hlist_head *hlist;
 	int dif = inet_iif(skb);
 	int delivered = 0;
@@ -178,13 +176,19 @@ static int raw_v4_input(struct net *net, struct sk_buff *skb,
 	hlist = &raw_v4_hashinfo.ht[hash];
 	rcu_read_lock();
 	sk_for_each_rcu(sk, hlist) {
+		iph = ip_hdr(skb);
 		if (!raw_v4_match(net, sk, iph->protocol,
 				  iph->saddr, iph->daddr, dif, sdif))
 			continue;
 
 		delivered = 1;
-		if ((iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) &&
-		    ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
+		if (iph->protocol == IPPROTO_ICMP) {
+			if (icmp_filter(sk, skb))
+				continue;
+			/* icmp_filter() might have changed skb->head. */
+			iph = ip_hdr(skb);
+		}
+		if (ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
 				   skb->dev->ifindex, sdif)) {
 			struct sk_buff *clone;
 
@@ -208,8 +212,7 @@ int raw_local_deliver(struct sk_buff *skb, int protocol)
 {
 	struct net *net = dev_net(skb->dev);
 
-	return raw_v4_input(net, skb, ip_hdr(skb),
-			    raw_hashfunc(net, protocol));
+	return raw_v4_input(net, skb, raw_hashfunc(net, protocol));
 }
 
 static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
-- 
2.43.0

