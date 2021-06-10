Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628572
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=V4U8V
	GIPScs250dEX3Ksv5D5Ie1IOyjuP6ltTQWgIAQ=; b=iENuMsemT5UV2WYkRwQsa
	D2xSOoe2cv4cyx9RGcV8MR+e9goYMGUMQS+MF056tiEoCAXbJ0yP57G60FXMq1yT
	9CQsYCag29qg0YPY7JRc21tECyJWpK/y07fGYWuPsBoQB2w+wO3uSLak7SmJXIeZ
	a7YOSyp2MsSz7k+jcw+bns=
Received: from [192.168.16.78] (unknown [110.86.5.93])
	by smtp7 (Coremail) with SMTP id C8CowACHfIxA28FgMOz1hA--.24106S2;
	Thu, 10 Jun 2021 17:28:33 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2 1/4] mptcp: fix warning in __skb_flow_dissect() when do syn
 cookie for subflow join
Message-ID: <ed5254b2-baa9-ea4c-df45-c61fa00622b9@163.com>
Date: Thu, 10 Jun 2021 17:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowACHfIxA28FgMOz1hA--.24106S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw43Jw1DWry3ZFW7Ar43ZFb_yoWxAr48pF
	45GrZxGrWkJ3W3GF4SyFWUZrn09r4vkFW5K343Kwn2yFn8Wwn2vFy8Gr40vFy7KrW0k347
	KFs7K3WkKFn7ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jEwZcUUUUU=
X-Originating-IP: [110.86.5.93]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiUQGtkFWBTQ8RgAAAsq

From: Jianguo Wu <wujianguo@chinatelecom.cn>

I got the following warning message while doing the test:

[   55.552626] TCP: request_sock_subflow: Possible SYN flooding on port 8099. Sending cookies.  Check SNMP counters.
[   55.553024] ------------[ cut here ]------------
[   55.553027] WARNING: CPU: 0 PID: 10 at net/core/flow_dissector.c:984 __skb_flow_dissect+0x280/0x1650
...
[   55.553117] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.12.0+ #18
[   55.553121] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   55.553124] RIP: 0010:__skb_flow_dissect+0x280/0x1650
...
[   55.553133] RSP: 0018:ffffb79580087770 EFLAGS: 00010246
[   55.553137] RAX: 0000000000000000 RBX: ffffffff8ddb58e0 RCX: ffffb79580087888
[   55.553139] RDX: ffffffff8ddb58e0 RSI: ffff8f7e4652b600 RDI: 0000000000000000
[   55.553141] RBP: ffffb79580087858 R08: 0000000000000000 R09: 0000000000000008
[   55.553143] R10: 000000008c622965 R11: 00000000d3313a5b R12: ffff8f7e4652b600
[   55.553146] R13: ffff8f7e465c9062 R14: 0000000000000000 R15: ffffb79580087888
[   55.553149] FS:  0000000000000000(0000) GS:ffff8f7f75e00000(0000) knlGS:0000000000000000
[   55.553152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.553154] CR2: 00007f73d1d19000 CR3: 0000000135e10004 CR4: 00000000003706f0
[   55.553160] Call Trace:
[   55.553166]  ? __sha256_final+0x67/0xd0
[   55.553173]  ? sha256+0x7e/0xa0
[   55.553177]  __skb_get_hash+0x57/0x210
[   55.553182]  subflow_init_req_cookie_join_save+0xac/0xc0
[   55.553189]  subflow_check_req+0x474/0x550
[   55.553195]  ? ip_route_output_key_hash+0x67/0x90
[   55.553200]  ? xfrm_lookup_route+0x1d/0xa0
[   55.553207]  subflow_v4_route_req+0x8e/0xd0
[   55.553212]  tcp_conn_request+0x31e/0xab0
[   55.553218]  ? selinux_socket_sock_rcv_skb+0x116/0x210
[   55.553224]  ? tcp_rcv_state_process+0x179/0x6d0
[   55.553229]  tcp_rcv_state_process+0x179/0x6d0
[   55.553235]  tcp_v4_do_rcv+0xaf/0x220
[   55.553239]  tcp_v4_rcv+0xce4/0xd80
[   55.553243]  ? ip_route_input_rcu+0x246/0x260
[   55.553248]  ip_protocol_deliver_rcu+0x35/0x1b0
[   55.553253]  ip_local_deliver_finish+0x44/0x50
[   55.553258]  ip_local_deliver+0x6c/0x110
[   55.553262]  ? ip_rcv_finish_core.isra.19+0x5a/0x400
[   55.553267]  ip_rcv+0xd1/0xe0
...

