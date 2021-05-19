Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29370
	for <mptcp@lists.linux.dev>; Wed, 19 May 2021 03:18:24 +0000 (UTC)
IronPort-SDR: tIVHV8kesjky04dVd0t5W+Hi1zW40SfrT1ga9eATFNlMfXfRA8NQCLl6Pm4HDBIVon+OjBrld4
 VH+WiMzuzMzw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286410140"
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="286410140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 20:18:23 -0700
IronPort-SDR: CCNM9gQgY8zneM9YkePW5DBxFFvts6W/ONumWeWboBqRMPzYEwlP2TlUG/GkJYbc4LZSwBsUtJ
 QEuROepi3pgg==
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="542285926"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 20:18:23 -0700
Date: Tue, 18 May 2021 20:18:23 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add deny_join_id0
 in mptcp_options_received"
In-Reply-To: <fecc3c1-5ac1-5ce7-7c8-8f253c619bb2@linux.intel.com>
Message-ID: <485860c5-ebd3-7796-62c4-b1a343f5e670@linux.intel.com>
References: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com> <fecc3c1-5ac1-5ce7-7c8-8f253c619bb2@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Mat Martineau wrote:

> On Tue, 18 May 2021, Geliang Tang wrote:
>
>> Please add this line to the commit log:
>> 
>> '''
>> In mptcp_finish_join, add the incomming join address check too.
>> '''
>> 
>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>> ---
>> net/mptcp/protocol.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index c725e8f02533..5cebecc838ca 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3116,7 +3116,8 @@ bool mptcp_finish_join(struct sock *ssk)
>> 	if (!msk->pm.server_side)
>> 		goto out;
>> 
>> -	if (!mptcp_pm_allow_new_subflow(msk)) {
>> +	if (!mptcp_pm_allow_new_subflow(msk) ||
>> +	    (READ_ONCE(msk->pm.remote_deny_join_id0) && !subflow->remote_id)) 
>> {
>
> This checks whether this side received a C==1 bit from the remote - but 
> that's already checked in mptcp_pm_create_subflow_or_signal_addr().
>
> What might be needed is a check in the opposite direction: if this side 
> *sent* C==1, and the incoming MP_JOIN is for the initial addr/port, that's 
> invalid.
>
> Not sure yet how we are going to interpret the RFC on this, will be 
> discussing at the meeting tomorrow.

I meant "our next scheduled community meeting" :)

>
>
>> 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
>> 		return false;
>> 	}
>> -- 
>> 2.31.1

--
Mat Martineau
Intel
