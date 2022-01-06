Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36652C9E
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641491938; x=1673027938;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7sruAOaWkh/x/i7nrfHu+JmV6GzmYnAU9XApxEglHoE=;
  b=YjVx9OsVFKPLQs3wNlirsFJEMQB1bUcB7JMxvIRfuhOiwJ4Z/HZZrNF5
   bbjo08NKW+2LdkTT34jTUZo1cIvqUXgj+co5vixRoJk18AF2VmUbbEFJE
   kXvGaMYH7MZXTiXEG7wJNT+++MhA683TmTUzBoW9TyUNGWMqjIO8VLOSu
   Ona5gaFDSQ/BgZex08t5rQp+6QiyMt75JJSrV8Vrci+v9HeCqy5Ipai/6
   4yEejrrh1k6vTrS9y74FqOqOB5tMgYn/OJ1rRgu6DgLpJhxoTNgLRXiZK
   8sKfChjA5FL+pHrOFGCpRZP4yT2mwVmJQ3rhg8Ly9X8sPWZvb30B/ivIO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266995345"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="266995345"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:58:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="471014596"
Received: from rahamme-mobl.amr.corp.intel.com ([10.252.138.196])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:58:56 -0800
Date: Thu, 6 Jan 2022 09:58:56 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: Upstreaming to net-next
In-Reply-To: <d816d92c328cca717b3f5576aa7a57d60b5478f9.camel@redhat.com>
Message-ID: <b0ef9e2b-b1c8-dbf6-a9af-9a12e02f93f4@linux.intel.com>
References: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com> <d816d92c328cca717b3f5576aa7a57d60b5478f9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-495434844-1641491936=:57347"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-495434844-1641491936=:57347
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Jan 2022, Paolo Abeni wrote:

> On Wed, 2022-01-05 at 17:54 -0800, Mat Martineau wrote:
>> As Matthieu noted in today's meeting, we need to figure out what goes
>> upstream to netdev this week:
>>
>> On Wed, 5 Jan 2022, Matthieu Baerts wrote:
>>
>>> Patches to send to netdev:
>>>    - net:
>>>        - probably best to send:
>>>            - mptcp: fix opt size when sending DSS + MP_FAIL
>>>            - mptcp: fix a DSS option writing error → but we might need
>>> to change
>>>        - But if they are accepted after the last PR from Net maintainer
>>> to Linus would delay stuff.
>>
>> I noticed that Jakub sent a "Networking for 5.16-final" pull request to
>> Linus today, so the 5.16 ship has sailed.
>>
>>>        - So if we don't want to rush to look at the tests, we can also
>>> send to net-next for the future -net (to be check which tree is merged
>>> in which one first?
>>
>> The next pull requests from Jakub to Linus will be from net-next, so
>> that's the fastest route to Linus' tree for fixes that will be added to
>> the stable tree.
>
> I'm a bit lost about all the above. Not sure if due to lack of mtg
> background, lack of coffee, or lack of time to digest the above ;)
>

That's ok - I'm not sure I explained it clearly in the meeting either. 
Just trying to get fixes into Linus' tree ASAP, without getting stuck in 
the net branch until after 5.17-rc1. This happened around a recent 
release, maybe 5.14-ish.

Anyway, I will just ask Jakub about how to best handle it.


>
>>
>>>
>>>    - net-next:
>>>        - patches from Paolo could go there, fixing issues, see GH
>>> issues/250:
>>>            - *@Paolo*: OK for you?
>>>
>>>        - + checksum fixes probably
>>>
>>>        - best to skip MP_FAIL series for now as we don't have a stable
>>> selftest yet
>>>
>>>        - and no need to send Mat's series as it is linked to new
>>> features in the Netlink PM part, not ready yet
>>
>> Here are the commits that look ready (commit ids from
>> export/20220105T054758):
>>
>> Paolo:
>>
>> 9f6720406819 mptcp: keep snd_una updated for fallback socket
>> 95bc19b21e00 mptcp: implement fastclose xmit path
>> 37b1cee6f04f mptcp: full disconnect implementation
>> 916957cdccd6 mptcp: cleanup accept and poll
>> 6358b829913e mptcp: implement support for user-space disconnect
>> adba2e970980 selftests: mptcp: add disconnect tests
>> afef858f5fa4 mptcp: fix per socket endpoint accounting
>> 9caba598fe7a mptcp: clean-up MPJ option writing
>> f584047ecf9a mptcp: keep track of local endpoint still available for each msk
>> fc51a4526843 mptcp: do not block subflows creation on errors
>> 893d4cb7ccb9 selftests: mptcp: add tests for subflow creation failure
>> 128e78db18bf mptcp: cleanup MPJ subflow list handling
>> e470b365da5f mptcp: avoid atomic bit manipulation when possible
>>
>> 3cdd8e644985 selftests: mptcp: more stable join tests-cases
>
> ... anyhow this LGTM for net-next.
>

Ok, good! Thank you for checking in :)

--
Mat Martineau
Intel
--0-495434844-1641491936=:57347--
