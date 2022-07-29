Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E034C77
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659118065; x=1690654065;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZG+6BHHLKqMsa1VYL5OYM9osm4fwtekpRnPo7Q/C7Ko=;
  b=N1OpRxq19MNpeEH8sm43K2PPAWE0qqijThphgQywuY/T1D34OWYTh8hO
   5fNl/XkboYOg8xn2zQWAX3VblTgZq4G00axmO/tLFxjz/3WDDOWbokSG0
   G2DDyDOnc18rOVaMPcKrr/C6x7H1ZkourZoTBaXL/UC9t16Yn4gwUoAf/
   0726IkjPG5mpLR4QFU3tWtR1H6QJd+Icamimt1V85CxD6JQbjX0yWIHJC
   MGj0BTFrr8Ge3eSkPKNInv4PqfIN9tLDGgwKRz0bx+NO2mP71Cvy7TD3q
   jHr4ZxC3pjW/uPOvn45anDGrypsRjMo5kc+mZTBjtavNkf/xqBtY6sicc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="275706221"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="275706221"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 11:07:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="690806887"
Received: from jmborger-mobl.amr.corp.intel.com ([10.209.59.73])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 11:07:44 -0700
Date: Fri, 29 Jul 2022 11:07:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev, matthieu.baerts@tessares.net, 
    Paolo Abeni <pabeni@redhat.com>, Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH v2 mptcp] selftests: mptcp: make sendfile selftest work
In-Reply-To: <20220729095550.3040-1-fw@strlen.de>
Message-ID: <7ff00ad-80b5-8ab-6544-fdfaefd43f0@linux.intel.com>
References: <20220729095550.3040-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Jul 2022, Florian Westphal wrote:

> When the selftest got added, sendfile() on mptcp sockets returned
> -EOPNOTSUPP, so running 'mptcp_connect.sh -m sendfile' failed
> immediately.
>
> This is no longer the case, but the script fails anyway due to timeout.
> Let the receiver know once the sender has sent all data, just like
> with '-m mmap' mode.
>
> v2: need to respect cfg_wait too, as pm_userspace.sh relied
> on -m sendfile to keep the connection open (Mat Martineau)
>
> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Looks good to me, tests run fine on my system. I tried to reproduce the 
failures that CI reported on the non-debug build but so far it doesn't 
look like this change caused those failures.

With the Fixes: tag I assume this is intended for -net?

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 26 ++++++++++++-------
> 1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index e2ea6c126c99..24d4e9cb617e 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -553,6 +553,18 @@ static void set_nonblock(int fd, bool nonblock)
> 		fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
> }
>
> +static void shut_wr(int fd)
> +{
> +	/* Close our write side, ev. give some time
> +	 * for address notification and/or checking
> +	 * the current status
> +	 */
> +	if (cfg_wait)
> +		usleep(cfg_wait);
> +
> +	shutdown(fd, SHUT_WR);
> +}
> +
> static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
> {
> 	struct pollfd fds = {
> @@ -630,14 +642,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
> 					/* ... and peer also closed already */
> 					break;
>
> -				/* ... but we still receive.
> -				 * Close our write side, ev. give some time
> -				 * for address notification and/or checking
> -				 * the current status
> -				 */
> -				if (cfg_wait)
> -					usleep(cfg_wait);
> -				shutdown(peerfd, SHUT_WR);
> +				shut_wr(peerfd);
> 			} else {
> 				if (errno == EINTR)
> 					continue;
> @@ -767,7 +772,7 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
> 		if (err)
> 			return err;
>
> -		shutdown(peerfd, SHUT_WR);
> +		shut_wr(peerfd);
>
> 		err = do_recvfile(peerfd, outfd);
> 		*in_closed_after_out = true;
> @@ -791,6 +796,9 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
> 		err = do_sendfile(infd, peerfd, size);
> 		if (err)
> 			return err;
> +
> +		shut_wr(peerfd);
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
