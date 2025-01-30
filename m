Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD241EB9E1;
	Thu, 30 Jan 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259738; cv=none; b=s9rmfH7eCF1aozojQRFtbjxjfJOWVbD25F6WHifo/RX1uQWFIjSXGExawgQ9pMAr6GSNBGCjrPz45i+JmJLq+AWJooIOGJrDkcDMQdi05A0Wrz7fWk3G2rWm2W8x3wmatGIIpbrmDvOS9dSLKysPbHcJ0BZTkzhmtD25LNedCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259738; c=relaxed/simple;
	bh=HN4oaVw6L4NZ7pdZIl7QwpK6oiJkLd7pgPdgW/nJ+wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XDT0YjjW/+8FuPob/NOnA7V7vTXKSWSBIbjrv9wk5d3Dq+dNESQjIvAg9XRKjV88lpoIfdkxyvtTXb19R5C38aa0olULSqS7GBuXmTqpsIXxRlNg/51pgfljmC91BaBp7NE1h3Oo+t9tKHg9whTsuaLboZTbrSISHiU0mGGt0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYv3eFNx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYv3eFNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738259736; x=1769795736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HN4oaVw6L4NZ7pdZIl7QwpK6oiJkLd7pgPdgW/nJ+wQ=;
  b=AYv3eFNxlteNE82iGiPBFZ5j01F0QV/maMzSrB96dZcbYIGOdQVSI8a+
   h9lUzvP2DPy7dwNqPhh21IQ6IGPlUo+OA8aALFiu2saLVgWsbV4iObeIW
   ii0m2hrQl8tB9Mian6xGWa0uXuiv4EHDrNDC165Rcq2L4NQHu1wFsuyZk
   0VV533d5IBnSMHyfnrejsiUjcouew78Ef8jlyIoUOQUGl7f94OSv8xjuO
   VJX8lOQjEkEOGKO4ATgHx0enLK5RUuJhPgDBXU8xafmVQLtXXF++hv8g0
   uMhqz5s/N/jcvTBh8SocrKZNgmuUQ4l/P8yiOAQXasoz8nL9EBwy4UkVv
   A==;
X-CSE-ConnectionGUID: zQXPGaWXR3usAtwrqJ0ODg==
X-CSE-MsgGUID: 9vr4nuIBSqSMX7vsc1z8dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="49477206"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="49477206"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 09:55:35 -0800
X-CSE-ConnectionGUID: jWsZPQwBROyZGkQvzxsUrg==
X-CSE-MsgGUID: Aufc8seVSM2gN8kE4nLRKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110295082"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Jan 2025 09:55:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdYlH-000kn1-16;
	Thu, 30 Jan 2025 17:55:31 +0000
Date: Fri, 31 Jan 2025 01:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev, matthieu.baerts@tessares.net,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: net/ipv4/ip_gre.c:141:22: warning: variable 'data_len' set but not
 used
