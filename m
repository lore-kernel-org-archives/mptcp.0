Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3F70
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627380208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BW1HJxzy208tTCXU1eA2SbQlM2lWN2+TWyoVGFDDco=;
	b=Ha5VxVoVweMHRm1QLnnpY8JQ3IIUjqVs+97GrDQ4LplNo1rgXT9zTPNKn+KRdUpGDcTlHL
	TVFWGxucS3XsTuslxua+8fpbKzLwyEhD/8NLgjd0Q20LIIjn4UOA41vZ9NVz/pGUgz5sGL
	PQ8dz9hdcOvEgAxCOKM34cxdH/e1ajI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-jgiFELr9OYyesi_EK8xWWQ-1; Tue, 27 Jul 2021 06:03:27 -0400
X-MC-Unique: jgiFELr9OYyesi_EK8xWWQ-1
Received: by mail-wm1-f71.google.com with SMTP id c41-20020a05600c4a29b0290253935d0f82so497434wmp.9
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 03:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3BW1HJxzy208tTCXU1eA2SbQlM2lWN2+TWyoVGFDDco=;
        b=Jq5it+BaJsrQmR86L8Ry3Uza/klYtbLkDSmRl06iQaxsf64Hg/yKhN7DmXlwZ1Ge12
         V6PejKtKJdIP5qtaVLb+ctpxCfgCR1C5MlxmveUYzmcgQSnuO17kJ7/31ZuIJ8YjdC4a
         PmPrB5wq2MyQLx147YUMMVsrKIVtWWagPD6R5W6K+FHoAOGAtQrllkwX1z0/gvpgqdHU
         +mb8hHuBDuVPe3q+UcZErPLCMuzvIJtwuzxM423fYFt9okuzGd8WWXXPQ08phEbFTwLl
         7OsDlQHBhdeRXDmW8te26FXBojq2gw5v2cPP/qixSTbg+ADDPfMK9lDe+dufV+TDerKG
         ZGsg==
X-Gm-Message-State: AOAM5323xFE11V5l040kjZ9RnD/3m+Tp6HXog/dF2lVSEcUe3BKvQlLY
	iY0wXrge5WXGaWD3zAwsWHugAmXkWXzk8XsGp6/wt51zj4VPBK9mIjOtTclxyVj9T7j/0eGyDoa
	Buh3v0gJbgmUJtD0=
X-Received: by 2002:a1c:3b07:: with SMTP id i7mr3271949wma.7.1627380205838;
        Tue, 27 Jul 2021 03:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya4sYyZZH4LVTfQByzYyUv9AVjsvNvGvsNSBr1iQ191duwpwH8KKiumaEVXfkr5TcROK4iug==
X-Received: by 2002:a1c:3b07:: with SMTP id i7mr3271925wma.7.1627380205580;
        Tue, 27 Jul 2021 03:03:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id d15sm2857221wri.39.2021.07.27.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 03:03:25 -0700 (PDT)
Message-ID: <16669ae198f1f0eb21bf9383d6630cb692b6f3e2.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 4/5] selftests: mptcp: add fullmesh
 testcases
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 27 Jul 2021 12:03:24 +0200
In-Reply-To: <78d86feae19ea4efd7061a9e92b81475ed035323.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com>
	 <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
	 <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
	 <69eb44fdf9899ec5eab342fa1f3b62d12ab2598e.1627372396.git.geliangtang@xiaomi.com>
	 <78d86feae19ea4efd7061a9e92b81475ed035323.1627372396.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added the testcases for the fullmesh address flag of the path
> manager.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 937e861e9490..ca19762b9c6e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -367,7 +367,13 @@ do_transfer()
>  	fi
>  
>  	if [ $addr_nr_ns2 -gt 0 ]; then
> -		let add_nr_ns2=addr_nr_ns2
> +		if [ $addr_nr_ns2 -gt 10 ]; then
> +			let add_nr_ns2=addr_nr_ns2-10
> +			flags=subflow,fullmesh
> +		else
> +			let add_nr_ns2=addr_nr_ns2
> +			flags=subflow
> +		fi
>  		counter=3
>  		sleep 1
>  		while [ $add_nr_ns2 -gt 0 ]; do
> @@ -377,7 +383,7 @@ do_transfer()
>  			else
>  				addr="10.0.$counter.2"
>  			fi
> -			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
> +			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
>  			let counter+=1
>  			let add_nr_ns2-=1
>  		done
> @@ -1697,6 +1703,46 @@ deny_join_id0_tests()
>  	chk_join_nr "subflow and address allow join id0 2" 1 1 1
>  }
>  
> +fullmesh_tests()
> +{
> +	# fullmesh 1
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
> +	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +	chk_join_nr "fullmesh test 1" 2 2 2
> +	chk_add_nr 1 1
> +
> +	# fullmesh 2
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
> +	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +	chk_join_nr "fullmesh test 2" 4 4 4
> +	chk_add_nr 1 1

This 2 tests are a bit redundand, I think. With a single remote known
address, the final topology will be the same as with non-fullmesh
subflows. Perhaps we can keep just one of this cases?

> +
> +	# fullmesh 3
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal

Here I think we need at least one 'fullmesh' subflow in ns2? Otherwise
this will be a non-fullmesh topology.

> +	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow
> +	chk_join_nr "fullmesh test 3" 3 3 3
> +	chk_add_nr 1 1
> +
> +	# fullmesh 4
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal

And perhaps here 2 'fullmesh' subflows? So we test explicitly the most
expected conf:

Client		Server
C1 ----------->	S1
    \       /->
     \     /
    - \ --/
   /   \
  /     \
 /       ----->
C2 ----------->	S2

(not sure how much the above "graph" will be readable :)

Additionally it would be nice to explicitly test a fullmesh topology
where we hit the max_subflows limit, e.g. 2 local address 3 remote ones
and max_subflows=4



> +	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
> +	chk_join_nr "fullmesh test 4" 5 5 5
> +	chk_add_nr 1 1
> +}
> +
>  all_tests()
>  {
>  	subflows_tests
> @@ -1712,6 +1758,7 @@ all_tests()
>  	syncookies_tests
>  	checksum_tests
>  	deny_join_id0_tests
> +	fullmesh_tests
>  }
>  
>  usage()
> @@ -1730,6 +1777,7 @@ usage()
>  	echo "  -k syncookies_tests"
>  	echo "  -S checksum_tests"
>  	echo "  -d deny_join_id0_tests"
> +	echo "  -m fullmesh_tests"
>  	echo "  -c capture pcap files"
>  	echo "  -C enable data checksum"
>  	echo "  -h help"
> @@ -1765,7 +1813,7 @@ if [ $do_all_tests -eq 1 ]; then
>  	exit $ret
>  fi
>  
> -while getopts 'fsltra64bpkdchCS' opt; do
> +while getopts 'fsltra64bpkdmchCS' opt; do
>  	case $opt in
>  		f)
>  			subflows_tests
> @@ -1806,6 +1854,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
>  		d)
>  			deny_join_id0_tests
>  			;;
> +		m)
> +			fullmesh_tests
> +			;;
>  		c)
>  			;;
>  		C)

