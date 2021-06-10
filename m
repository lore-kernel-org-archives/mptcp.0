Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795C2F80
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 21:25:52 +0000 (UTC)
IronPort-SDR: nfLy50K/8YlBGfkUBKS1La9hBG62gRKG1ZcRt8oHgqCURr0jg65CrHza8zvSzd6X31ezv7jpb4
 0yLUHIkqRMXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192518241"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="192518241"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:25:51 -0700
IronPort-SDR: l49zG2t2tmk0x8+CYPG+TMNmXIokzAljkt4GbZox6srVveZ8Z+2Esc8Kg+XUMeyhu8VsdvLjRc
 qu8Er+R4I5mQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="486342267"
Received: from ngattu-mobl1.amr.corp.intel.com ([10.209.121.205])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:25:51 -0700
Date: Thu, 10 Jun 2021 14:25:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net, 
    geliangtang@gmail.com
Subject: Re: [PATCH v2] selftests: mptcp: turn rp_filter off on each NIC
In-Reply-To: <1623288316-2771-1-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <31cbbbb9-d879-3b54-5566-2b7e9de820bf@linux.intel.com>
References: <1623288316-2771-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Jun 2021, Yonglong Li wrote:

> To turn rp_filter off we should:
> echo 0 > /proc/sys/net/ipv4/conf/default/rp_filter
> and
> echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter
> before NIC created.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
> tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 3aeef3b..6b6336d 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -60,6 +60,8 @@ setup()
> 	for i in "$ns1" "$ns2" "$ns3";do
> 		ip netns add $i || exit $ksft_skip
> 		ip -net $i link set lo up
> +		ip netns exec $1 sysctl -q net.ipv4.conf.all.rp_filter=0
> +		ip netns exec $1 sysctl -q net.ipv4.conf.default.rp_filter=0
> 	done
>
> 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
> @@ -80,7 +82,6 @@ setup()
>
> 	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
> 	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
> -	ip netns exec "$ns1" sysctl -q net.ipv4.conf.all.rp_filter=0
>
> 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
> 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
> -- 
> 1.8.3.1

Looks good to me, thank you!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
