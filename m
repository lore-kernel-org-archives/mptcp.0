Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0E71
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 06:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=tDpZY
	rEqvHE/8dxxq+VqeqdFtGE9W7HvpOltvZK67y0=; b=Ox4e/MAl9p9jTp7hlX2GG
	YeyhTOJLkbvwZfx8/KsFAQNzJSv52UnAGzri6/JJDyGbQcJX0iQKmoVOEY3xIZk7
	CWpm9IStAGsyva3zl2C4yskEmAkZKgm5cgje5NUJkfS9IZEGnIg7/B4qwiuaxJtL
	r4+BkTCxOIG9DmZ8hZ6WF0=
Received: from [10.8.1.202] (unknown [36.111.140.26])
	by smtp7 (Coremail) with SMTP id C8CowACntWVKLtBgghCMjA--.395S2;
	Mon, 21 Jun 2021 14:14:37 +0800 (CST)
Subject: Re: [PATCH v5 1/4] mptcp: fix warning in __skb_flow_dissect() when do
 syn cookie for subflow join
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
 <1623840570-42004-2-git-send-email-wujianguo106@163.com>
 <64212e1f-2b62-89dc-b4c5-b0c8bae51962@linux.intel.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <93307b1f-b402-885e-acd0-b5828a11395b@163.com>
Date: Mon, 21 Jun 2021 14:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <64212e1f-2b62-89dc-b4c5-b0c8bae51962@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:C8CowACntWVKLtBgghCMjA--.395S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AryrWw1fJFWxJw17GFyUJrb_yoW7Ww45pr
	W5GFZxGrW8A3s5J3yavFW7Xr98tr4vyFW8G3W5tF18AF1Duwn7J3W8Gw4j9Fy7Zr48C347
	Kr45X3WkK3ZrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdID7UUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJwi3kF5u+yVwRwACsT

Hi Mat,

On 2021/6/19 6:40, Mat Martineau wrote:
> 
> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
> 
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> I got the following warning message while doing the test:
> 
> Hi Jianguo, thanks for your patch set and revisions.
> 
> Could you explain some more about which test produced the following result? Was it one of the self tests?
> 
> If this is triggered by test code that is not upstream yet, it would help to add a selftest that shows if this bug is present or fixed. A packetdrill test is also an option, if that is a better way to reproduce the error.
> 

