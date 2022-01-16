Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02693173
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 21:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642368304; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZdF5F3tnKRGuwGljsSfCwISrmId3LxgAdyt9vfddj3c5gCuHLHLzvcRbmtj2e9IDF8nU4q5n/yC8OBSxR0ub8+sTT4/d04i/q4/0NBZ/r72iF8enl1mr4l6N5iY3SEPZgNvNK3AGXTcxh34vm6T/nWh+b7YWvvOsigbZToxOXBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642368304; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=s0/AjwFnkzmo5Xusd+Ukg6PXBC3bkgMFpmIxAi9IgY0=; 
	b=AMnPv7RSaF/Eo+LIP2aktQxk8lvF0IGR4IV25C0t99EjNU79wvetDHjQG3/5dwl7dNGuym8nBfcDoPn1TIRLalzv4zWXRDLHAFVDh8dygSskkYp0ngS5btwkUgEZpcN3e8e9jsnB8vxehMqBhiGFxygWmLmxWKDUydMOh34SC5w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642368304;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s0/AjwFnkzmo5Xusd+Ukg6PXBC3bkgMFpmIxAi9IgY0=;
	b=VuOQ41R6FUSKwdEOQynfqJ9WKsZ7ovO86bJPFTooMGuJH+oFyz0c2SH9b/rT3kTE
	ah51q6mkIPzlw5Yu5PO+bM+SENPFfZRFVyuXtRMcRWIaD8Fpnlly4sSl2zBR6xjvqVw
	JCw2zY72ce9mBfwbgP8vGCA0EjwtbOOaPwicu23k=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642368302053202.35318548853536; Sun, 16 Jan 2022 22:25:02 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <202201162148.bSZpItDM-lkp@intel.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <5c970a8d-008c-059f-b263-c46ee9f1a29c@shytyi.net>
Date: Sun, 16 Jan 2022 21:24:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202201162148.bSZpItDM-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

I think i fixed this locally but I'm not going to submit a new patch 
with a correction to avoid CI resource wasting. I wait until major change.
If you think it might be interesting to upload a new patch with this 
minor change, please let me know.

sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
| ^~~~~~~~~~~~~~~~~~~
| tcp_stream_alloc_skb

Also I'm curious as this patch is failed to apply to current master, but 
I don't know the reason (which conflict do I have?)... ...locally I 
successfully build this patch against: 5.16.0-rc8 met-next
Auto-merging net/mptcp/subflow.cCONFLICT (content): Merge conflict in 
net/mptcp/subflow.c
Auto-merging net/mptcp/sockopt.cCONFLICT (content): Merge conflict in 
net/mptcp/sockopt.c

Thanks for your advice.

Dmytro.


On 16/01/2022 13:15, kernel test robot wrote:
> Hi Dmytro,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on v5.16]
> [cannot apply to net-next/master linus/master next-20220116]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Dmytro-SHYTYI/net-mptcp-Fast-Open-Mechanism/20220116-081430
> base:    df0cc57e057f18e44dac8e6c18aba47ab53202f9
> config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20220116/202201162148.bSZpItDM-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/0day-ci/linux/commit/52c7bf82e2e91eb10c89ef6169fe02e0b63a6772
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Dmytro-SHYTYI/net-mptcp-Fast-Open-Mechanism/20220116-081430
>          git checkout 52c7bf82e2e91eb10c89ef6169fe02e0b63a6772
>          # save the config file to linux build tree
>          mkdir build_dir
>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/mptcp/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     net/mptcp/protocol.c: In function 'mptcp_sendmsg_fastopen':
>     net/mptcp/protocol.c:1650:8: error: implicit declaration of function 'sk_stream_alloc_skb'; did you mean 'tcp_stream_alloc_skb'? [-Werror=implicit-function-declaration]
>      1650 |  skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
>           |        ^~~~~~~~~~~~~~~~~~~
>           |        tcp_stream_alloc_skb
>>> net/mptcp/protocol.c:1650:6: warning: assignment to 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      1650 |  skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
>           |      ^
>     cc1: some warnings being treated as errors
> 
> 
> vim +1650 net/mptcp/protocol.c
> 
>    1635	
>    1636	static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>    1637					  size_t len, struct mptcp_sock *msk, size_t copied)
>    1638	{
>    1639		const struct iphdr *iph;
>    1640		struct ubuf_info *uarg;
>    1641		struct sockaddr *uaddr;
>    1642		struct sk_buff *skb;
>    1643		struct tcp_sock *tp;
>    1644		struct socket *ssk;
>    1645		int ret;
>    1646	
>    1647		ssk = __mptcp_nmpc_socket(msk);
>    1648		if (unlikely(!ssk))
>    1649			goto out_EFAULT;
>> 1650		skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
>    1651		if (unlikely(!skb))
>    1652			goto out_EFAULT;
>    1653		iph = ip_hdr(skb);
>    1654		if (unlikely(!iph))
>    1655			goto out_EFAULT;
>    1656		uarg = msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
>    1657		if (unlikely(!uarg))
>    1658			goto out_EFAULT;
>    1659		uaddr = msg->msg_name;
>    1660	
>    1661		tp = tcp_sk(ssk->sk);
>    1662		if (unlikely(!tp))
>    1663			goto out_EFAULT;
>    1664		if (!tp->fastopen_req)
>    1665			tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req), ssk->sk->sk_allocation);
>    1666	
>    1667		if (unlikely(!tp->fastopen_req))
>    1668			goto out_EFAULT;
>    1669		tp->fastopen_req->data = msg;
>    1670		tp->fastopen_req->size = len;
>    1671		tp->fastopen_req->uarg = uarg;
>    1672	
>    1673		/* requests a cookie */
>    1674		ret = mptcp_stream_connect(sk->sk_socket, uaddr,
>    1675					   msg->msg_namelen, msg->msg_flags);
>    1676	
>    1677		return ret;
>    1678	out_EFAULT:
>    1679		ret = -EFAULT;
>    1680		return ret;
>    1681	}
>    1682	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
