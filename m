Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6770
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 00:07:34 +0000 (UTC)
IronPort-SDR: +30wkv31jF1+Zjp+Cyu4LPFJBy0JNNYD8BBndR3SAbRQ/CMVmCmAVuyI8a1oc8kKf5zsTTXd4Y
 a8dUpkSU/Ghg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191522352"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="191522352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:07:30 -0700
IronPort-SDR: JCarBVCCWMqk/eqqGLwNEYFLfRPHYWHHcN6IB/YJzlevxEnZwLqI7Jw2msUTtk3uuwD7z7EKwn
 ERgodCicRylg==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="417574417"
Received: from jhe12-mobl.amr.corp.intel.com ([10.212.229.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:07:27 -0700
Date: Thu, 3 Jun 2021 17:07:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Subject: Re: [PATCH v2 mptcp-net] selftests: mptcp: enable syncookie only in
 absence of reorders
In-Reply-To: <1a2b1cda55fc38e2143aae3ebab3d9b4e5e5d53f.1622731728.git.pabeni@redhat.com>
Message-ID: <19795944-c6a6-b483-68b8-9774853ae56c@linux.intel.com>
References: <1a2b1cda55fc38e2143aae3ebab3d9b4e5e5d53f.1622731728.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 3 Jun 2021, Paolo Abeni wrote:

> Syncookie validation may fail for OoO packets, causing spurious
> resets and self-tests failures, so let's force syncookie only
> for tests iteration with no OoO.
>
> Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/198
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>

Looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 69351c3eb68c..2484fb6a9a8d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -202,9 +202,6 @@ ip -net "$ns4" link set ns4eth3 up
> ip -net "$ns4" route add default via 10.0.3.2
> ip -net "$ns4" route add default via dead:beef:3::2
>
> -# use TCP syn cookies, even if no flooding was detected.
> -ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
> -
> if $checksum; then
> 	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
> 		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
> @@ -748,6 +745,14 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
> 		exit $ret
> 	fi
>
> +	# ns1<->ns2 is not subject to reordering/tc delays. Use it to test
> +	# mptcp syncookie support.
> +	if [ $sender = $ns1 ]; then
> +		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
> +	else
> +		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=1
> +	fi
> +
> 	run_tests "$ns2" $sender 10.0.1.2
> 	run_tests "$ns2" $sender dead:beef:1::2
> 	run_tests "$ns2" $sender 10.0.2.1
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
