Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771E173
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 00:29:44 +0000 (UTC)
IronPort-SDR: eK97ZXRkSa1d/YgFbLQ9juElelncNLDNbtV9HOYNepqc5agUaPJ7ExKQ1gfOs2oImHwpYSYvip
 JmLZknrh84SQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="203347951"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="203347951"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 17:29:41 -0700
IronPort-SDR: bUkU3d20OuVFhOPGIHkfdBFjxyeApEZgBEXRJg1Sefi6Hu4oEf5Lb8v6Py1FE/o/zyPcSTSwGw
 VKU1TdO80TOg==
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="485934316"
Received: from kcsherwo-mobl1.amr.corp.intel.com ([10.212.135.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 17:29:39 -0700
Date: Wed, 9 Jun 2021 17:29:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net, 
    geliangtang@gmail.com
Subject: Re: [PATCH] selftests: mptcp: turn rp_filter off on every NIC
In-Reply-To: <1623219771-40982-1-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <e542131a-8ade-844c-7d9a-3e41e5544c9a@linux.intel.com>
References: <1623219771-40982-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Jun 2021, Yonglong Li wrote:

> To turn rp_filter off we should:
> echo 0 > /proc/sys/net/ipv4/conf/<device>/rp_filter
> and
> echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
> tools/testing/selftests/net/mptcp/simult_flows.sh | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 3aeef3b..a29ffef 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -81,6 +81,8 @@ setup()
> 	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
> 	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
> 	ip netns exec "$ns1" sysctl -q net.ipv4.conf.all.rp_filter=0
> +	ip netns exec "$ns1" sysctl -q net.ipv4.conf.ns1eth1.rp_filter=0
> +	ip netns exec "$ns1" sysctl -q net.ipv4.conf.ns1eth2.rp_filter=0
>
> 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
> 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
> -- 
> 1.8.3.1
>
>

Would it make sense to set net.ipv4.conf.all.rp_filter=0 and 
net.ipv4.conf.default.rp_filter=0 at line 63 (in the loop that runs 'ip 
netns add') like mptcp_join.sh and mptcp_connect.sh do?

--
Mat Martineau
Intel
