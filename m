Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAC14270;
	Wed, 17 Jan 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486325; cv=none; b=Cqop0ZPxytUQc1pl6IpVTw7BwAe7sHfQdGJ+gniu5TG2gQlr7Gwst2ps7M+iEL4l1Lwee0VnFyqUyka7z8sgMgOPUF1wIzNAHvyi3WcwAe6IDxk6eJIkCm+pQURC6IEhbugXN8MhWdn5a8nD0onygxjjpu/omXqnrQVuW7kfwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486325; c=relaxed/simple;
	bh=A8QQxh4Zjk+z67BAbAJ4nXFfTq18Kkr2LN41/MW+/00=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f7mSOUTUPvYqLwm0YghF7FwK4I0+kSWrf+GBalkHnBKQ7yIDyw7lGY+p8faFjkjb0NRe/FOFW2GJxxHR+vrKDlItFg0qkIp6GKseMk4eouz+aLPV/kDZ1uN/7zektRBkb0bvUykHRjyxT0yaqjgVAlqe31i2EIJRH4hvQJRHEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUiZiLpF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUiZiLpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705486324; x=1737022324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8QQxh4Zjk+z67BAbAJ4nXFfTq18Kkr2LN41/MW+/00=;
  b=CUiZiLpFC31aGt/yyxzKwYnyTXgsJJ1VIwG8yLUBUXI0GSo0GQAPQRQB
   t4IlGrWsI69/FLtMzXF6WcqCtFHW2MRZrKJzAe37fv2W4FqB5EMOUOWyw
   ZxnQIG+yAlVwP8w9vhfbLX2hYa6q108rZOEVSbgwkIreLw8A/8t0ieWWd
   FQigRGfgQM3wkQ1QH/mQyIYwqKbjQROmJo/wsrb+OINKKWVY43SYAIhVD
   aW6Wie2BGftc/c8tRqvF10q8NdCCnIMjz6/A0AEQAlS7eslC7GNcdSRnU
   aW4GxWwCGwWb7Wvl8NTaRyiido80qZ8eVMOBUX4YMHvE9/G2xOpmbM/zU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6835461"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6835461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 02:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="733939431"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="733939431"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2024 02:12:01 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQ2tn-0001rg-29;
	Wed, 17 Jan 2024 10:11:55 +0000
Date: Wed, 17 Jan 2024 18:11:04 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 07/23] mptcp: implement
 mptcp_userspace_pm_dump_addr
Message-ID: <202401171744.SJN2kTRQ-lkp@intel.com>
References: <fe0b361ec239de2c02192c729a083c45f301e559.1705375746.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0b361ec239de2c02192c729a083c45f301e559.1705375746.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[also build test WARNING on mptcp/export-net linus/master next-20240117]
[cannot apply to v6.7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-pm_has_addr_attr_id-helper/20240116-113812
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/fe0b361ec239de2c02192c729a083c45f301e559.1705375746.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next v9 07/23] mptcp: implement mptcp_userspace_pm_dump_addr
config: i386-buildonly-randconfig-002-20240116 (https://download.01.org/0day-ci/archive/20240117/202401171744.SJN2kTRQ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401171744.SJN2kTRQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401171744.SJN2kTRQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mptcp/pm_userspace.c:602:6: warning: variable 'sk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     602 |         if (!mptcp_pm_is_userspace(msk)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mptcp/pm_userspace.c:634:11: note: uninitialized use occurs here
     634 |         sock_put(sk);
         |                  ^~
   net/mptcp/pm_userspace.c:602:2: note: remove the 'if' if its condition is always false
     602 |         if (!mptcp_pm_is_userspace(msk)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     603 |                 GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     604 |                 goto out;
         |                 ~~~~~~~~~
     605 |         }
         |         ~
   net/mptcp/pm_userspace.c:590:17: note: initialize the variable 'sk' to silence this warning
     590 |         struct sock *sk;
         |                        ^
         |                         = NULL
   1 warning generated.


vim +602 net/mptcp/pm_userspace.c

   577	
   578	int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
   579					 struct netlink_callback *cb)
   580	{
   581		struct id_bitmap {
   582			DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
   583		} *bitmap;
   584		const struct genl_info *info = genl_info_dump(cb);
   585		struct net *net = sock_net(msg->sk);
   586		struct mptcp_pm_addr_entry *entry;
   587		struct mptcp_sock *msk;
   588		struct nlattr *token;
   589		int ret = -EINVAL;
   590		struct sock *sk;
   591		void *hdr;
   592	
   593		bitmap = (struct id_bitmap *)cb->ctx;
   594		token = info->attrs[MPTCP_PM_ATTR_TOKEN];
   595	
   596		msk = mptcp_token_get_sock(net, nla_get_u32(token));
   597		if (!msk) {
   598			NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
   599			return ret;
   600		}
   601	
 > 602		if (!mptcp_pm_is_userspace(msk)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
