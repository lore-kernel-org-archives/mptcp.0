Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181D1860
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656709509; x=1688245509;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cPEPh/huc5+wJ4F4IEhSyidGnohtAvU4d1EsCfSHpWc=;
  b=YbQq5HKpBSuz3+getcqTm1Ix6sQLImlFXWyQPCbdwrTBWFLQX1+CVW02
   Az4TqrIUtG8/8iqYNywJCUj36OT/q86OMyAr+Y+DISQ+DCyMUxsPnov3Z
   aDIMO7dEkTSGQlqIh0XfFv5bVZYQAURlTFFMNjJsFreEugtx6wlns91+k
   DO2yqP6LGb77yjJLjgTQM0Z8hj3FhtkNVO7DxR1V2dXTtIotaP1i4iMFJ
   sJ+SNLTrx4bx3wlE3/IL+iUpnbhwtqN9TUDt/OOPPSBxb5Fo/FigJC0dU
   XtCb7zonSyIoUeKOdsEzpUlAP9q6kIVz22PsI7cvqHXQugHpZYRuQN3uQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="369064620"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="369064620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:05:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="681539498"
Received: from shubhaml-mobl.amr.corp.intel.com ([10.255.229.171])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:05:09 -0700
Date: Fri, 1 Jul 2022 14:05:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
In-Reply-To: <617c2057-b8e5-90df-e246-4db5f439f678@linux.intel.com>
Message-ID: <554ad2e8-2058-aa6d-5d7c-33dabeedf0c9@linux.intel.com>
References: <22c84dbb74978d8062d453f6bc1857502078fc28.1656578856.git.geliang.tang@suse.com> <076e8532-b07a-fb64-d5d1-2294226cfc49@gmail.com> <20220630123409.GA9212@bogon> <617c2057-b8e5-90df-e246-4db5f439f678@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1950991687-1656709509=:71463"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1950991687-1656709509=:71463
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 1 Jul 2022, Mat Martineau wrote:

> On Thu, 30 Jun 2022, Geliang Tang wrote:
>
>> On Thu, Jun 30, 2022 at 10:32:37AM +0000, MPTCP CI wrote:
>>> Hi Geliang,
>>> 
>>> Thank you for your modifications, that's great!
>>> 
>>> Our CI did some validations and here is its report:
>>> 
>>> - KVM Validation: normal:
>>>   - Unstable: 1 failed test(s): selftest_simult_flows - Critical: 2 Call 
>>> Trace(s) ❌:
>>>   - Task: https://cirrus-ci.com/task/5934869556494336
>>>   - Summary: 
>>> https://api.cirrus-ci.com/v1/artifact/task/5934869556494336/summary/summary.txt
>>> 
>>> - KVM Validation: debug:
>>>   - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 2 Call 
>>> Trace(s) ❌:
>>>   - Task: https://cirrus-ci.com/task/5371919603073024
>>>   - Summary: 
>>> https://api.cirrus-ci.com/v1/artifact/task/5371919603073024/summary/summary.txt
>>> 
>>> Initiator: Patchew Applier
>>> Commits: 
>>> https://github.com/multipath-tcp/mptcp_net-next/commits/012eddf81089
>>> 
>>> 
>>> If there are some issues, you can reproduce them using the same 
>>> environment as
>>> the one used by the CI thanks to a docker image, e.g.:
>>>
>>>     $ cd [kernel source code]
>>>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>>>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>>>         auto-debug
>>> 
>>> For more details:
>>>
>>>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>>> 
>>> 
>>> Please note that despite all the efforts that have been already done to 
>>> have a
>>> stable tests suite when executed on a public CI like here, it is possible 
>>> some
>>> reported issues are not due to your modifications. Still, do not hesitate 
>>> to
>>> help us improve that ;-)
>>> 
>>> Cheers,
>>> MPTCP GH Action bot
>>> Bot operated by Matthieu Baerts (Tessares)
>> 
>> Hi Matt,
>> 
>> I can't reproduce all the CI failures. All tests (mptcp_connect.sh,
>> mptcp_join.sh and bpf mptcp selftests) passed on my side.
>> 
>> All the test logs are attached.
>
> I checked out the tag that the CI built from 
> (patchew/cover.1656578856.git.geliang.tang@suse.com), and it looks like the 
> CI hit this:
>
> if (WARN_ON_ONCE(!msk->recovery))
>
> at line 999 of protocol.c, so this is an unexpected instance where dfrag == 
> msk->first_pending and msk->recovery is not set. My guess is that 
> msk->first_pending is not getting updated before returning from 
> __mptcp_push_pending() in some rare case. I'll look for this when reviewing 
> patch 2.

I think this will probably be fixed by changing the dfrag updates as I 
describe in the patch 2 review comments.

--
Mat Martineau
Intel
--0-1950991687-1656709509=:71463--
