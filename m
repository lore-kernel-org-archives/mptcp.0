Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A5173
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643160391; x=1674696391;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=std0EtPcPt+V0TLqlVSv9PyrdkigWmdAhofCREvWBFU=;
  b=R/9Yp9re+kxmnMyiRwYyfntUWFI6+PYPxRf8PSGzUmTKXr2U9JF9pONV
   +McqpqS9kL/Y9RhiG0SVxQEf7tsT9ZQJBDpugSVJmq3CHyN9r4uJw9241
   kGGB/L4r3aHpmkTD/+vhTUPvEozcj7pw9h9RxskdKKS4Jgjx8H5o3xQ8a
   k7hBW98+sqa1qpdAAe+pLLhR+cM/5S+Pzi2/JOvpH6g00PUHb6z44dL2L
   FfDeri2fAq+ZasKQwMiaEA8weAz4sARK9/pOrsFludXO1BlrueMJ637dL
   GBdFD9TjtB8OrYfo0zjrm0pxQ1K1+DiUzl6sMH/ffNLdKjJtrNtoEx540
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309772985"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="309772985"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:26:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="766980116"
Received: from vsanjeep-mobl.amr.corp.intel.com ([10.212.157.188])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:26:30 -0800
Date: Tue, 25 Jan 2022 17:26:30 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliangtang@gmail.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: add missing join check
In-Reply-To: <fc920e6d-72fe-49c8-e31f-920fbd15c952@tessares.net>
Message-ID: <3f68e731-3c0-d74-2040-28ef4485a3b@linux.intel.com>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net> <20220122093135.4023846-3-matthieu.baerts@tessares.net> <CA+WQbwuSJ-WZuQFEjTAtD5ycodbiC0mZ7dwDWQa0VEWsOPSO=g@mail.gmail.com> <fc920e6d-72fe-49c8-e31f-920fbd15c952@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1833725667-1643160390=:24422"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1833725667-1643160390=:24422
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jan 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> Thank you for looking at that!
>
> On 22/01/2022 15:04, Geliang Tang wrote:
>> I think in this test chk_join_nr is omitted on purpose, since it is more
>> likely to fail. As we can see, chk_add_nr failed sometimes, if we add this
>> chk_join_nr, it will fail more frequently.
>
> May you explain why this tests is likely to fail? Both the commit
> message and the comment in the code don't explain that.
>
>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月22日周六 17:32写道：
>>>
>>> This function also writes the name of the test with its ID, making clear
>>> a new test has been executed.
>>>
>>> Without that, the ADD_ADDR results from this test was appended at the
>>> end of the previous test causing confusions. Especially when the second
>>> test was failing, we had:
>>>
>>>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>>>                                   add[ ok ] - echo  [ ok ]
>>>                                   add[fail] got 2 ADD_ADDR[s] expected 3
>>>
>>> In fact, this 17th test was OK but not the 18th one.
>>>
>>> Now we have:
>>>
>>>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>>>                                   add[ ok ] - echo  [ ok ]
>>>   18 signal addresses race test   syn[ ok ] - synack[ ok ] - ack[ ok ]
>>>                                   add[fail] got 2 ADD_ADDR[s] expected 3
>>
>> I think if chk_add_nr fail here, chk_join_nr must fail too. If we got 2
>> ADD_ADDR[s], we got 2 JOIN[s] syn too, not 3. Furthermore, if chk_add_nr
>> passed, we can't make sure chk_join_nr will pass too. Since MP_JOIN is
>> translated after ADD_ADDR, it may be lost.
>
> Indeed, to simplify the commit message, I mixed both a "success" and a
> "failure" output. I should not have done that and only put a "success"
> one to keep the output small.
>

Given that Geliang withdrew his comments, and I don't have changes to 
request, I think this looks ok for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Not sure if you want to adjust the commit message as you mention just 
above.

-Mat

>>> Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index 76c45c845d3b..67be3e1215d7 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -1342,6 +1342,7 @@ signal_address_tests()
>>>         pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
>>>         pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
>>>         run_tests $ns1 $ns2 10.0.1.1
>>> +       chk_join_nr "signal addresses race test" 3 3 3
>>
>> I think we can omit the join numbers check, just print out the name of the
>> test. Don't pass the join numbers to chk_join_nr, just the msg:
>>
>>         chk_join_nr "signal addresses race test"
>
> Do you mean we could have situations where ADD_ADDR have been properly
> sent and received but we check counters just before MPJ are emitted? In
> this case we would mark the test as failed because MPJs are not OK
> (checked too soon in fact) while ADD_ADDR are?
>
> If yes and if it helps, we can also wait for the kernel to have sent
> exactly 3 ADD_ADDR before checking the MPJ. On the other hand, do we not
> already cover this UC where we look for MPJs emitted after having
> received an ADD_ADDR, no?
>
> If we keep checking all counters, I think it might be clearer: MPJ
> counters are not OK because we didn't receive/process the ADD_ADDR, no?
>

--
Mat Martineau
Intel
--0-1833725667-1643160390=:24422--
