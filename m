Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD123E169F;
	Thu,  6 Aug 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047528; cv=none; b=PkNtyLnWbdZU3dtl8ngkowFtLShpsRHaCDRy/qQZyt2DsiMOGFdoHxbo63hsjckwwtMyRUpD3+H9mKjQ1Hv6Qk5cXYG+WUiq7ONsQ3/g/E5/1UaPsjCUTXmDgNWYSa872+dStawTV6rSN6K+Ph6pybYJgH/g/YEUEWrmsTgZp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047528; c=relaxed/simple;
	bh=Q4n7hXRBRwy3fJL4Bzki5M+KpFlWVDk50guP03iJCxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVrT4Xez7Tfhn/9enghctDhmtwrzo4IeE0NVwgbsHIBp+bQiLVBGfGlPARXPjyiKB/bFiyX80m3UrjMM71MbN8YKPVH5zic0aO4xjJGSaY9xUbs+chyezjbAJeKZVW+7O72fcxLFltZR87NybNq788doTZqjf/5ndivIIMZP60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgLH83+f; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgLH83+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786047525; x=1817583525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4n7hXRBRwy3fJL4Bzki5M+KpFlWVDk50guP03iJCxI=;
  b=BgLH83+fTJP+3PNReze2pi4jNJ3CVWI+FyPjMeNFglNxXdq+FAyY7H8X
   ONX342qhI+ehwo5inUNRhld0qIdymODykHkFV5va0zxV6mmO6V60PBkIW
   bHOYykKreh7whBedJfcH+ZIA/Gxo/p4U4wMxaJ/NASp88i/EYjwmjrHWr
   c2d1BWWiNrwoXaHh09UKXHZIUJdDgb0JaWfiO8LvMdic97JZvgWXIiE9C
   Av3ZUGk6kuBIV5XwS7GkNUN2o4jEr9R6Wn+JYii57NEzjbEgGMMih0S5K
   7yl0rhYxmPTIIyX6HCgT5V0sAWEW8wVagfG0+4vOVv1lmmIVUa838epdh
   A==;
X-CSE-ConnectionGUID: bV569a2zT3aNy1e5fBtmNA==
X-CSE-MsgGUID: BvQkRcGTR8WVH4njzvsWTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86663176"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86663176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:18:42 -0700
X-CSE-ConnectionGUID: SLixt9vrQtmzgmNLYssxow==
X-CSE-MsgGUID: ORlMbwbLQ169NRIlkmHepA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="285572421"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Aug 2026 13:18:40 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws4Y1-00000000G9p-3dzZ;
	Thu, 06 Aug 2026 20:18:37 +0000
Date: Fri, 7 Aug 2026 04:17:47 +0800
From: kernel test robot <lkp@intel.com>
To: luoqing <l1138897701@163.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, matttbe@kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH] mptcp: pm: Fix address ID overflow when all IDs are
 exhausted
Message-ID: <202608070408.cjzYB3m6-lkp@intel.com>
References: <20260714080356.805839-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714080356.805839-1-l1138897701@163.com>

