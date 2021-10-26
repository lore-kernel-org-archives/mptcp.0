Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D42CA8
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 23:10:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="293498139"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="293498139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:10:33 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="537320002"
Received: from gacramer-mobl2.amr.corp.intel.com ([10.209.53.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:10:33 -0700
Date: Tue, 26 Oct 2021 16:10:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix corrupt receiver key in MPC +
 data + checksum
In-Reply-To: <c623e2-9f3d-ef3f-8135-fe2662f1dd@linux.intel.com>
Message-ID: <68a55657-2cdb-54f3-9a2c-73864101323@linux.intel.com>
References: <0ad4620ed5034e9267e579f71c060b312b3e2eee.1635258393.git.dcaratti@redhat.com> <c623e2-9f3d-ef3f-8135-fe2662f1dd@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-952142265-1635289833=:37090"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-952142265-1635289833=:37090
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 26 Oct 2021, Mat Martineau wrote:

> On Tue, 26 Oct 2021, Davide Caratti wrote:
>
>> using packetdrill it's possible to observe that the receiver key contains
>> random values when clients transmit MP_CAPABLE with data and checksum (as
>> specified in RFC8684 §3.1). Fix the layout of mptcp_out_options, to avoid
>> using the skb extension copy when writing the MP_CAPABLE sub-option.
>> 
>> Fixes: d7b269083786 ("mptcp: shrink mptcp_out_options struct")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/233
>> Reported-by: Poorva Sonparote <psonparo@redhat.com>
>> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>> ---
>> 
>> Notes:
>>    v1:
>>     - fix metadata in the commit message (Mat Martineau)
>>     - adjust comment in mptcp_established_options_mp() (Mat Martineau)
>>     - fix sparse warning in __mptcp_make_csum() (Mat Martineau / patchew 
>> CI)
>> 
>
> Thanks Davide, v2 looks good and I confirmed the correct keys in MPC+data 
> with 'mptcp_connect.sh -C'.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>

Matthieu -

One more thing: If your schedule allows, could you apply this early 
Wednesday? That way CI can complete, and then there's a chance to sync up 
on IRC when our timezones overlap. Hopefully I can send this to netdev in 
the morning (my time), probably the last chance to get it merged for 
v5.15.

--
Mat Martineau
Intel
--0-952142265-1635289833=:37090--
