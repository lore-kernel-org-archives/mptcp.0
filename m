Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D372
	for <mptcp@lists.linux.dev>; Thu,  8 Jul 2021 22:16:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="273444134"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="273444134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 15:16:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="461912810"
Received: from pkadam-mobl1.amr.corp.intel.com ([10.212.141.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 15:16:39 -0700
Date: Thu, 8 Jul 2021 15:16:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 8th of July 2021
In-Reply-To: <2303cc24-457e-42cf-7600-0ed9e56209a0@tessares.net>
Message-ID: <1b70a7d8-57a7-8bfd-d7fe-69748d2d33bc@linux.intel.com>
References: <2303cc24-457e-42cf-7600-0ed9e56209a0@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 8 Jul 2021, Matthieu Baerts wrote:

> Hello everyone,
>
> Today, we just had our 156th meeting with Mat and Ossama (Intel),
> Florian, Paolo, Davide, Poorva (RedHat), Geliang (Xiaomi) and myself
> (Tessares).
>
>
> Thanks again for this new good meeting!
>
> Here are the minutes of the meeting:

...

> Extra tests:

...

>    - CI (Matth):
>        - some selftests are often failing:
>            - selftest_diag: not all the time
>            - selftest_mptcp_join: always with debug
>            - selftest_simult_flows: always with debug
>        - @Mat: check if all tests are executed on kbuild

kbuild is only skipping diag.sh, because it has an older 'ss' version that 
doesn't support MPTCP.

>        - TODO: Matth: report this on Github to track the issues:
>            - always the same error?
>            - timing issue?

--
Mat Martineau
Intel
