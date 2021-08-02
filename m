Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870C72
	for <mptcp@lists.linux.dev>; Mon,  2 Aug 2021 22:23:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200740983"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="200740983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 15:23:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="520716377"
Received: from necannon-mobl.amr.corp.intel.com ([10.212.133.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 15:23:27 -0700
Date: Mon, 2 Aug 2021 15:23:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: Revised mptcp_info sockopt and selftests
In-Reply-To: <20210802145127.GK15121@breakpoint.cc>
Message-ID: <88709b4e-a16-57d-1097-ec61fb3a2a3@linux.intel.com>
References: <YQKV6GJe/RfkZh09@strlen.de> <aa6fcfda-9b53-c258-e03c-6ce731697ff6@linux.intel.com> <20210802145127.GK15121@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 2 Aug 2021, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>>> Here is a minimal usage example to illustrate the feature:
>>>
>>> UAPI structures:
>>> struct mptcp_info_opt_ptr {
>>> 	__aligned_u64	address;			/* userspace address */
>>> 	__u32		nmemb_user;			/* number of elements in address[] */
>>> 	__u32		size_user;			/* size of one element in address[] */
>>> 	__u32		nmemb_kernel;			/* nmemb count kernel wanted to store */
>>> 	__u32		size_kernel;			/* structure size in kernel */
>>> };
>>>
>>
>> Will embedding multiple userspace addresses in this way be a problem for
>> security frameworks, in-kernel sockets, BPF_CGROUP_RUN_PROG_SETSOCKOPT, etc?
>
> Yes :-/
>
> I was not aware of BPF_CGROUP_RUN_PROG_SETSOCKOPT, thanks for pointing
> this out (in this case, BPF_...GETSOCKOPT, but problem is similar).
>
> So, this approach is dead/cannot be done.
>
> [..]
>
>> With offsets, the above code could look something like:
>>
>> struct my_info_opt {
>> 	struct mptcp_info_opt m; /* Has to be first */
>> 	struct mptcp_info minfo;
>> 	struct tcp_info tinfo[16];
>> 	struct sockaddr_storage locals[16];
>> 	struct sockaddr_storage remotes[16];
>> } my_info;
>>
>> memset(&my_info, 0, sizeof(my_info));
>> my_info.num_ptrs = 4;
>>
>> my_info.m.mptcp_info.offset = offsetof(my_info.minfo);
>> my_info.m.mptcp_info.size_user = sizeof(my_info.minfo);
>>
>> my_info.m.tcp_info.offset = offsetof(my_info.tinfo);
>> /* size_user / nmemb_user same as above */
>>
>> /* and so on for locals and remotes */
>
> This takes away all the flexibility. Userspace would have to
> define such struct with locals[256], remotes[256], and so on, i.e.
> specify the largest possible value that it might need.

I agree, I did not account for dynamic allocation here (I was too narrowly 
focused on the example code I was modifying, which also used 
statically-sized arrays). There's some flexibility in the sense that the 
structure does not have to include all the possible members (for example, 
could define a struct my_info_opt with tcp_info entries but no sockaddrs), 
but handling the different array sizes seems more important.

> Or, create some macro magic that creates X 'struct my_info_opt_X'
> versions; one for each value of X (the size of the sub-arrays).
>

Prefer to avoid the macro magic.

>> I think it's a very flexible approach, my main suggestion is the offset vs.
>> address thing above.
>
> See above, I think its cumbersome to use, since you can no longer do
> something like
>
> struct mptcp_info_opt x = {};
>
> /* get the required sizes */
> getsockopt(... &x);
>
> x.locals.address = calloc(sizeof(struct sockaddr_storage), x.locals.nmemb_kernel);
> ...
>
> /* really get the data */
> getsockopt(... &x);

Yeah, that's a useful pattern.

>
> What about splitting the functionality in distinct getsockopt
> operations?
>
> struct mptcp_info_opt {
>    __u32           nmemb_user;             /* number of elements stored */
>    __u32           size_user;              /* size of one element stored */
>    __u32           nmemb_kernel;           /* number of elements kernel wanted to store */
>    __u32           size_kernel;            /* structure size in kernel */
>    __aligned_u64   data[1];		    /* actual data */
> };
>
> getsockopt(..., MPTCP_GETPEERNAMES, &opt, &optlen);
> ...
> getsockopt(..., MPTCP_GETSOCKNAMES, &opt, &optlen);
>
> .. but subflows can change between those two :(

Agreed, that's a problem :(

>
> That brings us back to the compound structure that mptcp.org kernel has to
> wrap both local and remote addresses in a single struct.
>
> The more I think about it, the less ideas i have on how to make
> any of this work.
>
> Sctp has connectx and bindx pseudo-syscalls (its really just setsockopts),
> those all expect 'struct sockaddr *', with some extra code in the kernel
> to guess the correct size of each by looking at ->sa_family.
>
> So, with all of that in mind:
> MPTCP_INFO -> gets the mptcp info diag data, with nothing else.  Single struct
> that is exported to userspace (already is).
>
> MPTCP_TCP_INFO -> gets array of 'struct tcp_info'.
> MPTCP_SUBFLOWS -> gets array of 'struct mptcp_subflow', which has both local+remote sockaddrs.
>
> To make both of those work without a need to guess the individual element size,
> it would make sense to prepend struct mptcp_info_opt, i.e.
>
> opt = malloc(sizeof(struct mptcp_info_opt) + sizeof(struct tcp_info) * 16));
>

It seems like this would work (for current archs?), since mptcp_info_opt's 
size is a multiple of 64. Trying to look at that with my "alignment 
paranoia" glasses on.

> opt.nmemb_user = 16;
> opt.size_user = sizeof(struct tcp_info);
>
> getsockopt(..., MPTCP_TCP_INFO, &opt, &optlen);
>
> This would still allow to fetch the rquired size, resp. retry if nmemb_kernel > nmemb_user
> after the call returns.
>

Seems like a workable approach, I'm fine with this direction.

>> Would it be frowned upon to put some inline helper functions or macros in
>> the mptcp.h UAPI to reduce the boilerplate code to populate the
>> mptcp_info_opt_ptrs? It looks like some UAPI headers have that, but not
>> many.
>
> No idea.  Personally I think the kernel should only
> expose enums/defines and, if needed, structure layouts and nothing else.
>
> That said, we could certainly add helpers (e.g. cmsg-alike or whatever)
> and expose that with a libmptcp or some such.

Yes, a library does seem like a better home for such helpers.


Thanks,

--
Mat Martineau
Intel