After debugging, I found in __skb_flow_dissect(), skb->dev and skb->sk are both NULL,
then net is NULL, and trigger WARN_ON_ONCE(!net), actually net is always NULL in this
code path, as skb->dev is set to NULL in tcp_v4_rcv(), and skb->sk is never set.

Code snippet in __skb_flow_dissect() that trigger warning:
  975         if (skb) {
  976                 if (!net) {
  977                         if (skb->dev)
  978                                 net = dev_net(skb->dev);
  979                         else if (skb->sk)
  980                                 net = sock_net(skb->sk);
  981                 }
  982         }
  983
  984         WARN_ON_ONCE(!net);

So, use 4-tuple derived hash.

Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use").
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/syncookies.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index abe0fd0..11721b3 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -35,13 +35,62 @@ struct join_entry {
 static struct join_entry join_entries[COOKIE_JOIN_SLOTS] __cacheline_aligned_in_smp;
 static spinlock_t join_entry_locks[COOKIE_JOIN_SLOTS] __cacheline_aligned_in_smp;

-static u32 mptcp_join_entry_hash(struct sk_buff *skb, struct net *net)
+static u32 mptcp_join_hashfn(const struct net *net, const __be32 laddr,
+			     const __be16 lport, const __be32 faddr,
+			     const __be16 fport)
 {
-	u32 i = skb_get_hash(skb) ^ net_hash_mix(net);
+	static u32 mptcp_join_hash_secret __read_mostly;
+	u32 i;
+
+	net_get_random_once(&mptcp_join_hash_secret,
+			    sizeof(mptcp_join_hash_secret));
+
+	i = jhash_3words((__force __u32) laddr,
+			 (__force __u32) faddr,
+			 ((__u32) lport) << 16 | (__force __u32)fport,
+			 mptcp_join_hash_secret + net_hash_mix(net));
+
+	return i % ARRAY_SIZE(join_entries);
+}
+
+static u32 mptcp_join_hashfn_inet6(const struct net *net,
+				   const struct in6_addr *laddr, const u16 lport,
+				   const struct in6_addr *faddr, const __be16 fport)
+{
+        static u32 mptcp_join_hash_secret_v6 __read_mostly;
+        static u32 ipv6_hash_secret __read_mostly;
+        u32 lhash, fhash, ports, i;
+
+        net_get_random_once(&mptcp_join_hash_secret_v6,
+			    sizeof(mptcp_join_hash_secret_v6));
+        net_get_random_once(&ipv6_hash_secret, sizeof(ipv6_hash_secret));
+
+        lhash = (__force u32)laddr->s6_addr32[3];
+        fhash = __ipv6_addr_jhash(faddr, ipv6_hash_secret);
+	ports = (((u32)lport) << 16) | (__force u32)fport;
+
+	i = jhash_3words(lhash, fhash, ports,
+			 mptcp_join_hash_secret_v6 + net_hash_mix(net));

 	return i % ARRAY_SIZE(join_entries);
 }

+static u32 mptcp_join_entry_hash(struct sk_buff *skb, struct net *net,
+				 unsigned short family)
+{
+	struct tcphdr *th = tcp_hdr(skb);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (family == AF_INET6 &&
+	    !ipv6_addr_v4mapped(&ipv6_hdr(skb)->saddr))
+		return mptcp_join_hashfn_inet6(net,
+					       &ipv6_hdr(skb)->daddr, th->dest,
+					       &ipv6_hdr(skb)->saddr, th->source);
+#endif
+	return mptcp_join_hashfn(net, ip_hdr(skb)->daddr, th->dest,
+				 ip_hdr(skb)->saddr, th->source);
+}
+
 static void mptcp_join_store_state(struct join_entry *entry,
 				   const struct mptcp_subflow_request_sock *subflow_req)
 {
@@ -58,7 +107,7 @@ void subflow_init_req_cookie_join_save(const struct mptcp_subflow_request_sock *
 				       struct sk_buff *skb)
 {
 	struct net *net = read_pnet(&subflow_req->sk.req.ireq_net);
-	u32 i = mptcp_join_entry_hash(skb, net);
+	u32 i = mptcp_join_entry_hash(skb, net, subflow_req->sk.req.ireq_family);

 	/* No use in waiting if other cpu is already using this slot --
 	 * would overwrite the data that got stored.
@@ -79,7 +128,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 					struct sk_buff *skb)
 {
 	struct net *net = read_pnet(&subflow_req->sk.req.ireq_net);
-	u32 i = mptcp_join_entry_hash(skb, net);
+	u32 i = mptcp_join_entry_hash(skb, net, subflow_req->sk.req.ireq_family);
 	struct mptcp_sock *msk;
 	struct join_entry *e;

-- 
1.8.3.1

