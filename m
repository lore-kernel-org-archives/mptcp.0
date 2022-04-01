Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765567B
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 23:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648854859; x=1680390859;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ov+GdFoE9cHZ6FoiXg+BAyICO/TF6xGvDJ4FtPzq8JQ=;
  b=JgnkwszWj/6zehLFGXdyMXqGoRUaYJt/ENZBUPMSvipL//K2UWzFViPi
   2XqcOWSm9n4+hBb9bTqtR2OhOVcL/XtRTeX5I5Grhui8vzh1jxsI7b/mn
   SGZ7tmGXvQX738v31Ukiu0820/wGTJvQO9bQYncoN51f/IqWZL3EBO4be
   i11VSJt4c+Z2pYJ/3UcUxuysJA6IxMO5Xtwc1ucqaQKziop6wsxOffVRY
   jiYA0Ih1tzjFa4EUoKivqbCYI3Jgp2/5Ek+3EcXs7MYCM1n7KwJVdLP3j
   Pj0/cfU6QR5rR9rhgiCC4tm4dRwqsYabUcF0UvSUqR2NyUYVt6PgA0PKc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="257830444"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="257830444"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 16:14:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="567902094"
Received: from jchai-mobl1.amr.corp.intel.com ([10.252.135.241])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 16:14:06 -0700
Date: Fri, 1 Apr 2022 16:14:06 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] split MP_FAIL testcases
In-Reply-To: <cover.1648826372.git.geliang.tang@suse.com>
Message-ID: <77362ea-cc6f-6e17-561-9cad96d58f7@linux.intel.com>
References: <cover.1648826372.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 1 Apr 2022, Geliang Tang wrote:

> Split MP_FAIL testcases into two patches:
>
> selftests: mptcp: add infinite map testcase
> selftests: mptcp: add MP_FAIL reset testcase
>
> The former can be upstreaming with the infinite map series, the latter
> stays on the export branch, waiting for the dropping bad data patches,
> and the fix for issue #265.
>
> Geliang Tang (2):
>  Squash to "selftests: mptcp: add the MP_FAIL testcases"
>  selftests: mptcp: add MP_FAIL reset testcase
>
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
> -- 
> 2.34.1

Fine with me to split the commit, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
