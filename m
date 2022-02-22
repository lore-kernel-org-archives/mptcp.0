Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC38366
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645555164; x=1677091164;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JeWJzmHZnBgAoF/3unRqoDsPlApX1RG2IBQGdw9GR3A=;
  b=WoHbLbSSHwwUefG6zzWiDG8spOdJ0z7RB5EY9KlJ5CAdpeSW92PdgM/Z
   mgsFcCx80PBWGEwTVZiyrZQFvarFUUBgYYdV3neRf9vZB2ZI91eJD+J2Z
   EhZmoHAw12gJn6xv0ayDpa3pVd91dfJ7w07DGxKB8a7YzlnsUmiCvABDn
   SUnuxp/fVIbZjcOTE+wRgLAil4IKJQBbEEF5bhWM1rQdKaZ8Z4pGyrdXA
   k/gqhgw3KvTK0g2bIDV45BV6VD7smKLFPMRm6Rd7kfPwuz8lppPG/C4Tf
   WtoDvTBLN74f3EYJakfRe/RLIl5XuKktLppvyzBq2eFuYaogly7J1zwOa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338217839"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="338217839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:39:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="573535934"
Received: from fdwikusu-mobl.amr.corp.intel.com ([10.251.6.85])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:39:05 -0800
Date: Tue, 22 Feb 2022 10:39:05 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: more careful RM_ADDR
 generation"
In-Reply-To: <5eea9634-7238-5dec-80e2-043d3cdead50@tessares.net>
Message-ID: <792f20dc-b820-25c-e38-d84c7c22194@linux.intel.com>
References: <a38625a058afb93ca629e300124cfc07a0bc43fa.1645462092.git.pabeni@redhat.com> <5eea9634-7238-5dec-80e2-043d3cdead50@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Feb 2022, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 21/02/2022 17:54, Paolo Abeni wrote:
>> When the self-tests flushed the subflows on both sides of
>> the MPTCP connections, the number of subflows actually deleted
>> on each side is unreliable.
>>
>> The test code always flushes  first the client side, but the
>> actual delete operations is performed asynchronously, and one
>> on more subflows could be processed after that the other end
>> already deleted it.
>>
>> The grand total of the deleted subflows is expected to be
>> in the [nr_subflows: 2* nr_subflows] range.
>>
>> Address the issue checking the total number of deleted subflows
>> in the simult flush cases and enforcing the above constraint
>
> Thank you for the update!
>
> It is now in our tree, I hope that's OK for you Mat!
>

Yes, thanks for applying!


--
Mat Martineau
Intel