Message-ID: <202501310132.oGDmspPN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72deda0abee6e705ae71a93f69f55e33be5bca5c
commit: 010b430d5df556d5d232e3751ac691ba9e88c041 mptcp: MPTCP_IPV6 should depend on IPV6 instead of selecting it
date:   4 years, 3 months ago
config: csky-randconfig-p001-20220406 (https://download.01.org/0day-ci/archive/20250131/202501310132.oGDmspPN-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250131/202501310132.oGDmspPN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501310132.oGDmspPN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/ip_gre.c: In function 'ipgre_err':
>> net/ipv4/ip_gre.c:141:22: warning: variable 'data_len' set but not used [-Wunused-but-set-variable]
     141 |         unsigned int data_len = 0;
         |                      ^~~~~~~~


vim +/data_len +141 net/ipv4/ip_gre.c

^1da177e4c3f41 Linus Torvalds           2005-04-16  122  
071f92d05967a0 Rami Rosen               2008-05-21  123  	/* All the routers (except for Linux) return only
^1da177e4c3f41 Linus Torvalds           2005-04-16  124  	   8 bytes of packet payload. It means, that precise relaying of
^1da177e4c3f41 Linus Torvalds           2005-04-16  125  	   ICMP in the real Internet is absolutely infeasible.
^1da177e4c3f41 Linus Torvalds           2005-04-16  126  
^1da177e4c3f41 Linus Torvalds           2005-04-16  127  	   Moreover, Cisco "wise men" put GRE key to the third word
c5441932145563 Pravin B Shelar          2013-03-25  128  	   in GRE header. It makes impossible maintaining even soft
c5441932145563 Pravin B Shelar          2013-03-25  129  	   state for keyed GRE tunnels with enabled checksum. Tell
c5441932145563 Pravin B Shelar          2013-03-25  130  	   them "thank you".
^1da177e4c3f41 Linus Torvalds           2005-04-16  131  
^1da177e4c3f41 Linus Torvalds           2005-04-16  132  	   Well, I wonder, rfc1812 was written by Cisco employee,
bff528578fc3c4 stephen hemminger        2012-02-24  133  	   what the hell these idiots break standards established
bff528578fc3c4 stephen hemminger        2012-02-24  134  	   by themselves???
^1da177e4c3f41 Linus Torvalds           2005-04-16  135  	   */
c5441932145563 Pravin B Shelar          2013-03-25  136  	struct net *net = dev_net(skb->dev);
c5441932145563 Pravin B Shelar          2013-03-25  137  	struct ip_tunnel_net *itn;
96f5a846bdd609 Eric Dumazet             2013-05-18  138  	const struct iphdr *iph;
88c7664f13bd1a Arnaldo Carvalho de Melo 2007-03-13  139  	const int type = icmp_hdr(skb)->type;
88c7664f13bd1a Arnaldo Carvalho de Melo 2007-03-13  140  	const int code = icmp_hdr(skb)->code;
20e1954fe238db Eric Dumazet             2016-06-18 @141  	unsigned int data_len = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  142  	struct ip_tunnel *t;
^1da177e4c3f41 Linus Torvalds           2005-04-16  143  
32bbd8793f24b0 Stefano Brivio           2018-11-08  144  	if (tpi->proto == htons(ETH_P_TEB))
32bbd8793f24b0 Stefano Brivio           2018-11-08  145  		itn = net_generic(net, gre_tap_net_id);
32bbd8793f24b0 Stefano Brivio           2018-11-08  146  	else if (tpi->proto == htons(ETH_P_ERSPAN) ||
32bbd8793f24b0 Stefano Brivio           2018-11-08  147  		 tpi->proto == htons(ETH_P_ERSPAN2))
32bbd8793f24b0 Stefano Brivio           2018-11-08  148  		itn = net_generic(net, erspan_net_id);
32bbd8793f24b0 Stefano Brivio           2018-11-08  149  	else
32bbd8793f24b0 Stefano Brivio           2018-11-08  150  		itn = net_generic(net, ipgre_net_id);
32bbd8793f24b0 Stefano Brivio           2018-11-08  151  
32bbd8793f24b0 Stefano Brivio           2018-11-08  152  	iph = (const struct iphdr *)(icmp_hdr(skb) + 1);
32bbd8793f24b0 Stefano Brivio           2018-11-08  153  	t = ip_tunnel_lookup(itn, skb->dev->ifindex, tpi->flags,
32bbd8793f24b0 Stefano Brivio           2018-11-08  154  			     iph->daddr, iph->saddr, tpi->key);
32bbd8793f24b0 Stefano Brivio           2018-11-08  155  
32bbd8793f24b0 Stefano Brivio           2018-11-08  156  	if (!t)
32bbd8793f24b0 Stefano Brivio           2018-11-08  157  		return -ENOENT;
32bbd8793f24b0 Stefano Brivio           2018-11-08  158  
^1da177e4c3f41 Linus Torvalds           2005-04-16  159  	switch (type) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  160  	default:
^1da177e4c3f41 Linus Torvalds           2005-04-16  161  	case ICMP_PARAMETERPROB:
32bbd8793f24b0 Stefano Brivio           2018-11-08  162  		return 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  163  
^1da177e4c3f41 Linus Torvalds           2005-04-16  164  	case ICMP_DEST_UNREACH:
^1da177e4c3f41 Linus Torvalds           2005-04-16  165  		switch (code) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  166  		case ICMP_SR_FAILED:
^1da177e4c3f41 Linus Torvalds           2005-04-16  167  		case ICMP_PORT_UNREACH:
^1da177e4c3f41 Linus Torvalds           2005-04-16  168  			/* Impossible event. */
32bbd8793f24b0 Stefano Brivio           2018-11-08  169  			return 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  170  		default:
^1da177e4c3f41 Linus Torvalds           2005-04-16  171  			/* All others are translated to HOST_UNREACH.
^1da177e4c3f41 Linus Torvalds           2005-04-16  172  			   rfc2003 contains "deep thoughts" about NET_UNREACH,
^1da177e4c3f41 Linus Torvalds           2005-04-16  173  			   I believe they are just ether pollution. --ANK
^1da177e4c3f41 Linus Torvalds           2005-04-16  174  			 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  175  			break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  176  		}
^1da177e4c3f41 Linus Torvalds           2005-04-16  177  		break;
9f57c67c379d88 Pravin B Shelar          2015-08-07  178  
^1da177e4c3f41 Linus Torvalds           2005-04-16  179  	case ICMP_TIME_EXCEEDED:
^1da177e4c3f41 Linus Torvalds           2005-04-16  180  		if (code != ICMP_EXC_TTL)
32bbd8793f24b0 Stefano Brivio           2018-11-08  181  			return 0;
20e1954fe238db Eric Dumazet             2016-06-18  182  		data_len = icmp_hdr(skb)->un.reserved[1] * 4; /* RFC 4884 4.1 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  183  		break;
55be7a9c6074f7 David S. Miller          2012-07-11  184  
55be7a9c6074f7 David S. Miller          2012-07-11  185  	case ICMP_REDIRECT:
55be7a9c6074f7 David S. Miller          2012-07-11  186  		break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  187  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  188  

:::::: The code at line 141 was first introduced by commit
:::::: 20e1954fe238dbe5f8d3a979e593fe352bd703cf ipv6: RFC 4884 partial support for SIT/GRE tunnels

:::::: TO: Eric Dumazet <edumazet@google.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
