Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC3ED0
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 00:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644885470; x=1676421470;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kj5urDyhRguCxWSs8ak0ENA3T0wcqyoeq7cmfRV7MtU=;
  b=S1FJIZzZuqhSItAmtnusvH14QXOdWkqwqxFm9LOUaJmZJM8JeEXfFMO3
   2Kgb6PlCKxRWASjGyDb0xPYHTvzIw8zD40UEN+sLSpUVtuCZ07nLmD5Ck
   SGCrQgzpPQxdqUoA5nAKV3Bh/LQYF+MGxL9x6UGhTBf0YngTdv7f33aD0
   pqE94R0TgB5+SKnTdSoPea04dN6Q1mW29oxSnY4HAGPLOT0NEnA7UOhWi
   vx//qCWW0w3qy8J16VVOb1IMnPKTtHJwRBNNnlB3IftbICVNrOG1Mz2np
   23PlbUGuXYX405AhKlOheO8SnBzyyJtZ7+3U3qoz1uquDWvQGMEgqyBXP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247811991"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="247811991"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:37:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="635515655"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:37:49 -0800
Date: Mon, 14 Feb 2022 16:37:49 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add more arguments
 for chk_join_nr v7"
In-Reply-To: <5a8bc892093225da0667054819b6a5e280d73eee.1644631124.git.geliang.tang@suse.com>
Message-ID: <c2483d44-f66b-2b9-764-48a32447add3@linux.intel.com>
References: <5a8bc892093225da0667054819b6a5e280d73eee.1644631124.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 12 Feb 2022, Geliang Tang wrote:

> Allow multiple checksum errors.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 0b739785efd1..0e4a4c58f264 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -752,7 +752,8 @@ chk_csum_nr()
> 	printf " %-36s %s" "$msg" "sum"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != $csum_ns1 ]; then
> +	# allow multiple checksum errors
> +	if [ "$count" -lt $csum_ns1 ]; then

This breaks the other checksum tests - there are still tests where 
$csum_ns1 and $csum_ns2 default to 0 and the test should fail if $count > 
0.

> 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
> 		ret=1
> 		dump_stats=1
> @@ -762,7 +763,7 @@ chk_csum_nr()
> 	echo -n " - csum  "
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != $csum_ns2 ]; then
> +	if [ "$count" -lt $csum_ns2 ]; then
> 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
> 		ret=1
> 		dump_stats=1
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
