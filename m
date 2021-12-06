Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063DB2C80
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 22:35:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224293709"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="224293709"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:35:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="502312604"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.251.18.10])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:35:34 -0800
Date: Mon, 6 Dec 2021 14:35:34 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 4/6] mptcp: Make kernel path manager check
 for userspace-managed sockets
In-Reply-To: <4e28df023bad9e9e844dbac86f38038c16acbe06.camel@redhat.com>
Message-ID: <25144778-99b5-743e-7084-60534bd1fee@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>  <20211202005216.154787-5-mathew.j.martineau@linux.intel.com> <4e28df023bad9e9e844dbac86f38038c16acbe06.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Paolo Abeni wrote:

> On Wed, 2021-12-01 at 16:52 -0800, Mat Martineau wrote:
>> Userspace-managed sockets should not have their subflows or
>> advertisements changed by the kernel path manager.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> ---
>>  net/mptcp/pm_netlink.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index a74eb0444cd2..2cd491229d23 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1122,7 +1122,8 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
>>  	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
>>  		struct sock *sk = (struct sock *)msk;
>>
>> -		if (!READ_ONCE(msk->fully_established))
>> +		if (!READ_ONCE(msk->fully_established) ||
>> +		    (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL))
>
> I'm ok with merging the series as is, but if you are considering
> another version, what about replacing a 'READ_ONCE(msk->pm.pm_type) !=
> MPTCP_PM_TYPE_KERNEL' with an helper, e.g. something alike
> mptcp_pm_is_user_space(sk) ?
>

I'll send a v3 - agree that a helper function would clarify this.

--
Mat Martineau
Intel
