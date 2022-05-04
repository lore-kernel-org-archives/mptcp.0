Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8DC33E0
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701959; x=1683237959;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wjl5CUBGON7BL43KS5pqq+KeTvR1Ilqkh6+3zbaW7OM=;
  b=RqMM6Orw7QIRdQ5HQ0aZ2j7EZZauOOZKMyG5vMXU3KJGpsencScVc2Rh
   oo9p7MHTfzo7A7oEkxq/6wgqzVbxZNeS5+TSWOreLy/mgbGIM6MLIuf2w
   JITTSHyFsJZAWeDaUJf14eTxAQ4mvGxpD+I6MB3/Y48JkMqxYHkCBRRP5
   s37coXBIsogZ3hO4c9J6qzZCd7B37NRSHhvY4FrpX0Ch8E1ko7qjC9Es+
   uN3olOBxsb3G3R1DvSCi23/xlfjiiMTPTREW9XAeFZ3kY4mCPKiJ1ZI4S
   PgTNakzPgvYYI9Bprpx41QpI+joyb8Fa6nk0fYr3EgQC74/miVCCOY20U
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255382818"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="255382818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:05:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621005205"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:05:47 -0700
Date: Wed, 4 May 2022 15:05:45 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    edumazet@google.com, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/5] mptcp: Improve MPTCP-level window
 tracking
In-Reply-To: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
Message-ID: <73fb3f63-c10-2c9c-91a0-3567a838512@linux.intel.com>
References: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Wed, 4 May 2022, Mat Martineau wrote:

> This series improves MPTCP receive window compliance with RFC 8684 and
> helps increase throughput on high-speed links. Note that patch 3 makes a
> change in tcp_output.c
>
> For the details, Paolo says:
>
> I've been chasing bad/unstable performance with multiple subflows
> on very high speed links.
>
> It looks like the root cause is due to the current mptcp-level
> congestion window handling. There are apparently a few different
> sub-issues:
>
> - the rcv_wnd is not effectively shared on the tx side, as each
>  subflow takes in account only the value received by the underlaying
>  TCP connection. This is addressed in patch 1/4

I missed a couple of small edits - this should be "patch 1/5"...

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
> on the wire, see patch 4/5.
>
> - The offered window right edge tracking can happen concurrently on
>  multiple subflows, but there is no mutex protection. We need an
>  additional atomic operation - still patch 3/4

...and this "patch 4/5".

- Mat

>
> This series additionally bumps a few new MIBs to track all the above
> (ensure/observe that the suspected races actually take place).
>
> I could not access again the host where the issue was so
> noticeable, still in the current setup the tput changes from
> [6-18] Gbps to 19Gbps very stable.
>
>
> Paolo Abeni (5):
>  mptcp: really share subflow snd_wnd
>  mptcp: add mib for xmit window sharing
>  tcp: allow MPTCP to update the announced window
>  mptcp: never shrink offered window
>  mptcp: add more offered MIBs counter
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
>
> base-commit: a37f37a2e7f5ea3ae2a1278f552aa21a8e32c221
> -- 
> 2.36.0
>
>

--
Mat Martineau
Intel
