Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BB70
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 19:07:14 +0000 (UTC)
IronPort-SDR: pI0GKjesQoSdUCs3lGIBiiWe96UOvbOGPqlKZp8rDc6P7b84dXxffNujKRDQEIvFFXUMR4gBOG
 RXae/lqsp0TA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="198843060"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="198843060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:07:13 -0700
IronPort-SDR: Bapl2Nof9+BaCr6geBUxuofnRTJ/kOmP1FZhCNqArqBHXUHJDFe0zxxIlEMY5eTI7QvrWa1Frj
 1t8AwRMo8erQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="542089443"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:07:13 -0700
Date: Tue, 18 May 2021 12:07:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
In-Reply-To: <ccc1707df9391e1552ac67f6b358e879ab3aed0a.camel@redhat.com>
Message-ID: <dd9d31d-134-8b8b-7f40-f34e4be75956@linux.intel.com>
References: <cover.1621002341.git.geliangtang@gmail.com>  <10c0783f0b81ab279dbbf202033295e7891c18d6.camel@redhat.com>  <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com> <ccc1707df9391e1552ac67f6b358e879ab3aed0a.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 18 May 2021, Paolo Abeni wrote:

> On Mon, 2021-05-17 at 12:59 -0700, Mat Martineau wrote:
>> On Mon, 17 May 2021, Paolo Abeni wrote:
>>
>>> Hello,
>>>
>>> On Fri, 2021-05-14 at 22:32 +0800, Geliang Tang wrote:
>>>> v6:
>>>>  - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
>>>>  - update mptcp_pm_free_add_list
>>>>  - update code in mptcp_pm_nl_add_addr_received
>>>>  - tag: export/20210514T055902
>>>>
>>>> v5:
>>>>  - add a new patch "mptcp: add add_list in mptcp_pm_data"
>>>>  - fix !CONFIG_SYSCTL case
>>>>  - tag: export/20210507T174457
>>>>
>>>> v4:
>>>>  - rename mptcp_is_allow_join_id0 to mptcp_allow_join_id0
>>>>  - rename deny_join_id0 in mptcp_pm_data to remote_deny_join_id0
>>>>  - add comments for self test cases
>>>>  - apply: export/20210504T064955 +
>>>>           "data checksum support" +
>>>>           "data checksum support cleanups"
>>>>
>>>> v3:
>>>>  - use 'u8 allow_join_initial_addr_port'
>>>>  - drop the spinlock in patch 3
>>>>
>>>> v2:
>>>>  - rename join_denied to allow_join_id0 in mptcp_out_options
>>>>  - rename join_denied to deny_join_id0 in mptcp_options_received
>>>>  - add a new function mptcp_pm_deny_join_id0_received
>>>>  - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
>>>>  - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
>>>> instead of in mptcp_syn_options.
>>>>
>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183
>>>>
>>>> Geliang Tang (6):
>>>>   mptcp: add sysctl allow_join_initial_addr_port
>>>>   mptcp: add allow_join_id0 in mptcp_out_options
>>>>   mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
>>>>   mptcp: add add_list in mptcp_pm_data
>>>>   mptcp: add deny_join_id0 in mptcp_options_received
>>>>   selftests: mptcp: add deny_join_id0 testcases
>>>>
>>>>  Documentation/networking/mptcp-sysctl.rst     |  13 ++
>>>>  include/net/mptcp.h                           |   3 +-
>>>>  net/mptcp/ctrl.c                              |  16 ++
>>>>  net/mptcp/options.c                           |  14 +-
>>>>  net/mptcp/pm.c                                |   2 +
>>>>  net/mptcp/pm_netlink.c                        | 151 ++++++++++++++----
>>>>  net/mptcp/protocol.c                          |   1 +
>>>>  net/mptcp/protocol.h                          |  21 ++-
>>>>  net/mptcp/subflow.c                           |   3 +
>>>>  .../testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++-
>>>>  10 files changed, 238 insertions(+), 42 deletions(-)
>>>>
>>> I'm very sorry to give feedback this late, but I was unable to review
>>> this before.
>>>
>>> I have some very generic/broad questions:
>>> 1) shuold 'allow_join_initial_addr_port' be by default 0 for clients?
>>> If I read correctly, will be 1 after this patch.
>>
>> It should default to 1 because that is what keeps the current behavior.
>>
>> The logic is flipped from the 'C' bit: C=1 in the header means "do not
>> connect to initial subflow addr/port", but allow_join_initial_addr_port=1
>> means "*do* connect to the initial subflow addr/port".
>>
>>> 2) is the additional add_addr accounting required? I mean storing the
>>> received addrs in the msk pm add_list (patch 4/6). Can we instead
>>> simply enforce !allow_join_initial_addr_port looking up the relevant
>>> address into the existing subflows? (or caching first subflow dst addr
>>> and port in some new msk fields, whatever is simpler)
>>>
>>> if !allow_join_initial_addr_port && <exists subflow with target
>>> ip/port> && <such subflow is mp_capable/>
>>> 	<do not create new subflow>
>>>
>>
>> Caching the first subflow dst addr/port is enough to prevent sending a
>> MP_JOIN to that address, but I don't think it does quite enough.
>>
>> Consider:
>>
>> 1. Initial connection is made between Peer A and Peer B with C=1 (both
>> directions).
>>
>> 2. Peer A sends ADD_ADDR. Peer B currently has limits set that don't allow
>> outgoing MP_JOINs.
>
> Uhmmm.... Looking at the RFC, ADD_ADDR <MPC addr/MPC port> is a gray
> area to me. My understanding is that with 'C' bit == 0 the peer is
> allowed to create additional subflow towardst the initial subflow dst
> addr/port, and such subflows are not allowed with C==1.

