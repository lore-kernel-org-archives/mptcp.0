Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A231C00
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655849722; x=1687385722;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y9RC/3jFibE9CST7c1lZOfvcGanyxKRJFwfVNnK2SW0=;
  b=LtqXuo596q/ErYhp9OA60LHyrZSBHRFVzyDJnyomoAz5cHbZVwVOG6FV
   blC4/wwXo93IbJIqgjKOGxLMdBM0db52Hwz/SIVFNIteE4wKDHMa22sDa
   Lh3/cLd+dLq8v8Batj1zlQybhq1/Bczos9e2v2GF9tVUvIOHJgmcJoW6G
   oHvgMGly83eJY0nEL05rfmx/OUNfH9lU4/hMvoOfD/jaGYk88Zw55j06m
   qOkP827NfiUi2CVzj04tLiI9edqkCNaRW960vwCbvQf36lQl3PGtpWAta
   hjyyH9P9DkiWBuT8BYGA7dpHRUijRQSBkIyhgQ06HqBqQINiihoEEGSfM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277800626"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="277800626"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:15:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="730032684"
Received: from vanehosx-mobl.gar.corp.intel.com ([10.251.13.241])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:15:09 -0700
Date: Tue, 21 Jun 2022 15:15:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: userspace pm
 address tests"
In-Reply-To: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
Message-ID: <eefc9148-f432-5941-261b-8b474fcb1472@linux.intel.com>
References: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Jun 2022, Geliang Tang wrote:

> Use kill_wait() helper as Mat suggested.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

In the rest of that thread, Matthieu and I discussed this being optional - 
but now that you've done the work, it's fine with me to squash these.

- Mat

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 977c59c540b2..d889e7507cd9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -455,6 +455,12 @@ wait_mpj()
> 	done
> }
>
> +kill_wait()
> +{
> +	kill $1 > /dev/null 2>&1
> +	wait $1 2>/dev/null
> +}
> +
> pm_nl_set_limits()
> {
> 	local ns=$1
> @@ -917,8 +923,7 @@ do_transfer()
> 	fi
>
> 	if [ $userspace_pm -eq 1 ]; then
> -		kill $evts_ns1_pid
> -		wait $evts_ns1_pid 2>/dev/null
> +		kill_wait $evts_ns1_pid
> 		rm -rf $evts_ns1
> 	fi
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
