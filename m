Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F82CA0
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:52:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="234269009"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="234269009"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:52:39 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="677751006"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.65.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:52:39 -0800
Date: Thu, 2 Dec 2021 09:52:38 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add inq test
 case"
In-Reply-To: <20211202173216.2982478-2-matthieu.baerts@tessares.net>
Message-ID: <87d35f49-695f-fba-3c1f-3c993fbbbf13@linux.intel.com>
References: <20211202173216.2982478-1-matthieu.baerts@tessares.net> <20211202173216.2982478-2-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 2 Dec 2021, Matthieu Baerts wrote:

> Fixing a -Wunused-result error:
>
>  $ make -C tools/testing/selftests/net/mptcp
>  (...)
>  $ gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include     mptcp_inq.c  -o tools/testing/selftests/net/mptcp/mptcp_inq
>  mptcp_inq.c: In function 'connect_one_server':
>  mptcp_inq.c:303:2: warning: ignoring return value of 'write', declared with attribute warn_unused_result [-Wunused-result]
>    303 |  write(fd, buf, 1);
>        |  ^~~~~~~~~~~~~~~~~
>
> It seems adding "(void)" is not enough. As a workaround, we can also
> simply the output of 'write()'.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    to be squashed in "selftests: mptcp: add inq test case"
>

Also ok to squash this one.

-Mat

> tools/testing/selftests/net/mptcp/mptcp_inq.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
> index 07670f649327..b8debd4fb5ed 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
> @@ -300,7 +300,8 @@ static void connect_one_server(int fd, int unixfd)
>
> 	wait_for_ack(fd, 5000, sent);
>
> -	write(fd, buf, 1);
> +	ret = write(fd, buf, 1);
> +	assert(ret == 1);
> 	close(fd);
> 	ret = write(unixfd, "closed", 6);
> 	assert(ret == 6);
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