Hi luoqing,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v7.2-rc6 next-20260806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luoqing/mptcp-pm-Fix-address-ID-overflow-when-all-IDs-are-exhausted/20260806-155815
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/20260714080356.805839-1-l1138897701%40163.com
patch subject: [PATCH] mptcp: pm: Fix address ID overflow when all IDs are exhausted
config: nios2-randconfig-001-20260807 (https://download.01.org/0day-ci/archive/20260807/202608070408.cjzYB3m6-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260807/202608070408.cjzYB3m6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608070408.cjzYB3m6-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mptcp/pm_kernel.c: In function 'mptcp_pm_nl_append_new_local_addr':
>> net/mptcp/pm_kernel.c:798:3: error: a label can only be part of a statement and a declaration is not a statement
      unsigned int id = find_next_zero_bit(pernet->id_bitmap,
      ^~~~~~~~


vim +798 net/mptcp/pm_kernel.c

   734	
   735	static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
   736						     struct mptcp_pm_addr_entry *entry,
   737						     bool replace)
   738	{
   739		struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
   740		int ret = -EINVAL;
   741		u8 addr_max;
   742	
   743		spin_lock_bh(&pernet->lock);
   744		/* to keep the code simple, don't do IDR-like allocation for address ID,
   745		 * just bail when we exceed limits
   746		 */
   747		if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
   748			pernet->next_id = 1;
   749		if (pernet->endpoints == MPTCP_PM_MAX_ADDR_ID) {
   750			ret = -ERANGE;
   751			goto out;
   752		}
   753		if (test_bit(entry->addr.id, pernet->id_bitmap)) {
   754			ret = -EBUSY;
   755			goto out;
   756		}
   757	
   758		/* do not insert duplicate address, differentiate on port only
   759		 * singled addresses
   760		 */
   761		if (!address_use_port(entry))
   762			entry->addr.port = 0;
   763		list_for_each_entry(cur, &pernet->endp_list, list) {
   764			if (mptcp_addresses_equal(&cur->addr, &entry->addr,
   765						  cur->addr.port || entry->addr.port)) {
   766				/* allow replacing the exiting endpoint only if such
   767				 * endpoint is an implicit one and the user-space
   768				 * did not provide an endpoint id
   769				 */
   770				if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
   771					ret = -EEXIST;
   772					goto out;
   773				}
   774				if (entry->addr.id)
   775					goto out;
   776	
   777				/* allow callers that only need to look up the local
   778				 * addr's id to skip replacement. This allows them to
   779				 * avoid calling synchronize_rcu in the packet recv
   780				 * path.
   781				 */
   782				if (!replace) {
   783					kfree(entry);
   784					ret = cur->addr.id;
   785					goto out;
   786				}
   787	
   788				pernet->endpoints--;
   789				entry->addr.id = cur->addr.id;
   790				list_del_rcu(&cur->list);
   791				del_entry = cur;
   792				break;
   793			}
   794		}
   795	
   796		if (!entry->addr.id) {
   797	find_next:
 > 798			unsigned int id = find_next_zero_bit(pernet->id_bitmap,
   799							     MPTCP_PM_MAX_ADDR_ID + 1,
   800							     pernet->next_id);
   801			if (id > MPTCP_PM_MAX_ADDR_ID) {
   802				ret = -ENOSPC;
   803				goto out;
   804			}
   805			entry->addr.id = id;
   806			if (!entry->addr.id && pernet->next_id != 1) {
   807				pernet->next_id = 1;
   808				goto find_next;
   809			}
   810		}
   811	
   812		if (!entry->addr.id)
   813			goto out;
   814	
   815		__set_bit(entry->addr.id, pernet->id_bitmap);
   816		if (entry->addr.id > pernet->next_id)
   817			pernet->next_id = entry->addr.id;
   818	
   819		if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
   820			addr_max = pernet->endp_signal_max;
   821			WRITE_ONCE(pernet->endp_signal_max, addr_max + 1);
   822		}
   823		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
   824			addr_max = pernet->endp_subflow_max;
   825			WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
   826		}
   827		if (entry->flags & MPTCP_PM_ADDR_FLAG_LAMINAR) {
   828			addr_max = pernet->endp_laminar_max;
   829			WRITE_ONCE(pernet->endp_laminar_max, addr_max + 1);
   830		}
   831		if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
   832			addr_max = pernet->endp_fullmesh_max;
   833			WRITE_ONCE(pernet->endp_fullmesh_max, addr_max + 1);
   834		}
   835	
   836		pernet->endpoints++;
   837		if (!entry->addr.port)
   838			list_add_tail_rcu(&entry->list, &pernet->endp_list);
   839		else
   840			list_add_rcu(&entry->list, &pernet->endp_list);
   841		ret = entry->addr.id;
   842	
   843	out:
   844		spin_unlock_bh(&pernet->lock);
   845	
   846		/* just replaced an existing entry, free it */
   847		if (del_entry) {
   848			synchronize_rcu();
   849			__mptcp_pm_release_addr_entry(del_entry);
   850		}
   851		return ret;
   852	}
   853	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
