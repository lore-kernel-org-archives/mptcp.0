Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F242C80
	for <mptcp@lists.linux.dev>; Fri,  8 Oct 2021 21:14:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="225364894"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="225364894"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 14:14:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="485130916"
Received: from heechulk-mobl1.amr.corp.intel.com ([10.212.210.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 14:14:09 -0700
Date: Fri, 8 Oct 2021 14:14:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, kishen.maloor@intel.com
Subject: Re: [RFC PATCH 4/6] mptcp: Add a per-namespace sysctl to set the
 default path manager type
In-Reply-To: <fe75d37883a8805484bace4498f754d8c63b64ed.camel@redhat.com>
Message-ID: <e5e6d05b-de97-98be-3db7-7aa874fc23f@linux.intel.com>
References: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>  <20211006235953.212243-5-mathew.j.martineau@linux.intel.com> <fe75d37883a8805484bace4498f754d8c63b64ed.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 7 Oct 2021, Paolo Abeni wrote:

> On Wed, 2021-10-06 at 16:59 -0700, Mat Martineau wrote:
>> The new net.mptcp.userspace_pm_default sysctl determines which path
>> manager will be used by each newly-created MPTCP socket.
>>
>> Alternative: set the per-namespace default using the netlink API instead.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> ---
>>  Documentation/networking/mptcp-sysctl.rst | 17 +++++++++++++++++
>>  net/mptcp/ctrl.c                          | 16 ++++++++++++++++
>>  net/mptcp/pm.c                            |  4 +++-
>>  net/mptcp/protocol.h                      |  1 +
>>  4 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
>> index b0d4da71e68e..9f5d7bad9fba 100644
>> --- a/Documentation/networking/mptcp-sysctl.rst
>> +++ b/Documentation/networking/mptcp-sysctl.rst
>> @@ -46,6 +46,23 @@ allow_join_initial_addr_port - BOOLEAN
>>
>>  	Default: 1
>>
>> +userspace_pm_default - BOOLEAN
>> +
>> +	Set the default path manager type to use for each new MPTCP
>> +	socket.  The in-kernel path manager is used if this is set to 0,
>> +	and a userspace path manager is used if the value is set
>> +	to 1. In-kernel path management will control subflow connections
>> +	and address advertisements according to per-namespace values
>> +	configured over the MPTCP netlink API. Userspace path management
>> +	puts per-MPTCP-connection subflow connection decisions and
>> +	address advertisements under control of a privileged userspace
>> +	program, at the cost of more netlink traffic to propagate all of
>> +	the related events and commands.
>> +
>> +	This is a per-namespace sysctl.
>> +
>> +	Default: 0
>> +
>>  stale_loss_cnt - INTEGER
>>  	The number of MPTCP-level retransmission intervals with no traffic and
>>  	pending outstanding data on a given subflow required to declare it stale.
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index 8b235468c88f..e7aedb90e35a 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -26,6 +26,7 @@ struct mptcp_pernet {
>>  	u8 mptcp_enabled;
>>  	u8 checksum_enabled;
>>  	u8 allow_join_initial_addr_port;
>> +	u8 userspace_pm_default;
>>  };
>>
>>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
>> @@ -58,6 +59,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
>>  	return mptcp_get_pernet(net)->stale_loss_cnt;
>>  }
>>
>> +int mptcp_userspace_pm_default(const struct net *net)
>> +{
>> +	return mptcp_get_pernet(net)->userspace_pm_default;
>> +}
>> +
>>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>  {
>>  	pernet->mptcp_enabled = 1;
>> @@ -65,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>  	pernet->checksum_enabled = 0;
>>  	pernet->allow_join_initial_addr_port = 1;
>>  	pernet->stale_loss_cnt = 4;
>> +	pernet->userspace_pm_default = 0;
>>  }
>>
>>  #ifdef CONFIG_SYSCTL
>> @@ -108,6 +115,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
>>  		.mode = 0644,
>>  		.proc_handler = proc_douintvec_minmax,
>>  	},
>> +	{
>> +		.procname = "userspace_pm_default",
>> +		.maxlen = sizeof(u8),
>> +		.mode = 0644,
>> +		.proc_handler = proc_dou8vec_minmax,
>> +		.extra1       = SYSCTL_ZERO,
>> +		.extra2       = SYSCTL_ONE
>> +	},
>>  	{}
>>  };
>>
>> @@ -128,6 +143,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>>  	table[2].data = &pernet->checksum_enabled;
>>  	table[3].data = &pernet->allow_join_initial_addr_port;
>>  	table[4].data = &pernet->stale_loss_cnt;
>> +	table[5].data = &pernet->userspace_pm_default;
>>
>>  	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>>  	if (!hdr)
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 3fa3c0faed48..e97a22fcc0fa 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -367,6 +367,8 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
>>
>>  void mptcp_pm_data_init(struct mptcp_sock *msk)
>>  {
>> +	struct sock *sk = (struct sock *)msk;
>> +
>>  	msk->pm.add_addr_signaled = 0;
>>  	msk->pm.add_addr_accepted = 0;
>>  	msk->pm.local_addr_used = 0;
>> @@ -378,7 +380,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>>  	WRITE_ONCE(msk->pm.accept_addr, false);
>>  	WRITE_ONCE(msk->pm.accept_subflow, false);
>>  	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
>> -	WRITE_ONCE(msk->pm.userspace, false);
>> +	WRITE_ONCE(msk->pm.userspace, mptcp_userspace_pm_default(sock_net(sk)));
>
> I'm wondering if we could set work_pending as well, and avoid some
> multiple conditionals in patch 2/6

Since work_pending is only set to 'true' in mptcp_pm_nl_data_init() right 
now, that would work. work_pending (and a couple of other mptcp_pm_data 
members) are initialized twice right now, so I can clean that up and make 
the relationship with pm->userspace more obvious.

>
> Other than that LGTM!
>
> It would be nice to have some simple self-test, enabling user-space pm
> and observing no action is taken on add_addr, connection established,
> etc.
>

I will add tests for the next version of this series.

> I think the procfs switch for user-space pm fits more easily self-
> tests.


Thanks,

--
Mat Martineau
Intel
