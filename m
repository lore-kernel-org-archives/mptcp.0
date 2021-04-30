Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051A2F80
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 00:07:12 +0000 (UTC)
IronPort-SDR: KwlqiWN3DwwbHg+TNp+3tjWm2oHP0DmOrYy4QR9s2xOikbpAOd+Eyk27YCo+X5vWKjH/0hj+cm
 6L/WypqO7bqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197197786"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197197786"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 17:07:11 -0700
IronPort-SDR: eEpNwJVtmnvTJwD5Ootohr8rLADyARR0kHHsSt6C+VtKCUuLR61ae900JSkCmtRYtLHZm4pGi0
 pzhmK7tIcISQ==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="619922693"
Received: from rbidari-mobl1.amr.corp.intel.com ([10.254.72.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 17:07:10 -0700
Date: Thu, 29 Apr 2021 17:07:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: support SYSCTL only if enabled
In-Reply-To: <20210429145912.2022531-1-matthieu.baerts@tessares.net>
Message-ID: <9c92075-e759-baed-c1a5-7f167bfa60f9@linux.intel.com>
References: <20210429145912.2022531-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 29 Apr 2021, Matthieu Baerts wrote:

> Since the introduction of the sysctl support in MPTCP with
> commit 784325e9f037 ("mptcp: new sysctl to control the activation per NS"),
> we don't check CONFIG_SYSCTL.
>
> Until now, that was not an issue: the register and unregister functions
> were replaced by NO-OP one if SYSCTL was not enabled in the config. The
> only thing we could have avoid is not to reserve memory for the table
> but that's for the moment only a small table per net-ns.
>
> But the following commit is going to use SYSCTL_ZERO and SYSCTL_ONE
> which are not be defined if SYSCTL is not enabled in the config. This
> causes 'undefined reference' errors from the linker.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    The "following" commit is "mptcp: restrict values of 'enabled' sysctl".
>
>    The goal is to place this patch before this commit.
>
> net/mptcp/ctrl.c | 28 ++++++++++++++++++++++------
> 1 file changed, 22 insertions(+), 6 deletions(-)
>

Looks good to me, thanks Matthieu.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
