Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C62F2C
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644273583; x=1675809583;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fP6XhtK4RSiGAjGPAqjkVymXztDs8rpQOTj6TJbnct8=;
  b=ZgVNIVRVCyXHkHMmvkQJeQhmIsoxdjcR3uzI9zyTbjUFMWrcZsHXJAyA
   C0Sj3scDAnQQWrk6uHCvIHe2hx9ksv+7FeY7Ot/42FjW4VD6GwBqJvEAX
   u91O1Rd3q9gUz0ooErbiDepzvTM7in/D2Z9bFHGE10/VwX+R9wzxks6gy
   dfmTjRDzseUyuKnyNz6pMV+W2FMoPlKQ1qF9bOOlbTEpco7s2H/7xdwEH
   0z2es/8r/JhNU8pjxqVs6bBBM/8S/DcSyidiAo5pNRkjxGgUF5+u9DeAk
   1IL5AvJB6HS4IurHaLcxhz2lEbpN1Xf8lvRk9OSFJkBJvlzksVl4+xTLY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="247658121"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="247658121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:39:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="484592474"
Received: from ngoyal-mobl1.amr.corp.intel.com ([10.251.4.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:39:42 -0800
Date: Mon, 7 Feb 2022 14:39:42 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: increase timeout to 1
 hour
In-Reply-To: <785a3195-7fec-5809-f632-8a97714d84a9@tessares.net>
Message-ID: <26f4b8b-ee8d-504e-d61d-b8b887163a37@linux.intel.com>
References: <20220207100022.3936015-1-matthieu.baerts@tessares.net> <4fc5f913-3a8-38a0-7898-8949472c83ec@linux.intel.com> <785a3195-7fec-5809-f632-8a97714d84a9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 7 Feb 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 07/02/2022 20:49, Mat Martineau wrote:
>> On Mon, 7 Feb 2022, Matthieu Baerts wrote:
>>
>>> With the increase number of tests, on a slow public CI with kernel debug
>>> settings, it has been observed it can easily and regularly take up to 45
>>> minutes to execute all tests in this very slow environment. The slowest
>>> test, mptcp_join.sh takes ~30 minutes in this case.
>>>
>>> In such environments, the selftests timeout set in the 'settings' file
>>> is disabled. But because other similar environments can be used to run
>>> MPTCP selftests, it is certainly better to increase the timeout for
>>> everybody else to 1h.
>>>
>>> Most of the time, running all MPTCP selftests takes around 5 to 10
>>> minutes on decent environments and the slowest test takes less than 10
>>> minutes, the current timeout.
>>>
>>> The timeout could be disabled but it is always good to have an extra
>>> safeguard, just in case.
>>>
>>
>> I agree that it's good to have some timeout in place for our tests. An
>> hour seems like a lot, has there been any feedback from others with CI
>> as slow as ours?
>>
>> The largest existing selftest timeout is 1500 (net/settings), and
>> looking at the kbuild logs it takes their infrastructure 28 minutes to
>> run the net tests and 11 minutes to run the MPTCP tests. What do you
>> think about a smaller timeout increase for the MPTCP tests?
>
> I can, it would be enough for my CI. But not for a setup like the public
> CI where mptcp_join.sh tests can take up to 30 minutes and it keeps
> increasing.
>
> But if you prefer, I can double the current value and that's enough for
> my case. What do you prefer?
>

Doubling the current value is my preference for now.

--
Mat Martineau
Intel
