Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31A8490
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667585752; x=1699121752;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W+ZUdQkPgL9pUXmT9CKonDXxm8hdh/EzAhVjLyki1nM=;
  b=ZM3Ghue+1H+2JEjlWzBIR7vM4mf47bOCme4t7hHY2DwUMKhi/RJZ64/x
   uqk2M7Z22dJInziv2n1zeJ6j5Fl0zVC7VgMmtqyrOY74bh9LaIleqe3wp
   8z4UfUSFCNLuqo0xiQLL1UFYertAzf8GTdDGKrMEXuzZpgZDS0UM4mTKf
   V07SxqX3vs5d7eR/T/NZcoS1BBPcwHcBPCPxXo0ykwqxriPy9uPme4CA4
   WqHimkOx+1uaPKCCMoQVKOHKL4WT8ZcTZDg/XsrSbt9Z1EfvY047l6/Ts
   2p1K9WFP1P7G/sOqlgkqC7emAYkwBNCbw/4ib5WAvPbFEzK+pDRc7yKVa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="374274730"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="374274730"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:15:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="698741374"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="698741374"
Received: from mvedaei-mobl2.amr.corp.intel.com ([10.212.176.106])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:15:43 -0700
Date: Fri, 4 Nov 2022 11:15:43 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3] mptcp: use entry->lsk directly
In-Reply-To: <0c139c30ad0d626a67ddcffb83c83e211471c542.camel@redhat.com>
Message-ID: <c4219f9b-705a-d95e-a1ca-7ad18486f6ab@linux.intel.com>
References: <20221104115354.3413-1-geliang.tang@suse.com> <0c139c30ad0d626a67ddcffb83c83e211471c542.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 4 Nov 2022, Paolo Abeni wrote:

> Hello,
>
> On Fri, 2022-11-04 at 19:53 +0800, Geliang Tang wrote:
>> entry->lsk should be used as the PM listening socket directly in
>> mptcp_pm_nl_create_listen_socket(), not the initial subflow socket.
>>
>> This patch fixes this, use entry->lsk directly instead of ssock.
>>
>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>
> Sorry for the late review. I also don't understand exactly what bug is
> fixed here. Could you please elaborate more - even in this thread,
> before an eventual next version?
>
> AFAICS, this patch introduces a functional change: before the msk
> created by the NL PM was left in TCP_CLOSE status, while the tcp
> subflow entered into the TCP_LISTENER mode.
>
> After this patch even the msk status is updated to TCP_LISTENER, which
> is possibly cleaner, and looks safe, but I don't see a bug fixed
> here?!?
>

I think this patch came up because Geliang was working on 
https://github.com/multipath-tcp/mptcp_net-next/issues/313 and found that 
the in-kernel listening sockets were only listening at the subflow level 
and not the msk level.

In the v2 review I misread where the msk was coming from and thought there 
was something buggy here - but now I see this code is dealing with the 
MPTCP-level socket that was just created and added to the new 
mptcp_pm_addr_entry. So, I agree (now) that this is not a bug fix, and 
that it's "possibly cleaner and looks safe".

That still leaves an open question of whether to make this change in 
mptcp-next for #313. An alternative is to have 
mptcp_pm_nl_create_listen_socket() trigger MPTCP_EVENT_LISTENER_CREATED 
after listening on the subflow rather than depending on
kernel_listen(msk, ...) to do it using this patch.

--
Mat Martineau
Intel
