Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B84C8F;
	Fri, 29 Jul 2022 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659123982; x=1690659982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZeTC2Z2V9XY34hkFXLjyOjTxWuxGFFJJjrLzqDTmT9A=;
  b=IABXAdTFKZMqenSsmnFWZp9mOxVtCnzy8P6U1tZWZndkosKEdd9lyYlh
   qpoEmMGkChKHwzUGW1n4RvDNQXJVXYUgqMGnBHl0GzXaLK9b9+wG2MyYB
   b/McQGXWjUZRbegceK9Az31PmtTjlAOJTqUmbqsczFG6dY/3IHRPQhbuz
   8IMpV59gPuyOJ3Q6XZN9+1bCNzwKj3lYtz39/2vDPyTWXoaRh/CVFBaFy
   yu4zceB818JC9TLXtTU2ZOkYY8Zy+mfo1wrnAJKtUcoii++my8kxSecq/
   szP0yqzmTL/QAkm3MF5Ov2RBPvy8z/BqgZS/XCd8oLqQThQpPe5NK1rhd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286392824"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="286392824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="629490911"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 12:46:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oHVwB-000C21-1M;
	Fri, 29 Jul 2022 19:46:19 +0000
Date: Sat, 30 Jul 2022 03:45:46 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH mptcp-next 3/4] mptcp: move msk input path under full msk
 socket lock
Message-ID: <202207300345.qUOe9yq9-lkp@intel.com>
References: <3fdd375269bc0bad45ccadfca268dcb3ac3389c1.1659107989.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdd375269bc0bad45ccadfca268dcb3ac3389c1.1659107989.git.pabeni@redhat.com>

Hi Paolo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220729-233501
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: hexagon-randconfig-r045-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300345.qUOe9yq9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/120ee56b1ad70bbb3d1b35c107110b0f83b2e4e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220729-233501
        git checkout 120ee56b1ad70bbb3d1b35c107110b0f83b2e4e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/protocol.c:798:6: warning: no previous prototype for function '__mptcp_data_ready' [-Wmissing-prototypes]
   void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
        ^
   net/mptcp/protocol.c:798:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
   ^
   static 
   1 warning generated.


vim +/__mptcp_data_ready +798 net/mptcp/protocol.c

   797	
 > 798	void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
   799	{
   800		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
   801	
   802		/* The peer can send data while we are shutting down this
   803		 * subflow at msk destruction time, but we must avoid enqueuing
   804		 * more data to the msk receive queue
   805		 */
   806		if (unlikely(subflow->disposable))
   807			return;
   808	
   809		/* Wake-up the reader only for in-sequence data */
   810		if (move_skbs_to_msk(mptcp_sk(sk), ssk))
   811			sk->sk_data_ready(sk);
   812	}
   813	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
