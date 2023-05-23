Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D21F93C
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 18:53:51 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q1Whk-0004jN-Bs; Tue, 23 May 2023 20:25:52 +0200
Date: Tue, 23 May 2023 20:25:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Message-ID: <ZG0FL9XM-MFgfyQ-@strlen.de>
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>

Paolo Abeni <pabeni@redhat.com> wrote:
> Some user-space applications want to monitor the subflows utilization.
> 
> Dumping the per subflow tcp_info is not enough, as the PM could close
> and re-create the subflows under-the-hood, fooling the accounting.
> Even checking the src/dst addresses used by each subflow could not
> be enough, because new subflows could re-use the same address/port of
> the just closed one.
> 
> This patch introduces a new socket option, allow dumping all the relevant
> information all-at-once (everything, everywhere...), in a consistent manner.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>  - added missing changelog (oops)
> ---
>  include/uapi/linux/mptcp.h | 16 ++++++++
>  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 32af2d278cb4..f4f42d88e58b 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -12,6 +12,7 @@
>  #include <linux/in.h>		/* for sockaddr_in			*/
>  #include <linux/in6.h>		/* for sockaddr_in6			*/
>  #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
> +#include <linux/tcp.h>		/* for tcp_info				*/
>  
>  #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
>  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
> @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
>  	};
>  };
>  
> +struct mptcp_subflow_info {
> +	__u32				id;
> +	struct mptcp_subflow_addrs	addrs;
> +};
> +
> +/* struct subflow_info is not supposed nor allowed to grow in
> + * future versions.
> + * If need will arise, a new socket option should be added.
> + */
> +struct mptcp_subflow_full_info {
> +	struct mptcp_subflow_info	subflow_info;
> +	struct tcp_info			tcp_info;
> +};

I dislike this constraint.

Why not do something like this:

struct mptcp_subflow_full_info {
	__u32		size_subflow_full_info;         /* size of this structure in userspace */
	__u32           num_subflows_user;              /* max subflows that userspace is interested in */
	__u32           num_subflows_kern;              /* must be 0, set by kernel (real subflow count) */
	__u32		num_subflows_copied;		/* must be 0, set by kernel (number of subflow infos copied back)
        __u32           size_sfinfo_kernel;		/* must be 0, set by kernel */
        __u32           size_sfinfo_user;
        __u32           size_tcpinfo_kernel;            /* must be 0, set by kernel */
        __u32           size_tcpinfo_user;
	__aligned_u64	subflow_info_addr;
	__aligned_u64	tcp_info_addr;
};

userspace does:

x = calloc(sizeof(struct mptcp_subflow_info), 42);
y = calloc(sizeof(struct tcp_info), 42);

struct mptcp_subflow_full_info {
	.size_subflow_full_info = sizeof(struct mptcp_subflow_full_info),
	.num_subflows_user = 42,
	.size_sfinfo_user = sizeof(struct mptcp_subflow_info),
	.size_tcpinfo_user = sizeof(struct mptcp_subflow_info),
	.subflow_info_addr = (u64)x,
	.tcp_info_addr = (u64)y,
};

kernel does:
1. put_user() the real sizes uses by the kernel
2. put_user() the real subflow count
3. copy subflow_info_addr and tcp_info_addr addresses
4. treat as userspace pointers

for each subflow, copy tcpinfo and subflow info to the
two arrays provided by userspace.

Kernel truncates copied data via size_sfinfo_user/size_tcpinfo_user so
that new kernel won't populate fields that don't exist in userspace.

Kernel stops copying after 'num_subflows_user' or 'num_subflows_kern',
whatever comes first and updates num_subflows_copied to the real copied
value.

This allows userspace to discover when kernel had more subflows
but could not place the data due to lack of space in the
userspace-provided arrays.

This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V4
etc. in the future.

What do you think?
