Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A46AB4
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656531418; x=1688067418;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PpgZH9HeAZEe+nl6PphJAiGEmojgSG2TlUd/sLV2ogw=;
  b=e7IHlsnS5iGg/xwWRfENDdTp3D8AlkgF7cLjWoHrhM6Tj1VvKjcKfM7e
   TKMoCrGTo7ZNQyRpcc1BMCLuRi8X0wAG0dlzKc3ds/DNP4zN6sHGH0/p1
   vQ6SM07NVB4t/a9P8x4m8jL75wYUeAuYhMtD+AK2TVJe8KVdVb7dS7VwZ
   fj9eN2l9T0bRRQzRaZCd+Mm+1ZnSHiBVyKhRpTq8hqoH1kEmSX2IkOgE2
   dVvN5C1r9VQKQxVa718/bSBZYxoZo2n855Gbl0jslkJvxwMKELnnD09GH
   h4A9B3RY5mTqcNDRZzjGDMJ/EhB1wSfQQ6nqqTx9SLCaJUUY694Ej/16X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="261933085"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="261933085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:13:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="540965459"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:13:52 -0700
Date: Wed, 29 Jun 2022 12:13:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
    mptcp@lists.linux.dev
Subject: Re: Should the MIB_RMSUBFLOW commit go to -net?
In-Reply-To: <c2dbb9d3-47a2-aebf-e133-15d6d3c12d0d@tessares.net>
Message-ID: <ad2f349e-68fe-6993-155b-c64e96e09fa9@linux.intel.com>
References: <ad151d35-f094-675d-5ced-71df98ea5857@linux.intel.com> <437af8add242099c84cf106108ab4988a65010ff.camel@redhat.com> <c2dbb9d3-47a2-aebf-e133-15d6d3c12d0d@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 24 Jun 2022, Matthieu Baerts wrote:

> Hi Mat, Paolo,
>
> On 24/06/2022 10:40, Paolo Abeni wrote:
>> On Thu, 2022-06-23 at 16:19 -0700, Mat Martineau wrote:
>>> I was preparing the patches we had agreed to be ready for net-next in the
>>> meeting today:
>>>
>>>          - [f1eb3f2cb4d2] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy (Geliang Tang)
>>>          - [f3c5dde10031] selftests: mptcp: userspace pm address tests (Geliang Tang)
>>>          - [92378ff55152] selftests: mptcp: userspace pm subflow tests (Geliang Tang)
>>>          - [1908a4ccaa2c] selftests: mptcp: avoid Terminated messages in userspace_pm (Geliang Tang)
>>>          - [bac5548c7c47] selftests: mptcp: update pm_nl_ctl usage header (Geliang Tang)
>>>
>>> I think the selftest commits are definitely best for net-next. But for the
>>> first one ("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy"), should we add
>>>
>>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
>>>
>>> and include that in a patch set for -net? Seems like it would be good to
>>> improve the MIB accuracy with the userspace PM in 5.19.
>>>
>>> Link to commit in patchwork:
>>> https://patchwork.kernel.org/project/mptcp/patch/723d61d82730b996132925686b43f9c3c79bc747.1655355422.git.geliang.tang@suse.com/
>>>
>>>
>>> If that patch goes to -net, it would also require waiting until the next
>>> net/net-next sync before sending the selftest patches listed above.
>>
>> I would vote for keeping the process simple and keeping all the above
>> patches on net-next.
>>
>> If we choose otherwise, I think we should also update a bit the
>> ("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy") commit message to
>> something more tuned for -net. Alike: "The user-space patch manager
>> currently miss the required update of the subflow destruction MIB,
>> address the issue "...
>
> I think all commits fixing something should have the "Fixes" tag and
> target "-net". That's not a must of course depending on the complexity
> and what the fix implies. This should simplify stable versions
> maintenance somehow if we know all fixes are explicitly linked to a
> feature: the stable team can do the backport if they think it makes
> sense to do that. We can also avoid messages like: ah yes, in v5.19,
> don't look at this MIB counter, it is not correct but that's fixed later
> in vX.Y.
>
> But I understand the issue with the sync of -net and net-next.
> Could it help to send the conflicting patch in both -net and net-next?
> 'git merge' might understand the same modification has been done on both
> side.
>
> Or explain in the commit message/cover letter there is a conflict with
> -net and the fix is not urgent?
>

I think it will be best to send it to -net with a modified commit message 
like Paolo suggests. The net/net-next sync shouldn't be a problem since 
we're at 5.19-rc4 and the dependent selftest fixes are not super urgent 
for net-next.

This patch to pm_userspace.c also fits in with the one pending commit in 
export-net and the 5 -net patches in patchwork.

--
Mat Martineau
Intel
