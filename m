Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F44F21
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 00:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645228962; x=1676764962;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KMOAhz+r5WvgSkqfDJENwD4n0mswPrREtfWbmbuvCow=;
  b=eXaGUqK0qUD45JovK/IFX8q34wQ/RGz4BdUMwKYYja29RFmIDHM/+jNv
   DWNcxQv6WXCXAViwgGRt5gV1M6/cXwxd+lYi0u5Qgom9JcSrkNgmMUxHL
   Pd+H8DSGYprC85aE7OkYpGtZKSuA5M0Mjb3sAHx0eq5XxDMuxTufSmgdv
   uUF7Di/EYBBpqcwuGwKXsGIl7lOwA3R0u1f6fdEu0RHysPM/2weRqRwjr
   kXzwrqaIdBUKfSmMBIKMrgEIKOIYUYsc1LOmjVRWnfsADeLKkhxuGMahD
   EWQZ24KT/JS2W8ZtTzZbkEziK8MV9Pxeuwug0JQfuzRDDg6EE4+UIkQO+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="234787316"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="234787316"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 16:02:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="705575582"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 16:02:40 -0800
Date: Fri, 18 Feb 2022 16:02:40 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/7] add fastclose testcases
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
Message-ID: <cc8eee29-4877-e81e-1b55-b99f28da18ac@linux.intel.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 15 Feb 2022, Geliang Tang wrote:

> v3:
> - merge the squash-to patch ("Squash to "selftests: mptcp: add
> fastclose testcases v2") into v3.
> - add a new patch to check fastclose in mptcp_connect.sh
>
> base-commit: 9dff76d953f7a0fe2b27818f2aa93031c9a617cf

With the two squash-to patches:

https://patchwork.kernel.org/project/mptcp/patch/22588887e5e516015f7f7b9d09112efc679fecf7.1645159759.git.geliang.tang@suse.com/
https://patchwork.kernel.org/project/mptcp/patch/0ecb29a09e1b2768ef1166a33dc089e1fa3ae339.1645180743.git.geliang.tang@suse.com/

v3 looks good for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> v2:
> - merge the squash-to patch ("Squash to "selftests: mptcp: add the
> MP_RST mibs check") into v2.
> - update the commit logs.
>
> This patchset is related to issue #48 and issue #197. The two MP_RST
> patches are moved from the "add mp_fail testcases" series.
>
> Geliang Tang (7):
>  mptcp: add the mibs for MP_FASTCLOSE
>  selftests: mptcp: add the MP_FASTCLOSE mibs check
>  mptcp: add the mibs for MP_RST
>  selftests: mptcp: add the MP_RST mibs check
>  selftests: mptcp: add extra_args in do_transfer
>  selftests: mptcp: add fastclose testcases
>  selftests: mptcp: fastclose check in mptcp_connect
>
> net/mptcp/mib.c                               |   4 +
> net/mptcp/mib.h                               |   4 +
> net/mptcp/options.c                           |   5 +
> .../selftests/net/mptcp/mptcp_connect.sh      |  37 +++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 134 ++++++++++++++++--
> 5 files changed, 171 insertions(+), 13 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
