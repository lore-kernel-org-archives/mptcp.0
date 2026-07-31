Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DF369D54;
	Fri, 31 Jul 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522169; cv=none; b=NQDXU9hgPFBJYVM0ewEog1W5wK/IdOOLtklTsM5tOLGvxByjzUTJM7+yHP5bUlsDpQTWNMY51sbOVN7CSVyuzBIRHS9ataDm0EFl82203i3Mqa6gMin16XjG6rBdvMWdRZc/C2yFf1ZFctV2xT4Nd4yj7ore9K5S/Ml4IQPe/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522169; c=relaxed/simple;
	bh=l0UYV6v99l4kayaDyVsaa3EEMIjdVs53AKYspVyykdQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qpCUF7S7vrBdREqyxL2iLnMcY0JOO7Y2aSYgGLguAVqeHSay0gYFMMm6RgTb/OMRcNWp2HJ+B0+57R7d7EEcfnNqgnPYGo6q5SgBJdqu/Hs0NkjcPUVtsE3hba18WqVULIV1jNAuA8uD0hgtLNNRtl6c1qWCH2J/G3mdTHlk3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUp1QjnA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUp1QjnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785522167; x=1817058167;
  h=date:from:to:cc:subject:message-id;
  bh=l0UYV6v99l4kayaDyVsaa3EEMIjdVs53AKYspVyykdQ=;
  b=RUp1QjnAjuRFhzI/uo9sHKXn8/V86IdApUEUhQMwru9cnm82SbyLoX+y
   hCy3NN6zQ03Uw+fABrJZijTN6Ai98WxqmvQSJs/BkQMMx5XaIkDkOCmWC
   66ajM7ORZwfBFRObXEDGwTv2CmncatPqsse5L/sWPr6jjsjMBhpqnaAh9
   HwThhAY5kIQ2b0qM7VxWYNKNrnIw/4fdpx9w/GpFmDwUTR4I3bLo1dGOd
   GEMoZq1JGinNsnQLXCuH3dshCjbXvavGk5gx1D0bTO6DjYNVlG+OUJ77Y
   SAsTexmtn4PZ+7sVMjU31Yuo4oseDRmZz9bpxvoqaCMzvzobXu/D4wL/l
   w==;
X-CSE-ConnectionGUID: 9sEERp8FRA2yxifUoRotGQ==
X-CSE-MsgGUID: S8x5hYUNSfWbf+0rGT8YMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="97526556"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="97526556"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 11:22:46 -0700
X-CSE-ConnectionGUID: aRT1qm6iT5uwlu1gED8IRA==
X-CSE-MsgGUID: 1ruQRTDaSY2hpAdqC0WJ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="261256406"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2026 11:22:45 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wprsY-000000003FC-2g1K;
	Fri, 31 Jul 2026 18:22:42 +0000
Date: Fri, 31 Jul 2026 20:22:06 +0200
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net, 0day robot <lkp@intel.com>
Subject: net/mptcp/options.c:1207:39: warning: implicit conversion
 from 'enum <anonymous>' to 'enum linux_mptcp_mib_field'
Message-ID: <202607312002.iM0J3v4Q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/intel-lab-lkp/linux/commits/Matthieu-Baerts-NGI0/Squash-to-mptcp-explicitly-drop-over-memory-limits/20260731-182110
head:   85f8043c37254556a09478e4f26c2012a1c92fc6
commit: 79d68403b0c660279617aeb43ee4265c72640fd3 Squash to "mptcp: explicitly drop over memory limits"
date:   8 hours ago
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260731/202607312002.iM0J3v4Q-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260731/202607312002.iM0J3v4Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607312002.iM0J3v4Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/options.c: In function 'mptcp_over_limit':
>> net/mptcp/options.c:1207:39: warning: implicit conversion from 'enum <anonymous>' to 'enum linux_mptcp_mib_field' [-Wenum-conversion]
    1207 |         MPTCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
         |                                       ^~~~~~~~~~~~~~~~~~~~~


vim +1207 net/mptcp/options.c

  1185	
  1186	static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
  1187				     const struct sk_buff *skb)
  1188	{
  1189		struct mptcp_sock *msk = mptcp_sk(sk);
  1190		u64 mem = sk_rmem_alloc_get(sk);
  1191	
  1192		mem += READ_ONCE(msk->backlog_len);
  1193		if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
  1194			return false;
  1195	
  1196		/* Avoid silently dropping pure acks, fin or already-acked segments. */
  1197		if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
  1198		    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
  1199		    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
  1200			return false;
  1201	
  1202		/* Dropped due to memory constraints, schedule an ack. */
  1203		inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
  1204		inet_csk_schedule_ack(ssk);
  1205	
  1206		/* In fallback mode: skb is dropped before the TCP recv queue. */
> 1207		MPTCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
  1208	
  1209		return true;
  1210	}
  1211	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