I tested with wrk(https://github.com/wg/wrk) and webfsd(https://github.com/ourway/webfsd) with the assistance of mptcp-tools(https://github.com/pabeni/mptcp-tools),
Server side:
    ./use_mptcp.sh webfsd -4 -R /tmp/ -p 8099
Client side:
    ./use_mptcp.sh wrk -c 200 -d 30 -t 4 http://192.168.174.129:8099/

I will try self tests.

> Code below looks fine, but would like to understand the test scenario better!
> 
> -Mat
> 
>>
>> [   55.552626] TCP: request_sock_subflow: Possible SYN flooding on port 8099. Sending cookies.  Check SNMP counters.
>> [   55.553024] ------------[ cut here ]------------
>> [   55.553027] WARNING: CPU: 0 PID: 10 at net/core/flow_dissector.c:984 __skb_flow_dissect+0x280/0x1650
>> ...
>> [   55.553117] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.12.0+ #18
>> [   55.553121] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
>> [   55.553124] RIP: 0010:__skb_flow_dissect+0x280/0x1650
>> ...
>> [   55.553133] RSP: 0018:ffffb79580087770 EFLAGS: 00010246
>> [   55.553137] RAX: 0000000000000000 RBX: ffffffff8ddb58e0 RCX: ffffb79580087888
>> [   55.553139] RDX: ffffffff8ddb58e0 RSI: ffff8f7e4652b600 RDI: 0000000000000000
>> [   55.553141] RBP: ffffb79580087858 R08: 0000000000000000 R09: 0000000000000008
>> [   55.553143] R10: 000000008c622965 R11: 00000000d3313a5b R12: ffff8f7e4652b600
>> [   55.553146] R13: ffff8f7e465c9062 R14: 0000000000000000 R15: ffffb79580087888
>> [   55.553149] FS:  0000000000000000(0000) GS:ffff8f7f75e00000(0000) knlGS:0000000000000000
>> [   55.553152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   55.553154] CR2: 00007f73d1d19000 CR3: 0000000135e10004 CR4: 00000000003706f0
>> [   55.553160] Call Trace:
>> [   55.553166]  ? __sha256_final+0x67/0xd0
>> [   55.553173]  ? sha256+0x7e/0xa0
>> [   55.553177]  __skb_get_hash+0x57/0x210
>> [   55.553182]  subflow_init_req_cookie_join_save+0xac/0xc0
>> [   55.553189]  subflow_check_req+0x474/0x550
>> [   55.553195]  ? ip_route_output_key_hash+0x67/0x90
>> [   55.553200]  ? xfrm_lookup_route+0x1d/0xa0
>> [   55.553207]  subflow_v4_route_req+0x8e/0xd0
>> [   55.553212]  tcp_conn_request+0x31e/0xab0
>> [   55.553218]  ? selinux_socket_sock_rcv_skb+0x116/0x210
>> [   55.553224]  ? tcp_rcv_state_process+0x179/0x6d0
>> [   55.553229]  tcp_rcv_state_process+0x179/0x6d0
>> [   55.553235]  tcp_v4_do_rcv+0xaf/0x220
>> [   55.553239]  tcp_v4_rcv+0xce4/0xd80
>> [   55.553243]  ? ip_route_input_rcu+0x246/0x260
>> [   55.553248]  ip_protocol_deliver_rcu+0x35/0x1b0
>> [   55.553253]  ip_local_deliver_finish+0x44/0x50
>> [   55.553258]  ip_local_deliver+0x6c/0x110
>> [   55.553262]  ? ip_rcv_finish_core.isra.19+0x5a/0x400
>> [   55.553267]  ip_rcv+0xd1/0xe0
>> ...
>>
>> After debugging, I found in __skb_flow_dissect(), skb->dev and skb->sk are both NULL,
>> then net is NULL, and trigger WARN_ON_ONCE(!net), actually net is always NULL in this
>> code path, as skb->dev is set to NULL in tcp_v4_rcv(), and skb->sk is never set.
>>
>> Code snippet in __skb_flow_dissect() that trigger warning:
>>  975         if (skb) {
>>  976                 if (!net) {
>>  977                         if (skb->dev)
>>  978                                 net = dev_net(skb->dev);
>>  979                         else if (skb->sk)
>>  980                                 net = sock_net(skb->sk);
>>  981                 }
>>  982         }
>>  983
>>  984         WARN_ON_ONCE(!net);
>>
>> So, using seq and transport header derived hash.
>>
>> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use").
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Suggested-by: Florian Westphal <fw@strlen.de>
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>> net/mptcp/syncookies.c | 16 +++++++++++++++-
>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
>> index abe0fd099746..37127781aee9 100644
>> --- a/net/mptcp/syncookies.c
>> +++ b/net/mptcp/syncookies.c
>> @@ -37,7 +37,21 @@ struct join_entry {
>>
>> static u32 mptcp_join_entry_hash(struct sk_buff *skb, struct net *net)
>> {
>> -    u32 i = skb_get_hash(skb) ^ net_hash_mix(net);
>> +    static u32 mptcp_join_hash_secret __read_mostly;
>> +    struct tcphdr *th = tcp_hdr(skb);
>> +    u32 seq, i;
>> +
>> +    net_get_random_once(&mptcp_join_hash_secret,
>> +                sizeof(mptcp_join_hash_secret));
>> +
>> +    if (th->syn)
>> +        seq = TCP_SKB_CB(skb)->seq;
>> +    else
>> +        seq = TCP_SKB_CB(skb)->seq - 1;
>> +
>> +    i = jhash_3words(seq, net_hash_mix(net),
>> +             (__force __u32)th->source << 16 | (__force __u32)th->dest,
>> +             mptcp_join_hash_secret);
>>
>>     return i % ARRAY_SIZE(join_entries);
>> }
>> -- 
>> 1.8.3.1
>>
>>
>>
> 
> -- 
> Mat Martineau
> Intel

