Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A92C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 21:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641505773; x=1673041773;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=icm/KXbmAoUpohWTWvH7h3x51yMWTPJ9ybhIceX8uD0=;
  b=ad+LGTy98Mc1T5C/u2g4EsLW7SHu818qEam8imjH/iqN2jaP9Dumxx4I
   aLzStE0zGfzjERra44S3RmSLTUEMnuWCWgV6X77Qtmq7dS+a/tRwJTe7e
   SvW6YcwfEl4DREYMmLoojzvnvXLzSzTQvuJ7zC06i1Fq98kCsm8R77ROg
   WB4RSLamNYFABZYt0l5v5wGlbqVFiPWyIHJHmB12H0TG4JlBpS6sCQm0u
   SKpeDjUDWuJ7XwG7JcbPJ5+tXCIOY50esmPhCjadIagiBnd9Nas+pS2tm
   19UqrdgvsHdCyDuBt6S3zv/qKWoZYPnYU0tao0i6LLJ4rkgITSrGjlvJ4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229557205"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="229557205"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:49:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="591518725"
Received: from rahamme-mobl.amr.corp.intel.com ([10.252.138.196])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:49:32 -0800
Date: Thu, 6 Jan 2022 13:49:32 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: Upstreaming to net-next
In-Reply-To: <b0ef9e2b-b1c8-dbf6-a9af-9a12e02f93f4@linux.intel.com>
Message-ID: <77bde286-a53c-b9f3-1b7f-129bdd533d0@linux.intel.com>
References: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com> <d816d92c328cca717b3f5576aa7a57d60b5478f9.camel@redhat.com> <b0ef9e2b-b1c8-dbf6-a9af-9a12e02f93f4@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1351567998-1641505772=:57347"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1351567998-1641505772=:57347
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Jan 2022, Mat Martineau wrote:

> On Thu, 6 Jan 2022, Paolo Abeni wrote:
>
>> On Wed, 2022-01-05 at 17:54 -0800, Mat Martineau wrote:
>>> As Matthieu noted in today's meeting, we need to figure out what goes
>>> upstream to netdev this week:
>>> 
>>> On Wed, 5 Jan 2022, Matthieu Baerts wrote:
>>> 
>>>> Patches to send to netdev:
>>>>    - net:
>>>>        - probably best to send:
>>>>            - mptcp: fix opt size when sending DSS + MP_FAIL
>>>>            - mptcp: fix a DSS option writing error → but we might need
>>>> to change
>>>>        - But if they are accepted after the last PR from Net maintainer
>>>> to Linus would delay stuff.
>>> 
>>> I noticed that Jakub sent a "Networking for 5.16-final" pull request to
>>> Linus today, so the 5.16 ship has sailed.
>>>
>>>>        - So if we don't want to rush to look at the tests, we can also
>>>> send to net-next for the future -net (to be check which tree is merged
>>>> in which one first?
>>> 
>>> The next pull requests from Jakub to Linus will be from net-next, so
>>> that's the fastest route to Linus' tree for fixes that will be added to
>>> the stable tree.
>> 
>> I'm a bit lost about all the above. Not sure if due to lack of mtg
>> background, lack of coffee, or lack of time to digest the above ;)
>> 
>
> That's ok - I'm not sure I explained it clearly in the meeting either. Just 
> trying to get fixes into Linus' tree ASAP, without getting stuck in the net 
> branch until after 5.17-rc1. This happened around a recent release, maybe 
> 5.14-ish.
>
> Anyway, I will just ask Jakub about how to best handle it.
>

I think I was being overly paranoid about this - while it looks like the 
net->net-next merge was skipped for 5.13, the netdev maintainers have been 
consistent about it since then. So I won't complicate things by asking 
about it.


--
Mat Martineau
Intel
--0-1351567998-1641505772=:57347--