That's correct. My example was unclear: my intent was to say Peer A sent 
an ADD_ADDR for a new/different address that it does want Peer B to 
connect to.

>
> But it looks like that ADD_ADDR should override that request. At the
> very least an ADD_ADDR for the initial addr/port when the MPC handshake
> completed with C==1 is weird.

This is a corner case that I hadn't considered and I agree that it's 
weird. Given the unconditional "MUST NOT" wording of the C bit 
description, I would not expect the ADD_ADDR to override. If a peer 
sends a weird ADD_ADDR they are asking for weirdness I guess, but it's ok 
to ignore them :)

> 
>> I've expected that we would add better tracking of ADD_ADDRs -
>> remember
>> that ADD_ADDR is an advertisement, not a request to "please connect
>> to
>> this address right now". Userspace path managers will certainly have
>> more
>> persistance of the peer's advertised addresses. Any more
>> comprehensive
>> in-kernel PM will also need the add_list. The main concern is that
>> the
>> list doesn't consume excessive memory, and the add_list is not
>> expanded
>> when pm->accept_addr is false.
>
> The in-kernel path manager is want to be as simple as possible. As soon
> as we start allocating memory on peer req it's very easy to be prone to
> DoS. Memory accounting and limits could save us or at least mitigate
> the problem, but they will add more complexity.

My assumption was that high-connection-count servers would probably have 
their limits set in a way that ADD_ADDRs would not be accepted anyway. 
This is the use case where clients may be behind a NAT and the server is 
accepting MP_JOINs from the client (but the server is never sending 
MP_JOINs), and the server is possibly sending ADD_ADDRs to the client. The 
configurable limit is already there from the existing in-kernel PM code.

I do agree with "as simple as possible", but the RFC requirements are 
constraining that. Even though the C bit is ignored in Linux 
implementations so far, I don't think it should stay that way. The current 
code always tries to connect to the initial subflow, so we need to do 
*something* different to remember an alternate peer address. There are 
other options (like remembering only the most recent ADD_ADDR), but given 
the configurable limits we have it doesn't seem that different 
memory-wise. What's important is implementing this RFC functionality well, 
so it's really helpful to explore the alternatives here - and your 
understanding of the resource issues and DoS tradeoffs is very useful.


