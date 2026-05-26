Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1F2868A7;
	Tue, 26 May 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808438; cv=none; b=XYVaGAcdhNwKjobS2vzV60BLxcwocjhiDrK5+pGjqU3s8hVqoP4j7wx05dFOlZsr9LRtXoyikBI+SuW7EZejvyglrcy+2dZ1sxGc/COJr3upzf2iGXiXwUIqwmhjWeLisGyNORJ9aN+DfPKDzFeN7cM9EIU7olJd89Z/9cphZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808438; c=relaxed/simple;
	bh=f+fVeGwH2AGX0iHgTYcaIbHb7350IWFdEYH/N4AH1+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud7KpZWih3b+ojU4Q/SqUf6XAzZ5ukpyOlC042nit5qDso6r8Nqh/K4lZ9A6fz88LPChN+zcDeJ46p53DE8vVDnZCIWmSws2Xf+BkHasKVcz6W4lqBQ2vPPClDTe+SZGlT5iG6As1X/xRfl6wa+D0rvby66HLaXV3eWRn4iI4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZJBisl7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZJBisl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779808437; x=1811344437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+fVeGwH2AGX0iHgTYcaIbHb7350IWFdEYH/N4AH1+g=;
  b=ZZJBisl7RHGnLa3zzJrFA9v8iA+T1T2eV4pT1P1hOHmcCVNNyqS4y5IE
   oGFxaECZjlWiA/0tew53K1UyKCLwRZ0eRr4aCnMPtYbDnQUaVQuRzIiXZ
   wIouFjLDO+VWSTZFbsG8Bw8G4Qf8k1D39HB38m7beOklci92S/Jo3acTK
   5ZUJmbEUEFgXe3YXnHOLo2aOU2AjiPSxhMPhMqiLdLLeWkuwNaITsOBMK
   PX3My+cqlpft8mxv96cMalWd1znWTFcPkQjPZPuPpv83e37Qqxlp86YLY
   bvywCkNPkE2gr+o7jGobblB3Nx4kWFGVSV3kO3uXF2ZRXIAC31EB8MKEl
   A==;
X-CSE-ConnectionGUID: mN/Ib9vbRxisW4Ftz4yggA==
X-CSE-MsgGUID: qlE2nFCIRyaz2+6/yvznDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91194419"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="91194419"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:13:35 -0700
X-CSE-ConnectionGUID: eR//+E9BSAyKkRggeAy5GQ==
X-CSE-MsgGUID: 1zvR1ORqStekGfCZ3gQ+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="237782045"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 26 May 2026 08:13:33 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wRtTH-00000000CQb-0JbS;
	Tue, 26 May 2026 15:13:31 +0000
Date: Tue, 26 May 2026 17:13:23 +0200
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: remove unused data_ack from struct
 mptcp_ext
Message-ID: <202605261737.8n5ShBlg-lkp@intel.com>
References: <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v7.1-rc5 next-20260525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-remove-unused-data_ack-from-struct-mptcp_ext/20260526-174441
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next] mptcp: remove unused data_ack from struct mptcp_ext
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260526/202605261737.8n5ShBlg-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260526/202605261737.8n5ShBlg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605261737.8n5ShBlg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mptcp/options.c:607:18: error: no member named 'data_ack' in 'struct mptcp_ext'
     607 |                 opts->ext_copy.data_ack = ack_seq;
         |                 ~~~~~~~~~~~~~~ ^
>> net/mptcp/options.c:611:18: error: no member named 'data_ack32' in 'struct mptcp_ext'
     611 |                 opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
         |                 ~~~~~~~~~~~~~~ ^
   net/mptcp/options.c:1479:31: error: no member named 'data_ack' in 'struct mptcp_ext'
    1479 |                                 put_unaligned_be64(mpext->data_ack, ptr);
         |                                                    ~~~~~  ^
   net/mptcp/options.c:1482:31: error: no member named 'data_ack32' in 'struct mptcp_ext'
    1482 |                                 put_unaligned_be32(mpext->data_ack32, ptr);
         |                                                    ~~~~~  ^
   4 errors generated.


vim +607 net/mptcp/options.c

