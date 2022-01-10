Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2312C80
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641839223; x=1673375223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R5Zo9ny13KCunK1kSzVm6MLNseWPMAXIirbf7EO9R/w=;
  b=L+rpnG5u4AGdd7k3mM5/QtWKa2huND8h9j2S4CKVn4lw/1XIxoUk9EdX
   zSK1hB3ZhLOxrTizkQnZ63E8fPyZEFS92bPuh5KK7srG4e/VlbLu91vJ1
   VoTnYue8jXy3h8Pm2YDWTBCDSeOsMw5CKrT9LRovRC1jQRI9mjrFKDT/Z
   rxFr4gyG8PLDQ7eBEo6HMstEpFuifyA2BsLbm6kucpMYJkoOo4v2YKP5H
   tFs6ZAbATtZGyqmSOHC0ns6bjos9muAbQMPi+h30u/9Pecy2P8zFH3PHC
   HvJhuWBocaDoAKcSF7Yp1WWMMePbAnnCaaBcXClbInj/CFlgivEfosVUx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="242103278"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242103278"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:27:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="558071488"
Received: from rspencer-mobl.amr.corp.intel.com ([10.209.51.95])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:26:56 -0800
Date: Mon, 10 Jan 2022 10:26:56 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Export branch squash
Message-ID: <af3c2f86-51cd-f0b7-66f3-19c9238ec188@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Matthieu -

With the latest export branch rebase (export/20220110T054834), there are 
two "selftests: mptcp: more stable join tests-cases" commits: one is the 
version merged to net-next, the other is a leftover bit only in the export 
branch due to patch reordering.

The one that isn't in net-next (74397e5f40b3) can be squashed with 
"selftests: mptcp: add infinite map mibs check" (cb7e9100a8b8)


Thanks!

--
Mat Martineau
Intel
