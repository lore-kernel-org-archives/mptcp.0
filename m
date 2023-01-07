Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34110E5
	for <mptcp@lists.linux.dev>; Sat,  7 Jan 2023 01:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673056430; x=1704592430;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tAN3tG4klx6uJOaNR1i4Z8z0U0sej1LXSMPML+feWLA=;
  b=WjcNOOA2hPFyXlIlrwTaPP9c1BfChOL966RH/pqQfmkSuHHalQSc7xDI
   AMfOm629vuUwmFndpQL1uJ+aHINi4EVO0kljWPYW4uWexsNIAz2N8jLyA
   X2Raq4B/T+pXC3CUJDOqD1QA25WLSIu9oAAmzAVP1Jdwd9mA0R9f5e8Ym
   dSHeDaOCs69/O3FoFXRyD5FITrr6S6yUwYhWG9Kg0sJ5HqXza3RV2lX/g
   ToLiA7EwUc70zAqqIQVIsqYTwWNmT5ak5c3bRcu5Kq4FtPFuAL87Nqrr9
   HwUAKVgTxcf52LWlBRzEBq2EHR6unjkErKWojV/6tnFYGZKmaEhTdlzNr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="302299631"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="302299631"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:53:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="656115355"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="656115355"
Received: from rkoganti-mobl.amr.corp.intel.com ([10.209.28.230])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:53:48 -0800
Date: Fri, 6 Jan 2023 17:53:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
cc: matthieu.baerts@tessares.net, pabeni@redhat.com, mptcp@lists.linux.dev
Subject: Re: [PATCH 5.15 0/2] mptcp: use proper req destructor for IPv6
In-Reply-To: <20230107011959.448249-1-mathew.j.martineau@linux.intel.com>
Message-ID: <eac12f5d-303a-8318-cc75-4e0870174a9d@linux.intel.com>
References: <20230107011959.448249-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 6 Jan 2023, Mat Martineau wrote:

> Greg -
>
> Here are backports of two MPTCP patches that recently failed to apply to
> the 5.15 stable tree. Two prerequisite patches are already queued in
> 5.15.87-rc1:
>
>  mptcp: mark ops structures as ro_after_init
>  mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
>
> These patches prevent IPv6 memory leaks with MPTCP.
>

Sorry about the cut & paste error on the cover letter subject line, was 
supposed to be "v5.15 stable backports for MPTCP request sock fixes".


--
Mat Martineau
Intel
