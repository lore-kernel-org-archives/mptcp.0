Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8532C84
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrarynNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702899470; x=1734435470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x390/JoqrwCJKHJ41hPIQjHrKVNmLzV6mMY7P413fek=;
  b=mrarynNOq7/P0JfncsZaG+33h2xXfn43YPpFdwfly9C11dKXaISI0PSS
   BZZ9aJADsRGAsHoWb44OpGPDoG/tfDr2UG10mU7e45ycCxgQjoBJnhWKI
   UskHm2CVWNMhvLbBOXsVutnPSDORcIZgSoui2CGmXTxI0T9I3UxhZev8c
   e9GGmNq+CuEcXqfOXnteaOZbt+BkBcE5PzF75qDfFnmzIBSyhqqYYHc/x
   zoIi4Ech0HpsMoXF8dO7OmYjCCIzeluAsmwWQfR3zhKr4s3GRzWvPeAZA
   pLSbz0e+zluwpkKmzcMRlWT13J4OuDicrxu+BVpksSG9hLhNYkWPPTegF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2701101"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="2701101"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1106909102"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="1106909102"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:37:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFBwL-00000006udw-2pFz;
	Mon, 18 Dec 2023 13:37:41 +0200
Date: Mon, 18 Dec 2023 13:37:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	nhorman@tuxdriver.com, matttbe@kernel.org, martineau@kernel.org,
	yotam.gi@gmail.com, jiri@resnulli.us, jacob.e.keller@intel.com,
	johannes@sipsolutions.net, fw@strlen.de
Subject: Re: [PATCH net-next] genetlink: Use internal flags for multicast
 groups
Message-ID: <ZYAvBdhiAnR9dIi3@smile.fi.intel.com>
References: <20231217075348.4040051-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217075348.4040051-1-idosch@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 17, 2023 at 09:53:48AM +0200, Ido Schimmel wrote:
> As explained in commit e03781879a0d ("drop_monitor: Require
> 'CAP_SYS_ADMIN' when joining "events" group"), the "flags" field in the
> multicast group structure reuses uAPI flags despite the field not being
> exposed to user space. This makes it impossible to extend its use
> without adding new uAPI flags, which is inappropriate for internal
> kernel checks.
> 
> Solve this by adding internal flags (i.e., "GENL_MCAST_*") and convert
> the existing users to use them instead of the uAPI flags.
> 
> Tested using the reproducers in commit 44ec98ea5ea9 ("psample: Require
> 'CAP_NET_ADMIN' when joining "packets" group") and commit e03781879a0d
> ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group").
> 
> No functional changes intended.

...

> +#define GENL_MCAST_CAP_NET_ADMIN	BIT(0)
> +#define GENL_MCAST_CAP_SYS_ADMIN	BIT(1)
> +
>  /**
>   * struct genl_multicast_group - generic netlink multicast group
>   * @name: name of the multicast group, names are per-family
> - * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
> - * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
> + * @flags: GENL_MCAST_* flags
>   */

No functional, but documentation changes...

So, I suggest to have these flags being described

/* ... */
#define FLAG1

/* ... */
#define FLAG2

-- 
With Best Regards,
Andy Shevchenko


