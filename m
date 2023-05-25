Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14D1381;
	Thu, 25 May 2023 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684976010; x=1716512010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l45J1OamduQ9mv7x54pXhZUy9a7UTNl4LxY774qtJN0=;
  b=RU8T9U8k/f40d/EPw4xISb79x5BFtUCRH8ToWIjYg5FRrZEMpF6T4S1v
   gJBnRxXIOJNnQ/nnJkb7Yfpi5FmnM3Fx10wSEQtcCQfQPQ8X9yW0XK1We
   Oq9rHA1LCWVEAcepJOTz0YA1teUo8FQLulhYTIvoqEmj/chWyq0KatZoF
   ulFGsy3mxD9lrPpJFFY1x4Q3WdjGyF2K4ej0k6yeinKTIBfAWNfmYLBuL
   GA6J7SbD/GUg2wh6z/2dHylugcKlZZJT8uQuJb+InxZeftwGK77hwAJlS
   QeeN+j05LcCXJLdBWNQ/FtQ8BvQduY3tS5LUHvRvW00MqB5HAotSIJIx3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338309978"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338309978"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 17:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="878900960"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="878900960"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2023 17:53:27 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q1zEN-000FJR-0P;
	Thu, 25 May 2023 00:53:27 +0000
Date: Thu, 25 May 2023 08:52:49 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v5 mptcp-next 5/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Message-ID: <202305250816.Ie1tjg5a-lkp@intel.com>
References: <400326ed4b59e6c9878fc4a406c2bf406876ee72.1684962909.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400326ed4b59e6c9878fc4a406c2bf406876ee72.1684962909.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export]
[cannot apply to mptcp/export-net linus/master v6.4-rc3 next-20230524]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-move-snd_una-update-earlier-for-fallback-socket/20230525-053110
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/400326ed4b59e6c9878fc4a406c2bf406876ee72.1684962909.git.pabeni%40redhat.com
patch subject: [PATCH v5 mptcp-next 5/6] mptcp: introduce MPTCP_FULL_INFO getsockopt
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230525/202305250816.Ie1tjg5a-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8317ccb72cec68bc55db2258c67c166180f07712
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-move-snd_una-update-earlier-for-fallback-socket/20230525-053110
        git checkout 8317ccb72cec68bc55db2258c67c166180f07712
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash net/mptcp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305250816.Ie1tjg5a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/sockopt.c: In function 'mptcp_getsockopt_full_info':
>> net/mptcp/sockopt.c:1226:30: warning: variable 'infoptr' set but not used [-Wunused-but-set-variable]
    1226 |                 char __user *infoptr;
         |                              ^~~~~~~


vim +/infoptr +1226 net/mptcp/sockopt.c

  1207	
  1208	static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optval,
  1209					      int __user *optlen)
  1210	{
  1211		struct mptcp_subflow_context *subflow;
  1212		struct sock *sk = (struct sock *)msk;
  1213		unsigned int sfcount = 0, copied = 0;
  1214		void __user *tcpinfoptr, *sfinfoptr;
  1215		struct mptcp_full_info mfi;
  1216		int len;
  1217	
  1218		len = mptcp_get_full_info(&mfi, optval, optlen);
  1219		if (len < 0)
  1220			return len;
  1221	
  1222		/* don't bother filling the mptcp info if there is not enough
  1223		 * user-space-provided storage
  1224		 */
  1225		if (len > 0) {
> 1226			char __user *infoptr;
  1227			int mptcp_info_len;
  1228	
  1229			infoptr = optval + MIN_FULL_INFO_OPTLEN_SIZE;
  1230			mptcp_info_len = min_t(unsigned int, len, sizeof(struct mptcp_info));
  1231			mptcp_diag_fill_info(msk, &mfi.mptcp_info);
  1232	
  1233			copied += mptcp_info_len;
  1234		}
  1235	
  1236		mfi.size_tcpinfo_kernel = sizeof(struct tcp_info);
  1237		mfi.size_tcpinfo_user = min_t(unsigned int, mfi.size_tcpinfo_user,
  1238					      sizeof(struct tcp_info));
  1239		sfinfoptr = u64_to_user_ptr(mfi.subflow_info);
  1240		mfi.size_sfinfo_kernel = sizeof(struct mptcp_subflow_info);
  1241		mfi.size_sfinfo_user = min_t(unsigned int, mfi.size_sfinfo_user,
  1242					     sizeof(struct mptcp_subflow_info));
  1243		tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
  1244	
  1245		lock_sock(sk);
  1246		mptcp_for_each_subflow(msk, subflow) {
  1247			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
  1248			struct mptcp_subflow_info sfinfo;
  1249			struct tcp_info tcp_info;
  1250	
  1251			if (sfcount++ >= mfi.size_arrays_user)
  1252				continue;
  1253	
  1254			/* fetch addr/tcp_info only if the user space buffers
  1255			 * are wide enough
  1256			 */
  1257			memset(&sfinfo, 0, sizeof(sfinfo));
  1258			sfinfo.id = subflow->subflow_id;
  1259			if (mfi.size_sfinfo_user >
  1260			    offsetof(struct mptcp_subflow_info, addrs))
  1261				mptcp_get_sub_addrs(ssk, &sfinfo.addrs);
  1262			if (copy_to_user(sfinfoptr, &sfinfo, mfi.size_sfinfo_user))
  1263				goto fail_release;
  1264	
  1265			if (mfi.size_tcpinfo_user) {
  1266				tcp_get_info(ssk, &tcp_info);
  1267				if (copy_to_user(tcpinfoptr, &tcp_info,
  1268						 mfi.size_tcpinfo_user))
  1269					goto fail_release;
  1270			}
  1271	
  1272			tcpinfoptr += mfi.size_tcpinfo_user;
  1273			sfinfoptr += mfi.size_sfinfo_user;
  1274		}
  1275		release_sock(sk);
  1276	
  1277		mfi.num_subflows = sfcount;
  1278		if (mptcp_put_full_info(&mfi, optval, copied, optlen))
  1279			return -EFAULT;
  1280	
  1281		return 0;
  1282	
  1283	fail_release:
  1284		release_sock(sk);
  1285		return -EFAULT;
  1286	}
  1287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
