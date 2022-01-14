Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B56173
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 22:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642199188; x=1673735188;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dOrDXVCqfLp/4cy+QBgL5kZ6YjV/fgXB3Ho+FRNrBE0=;
  b=mBMfd4ibqHdiOlRbG/WOigy/gfAvS1lqT0/yTUenErQ8hsa2o7RDLhR9
   UCiYzOhWnZM7o6dOz0LQRjunYcxPamQEP3BiUJkqOUcuSxQpHROyDM4oT
   S6aSzprocZtYI59H++mo2ZlbR9Q0agyHRUI/7aX7y8vpXQZu0cP474dKj
   P9DscKs178oKxNwwBqR8CDv04Tn7SkMkBtnviVy2gCatMoLnhuSiiYxeU
   sHUtSPQJJh1SQKiH44KE2sewPbYNn5jrkv33W5SLPHcoaFQFfUQUvXepl
   74x2qS9cPtYS6GR0soi6IpN0uaogFnQHrzMJqG41aOJoS7TOC1VmUOhf6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="225026522"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="225026522"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:26:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="559631305"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:26:27 -0800
Date: Fri, 14 Jan 2022 14:26:27 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 08/21] mptcp: attempt to add listening
 sockets for announced addrs
In-Reply-To: <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
Message-ID: <811f18a3-2d3-e644-d4be-542ff83c7ac5@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>  <20220112221523.1829397-9-kishen.maloor@intel.com> <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Jan 2022, Paolo Abeni wrote:

...

> It will help reviewing, splitting this series in at least 2 chunks:
> * pre-reqs up to ~this patch
> * user-space PM specific stuff
>

Seems like the way to go here is to split patches 1-6 into another series, 
and have patch 7 as a standalone (or separate series w/ selftest) for 
mptcp-net.

--
Mat Martineau
Intel
