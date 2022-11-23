Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8A1FA3
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669204203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4kf4o5MbVIUXiTqzfKwTv04ui/IkPGcykJfT2rNrOs=;
	b=D6r8MG8CxdJBHu8Zi8vvEH+va/LYkENE8wJZEcgww0pp9Z9E9mG0kDIJ00mEc51kk5uVeV
	xnQZGzw+6eO1gJy2Oj1hF2Z17Y95MG3w97gQ8obZTml9fdSwXRVzCx4S1cqEqa2GXhXtMb
	E5QzUJz6slGJf/lMaYCytxWEWu7OKBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-fj4ZBLSpOVenjAOa8zouBQ-1; Wed, 23 Nov 2022 06:50:01 -0500
X-MC-Unique: fj4ZBLSpOVenjAOa8zouBQ-1
Received: by mail-wm1-f71.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso9520909wms.5
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 03:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4kf4o5MbVIUXiTqzfKwTv04ui/IkPGcykJfT2rNrOs=;
        b=FGpWaRCXvDoYE39hpdISQOaauljTkh0LaUuWQe6I82Uk4Q5VY1og86z2A/xjuz7wEX
         2k905rqRIVUwcVyuSSY2GVig1u0vH5Ex1E8gp+eQ1M9v5z8f0qQjNHSWfXN+3vEn3lqn
         t8YFCjytXmTVa8kJKpEPJ7y44g8xrk2WlWn1aIlyj/D/6hjpeP0OoQuuzQc9gk4pv7Nh
         C9PszSW4XKSyoqZnZOd5h9TgjYhsGrDCx13TK4HsGX6eDFKqnpM2KDPskQ2dLQYTgIHl
         ekfJiHk6CzAXp0wXzCgwA0CJ4M2WFFIFevQ7iK7sJ0og7MDoEZ3Q7/yYL5eARCu4rhCC
         ci4g==
X-Gm-Message-State: ANoB5plfaXw+wRTTHdTY49nDY7JahKTq8i9xTtA8OQSaS/rCJoB3Pe4E
	Cn+WGcSG+pH2bA4y15VPMEhHEtSy0iGlBaMpmLm8bY6/hu7MtjdpyaxQRVDnoR7lbQTfNhWKP26
	RhZi9YTS0FsRfQwY=
X-Received: by 2002:a05:6000:1148:b0:236:71cd:1a71 with SMTP id d8-20020a056000114800b0023671cd1a71mr17113032wrx.712.1669204200313;
        Wed, 23 Nov 2022 03:50:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf73Chen52HW61poUYz07zksYjCunuCmsv6mTQyMqeJ8d00kCmb+z11NtTRgatyG//+t7jHJNQ==
X-Received: by 2002:a05:6000:1148:b0:236:71cd:1a71 with SMTP id d8-20020a056000114800b0023671cd1a71mr17113015wrx.712.1669204200007;
        Wed, 23 Nov 2022 03:50:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003b47e75b401sm2347396wmq.37.2022.11.23.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:49:59 -0800 (PST)
Message-ID: <db094b53bb343ec9c490506134b913e15ea5ac20.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 4/4] selftests: mptcp: listener test for
 in-kernel PM
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 23 Nov 2022 12:49:58 +0100
In-Reply-To: <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
	 <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hello,

sorry for the late feedback.

On Thu, 2022-11-17 at 13:31 +0800, Geliang Tang wrote:
> This patch adds test coverage for listening sockets created by the
> in-kernel path manager in mptcp_join.sh.
> 
> It adds the listener event checking in the existing "remove single
> address with port" test. The output looks like this:
> 
>  003 remove single address with port syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                      add[ ok ] - echo  [ ok ] - pt [ ok ]
>                                      syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                      syn[ ok ] - ack   [ ok ]
>                                      rm [ ok ] - rmsf  [ ok ]   invert
>                                      CREATE_LISTENER 10.0.2.1:10100[ ok ]
>                                      CLOSE_LISTENER 10.0.2.1:10100 [ ok ]
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f10ef65a7009..89a30225bbd7 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2509,6 +2509,54 @@ backup_tests()
>  	fi
>  }
>  
> +LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> +LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
> +
> +AF_INET=2
> +AF_INET6=10
> +
> +verify_listener_events()
> +{
> +	local evt=$1
> +	local e_type=$2
> +	local e_family=$3
> +	local e_saddr=$4
> +	local e_sport=$5
> +	local type
> +	local family
> +	local saddr
> +	local sport
> +
> +	if [ $e_type = $LISTENER_CREATED ]; then
> +		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
> +			$e_saddr $e_sport
> +	elif [ $e_type = $LISTENER_CLOSED ]; then
> +		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
> +			$e_saddr $e_sport
> +	fi
> +
> +	type=$(grep "type:$e_type," $evt |
> +	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
> +	family=$(grep "type:$e_type," $evt |
> +		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
> +	sport=$(grep "type:$e_type," $evt |
> +		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')

This does not handle properly error conditions: $family, $type or
$sport could be undef in case of bugs, you need to quote them
everywhere.

> +	if [ $family = $AF_INET6 ]; then
> +		saddr=$(grep "type:$e_type," $evt |
> +			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> +	else
> +		saddr=$(grep "type:$e_type," $evt |
> +			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
> +	fi
> +
> +	if [ $type = $e_type ] && [ $family = $e_family ] &&
> +	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
> +		stdbuf -o0 -e0 printf "[ ok ]\n"
> +		return 0
> +	fi
> +	stdbuf -o0 -e0 printf "[fail]\n"

This is not enough, you must additionally call

	fail_test

to properly report the failure to the CI, otherwise the test will be
considered successful even when the condition is not meet.

> +}
> +
>  add_addr_ports_tests()
>  {
>  	# signal address with port
> @@ -2533,7 +2581,16 @@ add_addr_ports_tests()
>  	fi
>  
>  	# single address with port, remove
> +	# pm listener events
>  	if reset "remove single address with port"; then
> +		local evts
> +		local pid
> +
> +		evts=$(mktemp)
> +		:> $evts
> +		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
> +		pid=$!
> +
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>  		pm_nl_set_limits $ns2 1 1
> @@ -2541,6 +2598,11 @@ add_addr_ports_tests()
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1 1
>  		chk_rm_nr 1 1 invert
> +
> +		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
> +		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
> +		kill_wait $pid
> +		rm -rf $evts

is better if you make the 'evts' variable global, moving its definition
in the initial global variable declaration and move the 'rm -rf $evts'
in cleanup() 

@Geliang: could you please send a squash-to follow tacking care of
the above?

Thanks!

Paolo

