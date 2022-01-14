Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2077173
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642198163; x=1673734163;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eRV2cnRtDTEo6uGcTirbg5wq6dM9PGg1rqEaNCY3ptU=;
  b=M3qsF+sYsNk/RccBeiD3sQ90HVl734JpE8lF1wpMROuykQOQ4/pXJTTP
   Pdo8HPMIaD8tesEo+XZxfu6j8xK+vorU5Y5e8eZ+rHIpBA2u6RWECu4SA
   nFYs7N+vQOI0QsQNgo8RcvycI1of3rusMy3vOjYT3NmTd2RpfsnkuQSmA
   rhO1ogx7N1M2PQF3feDZGWLbdYDntTfJjr05XdWuDa8OaCjlFCkfLlIWp
   CMSLBYOJA3NkrPHxObYq4tcgNxP4MAEB9HvzbGwS7JgdVljvNRikKIw4Q
   7iJFVLLHBCspUPtGshjPZ81le6gqsXNI+OZGwV/mO6RSZCq8q22VEkW8P
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305069121"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="305069121"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:09:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="559628308"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:09:22 -0800
Date: Fri, 14 Jan 2022 14:09:21 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 07/21] mptcp: netlink: process IPv6 addrs
 in creating listening sockets
In-Reply-To: <489b1e836ec09b23cd9318f7fa8a404dec50e72b.camel@redhat.com>
Message-ID: <911f2260-4694-cd5a-61d8-f094f0ab672b@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>  <20220112221523.1829397-8-kishen.maloor@intel.com> <489b1e836ec09b23cd9318f7fa8a404dec50e72b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Jan 2022, Paolo Abeni wrote:

> Hello,
>
> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>> This change updates mptcp_pm_nl_create_listen_socket() to create
>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>>

This tag -

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")

would help with backporting to stable.

>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/pm_netlink.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 4c1895dbc2a5..779ec9d375f0 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -986,6 +986,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>  					    struct mptcp_pm_addr_entry *entry,
>>  					    struct socket **lsk)
>>  {
>> +	int addrlen = sizeof(struct sockaddr_in);
>>  	struct sockaddr_storage addr;
>>  	struct mptcp_sock *msk;
>>  	struct socket *ssock;
>> @@ -1010,8 +1011,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>  	}
>>
>>  	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
>> -	err = kernel_bind(ssock, (struct sockaddr *)&addr,
>> -			  sizeof(struct sockaddr_in));
>> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> +	if (entry->addr.family == AF_INET6)
>> +		addrlen = sizeof(struct sockaddr_in6);
>> +#endif
>> +	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
>>  	if (err) {
>>  		pr_warn("kernel_bind error, err=%d", err);
>>  		goto out;
>
> This looks a bugfix for -net to me?
>
> Possibly worthy additional an additional mp_join self-test for the ipv6
> case.
>

I agree, this would be good for -net. Kishen can you add the suggested 
selftest too and repost separately for mptcp-net?

--
Mat Martineau
Intel
