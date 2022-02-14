Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C52C8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644872119; x=1676408119;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xr/Q2vrESXeEZFSysSfoGPfr0WQuOFPXjx937YsRAKc=;
  b=XkANgiobe4hEkMQ5bbrMUqOc4SR7OfsuJ+4cHQ0+GtQ0rtH/7Pvad/h1
   LK/D/wE83qYcuifNea+GhUp4kXUNaETiuu0gYYC2Sk7rYz5lG1PjomJRJ
   n5bJIk+td2dOA3XL6Ilk4YYHx2GpzxbiNaa1/jcEn6Hm0pBdPDQikuR4D
   YfRhHV9LRyBveancBNGk10zkCbMwxwO+es8G+N8ifsBwGxZ84qZAcVpSK
   O/YFYCgiewtcqtlauRP8FKlRpreucpJH2vRIgveyNnpEFh2o3etSlsA0E
   269jkX7Oh3ivNB5M6vOyI3GlBstQMu6uuGgYWoatHQkIFbBhg3LmcYGlC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230146811"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230146811"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:55:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="624438197"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:55:19 -0800
Date: Mon, 14 Feb 2022 12:55:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Alex Maydanik <alexander.maydanik@gmail.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: net: fix documentation for kernel_getsockname: Build Failure
In-Reply-To: <181e1207-aa3f-a5c6-d564-e3edae4dd807@gmail.com>
Message-ID: <ccc29a1e-b131-dee2-4c5a-9edd90ce4422@linux.intel.com>
References: <20220212102927.25436-1-alexander.maydanik@gmail.com> <181e1207-aa3f-a5c6-d564-e3edae4dd807@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Feb 2022, MPTCP CI wrote:

> Hi Alex,
>
> Thank you for your modifications, that's great!
>
> But sadly, our CI spotted some issues with it when trying to build it.
>
> You can find more details there:
>
>  https://patchwork.kernel.org/project/mptcp/patch/20220212102927.25436-1-alexander.maydanik@gmail.com/
>  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843188936
>
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ec18713d1f5d
>

Alex,

Sorry about the unexpected email from our CI system. It appears there was
an issue with patchew.org that somehow applied and tagged your patch in
our github repo even though you didn't send to our mailing list.

--
Mat Martineau
Intel
