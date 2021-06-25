Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6B2FB2
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=MakED
	ofQaD31KXIqAWQlN7hGzL79GYYHQbAu/3snnWQ=; b=FsWPFrpzGKrFd2VDxB7QQ
	4v+FzVOF7QUqhOVqJfHAmUiYoqbuXouJGMKrAFOtTq213B10Rn3qzUPJ3ImRhWcG
	ZlvzWO4qp1jTuXEN5GrSXuriSr8CmBp6L3stnoSPKe2Gf1wkQ8tZGbkxXiFvGMl0
	mnTkNFlQH6BjDTpJiFLdUQ=
Received: from [10.8.0.206] (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowADX3dXhhtVgaNOLrQ--.34698S2;
	Fri, 25 Jun 2021 15:33:55 +0800 (CST)
Subject: Re: [PATCH mptcp-net v6 4/5] mptcp: avoid processing packet if a
 subflow reset
To: kernel test robot <lkp@intel.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, pabeni@redhat.com,
 mathew.j.martineau@linux.intel.com
References: <1624589330-2579-5-git-send-email-wujianguo106@163.com>
 <202106251443.gKe4sNHn-lkp@intel.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <eca75d66-19ad-664d-47d1-aa2bc3c026bc@163.com>
Date: Fri, 25 Jun 2021 15:33:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202106251443.gKe4sNHn-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowADX3dXhhtVgaNOLrQ--.34698S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF1DXr4DJr47Ww4rXryDtrb_yoW7CFyrpa
	4qgr4DGr18JrZ5KrW8tF40qa4Ykrs5tr1fXrsYk347Ar4Ygw4Fvr95Kryagw48KFsYyry3
	JrW8tan7K3ZxJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtF4iUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9xO8kF2MZYFm7wAAs0

Sorry for the mistake, please ignore this series, I will send v7.

On 2021/6/25 14:40, kernel test robot wrote:
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on mptcp/export]
> [also build test ERROR on next-20210624]
> [cannot apply to kselftest/next linus/master v5.13-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/wujianguo106-163-com/Fix-some-mptcp-syncookie-process-bugs/20210625-110557
> base:   https://github.com/multipath-tcp/mptcp_net-next.git export
> config: i386-randconfig-a011-20210622 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/8bac278b64d6949fede4d0f383ca5f01fca11ef7
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review wujianguo106-163-com/Fix-some-mptcp-syncookie-process-bugs/20210625-110557
>         git checkout 8bac278b64d6949fede4d0f383ca5f01fca11ef7
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    net/ipv4/tcp_input.c: In function 'tcp_data_queue':
>>> net/ipv4/tcp_input.c:4950:25: error: invalid use of void expression
>     4950 |  if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
>          |                         ^
>    net/ipv4/tcp_input.c: In function 'tcp_rcv_state_process':
>    net/ipv4/tcp_input.c:6537:27: error: invalid use of void expression
>     6537 |    if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb))
>          |                           ^
> 
> 
> vim +4950 net/ipv4/tcp_input.c
> 
>   4940	
>   4941	static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>   4942	{
>   4943		struct tcp_sock *tp = tcp_sk(sk);
>   4944		bool fragstolen;
>   4945		int eaten;
>   4946	
>   4947		/* If a subflow has been reset, the packet should not continue
>   4948		 * to be processed, drop the packet.
>   4949		 */
>> 4950		if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
>   4951			__kfree_skb(skb);
>   4952			return;
>   4953		}
>   4954	
>   4955		if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>   4956			__kfree_skb(skb);
>   4957			return;
>   4958		}
>   4959		skb_dst_drop(skb);
>   4960		__skb_pull(skb, tcp_hdr(skb)->doff * 4);
>   4961	
>   4962		tp->rx_opt.dsack = 0;
>   4963	
>   4964		/*  Queue data for delivery to the user.
>   4965		 *  Packets in sequence go to the receive queue.
>   4966		 *  Out of sequence packets to the out_of_order_queue.
>   4967		 */
>   4968		if (TCP_SKB_CB(skb)->seq == tp->rcv_nxt) {
>   4969			if (tcp_receive_window(tp) == 0) {
>   4970				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
>   4971				goto out_of_window;
>   4972			}
>   4973	
>   4974			/* Ok. In sequence. In window. */
>   4975	queue_and_out:
>   4976			if (skb_queue_len(&sk->sk_receive_queue) == 0)
>   4977				sk_forced_mem_schedule(sk, skb->truesize);
>   4978			else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
>   4979				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
>   4980				sk->sk_data_ready(sk);
>   4981				goto drop;
>   4982			}
>   4983	
>   4984			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
>   4985			if (skb->len)
>   4986				tcp_event_data_recv(sk, skb);
>   4987			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
>   4988				tcp_fin(sk);
>   4989	
>   4990			if (!RB_EMPTY_ROOT(&tp->out_of_order_queue)) {
>   4991				tcp_ofo_queue(sk);
>   4992	
>   4993				/* RFC5681. 4.2. SHOULD send immediate ACK, when
>   4994				 * gap in queue is filled.
>   4995				 */
>   4996				if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
>   4997					inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
>   4998			}
>   4999	
>   5000			if (tp->rx_opt.num_sacks)
>   5001				tcp_sack_remove(tp);
>   5002	
>   5003			tcp_fast_path_check(sk);
>   5004	
>   5005			if (eaten > 0)
>   5006				kfree_skb_partial(skb, fragstolen);
>   5007			if (!sock_flag(sk, SOCK_DEAD))
>   5008				tcp_data_ready(sk);
>   5009			return;
>   5010		}
>   5011	
>   5012		if (!after(TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt)) {
>   5013			tcp_rcv_spurious_retrans(sk, skb);
>   5014			/* A retransmit, 2nd most common case.  Force an immediate ack. */
>   5015			NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKLOST);
>   5016			tcp_dsack_set(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
>   5017	
>   5018	out_of_window:
>   5019			tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
>   5020			inet_csk_schedule_ack(sk);
>   5021	drop:
>   5022			tcp_drop(sk, skb);
>   5023			return;
>   5024		}
>   5025	
>   5026		/* Out of window. F.e. zero window probe. */
>   5027		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt + tcp_receive_window(tp)))
>   5028			goto out_of_window;
>   5029	
>   5030		if (before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
>   5031			/* Partial packet, seq < rcv_next < end_seq */
>   5032			tcp_dsack_set(sk, TCP_SKB_CB(skb)->seq, tp->rcv_nxt);
>   5033	
>   5034			/* If window is closed, drop tail of packet. But after
>   5035			 * remembering D-SACK for its head made in previous line.
>   5036			 */
>   5037			if (!tcp_receive_window(tp)) {
>   5038				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
>   5039				goto out_of_window;
>   5040			}
>   5041			goto queue_and_out;
>   5042		}
>   5043	
>   5044		tcp_data_queue_ofo(sk, skb);
>   5045	}
>   5046	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

