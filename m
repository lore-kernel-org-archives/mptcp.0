Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1E8F52
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667253861; x=1698789861;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VWxrD/MI3itLy5P32OnLES9Ck48oST9+odmgZxC9qsc=;
  b=U7d7O52OyzzXgPBxfu7fY2+nqpYozJNzC/g2tNYzWNKWDnmzwfy+QhXs
   Vw43ZiyZGYivmz7oLYS5OHnPiucMAyrfiWENLSwaT/7ROisNVE4BhfeRg
   3Qa7tjTqd49vER/DwcExOCH0tDwL/K4R0hxBVJbkkNVOFM3Te9xFET1j3
   J8qBWzh5FZVK1KqSycNvVBKCnC9jnU7g2u4WWdv/KnG6nQhRNALGdHN0X
   tCKLOb3FZ+KWMW7r0l6qkU2x3zcIMeRe0o+IMydiVXoIO+s8ODsJXknIG
   q2kFLcZOTVVsrV6t/V49KmB6poqk8miiPl1gSFC3rSVeW9XKKek1qrW7B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373221268"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="373221268"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 15:04:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="636200844"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="636200844"
Received: from jblosfi-mobl1.amr.corp.intel.com ([10.255.229.117])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 15:04:20 -0700
Date: Mon, 31 Oct 2022 15:04:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] mptcp: run mptcp_sockopt from a new netns
 + cleanup
In-Reply-To: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Message-ID: <a1572fd3-3ae2-5f67-4d9a-b561eecfed2a@linux.intel.com>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 19 Oct 2022, Matthieu Baerts wrote:

> Here are some small fixes for the MPTCP selftests, no big changes.
>
> The first patch is a fix and for -net: if we run mptcp_sockopt.sh after having
> modified some settings related to MPTCP on the host, we can run into issues
> without this patch.
>
> The second patch uses the new netns for mptcp_inq, cleaner.
>
> The third one remove some defined but unused vars.
>
> The last one uniform 'rndh' variable because it was declared with undefined
> variables in a few places.
>
> Matthieu Baerts (4):
>  selftests: mptcp: run mptcp_sockopt from a new netns
>  selftests: mptcp: run mptcp_inq from a clean netns
>  selftests: mptcp: removed defined but unused vars
>  selftests: mptcp: uniform 'rndh' variable
>
> tools/testing/selftests/net/mptcp/diag.sh       |  1 +
> .../selftests/net/mptcp/mptcp_connect.sh        |  6 +-----
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  5 +++--
> .../selftests/net/mptcp/mptcp_sockopt.sh        | 17 ++++++++---------
> .../testing/selftests/net/mptcp/simult_flows.sh |  4 +---
> .../testing/selftests/net/mptcp/userspace_pm.sh |  2 +-
> 6 files changed, 15 insertions(+), 20 deletions(-)
>
>
> base-commit: 1907372cfe4315a0491ae262ac23b1b4cd9cdf94
> -- 
> 2.37.2

Ok, with the follow-up discussion and handling Geliang's suggested fix for 
mptcp-next as an additional patch, this series looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
