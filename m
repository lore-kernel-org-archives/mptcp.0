Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C782F43
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673022902; x=1704558902;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XJmtexN9Bu13e+LiOaRNIlq6EdNSFqa3LR84cBkyV80=;
  b=W46icUl07Qf9jiXouwdQjAgQwOc51o1xSThazYJmiV7u5CTkL+qfhRjR
   PLSjMP10DdbZHTG6o6Xf1jhB1TJNrd7kpi2bDY3lRRB0ECaco8ULiFH4J
   /tQQOwcBOoiNjhm717rvL03Jf1qGqan4RIzMAu92rxG9l5xoWK0Vap9Nr
   qA7140QuVxSoDXqYkspS2gYsBVozC8mk62UDck75msImC0115kvHi2zl8
   N60fbFAjg+92Jh2s9yxjQB2xx3R0tDythta2KR6BF+2xp+6gxBTcVp9Rf
   KgjqMIVhki4wCA64wXRVHvfqwf3pJ/dgcxoYTOnwjLZwiX/1fo3nvr7ti
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="349717767"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="349717767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:35:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="605946502"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="605946502"
Received: from rkoganti-mobl.amr.corp.intel.com ([10.209.28.230])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:35:01 -0800
Date: Fri, 6 Jan 2023 08:34:54 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 09/12] selftests: mptcp: userspace: print
 titles
In-Reply-To: <bfae082b-18a5-4c15-8bdd-d9a34516d5f7@tessares.net>
Message-ID: <d9aefe94-6e0a-b2d0-b011-8f79664dd696@linux.intel.com>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net> <20230104171526.1416746-10-matthieu.baerts@tessares.net> <a684ae0c-060c-49ae-f3a4-ec0a26dd0e21@linux.intel.com> <bfae082b-18a5-4c15-8bdd-d9a34516d5f7@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-745705974-1673022901=:43377"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-745705974-1673022901=:43377
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 6 Jan 2023, Matthieu Baerts wrote:

> Hi Mat,
>
> Thank you for the review!
>
> 6 Jan 2023 02:19:26 Mat Martineau <mathew.j.martineau@linux.intel.com>:
>
>> On Wed, 4 Jan 2023, Matthieu Baerts wrote:
>>
>>> This script is running a few tests after having setup the environment.
>>>
>>> Printing titles helps understand what is being tested.
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>>
>>> Notes:
>>>    v3->v4:
>>>      - Add a title for the Cleanup (+ 'Done' at the end)
>>>
>>> .../selftests/net/mptcp/userspace_pm.sh       | 24 ++++++++++++++++++-
>>> 1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>>> index ab2d581f28a1..f9a03e6e968f 100755
>>> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
>>> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>>> @@ -43,6 +43,11 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
>>> ns1="ns1-$rndh"
>>> ns2="ns2-$rndh"
>>>
>>> +print_title()
>>> +{
>>> +   stdbuf -o0 -e0 printf "\t%s:\n" "${1}"
>>
>> The indented titles seem kind of inverted to me:
>>
>> """
>>     Init:
>> Created network namespaces ns1, ns2                     [OK]
>>     Make connections:
>> Established IPv4 MPTCP Connection ns2 => ns1            [OK]
>> Established IPv6 MPTCP Connection ns2 => ns1            [OK]
>>     Announce tests:
>> ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token           [OK]
>> ADD_ADDR id:55 10.0.2.2 (ns2) => ns1, reuse port        [OK]
>> ...
>> """
>>
>> It would read better to have the titles left-justified and the test results indented, but that makes all of the test results extra long. Seems like you are trying to avoid that (for good reason!).
>
> Indeed :)
>
>> What do you think about copying the "INFO: ..." style from mptcp_connect.sh?
>
> Good idea, that works for me!
>
> I can do the modification (s/\t/INFO: /) when applying the patches if that's OK for you (if there is nothing else to change of course).
>

Sure, that's fine with me. For patches 9-12:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
--0-745705974-1673022901=:43377--
