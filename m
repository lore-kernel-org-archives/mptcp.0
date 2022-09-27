Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D54C64
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664308748; x=1695844748;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=75x4CZZbJ76Gnj7NODJiPax5+PQzcpNMnIH+QXcZGfU=;
  b=cakr04lptQOkYIX0owlbhkoIsmnJ1Im//0bOMKsPM3JMTG/+y9sHv6o7
   7vFNIMcdyexJcTV9uy8+WYv0qprkMzeXkqGostfXuHcpSPsC2rTnUBc3s
   NLib407FoQRvNmA4h0o+GH/rzMzSJv1aBGchpyQBqe0t6NFnYyPNHSxhn
   uXgh3Bp7RR7+1uAzTX0bNJyNO17kTxzZbVOeeSqJYjvACZSRsLa8UI0dl
   fcMFYn0xiMQLfIP66MsQzSCG/VqLTE+1xyKABccBE1U9csHT+BMmeuhKK
   lpVVQV/LMUXLNjLHKxtrPwyNvw967kpQakLSFMkQ/QFnx/X8LxSJ5Fwz6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284546290"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="284546290"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:59:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616950870"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="616950870"
Received: from smahinde-mobl1.gar.corp.intel.com ([10.255.229.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:59:07 -0700
Date: Tue, 27 Sep 2022 12:59:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] mptcp: sockopt: make 'tcp_fastopen_connect'
 generic
In-Reply-To: <f348f260d1c2c988fd96e5079b18e9468ff8cb3b.camel@redhat.com>
Message-ID: <1eb00480-b89d-914e-bbd9-11c185448ef0@linux.intel.com>
References: <20220927150306.1552795-1-matthieu.baerts@tessares.net>  <20220927150306.1552795-2-matthieu.baerts@tessares.net> <f348f260d1c2c988fd96e5079b18e9468ff8cb3b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 27 Sep 2022, Paolo Abeni wrote:

> On Tue, 2022-09-27 at 17:03 +0200, Matthieu Baerts wrote:
>> There are other socket options that need to act only on the first
>> subflow, e.g. all TCP_FASTOPEN* socket options.
>>
>> This is similar to the getsockopt version.
>>
>> In the next commit, this new mptcp_setsockopt_first_sf_only() helper is
>> used by other another option.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  net/mptcp/sockopt.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index c7cb68c725b2..8d3b09d75c3a 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -769,17 +769,17 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
>>  	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
>>  }
>>
>> -static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *msk, sockptr_t optval,
>> -						     unsigned int optlen)
>> +static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
>> +					  sockptr_t optval, unsigned int optlen)
>>  {
>>  	struct socket *sock;
>>
>> -	/* Limit to first subflow */
>> +	/* Limit to first subflow, before the connection establishment */
>>  	sock = __mptcp_nmpc_socket(msk);
>>  	if (!sock)
>>  		return -EINVAL;
>
> Crazy idea: if we add another int argument e.g. 'default_reval', we can
> use this helper even for mptcp_setsockopt_sol_tcp_defer()
> (default_retval == 0, while here default_reval == -EINVAL) ;)
>
> Not a big deal, I'm fine even this way.

Or do something similar without adding the extra int argument: just have 
the call site for TCP_DEFER_ACCEPT in mptcp_setsockopt_sol_tcp() ignore 
the return value of mptcp_setsockopt_first_sf_only(), and remove 
mptcp_setsockopt_sol_tcp_defer()?

That would be a third patch to use the new helper, so if you (Matthieu) 
want to make that change I think these two patches are good as-is:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