6d0060f600adfd Mat Martineau    2020-01-21  561  
6d0060f600adfd Mat Martineau    2020-01-21  562  static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
d87903b63e3ce1 Paolo Abeni      2021-02-19  563  					  bool snd_data_fin_enable,
6d0060f600adfd Mat Martineau    2020-01-21  564  					  unsigned int *size,
6d0060f600adfd Mat Martineau    2020-01-21  565  					  struct mptcp_out_options *opts)
6d0060f600adfd Mat Martineau    2020-01-21  566  {
6d0060f600adfd Mat Martineau    2020-01-21  567  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
7279da6145bbb2 Mat Martineau    2020-07-28  568  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
6d0060f600adfd Mat Martineau    2020-01-21  569  	unsigned int dss_size = 0;
6d0060f600adfd Mat Martineau    2020-01-21  570  	struct mptcp_ext *mpext;
6d0060f600adfd Mat Martineau    2020-01-21  571  	unsigned int ack_size;
d22f4988ffecbe Christoph Paasch 2020-01-21  572  	bool ret = false;
d87903b63e3ce1 Paolo Abeni      2021-02-19  573  	u64 ack_seq;
6d0060f600adfd Mat Martineau    2020-01-21  574  
c5b39e26d00364 Geliang Tang     2021-06-17  575  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
0bac966a1f2ae0 Mat Martineau    2020-07-28  576  	mpext = skb ? mptcp_get_ext(skb) : NULL;
6d0060f600adfd Mat Martineau    2020-01-21  577  
7279da6145bbb2 Mat Martineau    2020-07-28  578  	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
c5b39e26d00364 Geliang Tang     2021-06-17  579  		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
6d0060f600adfd Mat Martineau    2020-01-21  580  
c5b39e26d00364 Geliang Tang     2021-06-17  581  		if (mpext) {
c5b39e26d00364 Geliang Tang     2021-06-17  582  			if (opts->csum_reqd)
c5b39e26d00364 Geliang Tang     2021-06-17  583  				map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
6d0060f600adfd Mat Martineau    2020-01-21  584  
6d0060f600adfd Mat Martineau    2020-01-21  585  			opts->ext_copy = *mpext;
c5b39e26d00364 Geliang Tang     2021-06-17  586  		}
6d0060f600adfd Mat Martineau    2020-01-21  587  
c5b39e26d00364 Geliang Tang     2021-06-17  588  		dss_size = map_size;
7279da6145bbb2 Mat Martineau    2020-07-28  589  		if (skb && snd_data_fin_enable)
9c29e36152748f Paolo Abeni      2020-07-03  590  			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
1bff1e43a30e2f Paolo Abeni      2021-08-24  591  		opts->suboptions = OPTION_MPTCP_DSS;
d22f4988ffecbe Christoph Paasch 2020-01-21  592  		ret = true;
d22f4988ffecbe Christoph Paasch 2020-01-21  593  	}
d22f4988ffecbe Christoph Paasch 2020-01-21  594  
2398e3991bda7c Paolo Abeni      2020-03-04  595  	/* passive sockets msk will set the 'can_ack' after accept(), even
2398e3991bda7c Paolo Abeni      2020-03-04  596  	 * if the first subflow may have the already the remote key handy
2398e3991bda7c Paolo Abeni      2020-03-04  597  	 */
d22f4988ffecbe Christoph Paasch 2020-01-21  598  	opts->ext_copy.use_ack = 0;
dc093db5cc052b Paolo Abeni      2020-03-13  599  	if (!READ_ONCE(msk->can_ack)) {
d22f4988ffecbe Christoph Paasch 2020-01-21  600  		*size = ALIGN(dss_size, 4);
d22f4988ffecbe Christoph Paasch 2020-01-21  601  		return ret;
6d0060f600adfd Mat Martineau    2020-01-21  602  	}
6d0060f600adfd Mat Martineau    2020-01-21  603  
e3859603ba13e7 Paolo Abeni      2021-02-11  604  	ack_seq = READ_ONCE(msk->ack_seq);
37198e93ced707 Davide Caratti   2020-10-06  605  	if (READ_ONCE(msk->use_64bit_ack)) {
6d0060f600adfd Mat Martineau    2020-01-21  606  		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
e3859603ba13e7 Paolo Abeni      2021-02-11 @607  		opts->ext_copy.data_ack = ack_seq;
a0c1d0eafd1ef1 Christoph Paasch 2020-05-14  608  		opts->ext_copy.ack64 = 1;
a0c1d0eafd1ef1 Christoph Paasch 2020-05-14  609  	} else {
a0c1d0eafd1ef1 Christoph Paasch 2020-05-14  610  		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
e3859603ba13e7 Paolo Abeni      2021-02-11 @611  		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
a0c1d0eafd1ef1 Christoph Paasch 2020-05-14  612  		opts->ext_copy.ack64 = 0;
a0c1d0eafd1ef1 Christoph Paasch 2020-05-14  613  	}
a0c1d0eafd1ef1 Christoph Paasch 2020-05-14  614  	opts->ext_copy.use_ack = 1;
1bff1e43a30e2f Paolo Abeni      2021-08-24  615  	opts->suboptions = OPTION_MPTCP_DSS;
6d0060f600adfd Mat Martineau    2020-01-21  616  
6d0060f600adfd Mat Martineau    2020-01-21  617  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
6d0060f600adfd Mat Martineau    2020-01-21  618  	if (dss_size == 0)
6d0060f600adfd Mat Martineau    2020-01-21  619  		ack_size += TCPOLEN_MPTCP_DSS_BASE;
6d0060f600adfd Mat Martineau    2020-01-21  620  
6d0060f600adfd Mat Martineau    2020-01-21  621  	dss_size += ack_size;
6d0060f600adfd Mat Martineau    2020-01-21  622  
6d0060f600adfd Mat Martineau    2020-01-21  623  	*size = ALIGN(dss_size, 4);
6d0060f600adfd Mat Martineau    2020-01-21  624  	return true;
6d0060f600adfd Mat Martineau    2020-01-21  625  }
6d0060f600adfd Mat Martineau    2020-01-21  626  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
