Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFF2C82
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642338959; x=1673874959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hAQ+sdbYplGMrdYif2XrPZCmpywJLTfjziYEtUg2ZVs=;
  b=LUgY7ueGwSgNONe9oC+4EqbRBbsIIG4Uj+Qus91yJkvb1vNY8v6ppAna
   wKN6Icf3599dZA790gFOmBJV1oCfb9pBtfXUx9JYXxVdK8Pv5o8RoPn1Z
   uXIzhjGu+kVbVfzWOIm9cBrORmOo9fefu24rdOIM5oTZuri798lP30rga
   sL4d4rT59hS47E5lCD89Q8LYOz9hZ2nIJdzxPb3CRiPn63sgoK52aEQ7R
   9eAq/tnRgarszn2XgKmMqeUUg6t9KJZHGGp6j5anpGQrqm3zVqLVZN3IN
   xT8USKqMBUBHFy8QnVSjbtJJ5mUErQHNVSZvQb+umccTfN/TpwPkCvF7Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="305221191"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="305221191"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 05:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="530985471"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2022 05:15:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n95O1-000AiB-A1; Sun, 16 Jan 2022 13:15:57 +0000
Date: Sun, 16 Jan 2022 21:15:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Dmytro SHYTYI <dmytro@shytyi.net>
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
Message-ID: <202201162148.bSZpItDM-lkp@intel.com>
References: <20220116001259.203319-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116001259.203319-1-dmytro@shytyi.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Dmytro,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.16]
[cannot apply to net-next/master linus/master next-20220116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmytro-SHYTYI/net-mptcp-Fast-Open-Mechanism/20220116-081430
base:    df0cc57e057f18e44dac8e6c18aba47ab53202f9
config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20220116/202201162148.bSZpItDM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/52c7bf82e2e91eb10c89ef6169fe02e0b63a6772
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmytro-SHYTYI/net-mptcp-Fast-Open-Mechanism/20220116-081430
        git checkout 52c7bf82e2e91eb10c89ef6169fe02e0b63a6772
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/mptcp/protocol.c: In function 'mptcp_sendmsg_fastopen':
   net/mptcp/protocol.c:1650:8: error: implicit declaration of function 'sk_stream_alloc_skb'; did you mean 'tcp_stream_alloc_skb'? [-Werror=implicit-function-declaration]
    1650 |  skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
         |        ^~~~~~~~~~~~~~~~~~~
         |        tcp_stream_alloc_skb
>> net/mptcp/protocol.c:1650:6: warning: assignment to 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1650 |  skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
         |      ^
   cc1: some warnings being treated as errors


vim +1650 net/mptcp/protocol.c

  1635	
  1636	static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
  1637					  size_t len, struct mptcp_sock *msk, size_t copied)
  1638	{
  1639		const struct iphdr *iph;
  1640		struct ubuf_info *uarg;
  1641		struct sockaddr *uaddr;
  1642		struct sk_buff *skb;
  1643		struct tcp_sock *tp;
  1644		struct socket *ssk;
  1645		int ret;
  1646	
  1647		ssk = __mptcp_nmpc_socket(msk);
  1648		if (unlikely(!ssk))
  1649			goto out_EFAULT;
> 1650		skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
  1651		if (unlikely(!skb))
  1652			goto out_EFAULT;
  1653		iph = ip_hdr(skb);
  1654		if (unlikely(!iph))
  1655			goto out_EFAULT;
  1656		uarg = msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
  1657		if (unlikely(!uarg))
  1658			goto out_EFAULT;
  1659		uaddr = msg->msg_name;
  1660	
  1661		tp = tcp_sk(ssk->sk);
  1662		if (unlikely(!tp))
  1663			goto out_EFAULT;
  1664		if (!tp->fastopen_req)
  1665			tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req), ssk->sk->sk_allocation);
  1666	
  1667		if (unlikely(!tp->fastopen_req))
  1668			goto out_EFAULT;
  1669		tp->fastopen_req->data = msg;
  1670		tp->fastopen_req->size = len;
  1671		tp->fastopen_req->uarg = uarg;
  1672	
  1673		/* requests a cookie */
  1674		ret = mptcp_stream_connect(sk->sk_socket, uaddr,
  1675					   msg->msg_namelen, msg->msg_flags);
  1676	
  1677		return ret;
  1678	out_EFAULT:
  1679		ret = -EFAULT;
  1680		return ret;
  1681	}
  1682	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
