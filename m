Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC77E3
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 01:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672967726; x=1704503726;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4rWGoHurHhpz0RALwlLyd5/fqwsBsrM9zbFG4W6h04Q=;
  b=PYnKabeleQ88ItxMTKXx7Ft3L0H3hNdFQnOmVu/z72lrigA08uXb8I11
   H7TrL3Nc21trRbQVGxDS4Kfxs1n8OEVUifgUipk4avjunGWCGnKiO7V6B
   puMeqjTtwjNYzdFTYu8FQciDj8LBD5HolL/ZFwC3idTIxo9+7t4IlGz1i
   b5zJFrX3DiANQlgiKgdt6HkPcbmVwT1PS/cl4Jgm+zz0+JNAm+aNC39KH
   LXOBV29Gj+J36c3cM+KAQlzAqhz9Zn6VcZD+Kgkbr9xQtKXF07UEYbBba
   DjSerGuNJk0XHeu5oqBHPHfbMmlWP6DIRHmQQ2ayU+19YB5IitRhsfgaJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="322436109"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="322436109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 17:15:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="686305578"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="686305578"
Received: from bkrishn1-mobl.amr.corp.intel.com ([10.251.16.148])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 17:15:02 -0800
Date: Thu, 5 Jan 2023 17:15:02 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net/next v5 00/12] mptcp: add support for mixed
 v4/v6
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Message-ID: <1d6a5e49-dd47-0c1a-c566-825e3da7e75b@linux.intel.com>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 4 Jan 2023, Matthieu Baerts wrote:

> This is a v5 of Paolo's series with the same name but with some
> modifications and additional patches.
>
> ChangeLog:
>  - v3 -> v4:
>    - Fix a compilation error without CONFIG_MPTCP_IPV6 in patch 4/12.
>    - Add a title for the cleanup part in patch 9/12
>    - Add the patch 12/12 to avoid "read" errors
>  - v4 -> v5:
>    - Fix typo in patch 2/12 (Mat)
>    - More details in the commit message of patch 2/12 (Mat)
>    - Rebased on top of the latest export branch
>
> This series can be split in 2 parts: the 3 first patches are for -net
> while the rest is for net-next. Patches for net-next depends on patches
> for -net, that's why everything is being sent together.
>
> Patch 1 lets the userspace PM selects the proper family to avoid
> creating subflows with wrong source and/or destination addresses because
> the family is not the expected one.
>
> Patch 2 makes sure the userspace PM doesn't allow the userspace to
> create subflows for a family that is not allowed.
>
> The core MPTCP implementation is just a few bits of properly supporting
> a mix of v4 and v6 subflows, we just need to allow specifying the
> subflow family explicitly (patch 1) and remove artificial constraints in
> the in-kernel PM currently enforcing no mixed subflow in place (patch
> 4).
>
> Patch 5 makes sure the sk_ipv6only attribute is also propagated to
> subflows, just in case the PM doesn't respect it.
>
> Some selftests have also been added for the userspace PM (patch 3) and
> the in-kernel PM (patch 6).
>
> Patches 7 and 8 are just some cleanups in the userspace PM, not related
> to the rest but I saw them when modifying the file.
>

Patches 1-8 look good for further testing in the export (and export-net) 
branches:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> Patches 9 to 12 improve the messages printed by the userspace PM,
> especially in case of error during the validation.
>

I have a very minor formatting comment on patch 9 (separate reply)


- Mat


> Matthieu Baerts (9):
>  mptcp: netlink: respect v4/v6-only sockets
>  selftests: mptcp: userspace: validate v4-v6 subflows mix
>  mptcp: propagate sk_ipv6only to subflows
>  mptcp: remove assigned but unused value
>  mptcp: userspace pm: use a single point of exit
>  selftests: mptcp: userspace: print titles
>  selftests: mptcp: userspace: refactor asserts
>  selftests: mptcp: userspace: print error details if any
>  selftests: mptcp: userspace: avoid read errors
>
> Paolo Abeni (3):
>  mptcp: explicitly specify sock family at subflow creation time
>  mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
>  selftests: mptcp: add test-cases for mixed v4/v6 subflows
>
> net/mptcp/pm.c                                |  25 +++
> net/mptcp/pm_netlink.c                        |  58 ++---
> net/mptcp/pm_userspace.c                      |  14 +-
> net/mptcp/protocol.c                          |   2 +-
> net/mptcp/protocol.h                          |   6 +-
> net/mptcp/sockopt.c                           |   1 +
> net/mptcp/subflow.c                           |   9 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh |  53 ++++-
> .../selftests/net/mptcp/userspace_pm.sh       | 200 ++++++++++++------
> 9 files changed, 262 insertions(+), 106 deletions(-)
>
>
> base-commit: 0e6e165b9b9b5ea418067cfac1e861892ee7e12c
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
