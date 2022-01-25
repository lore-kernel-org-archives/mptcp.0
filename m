Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD4173
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643074758; x=1674610758;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hSO/ma29ylfFehyErLnvX4UeBMfTWR2eA7sr3aVvNNk=;
  b=SQzEi59gA5jKhUwnCWJO/+ian9NKBUk6T9xVjvWQMZnQ+e8WwfM5G12C
   HNSq1gM5s+R93GukUbEM8v40gC5LK3qYH2OlGcFOnntDjccSSp04d2A+4
   imdn1+t+fRNpjN6Nh08E2Dlq3Ig2O5f2eiYs6WQeggIirPPDFRDWZZ3Nt
   reKxSqrVMzGMHxXTEF4WxbdV4VvE0l7GQ/+uiqRLGNVfcPBk8TuA4xaae
   E3AHLPemUwq5GKRi0qWHVztwUxprRJZRivxqR/aBUEHiis9KJPRCnj0TD
   73PMUm9Kdv62/cExWd5AH2oXwWTh6UhPZNys7uF0GYU4MKQBO6EOAJYPV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245974623"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245974623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:39:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534508111"
Received: from nchakrav-mobl1.amr.corp.intel.com ([10.209.84.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:39:17 -0800
Date: Mon, 24 Jan 2022 17:39:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add the id
 argument for set_flags"
In-Reply-To: <6e5475ee60365df2beb2c919eb3eb7a6d87b6a74.1642990037.git.geliang.tang@suse.com>
Message-ID: <6f3e87d-1335-dd36-6dff-72602c262032@linux.intel.com>
References: <6e5475ee60365df2beb2c919eb3eb7a6d87b6a74.1642990037.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 24 Jan 2022, Geliang Tang wrote:

> Update the usage of set_flags.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>    set [<ip>] [id <nr>] flags [[no]backup|[no]fullmesh] [port <nr>]
> ->
>    set [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]
> ---
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index e554928487f8..22a5ec1e128e 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -28,8 +28,7 @@ static void syntax(char *argv[])
> 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
> 	fprintf(stderr, "\tdel <id> [<ip>]\n");
> 	fprintf(stderr, "\tget <id>\n");
> -	fprintf(stderr, "\tset [<ip>] [id <nr>] [flags backup|nobackup|fullmesh|nofullmesh]\n");
> -	fprintf(stderr, "\t                                                     [port <nr>]\n");
> +	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]\n");
> 	fprintf(stderr, "\tflush\n");
> 	fprintf(stderr, "\tdump\n");
> 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
> -- 
> 2.31.1

Thanks Geliang, you can roll this in with v3 of the "add the id argument 
for set_flags" series.

--
Mat Martineau
Intel
