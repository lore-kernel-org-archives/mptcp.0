Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C558258B
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657127741; x=1688663741;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hirys4WHNeIVc8TqWyLD2CazkEei34db9l8Ads0k7jY=;
  b=LcV3LwMkE0sGf9KfVwJvKoNtS0ItrL38OchlyrTCyszI+7vuyRX98Qya
   EzrOycboXTZ30vDXUa/TitoEjYQ21vXQptqnSF9nOwbATAcstIxaJAui3
   8GPuYEwF8PSlaPTvsmrl6nMba6Us1NWrCyebA2LJbCS1xRrkcb8qIlKu2
   i/whZU254mL3R+wkUn9tHcX3nYfW19hJtdCWrSeDbjHSZJECiTvgt+UaI
   peXE8pTW1vLcvwg7vnx8nU9Og3MX89DQCXAutYPOvrrCLZCNtdAVPvfO7
   /WlzKNMLWmPdwYYtI5kd9nkgC37Qj9L20CQ/7wpDfp5Jt6JwqtaIok6Iv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="283841922"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="283841922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:15:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="543484822"
Received: from lerosale-mobl.amr.corp.intel.com ([10.209.34.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:15:40 -0700
Date: Wed, 6 Jul 2022 10:15:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix subflow traveral at disconnect
 time
In-Reply-To: <05928f87-fe08-2be9-0677-a9611138a088@tessares.net>
Message-ID: <60c93f68-7a-4d21-167d-8812fc651094@linux.intel.com>
References: <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com> <05928f87-fe08-2be9-0677-a9611138a088@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 6 Jul 2022, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 06/07/2022 13:18, Paolo Abeni wrote:
>> At disconnect time the MPTCP protocol traverse the subflows
>> list closing each of them. In some circumstances - MPJ subflow,
>> passive MPTCP socket, the latter operation can remove the
>> subflow from the list, invalidating the current iterator.
>>
>> Address the issue using the safe list traversing helper
>> variant.
>>
>> Reported-by: van fantasy <g1042620637@gmail.com>
>> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> I think this should go soon upstream, sending here to trigger the CI
>>
>> A pktdrill test will follow.
>
> Because the CI report was not fully green, I ran the full tests suite on
> my side (with and without a debug kernel) and I didn't spot any issues.
>
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> The patch looks good to me. If we can wait a bit, I guess it is better
> to wait for Mat to review it. But I don't mind applying now if needed.
>

Fine with me to apply it:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> Also, I think we should probably add a new macro on net-next:
>
>  mptcp_for_each_subflow_safe(msk, subflow, tmp)
>
> WDYT?

+1

--
Mat Martineau
Intel
