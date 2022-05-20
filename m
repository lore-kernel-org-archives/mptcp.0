Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A302F33
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 00:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653005115; x=1684541115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IiJY2js+rPkuFaQOWH7HKCr7xno9b7c+PtvFgscgEmU=;
  b=OCl1ck+zMcJ6LGAfPT4M1iC/x4nBoMf0Lr5M9YEYQDjO7sAMZ4LpTNht
   He6AtujYL8DIlnYaA+HJz1/E9FBg6y0hEVvslsmI9wlzUCjowGqD/PI3N
   hwGKc7AHcERQBcCiKc6r/bbYryoMC+06Yiz+W4y1J+v/BaCtibU7/6sdW
   H7GpLksohaANte5f2iuCiH0Aud41mUgDuUrw6i96kcjMTza715on+QtST
   Q5s5wvOEQkzmzshnhkCrMfMxgDX8C+TOsHGw3oeyLpQ57rHbDT8ApH/c4
   VRV3m8jZDqrmfIGeGRbYultpr9Fu52J6sQQIi+GJKHqw441DGfcBsTqFv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="333049064"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="333049064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:05:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="575903567"
Received: from camcconn-mobl1.amr.corp.intel.com ([10.255.229.130])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:05:14 -0700
Date: Thu, 19 May 2022 17:05:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Ossama Othman <ossama.othman@gmail.com>
cc: mptcp@lists.linux.dev, Ossama Othman <ossama.othman@intel.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix conflict with <netinet/in.h>
In-Reply-To: <20220519153929.214331-1-ossama.othman@intel.com>
Message-ID: <f4baa4-81e6-21df-80a5-13eb15317559@linux.intel.com>
References: <20220519153929.214331-1-ossama.othman@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 19 May 2022, Ossama Othman wrote:

> Including <linux/mptcp.h> before the C library <netinet/in.h> header
> causes symbol redefinition errors at compile-time due to duplicate
> declarations and definitions in the <linux/in.h> header included by
> <linux/mptcp.h>.
>
> Explicitly include <netinet/in.h> before <linux/in.h> in
> <linux/mptcp.h> when __KERNEL__ is not defined so that the C library
> compatibility logic in <linux/libc-compat.h> is enabled when including
> <linux/mptcp.h> in user space code.
>
> Signed-off-by: Ossama Othman <ossama.othman@intel.com>

Looks good to me, I think this makes things easier for userspace.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> include/uapi/linux/mptcp.h | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 921963589904..dfe19bf13f4c 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -2,16 +2,17 @@
> #ifndef _UAPI_MPTCP_H
> #define _UAPI_MPTCP_H
>
> +#ifndef __KERNEL__
> +#include <netinet/in.h>		/* for sockaddr_in and sockaddr_in6	*/
> +#include <sys/socket.h>		/* for struct sockaddr			*/
> +#endif
> +
> #include <linux/const.h>
> #include <linux/types.h>
> #include <linux/in.h>		/* for sockaddr_in			*/
> #include <linux/in6.h>		/* for sockaddr_in6			*/
> #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
>
> -#ifndef __KERNEL__
> -#include <sys/socket.h>		/* for struct sockaddr			*/
> -#endif
> -
> #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
> #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
> #define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
