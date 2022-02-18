Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057AD4C6D
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645210798; x=1676746798;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yEXM5MGaqWxSrsOOC7htaSGsvPd3usiDm0yGH+lLZe0=;
  b=cQxPpZRLpmBdEp2C0ljQw/IrQhkUPRrcIQCRW+rhoDAcSsBOXLbXzTQ1
   mC5k6vjgnnuFWjIiUNCKB9GncxjmjAJy5TIYdoeBhupw1yk7LgGMMlwG+
   w2XQ+tBvva6PyKhbyYZZtiDz1HM/yWgzv4qBCOrGAS5vO29k42/ZwGLJW
   yY+btvdoD6/ILS3PA9DezkGDhQZP41hJ+awRLQgganGHClnz1g5RO0BFh
   hFkpHhcY+Ny1e1rpUeoqdl57kY1jfZbIijNGa7LGTOQcUnAJ22EV78K6l
   +xfLNFtWcjuQD5G1Bdc8wKha3iJaSDr5FoWBLCPkeqNoSpcWGASlVNbTu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231825509"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231825509"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:59:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546398408"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 10:59:56 -0800
Date: Fri, 18 Feb 2022 10:59:56 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
In-Reply-To: <a58fd624f7261abfe417f27b92dc906aab5fb22f.camel@redhat.com>
Message-ID: <b53e8f70-dfb9-b587-5ac2-76d2e92272f1@linux.intel.com>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>  <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com>  <808f443ae9db49c2e5bc69a2285f230d5369853c.camel@redhat.com> <a58fd624f7261abfe417f27b92dc906aab5fb22f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Feb 2022, Paolo Abeni wrote:

> On Fri, 2022-02-18 at 12:04 +0100, Paolo Abeni wrote:
>> On Thu, 2022-02-17 at 16:33 -0800, Mat Martineau wrote:
>>>> Patch 4/9 is the updated version of the previous patch 3/9 from v1: mainly
>>>> rebased. I only added one line in the "usage()" function and use lower cases for
>>>> only_tests variable.
>>>>
>>>> Patch 5/9 is new and similar to the previous patch: another way to execute a
>>>> specific test, useful when using 'git blame'. Also help to have patch 6/9.
>>>>
>>>
>>> These are running fine for me, it's just the issue of 2000+ lines of churn
>>> and the potential (or even likely) net/net-next merge conflicts if we need
>>> to modify mptcp_join.sh after the 5.18 merge window. Hopefully all the
>>> work we're doing now to stabilize the tests means we will not have as many
>>> -net mptcp_join.sh changes in the next cycle, but we would still probably
>>> run in to some headaches. If we do apply these it would need to be right
>>> before net-next closes for 5.18.
>>>
>>> Since you've put this much work into this patch it implies that you think
>>> the merge headaches would be worth it for the 5.18 development cycle :)
>>> For the way I use the test script the ability to test by number is not
>>> that critical - is anyone else (Paolo?) thinking you'll use this feature?
>>
>> That feature would have saved a significant amount of my time in the
>> past weeks. I think the diffstat is a bit too much, and I still would
>> prefer the other approach of filtering out the test in each helper used
>> by the test themself.
>
> Uhmmm... my main argument vs the current version of patch 4 is defeated
> by patches 5 && 6, which look useful. So I'm ok with patch 4 as is...
>

Ok, thanks for the insight! I do like the features, just wanted to make 
sure there's enough interest to justify the conflict resolution work we're 
signing up for. And it does seem like the payoff is worth it. At least 
it's a selftest script and not kernel code that could be disrupted by 
incorrect git conflict resolution here :)

>> Additionally, I think it would be nice replace the 'bare' ip netns exec
>> ...' we still have in some the userspace tests with the appropriate
>> helpers - possibly worth a separate, independent patch.
>
> ... still think it would be nice (almost necessary) cover the above ->
> migrate all direct ip netns exec... usage to the appropriate helper.
>

Sure, that would be good too.

Matthieu, I think it would be good to delay adding 4/5/6 to the export 
branch until mptcp_join.sh has stabilized in -net and been merged back to 
net-next - what do you think? Once these changes go in to the export 
branch we have a lot less flexibility in the order that patches go to 
net-next.

--
Mat Martineau
Intel
