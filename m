Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499B2B9DE;
	Wed, 29 Nov 2023 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc77qZaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701293819; x=1732829819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9du+o7Orcft7X4JWs+Jt4akoA0d8doppyw8jEXkw/t8=;
  b=fc77qZaArjvgHUsBOh48z+XXXCOz1vdTF6Sa/ZLTdxTC0iGEFE62AZSL
   mp/QTwRAu+zUvIKfJFPmBR+0F4IcjT1SRfKWHqM/pDxa8QXDxWOMQn9GG
   FWVJ4YUZbfFfAaX9s/5wEm6s8PbkggpecAe5rX+RC1Y0WyoFoObdKMjWG
   VBxZICdqIHXoqWSfpqVGU7asW4PzYiSARM1GHZ6UyzwtoEvE2U3LcpXRF
   yGi97fC/tlgQJ4sPQ5C2Xi9i7UsXwtzx1h2WNU6L804edsrd9QACVYEvl
   gO0tytiiZ8h8uEDo05qPuOAV8S5G60jEvbz9fCfy+n5z1AtWOKOPSOc4B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11930815"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11930815"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 13:36:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772820647"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772820647"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2023 13:36:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8SEn-0000rB-19;
	Wed, 29 Nov 2023 21:36:53 +0000
Date: Thu, 30 Nov 2023 05:36:07 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for
 tcp_set_state
Message-ID: <202311300110.9kJQ1JjE-lkp@intel.com>
References: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.7-rc3 next-20231129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-add-a-current-established-counter/20231129-131030
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for tcp_set_state
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231130/202311300110.9kJQ1JjE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300110.9kJQ1JjE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300110.9kJQ1JjE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/mptcp/trace.c:11:
   net/mptcp/trace.c: In function 'mptcp_state_callback':
>> include/linux/ftrace.h:158:9: error: implicit declaration of function 'regs_get_kernel_argument'; did you mean 'regs_get_kernel_stack_nth'? [-Werror=implicit-function-declaration]
     158 |         regs_get_kernel_argument(ftrace_get_regs(fregs), n)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   net/mptcp/trace.c:39:29: note: in expansion of macro 'ftrace_regs_get_argument'
      39 |         sk = (struct sock *)ftrace_regs_get_argument(fregs, 0);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +158 include/linux/ftrace.h

94d095ffa0e16b Mark Rutland 2022-11-03  153  
94d095ffa0e16b Mark Rutland 2022-11-03  154  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
94d095ffa0e16b Mark Rutland 2022-11-03  155  #define ftrace_regs_get_instruction_pointer(fregs) \
94d095ffa0e16b Mark Rutland 2022-11-03  156  	instruction_pointer(ftrace_get_regs(fregs))
94d095ffa0e16b Mark Rutland 2022-11-03  157  #define ftrace_regs_get_argument(fregs, n) \
94d095ffa0e16b Mark Rutland 2022-11-03 @158  	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
94d095ffa0e16b Mark Rutland 2022-11-03  159  #define ftrace_regs_get_stack_pointer(fregs) \
94d095ffa0e16b Mark Rutland 2022-11-03  160  	kernel_stack_pointer(ftrace_get_regs(fregs))
94d095ffa0e16b Mark Rutland 2022-11-03  161  #define ftrace_regs_return_value(fregs) \
94d095ffa0e16b Mark Rutland 2022-11-03  162  	regs_return_value(ftrace_get_regs(fregs))
94d095ffa0e16b Mark Rutland 2022-11-03  163  #define ftrace_regs_set_return_value(fregs, ret) \
94d095ffa0e16b Mark Rutland 2022-11-03  164  	regs_set_return_value(ftrace_get_regs(fregs), ret)
94d095ffa0e16b Mark Rutland 2022-11-03  165  #define ftrace_override_function_with_return(fregs) \
94d095ffa0e16b Mark Rutland 2022-11-03  166  	override_function_with_return(ftrace_get_regs(fregs))
94d095ffa0e16b Mark Rutland 2022-11-03  167  #define ftrace_regs_query_register_offset(name) \
94d095ffa0e16b Mark Rutland 2022-11-03  168  	regs_query_register_offset(name)
94d095ffa0e16b Mark Rutland 2022-11-03  169  #endif
94d095ffa0e16b Mark Rutland 2022-11-03  170  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
