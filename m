Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76829CA
	for <mptcp@lists.linux.dev>; Fri, 28 May 2021 00:19:52 +0000 (UTC)
IronPort-SDR: hZJWEHN5vmkkaies7gNCRVcjYeHN09IdKnqp6y/yzBYo3vJWv3K3nlnUidcj45TznFBF33fKj3
 ognwQusQjkaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288455725"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="288455725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:19:51 -0700
IronPort-SDR: gkKIZbE2VX5OFN3qkBEAgjA72tc0WDclsEIkSvi9a9tphOjoE2tZWrbDJ+5NjTG458rnK82f9S
 bkmS9eP+Te4g==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="634178381"
Received: from mkronenb-mobl.amr.corp.intel.com ([10.209.5.218])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:19:50 -0700
Date: Thu, 27 May 2021 17:19:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: some smaller cleanup
In-Reply-To: <cover.1622132917.git.pabeni@redhat.com>
Message-ID: <bd916e46-d260-c2bb-39ae-3e2646fdcc@linux.intel.com>
References: <cover.1622132917.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 27 May 2021, Paolo Abeni wrote:

> This are 2 smallish pre-req for the RX path refactor.
>
> I think they can live of their own merit, so sending them
> out now.
>
> Paolo Abeni (2):
>  mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
>  mptcp: drop rendundant test in move_skbs_to_msk()
>
> net/mptcp/protocol.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
>
> -- 
> 2.26.3

Series looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
