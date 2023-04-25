Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE17B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 00:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26735C433D2;
	Tue, 25 Apr 2023 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682382065;
	bh=IVzkUxt30LqMprJAGSzNqDy65/9Kw5F52lfSUnqGVF4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QKkvFJ8MizAjOUYwVLFIQd+rptc034fOxQA0tN3/gPTNZ2/tleau5gcWPPufIb/zo
	 bFyyCqOqszgHfGBBgBUrME08J+qbjxWFGguiHxoF42LivCtJ56YUpEHs+ZrFsf4gTK
	 j7ZgX8oUWmkBanBuAGrxlhvqfRxibz3hxzhpnx4xDdW4N/I+F6yZWuMsYixz3M6QxB
	 seOHhitAAZ028Cm7QCdfaSECiLDERL92e4NwaEBQmQbDaPzNA/9G536w6OEhGpp0Ip
	 UA35jTPoGOHitnEzQTyjULmzJqU7jwyoQpG1NG2zsiAiiQX25jJI8zg4L5PENHVUTo
	 H0vbu3IUuN8qg==
Date: Mon, 24 Apr 2023 17:21:04 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when features
 are not supported
In-Reply-To: <03935b76-591d-85af-ad97-62c5ed5acedb@kernel.org>
Message-ID: <798f7a6c-34b7-9285-8d4c-c05dd0f4936c@kernel.org>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net> <03935b76-591d-85af-ad97-62c5ed5acedb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 24 Apr 2023, Mat Martineau wrote:

> On Fri, 7 Apr 2023, Matthieu Baerts wrote:
>
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>> 
>> These different patches add support for older kernels. More similar
>> checks will be needed but here is a first batch not to have too many
>> patches (because each patch fixes different commits).
>> 
>> I tried to minimise the modifications and do the checks from the bash
>> script not to have to detect the feature when being used in a .c file,
>> then pass the info to the bash script, skip the test, clean the
>> environment, etc.
>> 
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> Hi Matthieu -
>
> The "skip if MPTCP is not supported" patches (1-7) and patch 10 (missing ip 
> tool) look good to me:
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
>
>
> I have some comments on patch 8 and related, I'll reply separately on those.
>
> Thanks!
>

One more question:

Did you check some older kernels to see how the tests behaved? So far I 
only had the chance to try 5.4 (because it was easily available). If I 
recall, we may have had some behavior changes along the way that could 
cause some test failures even if features are present.


- Mat

>
>> ---
>> Matthieu Baerts (13):
>>      selftests: mptcp: connect: skip if MPTCP is not supported
>>      selftests: mptcp: pm nl: skip if MPTCP is not supported
>>      selftests: mptcp: join: skip if MPTCP is not supported
>>      selftests: mptcp: diag: skip if MPTCP is not supported
>>      selftests: mptcp: simult flows: skip if MPTCP is not supported
>>      selftests: mptcp: sockopt: skip if MPTCP is not supported
>>      selftests: mptcp: userspace pm: skip if MPTCP is not supported
>>      selftests: mptcp: lib: skip if missing symbol
>>      selftests: mptcp: connect: skip TFO tests if not supported
>>      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
>>      selftests: mptcp: userspace pm: skip if not supported
>>      selftests: mptcp: userspace pm: skip PM listener events tests if 
>> unavailable
>>      selftests: mptcp: join: skip PM listener events tests if unavailable
>> 
>> tools/testing/selftests/net/mptcp/Makefile         |  2 +-
>> tools/testing/selftests/net/mptcp/config           |  1 +
>> tools/testing/selftests/net/mptcp/diag.sh          |  4 +++
>> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++++
>> tools/testing/selftests/net/mptcp/mptcp_join.sh    | 18 ++++++++++--
>> tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 34 
>> ++++++++++++++++++++++
>> tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  4 +++
>> tools/testing/selftests/net/mptcp/pm_netlink.sh    |  4 +++
>> tools/testing/selftests/net/mptcp/simult_flows.sh  |  4 +++
>> tools/testing/selftests/net/mptcp/userspace_pm.sh  | 17 ++++++++++-
>> 10 files changed, 94 insertions(+), 4 deletions(-)
>> ---
>> base-commit: 016e68a1441264585c15defedc5ccf883b3b4211
>> change-id: 20230406-mptcp-issue-368-selftests-old-kernels-fffd69d67d91
>> 
>> Best regards,
>> -- 
>> Matthieu Baerts <matthieu.baerts@tessares.net>
>> 
>> 
>> 
>
