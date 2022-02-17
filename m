Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031B38D1
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645057070; x=1676593070;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1ymPaUf0waYNqfRXogzpt4PxfRKxM9lT1Aznz3MZKAM=;
  b=KK210XIRf9IM0HUOeUHY2qhhieojmJZlcSzgWPXFhNGKigiRbbOGcAn0
   aDoai0lR7Nbm05Goy2+sBAue5hnNdLG8QJ4g7ok8a2avpHOvkP08/YomB
   0zRcbMs2DNyqm4dPB734znoPuMiF/UhnFzJiNhDANrMbfj8P4OLcsZKnk
   12NizICb4WuMg+2zJn+IqVZYU10vIYyJZns1vN1KmMYiHRR7utOo/4mFu
   RuErTM/rXGkef1HXcgjs8KBKgO7tDlJlhkpskILvTVMeW6CCL4UrHY8FP
   AQxvP9Jr90gah/jyjYrKfCbuMmvaylOfu66uKj14y0J590vxP8OUa4rbi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231377715"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="231377715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:17:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="704525462"
Received: from hasaeed-mobl.amr.corp.intel.com ([10.209.58.207])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:17:49 -0800
Date: Wed, 16 Feb 2022 16:17:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: update output info of
 chk_rm_nr
In-Reply-To: <ea86b05ef31336262889bbb02a0da28e40f86907.1644979837.git.geliang.tang@suse.com>
Message-ID: <781c6678-5a6e-5253-acb8-39899068cee2@linux.intel.com>
References: <ea86b05ef31336262889bbb02a0da28e40f86907.1644979837.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 16 Feb 2022, Geliang Tang wrote:

> This patch updated the output info of chk_rm_nr. Renamed 'sf' to 'rmsf',
> which means 'remove subflow'. Added the display of whether the inverted
> namespaces has been used to check the mib counters.
>
> The new output looks like this:
>
> 002 remove multiple subflows          syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       rm [ ok ] - rmsf  [ ok ]
> 003 remove single address             syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ]
>                                       rm [ ok ] - rmsf  [ ok ]   invert
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c664565aa8b1..37b3d00b2dcb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1242,15 +1242,14 @@ chk_rm_nr()
> 	local invert=${3:-""}
> 	local count
> 	local dump_stats
> -	local addr_ns
> -	local subflow_ns
> +	local addr_ns=$ns1
> +	local subflow_ns=$ns2
> +	local extra_msg=""
>
> -	if [ -z $invert ]; then
> -		addr_ns=$ns1
> -		subflow_ns=$ns2
> -	elif [ $invert = "invert" ]; then
> +	if [[ $invert = "invert" ]]; then
> 		addr_ns=$ns2
> 		subflow_ns=$ns1
> +		extra_msg="   invert"
> 	fi
>
> 	printf "%-${nr_blank}s %s" " " "rm "
> @@ -1264,7 +1263,7 @@ chk_rm_nr()
> 		echo -n "[ ok ]"
> 	fi
>
> -	echo -n " - sf    "
> +	echo -n " - rmsf  "
> 	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$rm_subflow_nr" ]; then
> @@ -1272,9 +1271,11 @@ chk_rm_nr()
> 		ret=1
> 		dump_stats=1
> 	else
> -		echo "[ ok ]"
> +		echo -n "[ ok ]"
> 	fi
>
> +	echo "$extra_msg"

If the 'if' statement above went down the [fail] path, this will output 
either an extra empty line or "   invert" on its own line. But the output 
formatting gets messy with failures anyway so it's not a big deal (also 
happens in chk_rst_nr()), and it's still clear where the failure was.

Reviewed by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> +
> 	[ "${dump_stats}" = 1 ] && dump_stats
> }
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