>
>>> 3) If I read correctly the series enforce the peer who could create the
>>> new subflow to respect the 'allow_join_initial_addr_port' field, but
>>> does not implement the corrsponding check on the other end. e.g. if a
>>> server sets 'allow_join_initial_addr_port' to 0 and a client tries to
>>> create additional subflows, the server will not forbit that. I
>>> think/fear the missing complexity here is quite significant.
>>>
>>> I think it would be nice avoid adding additional complexity for the 'C'
>>> bit - currently even mptcp.org support it.
>>>
>>
>> Assuming you intended to say "currently even mptcp.org does not support
>> it."
>>
>> You're right: the incoming join address check is missing. But I'm not sure
>> the complexity is so bad, the PM can already reject joins. I think we
>> could pass enough information to mptcp_pm_allow_new_subflow() to implement
>> this check. Am I oversimplifying - is it harder to get at the dest
>> addr/port? Or is it something else?
>
> What abot that setting C==0 on client sockets? does that imply that the
> client will accept incoming connection on the src port/addr?

C==0 says it's valid to send MP_JOINs to the client on the src port/addr. 
It's up to the client's PM to accept or reject them.

>
> For the server case, even a list-based filter would add addtional
> overhead and complexity for all setup.
>

It's not free. The RFC wording is a little fuzzy here, since it says the 
sender of C==1 "will not accept" incoming connections on that subflow. 
There's no "MUST/MUST NOT", so maybe it's possible to get by without. It 
would be good to have some input from RFC authors on this :)


> AFAICS the RFC mentions this option as on optimization to avoid
> connection attempts failing when something outside the endpoint
> themself would prevent them from being succeful.
>
> But this "optimization" has a cost in term of memory, complexity and
> additional overhead for each connection/subflow. It will work only if
> the administrator will configure the C bit properly. And that could be
> non trivial, when load balancing and NAT are outside the mptcp host.
>
> Just does not seam worthy to me, I really think we should start with
> the bare minumum to respect the RFC itself, avoiding as much complexity
> as possible:
> - setting C always to 0 on server
> - when the peer send C==1, cache the MPC addr/port, and do not attempt
> other connection to such endpoint.
>
> I'm not even sure the latter step is strictly necessary.

For the former, it is certainly simpler to always send C==0, but sending 
C==1 from a high-connection-count server behind a load balancer is the 
primary use case.

I think the "MUST NOT" wording of the RFC does require the latter step 
(server or client), and that implies a minimally functional in-kernel PM 
would need to track some other address to connect to.


> Another option
> would be passing the info to the user-space path manager - if available
> - and let it deal with all the complexity. If no user-space path
> manager is available just be dumb and simple ;)

The C bit does need to propagate to the userspace path manager. Since the 
userspace PM is mostly a client-side thing, it is situated well to handle 
the complexity of tracking incoming ADD_ADDRs and sending/not-sending 
MP_JOINs that comply with the C bit from the server.

However, an important complexity question in this email thread is about 
the server side (without userspace PM) that may or may not need to reject 
incoming MP_JOINs that it said it won't accept (as I mentioned above, the 
RFC is fuzzy here).



Is any of that more convincing about what the minimal kernel PM needs? Do 
you think some RFC author input on the rejection of MP_JOINs by the C==1 
sender would be useful?


Thanks for the questions!


>
>>> Perhaps we could keep 'allow_join_initial_addr_port' constant (always 0
>>> for client, always 0 for server) - avoding the additional complexity of
>>> point 3) above.
>>>
>>
>> Given the answer to #1 is this still what you'd propose?
>> allow_join_initial_addr_port=1 is unchanged behavior from the kernel
>> today, and is the simpler case.

--
Mat Martineau
Intel
