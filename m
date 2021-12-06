Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BC29CA
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 22:42:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237233008"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237233008"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:42:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="515178870"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.251.18.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:42:03 -0800
Date: Mon, 6 Dec 2021 14:42:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v2 5/6] mptcp: Add a per-namespace sysctl to
 set the default path manager type
In-Reply-To: <2190ad1b150179fb1b311aa8c89344e440d7befa.camel@redhat.com>
Message-ID: <988f598-13ba-5c5f-c77b-4db3f3b6c08@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>  <20211202005216.154787-6-mathew.j.martineau@linux.intel.com>  <CA+WQbwuwfq0E-JQj_7cDf0R+NuMJ44uq+_6VYVceAfrwjYA8BQ@mail.gmail.com>
 <2190ad1b150179fb1b311aa8c89344e440d7befa.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463794943-1804108985-1638830242=:4883"
Content-ID: <bdfd834d-568c-6010-e8bf-d863d8b56c3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794943-1804108985-1638830242=:4883
Content-Type: text/plain; CHARSET=ISO-2022-JP; format=flowed
Content-ID: <4b5edea7-aa97-289c-327-fcac9ddf586@linux.intel.com>

On Mon, 6 Dec 2021, Paolo Abeni wrote:

> On Mon, 2021-12-06 at 15:56 +0800, Geliang Tang wrote:
>> Hi Mat,
>>
>> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年12月2日周四 08:52写道：
>>>
>>> The new net.mptcp.pm_type sysctl determines which path manager will be
>>> used by each newly-created MPTCP socket.
>>>
>>> v2: Handle builds without CONFIG_SYSCTL
>>>
>>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>> ---
>>>  Documentation/networking/mptcp-sysctl.rst | 18 ++++++++++++++++++
>>>  net/mptcp/ctrl.c                          | 21 +++++++++++++++++++++
>>>  net/mptcp/pm.c                            | 13 +++++++++----
>>>  net/mptcp/protocol.h                      |  1 +
>>>  4 files changed, 49 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
>>> index b0d4da71e68e..e263dfcc4b40 100644
>>> --- a/Documentation/networking/mptcp-sysctl.rst
>>> +++ b/Documentation/networking/mptcp-sysctl.rst
>>> @@ -46,6 +46,24 @@ allow_join_initial_addr_port - BOOLEAN
>>>
>>>         Default: 1
>>>
>>> +pm_type - INTEGER
>>> +
>>> +       Set the default path manager type to use for each new MPTCP
>>> +       socket. In-kernel path management will control subflow
>>> +       connections and address advertisements according to
>>> +       per-namespace values configured over the MPTCP netlink
>>> +       API. Userspace path management puts per-MPTCP-connection subflow
>>> +       connection decisions and address advertisements under control of
>>> +       a privileged userspace program, at the cost of more netlink
>>> +       traffic to propagate all of the related events and commands.
>>> +
>>> +       This is a per-namespace sysctl.
>>> +
>>> +       * 0 - In-kernel path manager
>>> +       * 1 - Userspace path manager
>>> +
>>> +       Default: 0
>>> +
>>>  stale_loss_cnt - INTEGER
>>>         The number of MPTCP-level retransmission intervals with no traffic and
>>>         pending outstanding data on a given subflow required to declare it stale.
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> index 8b235468c88f..ae20b7d92e28 100644
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>> @@ -16,6 +16,11 @@
>>>  #define MPTCP_SYSCTL_PATH "net/mptcp"
>>>
>>>  static int mptcp_pernet_id;
>>> +
>>> +#ifdef CONFIG_SYSCTL
>>> +static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
>>> +#endif
>>> +
>>>  struct mptcp_pernet {
>>>  #ifdef CONFIG_SYSCTL
>>>         struct ctl_table_header *ctl_table_hdr;
>>> @@ -26,6 +31,7 @@ struct mptcp_pernet {
>>>         u8 mptcp_enabled;
>>>         u8 checksum_enabled;
>>>         u8 allow_join_initial_addr_port;
>>> +       u8 pm_type;
>>>  };
>>>
>>>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
>>> @@ -58,6 +64,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
>>>         return mptcp_get_pernet(net)->stale_loss_cnt;
>>>  }
>>>
>>> +int mptcp_get_pm_type(const struct net *net)
>>> +{
>>> +       return mptcp_get_pernet(net)->pm_type;
>>> +}
>>> +
>>>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>>  {
>>>         pernet->mptcp_enabled = 1;
>>> @@ -65,6 +76,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>>         pernet->checksum_enabled = 0;
>>>         pernet->allow_join_initial_addr_port = 1;
>>>         pernet->stale_loss_cnt = 4;
>>> +       pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
>>>  }
>>>
>>>  #ifdef CONFIG_SYSCTL
>>> @@ -108,6 +120,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
>>>                 .mode = 0644,
>>>                 .proc_handler = proc_douintvec_minmax,
>>>         },
>>> +       {
>>> +               .procname = "pm_type",
>>> +               .maxlen = sizeof(u8),
>>> +               .mode = 0644,
>>> +               .proc_handler = proc_dou8vec_minmax,
>>> +               .extra1       = SYSCTL_ZERO,
>>> +               .extra2       = &mptcp_pm_type_max
>>> +       },
>>>         {}
>>>  };
>>>
>>> @@ -128,6 +148,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>>>         table[2].data = &pernet->checksum_enabled;
>>>         table[3].data = &pernet->allow_join_initial_addr_port;
>>>         table[4].data = &pernet->stale_loss_cnt;
>>> +       table[5].data = &pernet->pm_type;
>>>
>>>         hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>>>         if (!hdr)
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index 451948b11030..f1fc08d89c20 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -365,8 +365,12 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
>>>
>>>  void mptcp_pm_data_reset(struct mptcp_sock *msk)
>>>  {
>>> -       bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
>>> +       u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
>>>         struct mptcp_pm_data *pm = &msk->pm;
>>> +       bool subflows_allowed;
>>> +
>>> +       subflows_allowed = !!mptcp_pm_get_subflows_max(msk) &&
>>> +               pm_type == MPTCP_PM_TYPE_KERNEL;
>>>
>>>         pm->add_addr_signaled = 0;
>>>         pm->add_addr_accepted = 0;
>>> @@ -374,13 +378,14 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>>>         pm->subflows = 0;
>>>         pm->rm_list_tx.nr = 0;
>>>         pm->rm_list_rx.nr = 0;
>>> -       WRITE_ONCE(pm->pm_type, MPTCP_PM_TYPE_KERNEL);
>>> +       WRITE_ONCE(pm->pm_type, pm_type);
>>>         /* pm->work_pending must be only be set to 'true' when
>>>          * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
>>>          */
>>>         WRITE_ONCE(pm->work_pending,
>>> -                  (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
>>> -                  !!mptcp_pm_get_add_addr_signal_max(msk));
>>> +                  pm_type == MPTCP_PM_TYPE_KERNEL &&
>>> +                  ((!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
>>> +                   !!mptcp_pm_get_add_addr_signal_max(msk)));
>>
>> I think pm_type == MPTCP_PM_TYPE_KERNEL is somehow duplicate here, how
>> about use this code instead:
>>
>>         WRITE_ONCE(pm->work_pending,
>>                    (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
>>                    (!!mptcp_pm_get_add_addr_signal_max(msk) && pm_type
>> == MPTCP_PM_TYPE_KERNEL));
>
> Still apropos making this chunk of code more readable, what about:
>
> 	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
> 		// [current code]
> 	} else {
> 		WRITE_ONCE(pm->work_pending, 0);
> 		WRITE_ONCE(pm->accept_addr, 0);
> 		WRITE_ONCE(pm->accept_subflow, 0);
> 	}
>
> ?

I agree that it's more readable using the 'if' statement, I'll make that 
change.

--
Mat Martineau
Intel
---1463794943-1804108985-1638830242=:4883--
