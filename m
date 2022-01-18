Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2629CA
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642544526; x=1674080526;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sO35kb4+VYwrnvu/IEOt0g0jqegnhiBrnr4QM3AF6kc=;
  b=YZGaM7vnPcbmyZ5GwG5ZxCnt+WbwHDz5m/lWKQnIGCFVIB8RPzR7VhQ6
   KUnVHVbtxq0UZ0pWbYzXK7VyGvQmlRaTHIBtNr0HmZoXXOnFCkxfpNFWx
   cmlsAYkTZ817+C2nMMeOoThxJ92ZzF1miXLS0KZWy6MxENVsAYR3C1UFW
   z5rVeRt21bXH9b3LL7216zr9q8Zo9xuYR/FQTrE1iKBip9kE6x2y5vZgB
   +Y65Sl97ZswE9APAkqIiCP1o6er+SrWWVQ4RFc8W4W9fWx4MOlnz8E/w8
   boRzzXk3ujaFRTS7i+HFdOM5BYymtULjK6Lbq66x3H16bK/KLYKw7hQ33
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244721323"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="244721323"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 14:22:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="671981109"
Received: from fmaya-mobl1.amr.corp.intel.com (HELO sesloan-mobl1.amr.corp.intel.com) ([10.212.237.254])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 14:22:05 -0800
Date: Tue, 18 Jan 2022 14:22:04 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    MPTCP Upstream <mptcp@lists.linux.dev>, 
    Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail
 testcases
In-Reply-To: <CAKa-r6t75QbV-BE3rKvUHVCBYmcO1eW2typSFUgPSA34uDFEPw@mail.gmail.com>
Message-ID: <3acc8150-a6f4-c6a2-4e42-f4feba33be99@linux.intel.com>
References: <cover.1641804767.git.geliang.tang@suse.com> <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com> <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com> <a1679740-24ed-c788-46df-ad195068dd37@linux.intel.com>
 <CAKa-r6sgL1UUES5WYryNYedLJuq0_dEsO=X1263GFPOExci6BQ@mail.gmail.com> <eb7a9238-6fda-761e-23e9-47fbe332705f@tessares.net> <CAKa-r6t75QbV-BE3rKvUHVCBYmcO1eW2typSFUgPSA34uDFEPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 Jan 2022, Davide Caratti wrote:

> On Tue, Jan 18, 2022 at 3:15 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Davide,
>>
>> On 18/01/2022 14:32, Davide Caratti wrote:
>>> hello,
>>>
>>> started looking at this, but the wild-guess is that the problem should
>>> be fixed with [1]: I'll do a quick test on my VM now.
>>>
>>> [1] https://lore.kernel.org/netdev/20220110094750.236478-1-eric.dumazet@gmail.com/
>>
>> Good point, it might be linked to that.
>
> hello,
>
> confirmed, the problem happens when kernels are built with
> CONFIG_NET_NS_REFCNT_TRACKER=y and the problem is fixed by the
> above-mentioned patch from Eric. It can be easily verified also with
> tdc kselftest:
>
> # pushd tools/testing/selftests/tc-testing;  ./tdc.py -f
> tc-tests/filters/tests.json ; popd
>

Thanks for tracking this down and confirming, Davide!

--
Mat Martineau
Intel
