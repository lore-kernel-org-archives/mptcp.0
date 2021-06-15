Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD772
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 03:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=bMErQq/RHb9+Nv55IT
	915+/t6jItHEXB1wfDPx5DuKk=; b=lMcz2Auby9oDPxCmlM2M9I+K8sc+lecz50
	oeLjUxLWqVbOZYmWmha+BtxWhocZ4HPeHVw4rFzAs4UjWdfwlN3JJGsRR1ia9SNP
	ODA1Z1kYqJnDzVPgBORXn35ummV5OVRehj+1jssz3gzUAXvYgVS8rUOSdRi+1h0X
	ijx980a18=
Received: from localhost.localdomain.localdomain (unknown [110.80.1.45])
	by smtp10 (Coremail) with SMTP id DsCowAC3_2NMGMhgphfqOw--.24172S3;
	Tue, 15 Jun 2021 11:02:37 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH v4 1/4] mptcp: fix warning in __skb_flow_dissect() when do syn cookie for subflow join
Date: Tue, 15 Jun 2021 11:02:23 +0800
Message-Id: <1623726146-5911-2-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
References: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:DsCowAC3_2NMGMhgphfqOw--.24172S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DCrWfZFy3AFy7Gr17KFg_yoWrAr13pr
	45GrWDGrW8Jwn8Jr4YyFW7Xrn8Kr4qvFW8Gw1ayr1kJFs8Gwn2qFy8Jr40vFy7GrWYg347
	Kr1DJ3WkKFn7ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7mi_UUUUU=
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJw2ykF5u+ukiWQABsR
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

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

So, using seq and transport header derived hash.

Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use").
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/syncookies.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index abe0fd099746..37127781aee9 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -37,7 +37,21 @@ struct join_entry {
 
 static u32 mptcp_join_entry_hash(struct sk_buff *skb, struct net *net)
 {
-	u32 i = skb_get_hash(skb) ^ net_hash_mix(net);
+	static u32 mptcp_join_hash_secret __read_mostly;
+	struct tcphdr *th = tcp_hdr(skb);
+	u32 seq, i;
+
+	net_get_random_once(&mptcp_join_hash_secret,
+			    sizeof(mptcp_join_hash_secret));
+
+	if (th->syn)
+		seq = TCP_SKB_CB(skb)->seq;
+	else
+		seq = TCP_SKB_CB(skb)->seq - 1;
+
+	i = jhash_3words(seq, net_hash_mix(net),
+			 (__force __u32)th->source << 16 | (__force __u32)th->dest,
+			 mptcp_join_hash_secret);
 
 	return i % ARRAY_SIZE(join_entries);
 }
-- 
1.8.3.1

