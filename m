Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3C4C77
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659119116; x=1690655116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ltvm2d7MetkZ1LmGuDxRWFZT12u4l81YtRDgSrXpnvg=;
  b=A75W5JV5scAAXBGWt/GDwWi0ZiyOZehx/q1qjSQr8q3cj3oqqtlwlIES
   xA22xa0sQkdRCXre1p/7WLRITje7aIJi6OVl566OzhWCr2/kWrVNdPGLp
   X/h+GT2c0doqAjuOdUBUjUaRaQakuQjSjkU7gaSTv7L2i578r60pxlYLj
   Zp/y2eNB7DlpEGLdoRGprPHWyJWaxQ4ykBFcteQpLxP2Gr/9XAH2yzh9k
   UJm8R1JF/RwGbeQEjzMWxXBMwRVFF9DiGuJvrP9Jes99YvdBInttF+FBw
   p2fm8MI14JE2+9CxlogvPf75pj0JhvgCVvFJnk5uGUA1RBTDs3F2II6Ez
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="290025906"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="290025906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 11:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="629468947"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 11:25:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oHUfi-000Bxp-0x;
	Fri, 29 Jul 2022 18:25:14 +0000
Date: Sat, 30 Jul 2022 02:24:20 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org
Subject: Re: [PATCH mptcp-next 2/4] mptcp: more accurate receive buffer
 updates
Message-ID: <202207300227.kYan1H1K-lkp@intel.com>
References: <63def511912bf79d6af065dccb155e9304932640.1659107989.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63def511912bf79d6af065dccb155e9304932640.1659107989.git.pabeni@redhat.com>

Hi Paolo,

I love your patch! Yet something to improve:

[auto build test ERROR on mptcp/export]
[also build test ERROR on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220729-233501
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220730/202207300227.kYan1H1K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c330a583c6d306ab637d187f0f981bfe4408caba
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220729-233501
        git checkout c330a583c6d306ab637d187f0f981bfe4408caba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_cleanup_rbuf':
>> net/ipv4/tcp.c:1609:21: error: implicit declaration of function 'is_tcpsk' [-Werror=implicit-function-declaration]
    1609 |                 if (is_tcpsk(sk))
         |                     ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_tcpsk +1609 net/ipv4/tcp.c

  1563	
  1564	/* Clean up the receive buffer for full frames taken by the user,
  1565	 * then send an ACK if necessary.  COPIED is the number of bytes
  1566	 * tcp_recvmsg has given to the user so far, it speeds up the
  1567	 * calculation of whether or not we must ACK for the sake of
  1568	 * a window update.
  1569	 */
  1570	void tcp_cleanup_rbuf(struct sock *sk, int copied)
  1571	{
  1572		struct tcp_sock *tp = tcp_sk(sk);
  1573		bool time_to_ack = false;
  1574	
  1575		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
  1576	
  1577		WARN(skb && !before(tp->copied_seq, TCP_SKB_CB(skb)->end_seq),
  1578		     "cleanup rbuf bug: copied %X seq %X rcvnxt %X\n",
  1579		     tp->copied_seq, TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt);
  1580	
  1581		if (inet_csk_ack_scheduled(sk)) {
  1582			const struct inet_connection_sock *icsk = inet_csk(sk);
  1583	
  1584			if (/* Once-per-two-segments ACK was not sent by tcp_input.c */
  1585			    tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||
  1586			    /*
  1587			     * If this read emptied read buffer, we send ACK, if
  1588			     * connection is not bidirectional, user drained
  1589			     * receive buffer and there was a small segment
  1590			     * in queue.
  1591			     */
  1592			    (copied > 0 &&
  1593			     ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED2) ||
  1594			      ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED) &&
  1595			       !inet_csk_in_pingpong_mode(sk))) &&
  1596			      !atomic_read(&sk->sk_rmem_alloc)))
  1597				time_to_ack = true;
  1598		}
  1599	
  1600		/* We send an ACK if we can now advertise a non-zero window
  1601		 * which has been raised "significantly".
  1602		 *
  1603		 * Even if window raised up to infinity, do not send window open ACK
  1604		 * in states, where we will not receive more. It is useless.
  1605		 */
  1606		if (copied > 0 && !time_to_ack && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
  1607			__u32 rcv_window_now = tcp_receive_window(tp);
  1608	
> 1609			if (is_tcpsk(sk))
  1610				mptcp_receive_window(sk, &rcv_window_now);
  1611	
  1612			/* Optimize, __tcp_select_window() is not cheap. */
  1613			if (2*rcv_window_now <= tp->window_clamp) {
  1614				__u32 new_window = __tcp_select_window(sk);
  1615	
  1616				/* Send ACK now, if this read freed lots of space
  1617				 * in our buffer. Certainly, new_window is new window.
  1618				 * We can advertise it now, if it is not less than current one.
  1619				 * "Lots" means "at least twice" here.
  1620				 */
  1621				if (new_window && new_window >= 2 * rcv_window_now)
  1622					time_to_ack = true;
  1623			}
  1624		}
  1625		if (time_to_ack)
  1626			tcp_send_ack(sk);
  1627	}
  1628	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
