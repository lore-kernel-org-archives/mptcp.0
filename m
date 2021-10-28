Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B92C83
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 00:50:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="229048610"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="229048610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 17:50:25 -0700
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="537779647"
Received: from rasanto1-mobl.amr.corp.intel.com ([10.212.200.198])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 17:50:23 -0700
Date: Wed, 27 Oct 2021 17:50:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Poorva Sonparote <psonparo@redhat.com>
cc: mptcp@lists.linux.dev, matthieu.baerts@tessares.net
Subject: Re: [PATCH mptcp-next v4 0/2] Splitting commits for IP_TOS support
 in setsockopt()
In-Reply-To: <cover.1635367735.git.psonparo@redhat.com>
Message-ID: <119548f6-ee97-48c3-ccf9-3ce623371c58@linux.intel.com>
References: <cover.1635367735.git.psonparo@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 27 Oct 2021, Poorva Sonparote wrote:

> - patch 1/2 Add Support for IP_TOS for MPTCP setsockopt()
> - patch 2/2 Exposing  __ip_sock_set_tos() in ip.h
>
> Poorva Sonparote (2):
>  Exposing __ip_sock_set_tos() in ip.h
>  Support for IP_TOS for MPTCP setsockopt()
>
> include/net/ip.h       |  1 +
> net/ipv4/ip_sockglue.c |  2 +-
> net/mptcp/sockopt.c    | 40 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 42 insertions(+), 1 deletion(-)
>
> -- 
> 2.18.2

Hi Poorva -

Thanks! Looks like this is ready for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


It's not necessary to use getsockopt to implement a test for this, you 
could also use 'ss --tos' to see the tos value on the mptcp socket and the 
subflows. Would be good to have a selftest for this before upstreaming.


--
Mat Martineau
Intel
