Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B146B6
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650585842; x=1682121842;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jlBr5zYyDEesZhjSWGHpayndIzP0Qlsf28JHXCiaGww=;
  b=DPdbBRJ49ro3s2ULwuDZL58HM7UqCtVom1ruqUU+B432UNUM2WayJqrS
   Ru0dSBe4+DGNaOh6W2HdaaiWDl+h1z+fftCbElNLxSwL1TWNLlOoxPb31
   hySG9/la4lBc8gGwvOQ+USeVXiFsYcGSAx5zEp78NekSRcn41Vkl33apW
   00l0KuD+GK9uwV0SU/hl29VK5vgieEfE/RkLYsqj8pXKwS1inDBEqS5Se
   aTmmQkWquw4XJ7kfuZ2VV5YxG03bxqNquq5UfEBHvYvVIsZwmherC1MpE
   OWiHEk5zB8/KpiI/nhFKH8iLTiLTZr8a1eKirbsp1jBU4SWLmVF/aJStt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264293022"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264293022"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="658753912"
Received: from dolaleye-mobl.amr.corp.intel.com ([10.209.117.155])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:04:01 -0700
Date: Thu, 21 Apr 2022 17:04:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 0/5] mptcp: improve mptcp-level window tracking
In-Reply-To: <cover.1650550242.git.pabeni@redhat.com>
Message-ID: <fae0eb5d-34ea-55f6-6bc8-035e4a6c7b3@linux.intel.com>
References: <cover.1650550242.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 21 Apr 2022, Paolo Abeni wrote:

> I've been chasing bad/unstable performances with multiple subflows
> on very high speed links.
>
> It looks like the root cause is due to the current mptcp-level
> congestion window handling. There are apparently a few different
> sub-issues:
>
> - the rcv_wnd is not effectively shared on the tx side, as each
>  subflow takes in account only the value received by the underlaying
>  TCP connection. This is addressed in patch 1/4
>
> - The mptcp-level offered wnd right edge is currently allowed to shrink.
>  Reading section 3.3.4.:
>
> """
>   The receive window is relative to the DATA_ACK.  As in TCP, a
>   receiver MUST NOT shrink the right edge of the receive window (i.e.,
>   DATA_ACK + receive window).  The receiver will use the data sequence
>   number to tell if a packet should be accepted at the connection
>   level.
> """
>
> I read the above as we need to reflect window right-edge tracking
> on the wire, see patch 3/4.
>
> - The offered window right edge tracking can happen concurrently on
>  multiple subflows, but there is no mutex protection. We need an
>  additional atomic operation - still patch 3/4
>
> This series additionally bump a few new MIBs to track all the above
> (ensure/observe that the suspected races actually take place).
>
> I could not access again the host where the issue was su much
> noticeable, still in the current setup the tput changes from
> [6-18] Gbps to 19Gbps very stable.
>
> v1 -> v2:
> - pass only the TCP header to tcp_options_write (Mat)
> - fix build issues on some 32 bit arches (intel bot)

v2 looks good for the export branch, thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> RFC -> v1:
> - added patch 3/5 to address Mat's comment, and rebased the
>   following on top of it - I hope Eric may tolerate that, it's
>   more an hope than guess ;)
>
> Paolo Abeni (5):
>  mptcp: really share subflow snd_wnd
>  mptcp: add mib for xmit window sharing
>  tcp: allow MPTCP to update the announced window.
>  mptcp: never shrink offered window
>  mptcp: add more offered MIBs counter.
>
> include/net/mptcp.h   |  2 +-
> net/ipv4/tcp_output.c | 14 ++++++-----
> net/mptcp/mib.c       |  4 +++
> net/mptcp/mib.h       |  6 +++++
> net/mptcp/options.c   | 58 +++++++++++++++++++++++++++++++++++++------
> net/mptcp/protocol.c  | 32 +++++++++++++++---------
> net/mptcp/protocol.h  |  2 +-
> 7 files changed, 90 insertions(+), 28 deletions(-)
>
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
