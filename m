Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41933C9
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 20:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651610480; x=1683146480;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=+6aU1isN42uNoWFH9U/vgfPVJLDzmaSYdUxJF5qzKSs=;
  b=eRaXRGRM9q6AsV7i1iNkFnWT/yVKzVAW4YMd7D1t5WMmzPjhfF7B3Ah4
   ExZwNVx4/u5hpFHi6yHe4cSzCQeZbCBh6THt2ziJzXEzapVBukcYcv8RQ
   lQoFJRKdzfdXvBhpQk9PfIoS7Xb7lI/9PaVKtk+HCcVT0UzUybMv0eJEJ
   E2RpkdGT0+diNh4ZXbSAg9dPxMgMQb2q8qHNPabTjxecYOWiUsceM7lzT
   hG7tWJOdpadVYBuWi3tXNhgSs/fxkeLYg17MUObL8x68tn0PqpIwXy0P6
   c9W4amyhmH89katJh47nlFE4XyPIUAFU9GMsdHli8r0DgsvaDpAaTE8JS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265171617"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="265171617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:41:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="536510568"
Received: from skarmaka-mobl2.amr.corp.intel.com ([10.209.21.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:41:19 -0700
Date: Tue, 3 May 2022 13:41:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [Weekly meetings] MoM - 28th of April 2022 (MP_FAIL followup)
In-Reply-To: <6052111-39d7-1037-d711-59a3929db477@linux.intel.com>
Message-ID: <8c369784-1387-887e-6aa-60d631897690@linux.intel.com>
References: <6052111-39d7-1037-d711-59a3929db477@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 28 Apr 2022, Mat Martineau wrote:

>    - Features for net-next (next):
>
>        - [8053fb8d49ed] selftests: mptcp: add MP_FAIL reset testcase 
> (Geliang Tang)
>          - Two pending issues: open issue regarding multiple MP_FAIL in self 
> test, and dropping of bad data.
>          - Prioritize MP_FAIL fixes
>          - Follow up on ML to make sure Geliang is not blocked [Mat]
>

Geliang -

Were the two issues to resolve before upstreaming "selftests: mptcp: add 
MP_FAIL reset testcase" these:

1. https://github.com/multipath-tcp/mptcp_net-next/issues/265

2. Waiting for feedback on how to drop data on checksum failure.


For #1, Paolo has been making a lot of progress there. Since the bug is 
tracked, it will be clear when it is closed and no longer blocks 
upstreaming


For #2, do you have questions that I did not address in the "Infinite 
mapping and dropping data" message on the list (30-Mar-2022):

https://lore.kernel.org/mptcp/5e9cc0c5-1514-a198-5191-a765a67b9de4@linux.intel.com/#r

My conclusion there was that we don't need to drop data on checksum 
failure:

"""
I don't think it's necessary to discard any incoming data to
handle this single-subflow fallback scenario. As Matthieu mentioned in the
meeting, the checksum failure tells us that there was either MPTCP header
corruption or a mismatch between the data payload and the MPTCP mapping -
it is not an indication that the data was "bad". If the incoming data that
is read from the MPTCP socket matches the subflow's reassembled TCP
stream, then fallback was successful.
"""

Was that your concern, or is there a different issue?


Thanks!

--
Mat Martineau
Intel
