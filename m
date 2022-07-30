Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11623BB;
	Sat, 30 Jul 2022 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659163436; x=1690699436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bXR5RftXddzD3LTV09Yi5K5W6TGoloxS1Fx+Z3kLsIo=;
  b=IoOOPoHjO13hrjUnIp8XfmN1EQh8+2ld7LL0ElJbaTrD4V6XGAtkfADO
   +Fnzi+j9CT3f0zsVFr2/QL7eZOhsx5WN8GwqieZD6J1SbV6hMH5GoRYhb
   0ZinytHGZBpAna1YOsv6/ZGsU+3NCd1VwAYo0LnMLxlrfsEhJtzJZBqrZ
   fWOw3RkpmY0ZfIgkGpsZpCqkEx7aKlUwcvW7PCCijI0LDOgO8vw/ueIj8
   VALOG60V5hvR1W5VoKexSVf6DNKYZXMsObQSGgtfEZmBzsmjayF+XYlbo
   BoHAxMfHZHjW55QVoAmTHMUqHmh7oIxmewDAosf8+cdqNGUF8aDkAI8Pz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="290100666"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="290100666"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="847329849"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2022 23:43:53 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oHgCX-000CXr-11;
	Sat, 30 Jul 2022 06:43:53 +0000
Date: Sat, 30 Jul 2022 14:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: move msk input path under full
 msk socket lock
Message-ID: <202207301455.Biyfbfoh-lkp@intel.com>
References: <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>

Hi Paolo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220730-021638
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220730/202207301455.Biyfbfoh-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f2cae8b9b78304e87a6c4ee4dbaa50cc02b078d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220730-021638
        git checkout f2cae8b9b78304e87a6c4ee4dbaa50cc02b078d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mptcp/

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
