Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73BC2FD
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 10:04:10 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q1lLj-0002l8-LK; Wed, 24 May 2023 12:04:07 +0200
Date: Wed, 24 May 2023 12:04:07 +0200
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Message-ID: <20230524100407.GE17561@breakpoint.cc>
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> On 23/05/2023 20:25, Florian Westphal wrote:
> > 	__u32		size_subflow_full_info;         /* size of this structure in userspace */
> 
> Why do we need this field? Can we not use the option length (int __user
> *optlen) provided by the userspace?

Right, yes, we can (and should) use __user *optlen instead
of this explicit member.

> >         __u32           size_sfinfo_kernel;		/* must be 0, set by kernel */
> >         __u32           size_sfinfo_user;
> >         __u32           size_tcpinfo_kernel;            /* must be 0, set by kernel */
> >         __u32           size_tcpinfo_user;
> 
> Do we need to have the kernel and user size in different fields?
> Is it not enough have:
> 
>   num_subflows;          /* will be set by the kernel */
>   num_subflows_copied;   /* max for the user, kernel put what it did */
>   size_sfinfo;           /* user set it, kernel put what it used: min */
>   size_tcpinfo;          /* same */

Yes, that would work too: kernel updates value to what its using.

I have no preference.  I used extra fields to better document
that this is filled in by the kernel.

I'll let Paolo make the call.

> If we add mptcp_info structure as mentioned by Paolo, we are getting
> very close the the getsockopt(MPTCP_INFO) from the fork kernel, see the
> section "Get detailed information of your subflows":
> 
> https://multipath-tcp.org/pmwiki.php/Users/ConfigureMPTCP
> 
> And the kernel header:
> 
> https://github.com/multipath-tcp/mptcp/blob/mptcp_trunk/include/uapi/linux/tcp.h#L321-L366

Right, this is similar.

> If we want to be even more future prove, why not having something more
> flexible where the userspace puts flags of what it wants and then there
> is a kind of TLV structure? Maybe it would be too complex to read/write?
> 
> 
>   struct mptcp_tlv_info {
>       __u32 type;
>       __u32 length;
>       __aligned_u64 value;
>   };
> 
>   struct mptcp_full_info {
>       __u32 flags;
>       __u32 num_subflows;
>       __u32 num_subflows_copied;
>       struct mptcp_tlv_info[];   /* number has to be linked to flags */
>   };

Hmm, I think it would be better to reuse an existing scheme
and e.g. return a netlink attribute blob in such a case,
this would also allow sharing with the diag interface/functions.
