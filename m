Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBC2F26
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644015467; x=1675551467;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bzofFe8uPMM6M0MBlOzQmwttJ1rMcrTG+15/yCM2W+0=;
  b=KPuvacxqwn3/lqAii1XdIGp6yXUJOWFP27ZO+VlET2z3kJhDaRg3AOxR
   zE2MfZREhI++Wk2Z0z/LFlcbmYTaZdm35Vm94/csSOJIgdchASbOfyeij
   RSwiJp21Zaap3lPxzYWHcUlZkgjSTxIfXDRIEODc7R5jqk4qKDg4R7KBd
   vq1wM3GU6xzaLLm4L4+65k5oTX2rTDOiA4crEe5yMw8YmzK1nJtxBjT/v
   oGwKh8qOdf6ZLCeaFBv+5rCiFUw340s+l5odDFX6xIMd/Yp4FBZLl1J7r
   Kf/9w1UqciIFMTs2U87xwaJeMq5/0BoXdEofIsMw9MwCa4d7XOFQP8rPU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248670760"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248670760"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:57:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="524467082"
Received: from ktahomi-mobl3.amr.corp.intel.com ([10.209.88.47])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:57:46 -0800
Date: Fri, 4 Feb 2022 14:57:46 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: fix diag instability
In-Reply-To: <510a18db-2949-e95d-050f-942e15e9ea96@tessares.net>
Message-ID: <c3df5d6e-749c-e010-15dc-a4b071da396@linux.intel.com>
References: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com> <932621cc-7db9-91cb-7daf-e37a4953a43c@tessares.net> <cc21c95dccf7768ea9465438520a028e7a42fd5d.camel@redhat.com> <510a18db-2949-e95d-050f-942e15e9ea96@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 4 Feb 2022, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 04/02/2022 19:32, Paolo Abeni wrote:
>> On Fri, 2022-02-04 at 16:53 +0100, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> On 04/02/2022 13:17, Paolo Abeni wrote:
>>>> Instead of waiting for an arbitrary amount of time for the MPTCP
>>>> MP_CAPABLE handshake to complete, explicitly wait for the relevant
>>>> socket to enter into the established status.
>>>>
>>>> Additionally let the data transfer application use the slowest
>>>> transfer mode available (-r), to cope with very slow host, or
>>>> high jitter caused by hosting VMs.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> v1 -> v2:
>>>>  - use wait_for_ instead larger sleep
>>>>  - hopefully better commit message
>>>
>>> Thank you for the new version!
>>>
>>> It is being tested in the background. More than 175 attempts in a slow
>>> environment with a debug kernel and no failures so far!
>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
>>>> index 2674ba20d524..ff821025d309 100755
>>>> --- a/tools/testing/selftests/net/mptcp/diag.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/diag.sh-
>>>> @@ -119,7 +149,7 @@ for I in `seq 1 $NR_CLIENTS`; do
>>>>  				./mptcp_connect -p $((I+10001)) -l -w 10 \
>>>>  					-t ${timeout_poll} 0.0.0.0 >/dev/null &
>>>>  done
>>>> -sleep 0.1
>>>> +wait_local_port_listen $ns $((NR_CLIENTS + 10001))
>>>>
>>>>  for I in `seq 1 $NR_CLIENTS`; do
>>>>  	echo "b" | \
>>>
>>> Do we need the change the last sleep (sleep 1.5) as well? We could wait
>>> for a shorter time but well that's only 1.5 second once. And I guess we
>>> might need to look for each connection because looking at the last one
>>> might not be enough if there was an issue with a previous one.
>>>
>>> So best to keep the "sleep 1.5"?
>>
>> We need a more complex test to replace sleep 1.5 reliably. I'll look at
>> that later, surely in a different patch.
>
> If we don't see other issues with the public CI, it might be OK like that!
>
>>> If yes, do you prefer if the test run for a longer time or can I already
>>> apply it?
>>
>> Please, go ahead, thanks!
>
> Thanks!
>
> Should I add a Fixes tag and put it in -net?
>
> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
>
> @Mat: Also OK for you?
>

Yes, good for me. And:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
