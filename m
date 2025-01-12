Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB816FBF;
	Sun, 12 Jan 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736648167; cv=none; b=eArxzUGJCyesHREfjie8q0NnDoF4xTw2btpzRnScEwOiqo4GmbwRUb6w4QtgSFl4pECSmwIjBnoiE2wmt/QOPowUAuH2gzfcJ7a7n62B+uImtqhobZESlVoz+HjxvhCfFFL7g/UlPXXCw2bamO7iyyznY03EYIimwFat1vh3Hww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736648167; c=relaxed/simple;
	bh=xThfaOQ5NPBFtsgGQYrL1KmCNXu9iReCohV0Y+PByZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RemKKu/UCgaff7dY0xIU8Q60FPg0+CSzZ97BL12k0LzBhBPaum512jrcmDp5FmIWcy6RqJMDfTZ55rgoBgFA/ydKNGpb1EV6wO1vlmQHgZ0wUdmoYviQMqslxQG2G0l84f7LBK048uCGspyLeNwMLbWXQB9uvxZP75QMSXPnX9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7DUIaot; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7DUIaot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736648162; x=1768184162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xThfaOQ5NPBFtsgGQYrL1KmCNXu9iReCohV0Y+PByZk=;
  b=n7DUIaotuKZqAJo3NyzkFGZ8Tg+YiKobXl8N7wHdVjN2+jfN9uHVQ3eZ
   2CImdjpuL2ZPmmQ5y5k+c3REvgOvsD0Rk0YPR5xaLDrH2Th0xpjAKCxc+
   IBWYW91M3PXBGWyb15tACu2O637tNkIczBJVg/aF0jpjn2NXOjCiuhS5H
   MHcDYfZnmhrzxfmwxZwmRHrm0gXFS6JNeLWVwWExg455YqlljCoLGlKyP
   XcEM7nVQcqWaP2FxvnN6iTfjFXqQBZpC4yN+53nKfSQq8p1CiqHUH8M5W
   f+co6WYJ9dTMFPf37EyXybh4mChMS5SBimn7Nfkb+ZJo/E3Kw60G+KU1p
   g==;
X-CSE-ConnectionGUID: T33qRMzuRoCx4Vzd/35t2Q==
X-CSE-MsgGUID: Wtt5i3ULTCW50GdT1G/opw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="37066727"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="37066727"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 18:16:01 -0800
X-CSE-ConnectionGUID: Q7DONXmkRCGJDygU04dCEw==
X-CSE-MsgGUID: zFaIhtS8ThGz8UM9RMp//Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="134912452"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Jan 2025 18:15:59 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWnW9-000LTH-0c;
	Sun, 12 Jan 2025 02:15:57 +0000
Date: Sun, 12 Jan 2025 10:15:43 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev, matthieu.baerts@tessares.net,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: net/ipv4/ip_gre.c:141:22: warning: variable 'data_len' set but not
 used
