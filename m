Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E67C
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648839746; x=1680375746;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cVpnz/Jary86Rd3CFqZqmi5kqrMpA9W8BlJ4ImeAO+k=;
  b=AqEM83Is1S89nQ6beJ6SACYz1LzjOQG6lZB0NMKVJLIo/I8eY8IGapKY
   QyzE8YX1nFcD332Jc7k/aQFpz/hEGtwRYTecC2jwo+3ebmia9s6ikBezY
   MXnuXL0lSdPFiUAJxXG4eMcSgpKZLNLxMI3Lxwj4J30OfZS9PkkwAcjtI
   j1TpQd37vwM66KtUjY2Znvpq9iaaYSPQ8GowJH4K+1DK9mc/7A8yRVvpc
   HHnnMSvE2pZ2hQb1GYwpMzpYOi1sgs13Wgn/IwL/Hx7vIjNUwLKwlMTZq
   e/7TIQCp4p96XNmGEAB1LIzfn9Wa5/JEO7Xlu9K5VuqmEUxc4S8FDfG9Z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240799719"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="240799719"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:02:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567724101"
Received: from nidhikum-mobl.amr.corp.intel.com ([10.209.9.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:02:16 -0700
Date: Fri, 1 Apr 2022 12:02:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 02/14] mptcp: handle local addrs announced
 by userspace PMs
In-Reply-To: <20220329021437.1196552-3-kishen.maloor@intel.com>
Message-ID: <2588c590-a25d-28d-23e-fc8b75389bc9@linux.intel.com>
References: <20220329021437.1196552-1-kishen.maloor@intel.com> <20220329021437.1196552-3-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Mar 2022, Kishen Maloor wrote:

> This change adds an internal function to store/retrieve local
> addrs announced by userspace PM implementations to/from its kernel
> context. The function addresses the requirements of three scenarios:
> 1) ADD_ADDR announcements (which require that a local id be
> provided), 2) retrieving the local id associated with an address,
> and also where one may need to be assigned, and 3) reissuance of
> ADD_ADDRs when there's a successful match of addr/id.
>
> The list of all stored local addr entries is held under the
> MPTCP sock structure. Memory for these entries is allocated from
> the sock option buffer, so the list of addrs is bounded by optmem_max.
> The list if not released via REMOVE_ADDR signals is ultimately
> freed when the sock is destructed.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v6:
> -Move local_addr_list into struct mptcp_pm_data.
> -Replace mptcp_data_lock() with the pm spinlock.
> -Move mptcp_userspace_pm_append_new_local_addr() and
> mptcp_free_local_addr_list() into a new pm_userspace.c.
> -Make addresses_equal() helper non-static and rename to
> mptcp_addresses_equal().
> ---
> net/mptcp/Makefile       |  2 +-
> net/mptcp/pm.c           |  1 +
> net/mptcp/pm_netlink.c   | 34 +++++++++---------
> net/mptcp/pm_userspace.c | 74 ++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c     |  1 +
> net/mptcp/protocol.h     |  7 ++++
> 6 files changed, 101 insertions(+), 18 deletions(-)
> create mode 100644 net/mptcp/pm_userspace.c
>
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index e54daceac58b..cb7f53f6ab22 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
> obj-$(CONFIG_MPTCP) += mptcp.o
>
> mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
> -	   mib.o pm_netlink.o sockopt.o
> +	   mib.o pm_netlink.o sockopt.o pm_userspace.o
>
> obj-$(CONFIG_SYN_COOKIES) += syncookies.o
> obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5d6832c4d9f2..cdc2d79071f8 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -469,6 +469,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> {
> 	spin_lock_init(&msk->pm.lock);
> 	INIT_LIST_HEAD(&msk->pm.anno_list);
> +	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
> 	mptcp_pm_data_reset(msk);
> }
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8d04c8d8a8df..836f6df9f744 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -55,8 +55,8 @@ struct pm_nl_pernet {
> #define MPTCP_PM_ADDR_MAX	8
> #define ADD_ADDR_RETRANS_MAX	3
>
> -static bool addresses_equal(const struct mptcp_addr_info *a,
> -			    const struct mptcp_addr_info *b, bool use_port)
> +bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
> +			   const struct mptcp_addr_info *b, bool use_port)

There's a minor conflict with the export branch here after the get_pernet 
helpers were added. I know you're planning a rebase but figured I'd 
capture it here on the ML.


--
Mat Martineau
Intel
