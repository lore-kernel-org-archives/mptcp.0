Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0433A2D
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648746634; x=1680282634;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z0emDfhzZWYDkQClz9wxQ/eF1W3cPldBXwX0gzzMzVw=;
  b=DBc6/8PKHRxPYqCTht43pWNHdL29TJsFWOxoyTDgZpg4qgXse6OuVbs+
   2rKZpr8dfSm31erS25180nqR1zArEFG5EYkttx3MKq9ud8QP8zTN3/U5u
   bqkXfpTS2wojNKCk7CWGW5ZZddGNHgEwV66dqNb/6N+rtE19TQH975Emd
   NuD1aQwiO4G51edzn21mfEffrB3831CHqoteDRigENYEPEhd+S27BfrW3
   wn5BOzo3HzjMmLGbK6YogxvDuFRnZ/uqaMAMIarCsTE6AjfQtLEbby/RD
   mCEN+1yQSQxeUhoTzgGAiRR7f8cll423dcHqailKl832LH/33By0Ev3kF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257481254"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257481254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:09:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503831621"
Received: from aadl-mobl.amr.corp.intel.com ([10.209.86.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:09:51 -0700
Date: Thu, 31 Mar 2022 10:09:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, 
    "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Re: Commit logs update request
In-Reply-To: <8bf4ccea-7095-0183-66b7-40e19af72dfc@tessares.net>
Message-ID: <69e6641-8e9c-43d1-aa29-bde79af009f@linux.intel.com>
References: <HE1PR0402MB34974081CB4E91797BF80DE1F8E19@HE1PR0402MB3497.eurprd04.prod.outlook.com> <8bf4ccea-7095-0183-66b7-40e19af72dfc@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 31 Mar 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 31/03/2022 17:46, Geliang Tang wrote:
>> Hi Matt,
>>
>> As I mentioned in the weekly meeting, I noticed some of the commit logs
>> of my patches on the export branch became mismatch since changes have
>> squashed to them.
>>
>> Here I send a list of new commit logs. Please help me to update them.
>
> Thank you for noticing that!
>
> @Mat: because your RvB tag is on some of them, are you also OK with the
> modification?
>

The updated commit messages are all ok, thanks!

--
Mat Martineau
Intel
