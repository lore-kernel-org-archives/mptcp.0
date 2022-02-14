Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19024C8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644872507; x=1676408507;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IhAvsnhJIa4C8vlcx/E8tIGvwYMkhXgvoG0+4TW3rlU=;
  b=kUD7S/r5FsWlfN0PA68h9+rqXusspKNhOkTwmaIlwQoHiRDwNYabveUy
   w3rkVpb1FS5qr3/m0+L9DO4Q41H9iqlWttIIujVGkMv+w1fHL01gtpbpK
   HQCy4R6O9WT1SHBaeNMoURz7pVmVlFbN6LD0USafcMmtokLxceL8JWMH4
   8evflm/p3W6XoUaRSrsGcQQeufwOb184YIAOZTzIvgzCgs6c1OEhUW9xX
   EBIgzNrWxgCkcm7+DdyPQ5HhmbjEqVbfyrnNh9TvvgErugwQ6rDOPn36m
   IZI2kaowqDqbfOxWabo12hv9dDEXg4+t30KMLIyrmMX5ptLj+S2BuJsr/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230821880"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230821880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:01:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="570462892"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:01:46 -0800
Date: Mon, 14 Feb 2022 13:01:46 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: mips: Enable KCSAN: Build Failure
In-Reply-To: <1e9f47b3-3025-a126-996a-c23086225641@gmail.com>
Message-ID: <145e3987-bbee-d9fa-ef85-d8cdc185f020@linux.intel.com>
References: <20220211162142.2402-1-nemanja.rakovic@syrmia.com> <1e9f47b3-3025-a126-996a-c23086225641@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Feb 2022, MPTCP CI wrote:

> Hi Nemanja,
>
> Thank you for your modifications, that's great!
>
> But sadly, our CI spotted some issues with it when trying to build it.
>
> You can find more details there:
>
>  https://patchwork.kernel.org/project/mptcp/patch/20220211162142.2402-1-nemanja.rakovic@syrmia.com/
>  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843234131
>
> Status: cancelled
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6b8a96a1f02e
>

Nemanja,

Sorry about the unexpected email from our CI system. It appears there was
an issue with patchew.org that somehow applied and tagged your patch in
our github repo even though you didn't send to our mailing list.


--
Mat Martineau
Intel
