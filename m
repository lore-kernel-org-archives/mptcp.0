Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2DB2FAD
	for <mptcp@lists.linux.dev>; Tue,  8 Jun 2021 01:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=7XHlf
	C1dYFsHPN0wlFh/WYpUksuX+TFwuM+kBoZ08mc=; b=Mck+ujfzAUE5NC2ZDank8
	UCvahe5EeopPygCNtWtoCpeXz/Q56QkU7RQdmWC61QE/FyXry45eBeKNOTyE+Dfh
	7wOQgkRwSVbmNpR0oKFm6NIQyfxqk6fs/nAic6ccz0HB0TJ1cg2y0Br/YUoOU4E5
	rzUQtaRN8bLL7ealu09A1k=
Received: from [192.168.16.78] (unknown [110.80.1.45])
	by smtp9 (Coremail) with SMTP id DcCowACXnKDKxL5gpLCOFA--.54589S2;
	Tue, 08 Jun 2021 09:15:55 +0800 (CST)
Subject: Re: [PATCH] mptcp: fix warning in __skb_flow_dissect() when do syn
 cookie for subflow join
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <21423fd3-708f-fa57-c496-e50057db78e0@163.com>
 <36744bda70bf5200fbb43544daca75342341734d.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <73d9338a-76a2-6d46-447e-efbde76f6872@163.com>
Date: Tue, 8 Jun 2021 09:15:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <36744bda70bf5200fbb43544daca75342341734d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DcCowACXnKDKxL5gpLCOFA--.54589S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw17tFyrZFykJr43Gr4fuFg_yoWrGw4kpr
	45JFZrGrW8A3s5J3yYyrW7Xryqkw4qyF4rG3WFqF1kAF15uwnaq3W8Aw4UuFy7Jr4ru347
	Kr45Xa1kK3WkZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv5lbUUUUU=
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNwurkFWBkua-jgAAsW

Hi Paolo,

On 2021/6/7 19:07, Paolo Abeni wrote:
> Hello,
> 
> On Sat, 2021-06-05 at 11:24 +0800, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> I got the following warning message while doing the test:
>>
>> [   55.552626] TCP: request_sock_subflow: Possible SYN flooding on port 8099. Sending cookies.  Check SNMP counters.
>> [   55.553024] ------------[ cut here ]------------
>> [   55.553027] WARNING: CPU: 0 PID: 10 at net/core/flow_dissector.c:984 __skb_flow_dissect+0x280/0x1650
>> ...
>> [   55.553117] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.12.0+ #18
>> [   55.553121] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
>> [   55.553124] RIP: 0010:__skb_flow_dissect+0x280/0x1650
>> ...
>> [   55.553133] RSP: 0018:ffffb79580087770 EFLAGS: 00010246
>> [   55.553137] RAX: 0000000000000000 RBX: ffffffff8ddb58e0 RCX: ffffb79580087888
>> [   55.553139] RDX: ffffffff8ddb58e0 RSI: ffff8f7e4652b600 RDI: 0000000000000000
>> [   55.553141] RBP: ffffb79580087858 R08: 0000000000000000 R09: 0000000000000008
>> [   55.553143] R10: 000000008c622965 R11: 00000000d3313a5b R12: ffff8f7e4652b600
>> [   55.553146] R13: ffff8f7e465c9062 R14: 0000000000000000 R15: ffffb79580087888
>> [   55.553149] FS:  0000000000000000(0000) GS:ffff8f7f75e00000(0000) knlGS:0000000000000000
>> [   55.553152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   55.553154] CR2: 00007f73d1d19000 CR3: 0000000135e10004 CR4: 00000000003706f0
>> [   55.553160] Call Trace:
>> [   55.553166]  ? __sha256_final+0x67/0xd0
>> [   55.553173]  ? sha256+0x7e/0xa0
>> [   55.553177]  __skb_get_hash+0x57/0x210
>> [   55.553182]  subflow_init_req_cookie_join_save+0xac/0xc0
>> [   55.553189]  subflow_check_req+0x474/0x550
>> [   55.553195]  ? ip_route_output_key_hash+0x67/0x90
>> [   55.553200]  ? xfrm_lookup_route+0x1d/0xa0
>> [   55.553207]  subflow_v4_route_req+0x8e/0xd0
>> [   55.553212]  tcp_conn_request+0x31e/0xab0
>> [   55.553218]  ? selinux_socket_sock_rcv_skb+0x116/0x210
>> [   55.553224]  ? tcp_rcv_state_process+0x179/0x6d0
>> [   55.553229]  tcp_rcv_state_process+0x179/0x6d0
>> [   55.553235]  tcp_v4_do_rcv+0xaf/0x220
>> [   55.553239]  tcp_v4_rcv+0xce4/0xd80
>> [   55.553243]  ? ip_route_input_rcu+0x246/0x260
>> [   55.553248]  ip_protocol_deliver_rcu+0x35/0x1b0
>> [   55.553253]  ip_local_deliver_finish+0x44/0x50
>> [   55.553258]  ip_local_deliver+0x6c/0x110
>> [   55.553262]  ? ip_rcv_finish_core.isra.19+0x5a/0x400
>> [   55.553267]  ip_rcv+0xd1/0xe0
>> ...
>>
>> After debugging, I found in __skb_flow_dissect(), skb->dev and skb->sk are both NULL,
>> then net is NULL, and trigger WARN_ON_ONCE(!net), actually net is always NULL in this
>> code path.
>>
>> Code snippet in __skb_flow_dissect() that trigger warning:
>>   975         if (skb) {
>>   976                 if (!net) {
>>   977                         if (skb->dev)
>>   978                                 net = dev_net(skb->dev);
>>   979                         else if (skb->sk)
>>   980                                 net = sock_net(skb->sk);
>>   981                 }
>>   982         }
>>   983
>>   984         WARN_ON_ONCE(!net);
>>
>> skb->dev is set to NULL in tcp_v4_rcv(), and skb->sk is never set in this code path.
>> But for sk_state is TCP_NEW_SYN_RECV or TCP_TIME_WAIT, skb->dev is not set to NULL,
>> so we can remove skb->dev = NULL in tcp_v4_rcv()?
> 
> Thank you for the detailed report!
> 
> I'm unable to find easily any negative side effect to remove such
> assignment, still I'm more than a bit uneasy for such change.
> 
> The issue is clearly an mptcp-specific one, so I think event the fix
> should be mptcp-specific.
> 
> If the skb->hash is not available - !skb_get_hash_raw(skb) == 0, then
> we could fallback using an sk-derived hash, e.g. doing something alike
> what inet_ehashfn() does - with different seeds/secrets.
> 

I will try to prepare a new patch as your suggestion, Thanks!

> Cheers,
> 
> Paolo
> 

