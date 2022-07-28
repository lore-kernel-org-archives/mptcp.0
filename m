Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B377A
	for <mptcp@lists.linux.dev>; Thu, 28 Jul 2022 22:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659048957; x=1690584957;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eiJ6ah3eXrYz3OuEc/CGDCNqqZEp6A81hP3kV+t2Hdg=;
  b=mbRrXsgqphJUFzsht9ZwMc3R7B2+I/blAhYrUZCdIv/Mb93YrUrgq89k
   b7io/ntd7tFkg8Qqq1S4Zlel+ct5A+6sNKRE6lX9ZQqbnZZ245lyvNIxD
   Rqh6V5ZS5Gsq4B9HgB05bHrp4micp4NGVt+J3mtdPcH+/z0rdCtLRUodS
   1n9kTlnAANWxKUn55PBYdxhRo9cGuGyH0phaBmoCpBpTLRk/qBBUBQzPB
   ZEVqye/vqfSahFgy+V9DsdNa7qOnKWtuWarLmjNvt3QW5VbrhfBgu9uDl
   l5KKM/vmD8ujWENDQRaDhLjLWhQrtm0hAA1fszYzDikpy+A1ITwas1AOf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="275527849"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="275527849"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 15:55:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="703988726"
Received: from jjois-mobl1.amr.corp.intel.com ([10.209.56.209])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 15:55:51 -0700
Date: Thu, 28 Jul 2022 15:55:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>
Subject: Re: [PATCH mptcp] selftests: mptcp: make sendfile selftest work
In-Reply-To: <20220728182544.4128-1-fw@strlen.de>
Message-ID: <1067d82c-2147-4541-c34a-462fecba42d@linux.intel.com>
References: <20220728182544.4128-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 28 Jul 2022, Florian Westphal wrote:

> When the selftest got added, sendfile() on mptcp sockets returned
> -EOPNOTSUPP, so running 'mptcp_connect.sh -m sendfile' failed
> immediately.
>
> This is no longer the case, but the script fails anyway due to timeout.
> Let the receiver know once the sender has sent all data, just like
> with '-m mmap' mode.
>

Hi Florian -

I could duplicate the timeout, and confirm that this patch fixes the 
behavior for 'mptcp_connect.sh -m sendfile'.

Unfortunately it breaks userspace_pm.sh, which also uses the mptcp_connect 
binary and deliberately keeps the connection open. userspace_pm.sh uses 
the '-w' flag with sendfile, though. See below.

> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index e2ea6c126c99..6e429b88f911 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -791,6 +791,9 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
> 		err = do_sendfile(infd, peerfd, size);
> 		if (err)
> 			return err;
> +

Adding

 		if (cfg_wait)
 			usleep(cfg_wait);

here (matching with what's in copyfd_io_poll()) seems to keep both 
userspace_pm.sh and 'mptcp_connect.sh -m sendfile' happy. copyfd_io_mmap() 
could probably use the usleep() call too.


Thanks,
Mat

> +		shutdown(peerfd, SHUT_WR);
> +
> 		err = do_recvfile(peerfd, outfd);
> 		*in_closed_after_out = true;
> 	}
> -- 
> 2.35.1
>
>

--
Mat Martineau
Intel
