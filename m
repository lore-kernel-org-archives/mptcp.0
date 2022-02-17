Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9934615
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645137832; x=1676673832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/3ebf5rlj0XZzYFBPG+puXbFk4nNPRJmye6W8oBlaoU=;
  b=RuAnMLE99ZqPW5bZmsyVkehDac4tuqGXER9BnvO2AB/j6bxNUrkFoN1k
   wmmd5hWE52qRZnmZjoZYJFVr7IUgVoMZbGscbpuPePsWDaOzwrzWVkqnC
   U+x5kgQkqPKfMjEiFYaSUv+wbRQqkRlVTPbYY+BtyItfol1F8FrgBalhu
   ba2tuzQVyzbDyi3QlsqdqY8KX0g6IJfTXh0a1dQrfp8ftrflBjPJM225D
   Ab5Mu0ZhpqaXPTzrv+BGhsT0VYd4z0lpakXScR7YaW3Bh5HiGvz3iCR3y
   Bsl8GrElz8H8SXv3JR1LGNDoLRxU3u0T52UTj+1fES2nRyji6EKptR7FR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248587728"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="248587728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 14:43:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="637416346"
Received: from pjayapal-mobl1.amr.corp.intel.com ([10.212.185.200])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 14:43:51 -0800
Date: Thu, 17 Feb 2022 14:43:51 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Upstreaming pending -net patches from the export branch, with
 conflicts
Message-ID: <c2bcf4d9-9f9a-d4f-a877-2d18c2606f7a@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Paolo -

There are 7 pending -net patches in the export branch 
(export/20220217T054646):

a92e1a369e45 selftests: mptcp: be more conservative with cookie MPJ limits
0d1f61719931 selftests: mptcp: more robust signal race test
f9ce14971cd2 mptcp: add mibs counter for ignored incoming options
474d31e3d81f mptcp: fix race in incoming ADD_ADDR option processing
cb3236ecdf7f mptcp: fix race in overlapping signal events
ec621fe172ae selftests: mptcp: improve 'fair usage on close' stability
3dbd5c179fa0 selftests: mptcp: fix diag instability

I was doing a test run to see how these applied to net/master and ran in 
to two issues:

"selftests: mptcp: improve 'fair usage on close' stability" creates a 
net/net-next merge conflict due to the renaming of "wait_for_tw" to 
"wait_attempt_fail". I propose to drop this rename for the -net patch and 
queue a new patch for mptcp-next with just the rename.


"selftests: mptcp: more robust signal race test" creates a net/net-next 
conflict that's due to changes in the patch context (switching from 
direct calls to "ip netns exec..." to "pm_nl_add_endpoint"). I think the 
conflict resolution is super obvious for the netdev maintainers if we 
remove the blank line added here:

  	# signal addresses race test
  	reset
+
  	pm_nl_set_limits $ns1 4 4
  	pm_nl_set_limits $ns2 4 4

So, I propose to remove that whitespace change and mention the expected 
merge conflict when posting to netdev.

Sound good?

--
Mat Martineau
Intel
