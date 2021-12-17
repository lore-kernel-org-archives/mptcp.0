Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21186173
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 05:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639720010; x=1671256010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qY0Wwk+mzs/pA6vJJ8UEZG70IwR/pEoSFiN6S+mMw2k=;
  b=i4B+Tu/aaP0TlWdgCLlfH3wv8QOg8+3GpqnXBQ15RfGHGL12o9F/D76s
   XWBSs7Wdg9tiHu3rxZkGlC82KEpfSfIV6xQgJYZ6zwDslIhMGbQMjRO5y
   rpumOzU847gZVg6piuR05JoJEwChmCf1nkkaRNRBWzJRC3IHEfy3XZ/Dd
   R56hyTcd4kOtHSLMS0ycI9kFAABJBTBubaSbT9VwuY0TPhjV85BpudLCT
   HkEyf5No3VVObLjYS6Edl5NnLuA2OQVw8wI6I7Rnhm+LAueD834ygLsC5
   FzTrlnoPe6MfBmoWvx/F4g1hc9zMgnX3sji3XdN6BsvEjSqv4psgC3YIY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239909355"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="239909355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 21:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683260096"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 21:46:47 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1my64s-0004H1-Mc; Fri, 17 Dec 2021 05:46:46 +0000
Date: Fri, 17 Dec 2021 13:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next 17/21] mptcp: netlink: allow userspace-driven
 subflow establishment
Message-ID: <202112171344.Zn3aOifg-lkp@intel.com>
References: <20211216222314.1244708-18-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216222314.1244708-18-kishen.maloor@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Kishen,

I love your patch! Yet something to improve:

[auto build test ERROR on f81a8b95bfe9cae8ff02739e3e263d9310422af7]

url:    https://github.com/0day-ci/linux/commits/Kishen-Maloor/mptcp-support-userspace-path-management/20211217-062636
base:   f81a8b95bfe9cae8ff02739e3e263d9310422af7
config: arc-randconfig-r043-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171344.Zn3aOifg-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ece3dbcf3e16211dda7bdeb0f00b2450e776814d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kishen-Maloor/mptcp-support-userspace-path-management/20211217-062636
        git checkout ece3dbcf3e16211dda7bdeb0f00b2450e776814d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/atomic.h:12,
                    from include/linux/atomic.h:7,
                    from include/net/net_namespace.h:8,
                    from include/linux/inet.h:42,
                    from net/mptcp/pm_netlink.c:9:
   net/mptcp/pm_netlink.c: In function 'mptcp_nl_find_ssk':
>> net/mptcp/pm_netlink.c:2613:54: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                                                      ^~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
   net/mptcp/pm_netlink.c:2614:55: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    2614 |                             !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
         |                                                       ^~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
>> include/net/sock.h:388:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     388 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
   net/mptcp/pm_netlink.c:2614:68: note: in expansion of macro 'sk_v6_daddr'
    2614 |                             !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
         |                                                                    ^~~~~~~~~~~
>> net/mptcp/pm_netlink.c:2613:54: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                                                      ^~~~~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
   net/mptcp/pm_netlink.c:2614:55: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    2614 |                             !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
         |                                                       ^~~~~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
>> include/net/sock.h:388:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     388 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
   net/mptcp/pm_netlink.c:2614:68: note: in expansion of macro 'sk_v6_daddr'
    2614 |                             !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
         |                                                                    ^~~~~~~~~~~
>> net/mptcp/pm_netlink.c:2613:54: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                                                      ^~~~~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
   net/mptcp/pm_netlink.c:2614:55: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    2614 |                             !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
         |                                                       ^~~~~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
>> include/net/sock.h:388:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     388 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   net/mptcp/pm_netlink.c:2613:25: note: in expansion of macro 'if'
    2613 |                         if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
         |                         ^~
   net/mptcp/pm_netlink.c:2614:68: note: in expansion of macro 'sk_v6_daddr'
    2614 |                             !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
         |                                                                    ^~~~~~~~~~~


vim +2613 net/mptcp/pm_netlink.c

  2579	
  2580	static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
  2581					      const struct mptcp_addr_info *local,
  2582					      const struct mptcp_addr_info *remote)
  2583	{
  2584		struct sock *sk = &msk->sk.icsk_inet.sk;
  2585		struct mptcp_subflow_context *subflow;
  2586		struct sock *found = NULL;
  2587	
  2588		if (local->family != remote->family)
  2589			return NULL;
  2590	
  2591		lock_sock(sk);
  2592	
  2593		mptcp_for_each_subflow(msk, subflow) {
  2594			const struct ipv6_pinfo *pinfo;
  2595			const struct inet_sock *issk;
  2596			struct sock *ssk;
  2597	
  2598			ssk = mptcp_subflow_tcp_sock(subflow);
  2599	
  2600			if (local->family != ssk->sk_family)
  2601				continue;
  2602	
  2603			issk = inet_sk(ssk);
  2604	
  2605			switch (ssk->sk_family) {
  2606			case AF_INET:
  2607				if (issk->inet_saddr != local->addr.s_addr ||
  2608				    issk->inet_daddr != remote->addr.s_addr)
  2609					continue;
  2610				break;
  2611			case AF_INET6:
  2612				pinfo = inet6_sk(ssk);
> 2613				if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
  2614				    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
  2615					continue;
  2616				break;
  2617			default:
  2618				continue;
  2619			}
  2620	
  2621			if (issk->inet_sport == local->port &&
  2622			    issk->inet_dport == remote->port) {
  2623				found = ssk;
  2624				goto found;
  2625			}
  2626		}
  2627	
  2628	found:
  2629		release_sock(sk);
  2630	
  2631		return found;
  2632	}
  2633	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
