Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AA1C13
	for <mptcp@lists.linux.dev>; Thu, 27 Oct 2022 19:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666900679; x=1698436679;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lkgvo5v2gXVrsND8MuZWgSE+T2MYixcX/LM0N4Lyj6s=;
  b=S0CcHm3RyGyNyxmHHRO2y5NzKl7va8D2vXFCLGMNFZYADvThIhaszfiP
   J3JW7/oiaoNqjCgLOtyh4/qazo7tpMtxUNexrpu//vAlFtUNizI8jRFuL
   RtLuaUScHs3Wu3+cp+wiClr6kZ47739OkXpE9FXViY0dO3rygkuRLP55S
   0FRojWUpmISikadl+8uO/KTtfUFW0I+1w92N90ahZ99tMG3gePKPZEcVN
   SZKoAlJZ0f8KGCdd6GiwrB4GTlSD922gFniKgeKdfQCjzKERA0j7cIMqK
   gwl8F+XpY756tXe3uvSU0mJmelVLlZYlFqDju8pdsbOGJ0cpQLa3lmKuI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="334962364"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="334962364"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 12:57:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="695948372"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="695948372"
Received: from wayzkhan-mobl.amr.corp.intel.com ([10.212.240.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 12:57:58 -0700
Date: Thu, 27 Oct 2022 12:57:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: update userspace pm tests
In-Reply-To: <20221026124114.24816-1-geliang.tang@suse.com>
Message-ID: <415d4027-9ef5-ca7f-4875-322b6261f837@linux.intel.com>
References: <20221026124114.24816-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Oct 2022, Geliang Tang wrote:

> Some userspace pm tests failed since pm listener events have been added.
> Fix them.
>
> patch 3 in "add pm listener events" series.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

Could you also add some test coverage for the new listener events?


Thanks,

Mat


> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
> tools/testing/selftests/net/mptcp/userspace_pm.sh | 7 ++++---
> 2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f3dd5f2a0272..763246eb16cb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -829,7 +829,8 @@ do_transfer()
> 			if [ $userspace_pm -eq 0 ]; then
> 				pm_nl_add_endpoint $ns1 $addr flags signal
> 			else
> -				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
> +				tk=$(grep "type:1," "$evts_ns1" |
> +				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
> 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
> 				sleep 1
> 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 3229725b64b0..856ff26b6ef0 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -172,9 +172,10 @@ make_connection()
> 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
> 				      "$client_evts")
> 	kill_wait $server_evts_pid
> -	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
> -	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
> -				      "$server_evts")
> +	server_token=$(grep "type:1," "$server_evts" |
> +		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
> +	server_serverside=$(grep "type:1," "$server_evts" |
> +			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
> 	rm -f "$client_evts" "$server_evts" "$file"
>
> 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
