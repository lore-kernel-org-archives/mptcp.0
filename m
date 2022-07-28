Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38917A
	for <mptcp@lists.linux.dev>; Thu, 28 Jul 2022 23:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659049612; x=1690585612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OtoJA21w/xUWIJo6/Pj6979497v3tlvel35mFx7ME8I=;
  b=SqrLtaCLlzkg2ZLYBoA0fVtMXj5zqym8I2kmqTzwzDJibMQ7NyLthUvd
   eDazDyWR6CzhGqm8D8+iIzW+/2XUBY982H8t36rxvYaAiS3Nj3WQwpeYp
   bPRiBrsm5nNy/G2f0pyG9SinyC77JE4/hGeX8jg8KfiocYvNaSnsKa+Cf
   F4SaOxWiDAhJabZR2V3dmzf3dDeWYVkKBxRHgWMe+3NMH+WxT+j9fQ/ml
   PiHkdSwk8i9q6qtEWtqyaiAdo5Gjnh1ITGeGe2oKTqS53A3ueS1vLChyS
   Yx0TdoBD2hSoVJTxXXFiPEOhCT0trxinXaDb1Ywh6yOb/8xz0935Juvdb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="271688388"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="271688388"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 16:06:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="703993422"
Received: from jjois-mobl1.amr.corp.intel.com ([10.209.56.209])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 16:06:51 -0700
Date: Thu, 28 Jul 2022 16:06:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: MPTCP patches pending for -net
Message-ID: <73f44e58-3ead-e2fc-ac83-4e3ee99d534@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Paolo -


Since we didn't get to discuss this question in the meeting today: With 
the final -net pull request for 5.19-final already sent, should I wait 
until next week to send the two patches we have in export-net now?

mptcp: do not queue data on closed subflows
mptcp: move subflow cleanup in mptcp_destroy_common()


Thanks,

--
Mat Martineau
Intel
