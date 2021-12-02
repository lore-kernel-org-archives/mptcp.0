Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF22C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:52:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="217450041"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="217450041"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:52:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="477988883"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.65.201])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:52:26 -0800
Date: Thu, 2 Dec 2021 09:52:20 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: check IP_TOS
 in/out are the same"
In-Reply-To: <20211202173216.2982478-1-matthieu.baerts@tessares.net>
Message-ID: <825d1f7f-26d4-fd53-f1-198aa0c7da87@linux.intel.com>
References: <20211202173216.2982478-1-matthieu.baerts@tessares.net>
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
>  gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include    mptcp_sockopt.c  -o tools/testing/selftests/net/mptcp/mptcp_sockopt
>  mptcp_sockopt.c: In function 'init_rng':
>  mptcp_sockopt.c:695:9: warning: ignoring return value of 'read', declared with attribute warn_unused_result [-Wunused-result]
>    695 |   (void)read(fd, &foo, sizeof(foo));
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It seems adding "(void)" is not enough. As a workaround, we can also
> simply the output of 'read()'.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    to be squashed in "selftests: mptcp: check IP_TOS in/out are the same"
>

Looks good to squash, thanks.

-Mat

> tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index 5b87e162e704..ac9a4d9c1764 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -690,9 +690,11 @@ static void init_rng(void)
>
> 	if (fd >= 0) {
> 		unsigned int foo;
> +		ssize_t ret;
>
> 		/* can't fail */
> -		(void)read(fd, &foo, sizeof(foo));
> +		ret = read(fd, &foo, sizeof(foo));
> +		assert(ret == sizeof(foo));
>
> 		close(fd);
> 		srand(foo);
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