Message-ID: <202501121007.2GofXmh5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b62cef9a5c673f1b8083159f5dc03c1c5daced2f
commit: 010b430d5df556d5d232e3751ac691ba9e88c041 mptcp: MPTCP_IPV6 should depend on IPV6 instead of selecting it
date:   4 years, 3 months ago
config: csky-randconfig-p001-20220406 (https://download.01.org/0day-ci/archive/20250112/202501121007.2GofXmh5-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501121007.2GofXmh5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501121007.2GofXmh5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/ip_gre.c: In function 'ipgre_err':
>> net/ipv4/ip_gre.c:141:22: warning: variable 'data_len' set but not used [-Wunused-but-set-variable]
     141 |         unsigned int data_len = 0;
         |                      ^~~~~~~~


vim +/data_len +141 net/ipv4/ip_gre.c

^1da177e4c3f415 Linus Torvalds           2005-04-16  122  
071f92d05967a0c Rami Rosen               2008-05-21  123  	/* All the routers (except for Linux) return only
^1da177e4c3f415 Linus Torvalds           2005-04-16  124  	   8 bytes of packet payload. It means, that precise relaying of
^1da177e4c3f415 Linus Torvalds           2005-04-16  125  	   ICMP in the real Internet is absolutely infeasible.
^1da177e4c3f415 Linus Torvalds           2005-04-16  126  
^1da177e4c3f415 Linus Torvalds           2005-04-16  127  	   Moreover, Cisco "wise men" put GRE key to the third word
c54419321455631 Pravin B Shelar          2013-03-25  128  	   in GRE header. It makes impossible maintaining even soft
c54419321455631 Pravin B Shelar          2013-03-25  129  	   state for keyed GRE tunnels with enabled checksum. Tell
c54419321455631 Pravin B Shelar          2013-03-25  130  	   them "thank you".
^1da177e4c3f415 Linus Torvalds           2005-04-16  131  
^1da177e4c3f415 Linus Torvalds           2005-04-16  132  	   Well, I wonder, rfc1812 was written by Cisco employee,
bff528578fc3c4a stephen hemminger        2012-02-24  133  	   what the hell these idiots break standards established
bff528578fc3c4a stephen hemminger        2012-02-24  134  	   by themselves???
^1da177e4c3f415 Linus Torvalds           2005-04-16  135  	   */
c54419321455631 Pravin B Shelar          2013-03-25  136  	struct net *net = dev_net(skb->dev);
c54419321455631 Pravin B Shelar          2013-03-25  137  	struct ip_tunnel_net *itn;
96f5a846bdd6098 Eric Dumazet             2013-05-18  138  	const struct iphdr *iph;
88c7664f13bd1a3 Arnaldo Carvalho de Melo 2007-03-13  139  	const int type = icmp_hdr(skb)->type;
88c7664f13bd1a3 Arnaldo Carvalho de Melo 2007-03-13  140  	const int code = icmp_hdr(skb)->code;
20e1954fe238dbe Eric Dumazet             2016-06-18 @141  	unsigned int data_len = 0;
^1da177e4c3f415 Linus Torvalds           2005-04-16  142  	struct ip_tunnel *t;
^1da177e4c3f415 Linus Torvalds           2005-04-16  143  
32bbd8793f24b0d Stefano Brivio           2018-11-08  144  	if (tpi->proto == htons(ETH_P_TEB))
32bbd8793f24b0d Stefano Brivio           2018-11-08  145  		itn = net_generic(net, gre_tap_net_id);
32bbd8793f24b0d Stefano Brivio           2018-11-08  146  	else if (tpi->proto == htons(ETH_P_ERSPAN) ||
32bbd8793f24b0d Stefano Brivio           2018-11-08  147  		 tpi->proto == htons(ETH_P_ERSPAN2))
32bbd8793f24b0d Stefano Brivio           2018-11-08  148  		itn = net_generic(net, erspan_net_id);
32bbd8793f24b0d Stefano Brivio           2018-11-08  149  	else
32bbd8793f24b0d Stefano Brivio           2018-11-08  150  		itn = net_generic(net, ipgre_net_id);
32bbd8793f24b0d Stefano Brivio           2018-11-08  151  
32bbd8793f24b0d Stefano Brivio           2018-11-08  152  	iph = (const struct iphdr *)(icmp_hdr(skb) + 1);
32bbd8793f24b0d Stefano Brivio           2018-11-08  153  	t = ip_tunnel_lookup(itn, skb->dev->ifindex, tpi->flags,
32bbd8793f24b0d Stefano Brivio           2018-11-08  154  			     iph->daddr, iph->saddr, tpi->key);
32bbd8793f24b0d Stefano Brivio           2018-11-08  155  
32bbd8793f24b0d Stefano Brivio           2018-11-08  156  	if (!t)
32bbd8793f24b0d Stefano Brivio           2018-11-08  157  		return -ENOENT;
32bbd8793f24b0d Stefano Brivio           2018-11-08  158  
^1da177e4c3f415 Linus Torvalds           2005-04-16  159  	switch (type) {
^1da177e4c3f415 Linus Torvalds           2005-04-16  160  	default:
^1da177e4c3f415 Linus Torvalds           2005-04-16  161  	case ICMP_PARAMETERPROB:
32bbd8793f24b0d Stefano Brivio           2018-11-08  162  		return 0;
^1da177e4c3f415 Linus Torvalds           2005-04-16  163  
^1da177e4c3f415 Linus Torvalds           2005-04-16  164  	case ICMP_DEST_UNREACH:
^1da177e4c3f415 Linus Torvalds           2005-04-16  165  		switch (code) {
^1da177e4c3f415 Linus Torvalds           2005-04-16  166  		case ICMP_SR_FAILED:
^1da177e4c3f415 Linus Torvalds           2005-04-16  167  		case ICMP_PORT_UNREACH:
^1da177e4c3f415 Linus Torvalds           2005-04-16  168  			/* Impossible event. */
32bbd8793f24b0d Stefano Brivio           2018-11-08  169  			return 0;
^1da177e4c3f415 Linus Torvalds           2005-04-16  170  		default:
^1da177e4c3f415 Linus Torvalds           2005-04-16  171  			/* All others are translated to HOST_UNREACH.
^1da177e4c3f415 Linus Torvalds           2005-04-16  172  			   rfc2003 contains "deep thoughts" about NET_UNREACH,
^1da177e4c3f415 Linus Torvalds           2005-04-16  173  			   I believe they are just ether pollution. --ANK
^1da177e4c3f415 Linus Torvalds           2005-04-16  174  			 */
^1da177e4c3f415 Linus Torvalds           2005-04-16  175  			break;
^1da177e4c3f415 Linus Torvalds           2005-04-16  176  		}
^1da177e4c3f415 Linus Torvalds           2005-04-16  177  		break;
9f57c67c379d88a Pravin B Shelar          2015-08-07  178  
^1da177e4c3f415 Linus Torvalds           2005-04-16  179  	case ICMP_TIME_EXCEEDED:
^1da177e4c3f415 Linus Torvalds           2005-04-16  180  		if (code != ICMP_EXC_TTL)
32bbd8793f24b0d Stefano Brivio           2018-11-08  181  			return 0;
20e1954fe238dbe Eric Dumazet             2016-06-18  182  		data_len = icmp_hdr(skb)->un.reserved[1] * 4; /* RFC 4884 4.1 */
^1da177e4c3f415 Linus Torvalds           2005-04-16  183  		break;
55be7a9c6074f74 David S. Miller          2012-07-11  184  
55be7a9c6074f74 David S. Miller          2012-07-11  185  	case ICMP_REDIRECT:
55be7a9c6074f74 David S. Miller          2012-07-11  186  		break;
^1da177e4c3f415 Linus Torvalds           2005-04-16  187  	}
^1da177e4c3f415 Linus Torvalds           2005-04-16  188  

:::::: The code at line 141 was first introduced by commit
:::::: 20e1954fe238dbe5f8d3a979e593fe352bd703cf ipv6: RFC 4884 partial support for SIT/GRE tunnels

:::::: TO: Eric Dumazet <edumazet@google.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
