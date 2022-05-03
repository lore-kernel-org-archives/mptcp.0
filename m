Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B233CA
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651603184; x=1683139184;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yPGa3ptepqY0eGEwfvy7thF/1rAWZ26iDnYWlQvfAIQ=;
  b=djQxCdDP40V3dXiLhGUagttPU2du/QA4NTFVcjeEP25yK2XBW6CIbgHt
   2sAbu7b5skL+w04kxwVPxVHSPpOjPlkS9/bEXr42E8CW0D3FNp7iV+7o5
   yXcsrDFr2mEUiUrLWkUICcfy7iLf468QV+YOA0TrqMYdS6LNEpsFzxoo4
   J1qdkl9p4Oxv4BXydbMbSGAFllM/Dp1aPixaMu5D5Sz9yUxl3qUUfE3+G
   6ppFuEObKuer9DYLcY393zXSjZ6ZBKo6Ih3+aWMbK9ZLn9Gokcd52NZpg
   myvgDu/HYvZ5///whN5lPEogEvwXZTEzDbzBAJPkBm3YhGPwX1sp5FHZm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="292747651"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="292747651"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:39:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="599186666"
Received: from skarmaka-mobl2.amr.corp.intel.com ([10.209.21.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:39:43 -0700
Date: Tue, 3 May 2022 11:39:43 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix MP_FAIL test-case
In-Reply-To: <66bebfa5f6fcfc6180e13861bd1f629b066a5f4d.camel@redhat.com>
Message-ID: <ec75c84-1e92-3a7a-3c92-d64f40d37e69@linux.intel.com>
References: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>  <7d6e2ab9-ac1-a86f-2ce4-4551e63eb087@linux.intel.com> <66bebfa5f6fcfc6180e13861bd1f629b066a5f4d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 3 May 2022, Paolo Abeni wrote:

> Hello,
>
> On Fri, 2022-04-29 at 12:46 -0700, Mat Martineau wrote:
>> On Fri, 29 Apr 2022, Paolo Abeni wrote:
>>
>>> The mentioned tests sometimes fails because the data
>>> transfer completes before any packet is sent on the 2nd
>>> link (the failing one).
>>>
>>> Address the issue reducing the "virtual" b/w available
>>> on the primary link.
>>>
>>> Fixes: bfd4cdbe7032 ("selftests: mptcp: add MP_FAIL reset testcase")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> together with the previous patch this fixes issues/265 for
>>> good here. I'm not adding the Close tag due to the mentioned
>>> dep, which may take a different/longer route
>>> ---
>>> tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index a98fee834950..0d65295c1b33 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -2734,7 +2734,7 @@ fail_tests()
>>>
>>> 	# multiple subflows
>>> 	if reset_with_fail "MP_FAIL MP_RST" 2; then
>>> -		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
>>> +		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 10mbit delay 5
>>
>> The "MP_FAIL MP_RST" test still fails within a couple of minutes on my
>> desktop with this change. I changed 10mbit to 1mbit and so far it is still
>> running. You ok with slowing it down even more?
>
> [sorry I almost missed this comment]. Just to be sure, is such test
> running on top of the pedit patch? (we need both of them). Otherwise no
> objection to reduce the rate even more.
>

Yes, I was testing with both patches applied.

--
Mat Martineau
Intel
