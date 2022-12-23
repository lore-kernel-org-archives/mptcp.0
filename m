Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A68476
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 14:35:29 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id c34so759482edf.0
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7XA4IJ3PU0BGp01QqxgiyrB82V6OjFUwdcNyqMxFIM=;
        b=iMeae+AR7OAv1n8epQES96KLScM7irYX8nEJPulytYaxVUCGJc2mb9jN3+zPErH5kx
         /xWCrlCjFqe32tBJVtGooRr4r+i+fmMut/mF9Nj/g25ioEAjw6X3TBED0Q23S2SYfUAd
         QkSaP0YYRF7GQdWJVzDoh/tHrMGn17JwXPa/rAChSF6m+BS9zAZW8mAMuT3t6W6kDUio
         xfyJ2VdZMLmHTsHdI2A+GIxkV1ZNNXNkywSjU2rNgtEGI2eaewMJyb7h3DxyS7gGZL2G
         EhJ3vK177yLcThgZburDHKxVdFojjoZ531VtnyUND20Nm6kekJtF1C4gw1wd7fvru5lq
         xkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7XA4IJ3PU0BGp01QqxgiyrB82V6OjFUwdcNyqMxFIM=;
        b=1mOvxpl240vFWYgUI4H6VXYxWesRqeo0AvGxD19whrKumlq1L+mJQ2aLVI5f0ZvkYD
         1/VWgPqTTwO/DXFXYR+at7DwhnjQgf76+oso/HHGXi3WPAuoHQksZCNiePvpyxnTReZd
         MecUVVKTP3t+HOfqGkdVMKDIeQLV6Y7s5pkHUaol30exw6uCTZ5FTW3Izzl/djF4tiOY
         T9KK1v4+9oAwtNHyqBmDIBWkPZqTEy+WWDM01MTGGsIgFr3uM4MnAeu3zaYKL9C9NBC4
         pzIHHMXMTtlcL4RTmMmIi2MXsuf3NMSlp/GmuYLH59RLI2SPltfy22XOeObWfvBS/fCO
         5P4A==
X-Gm-Message-State: AFqh2koSOLxsMukCOyB6UnM9w/v1IcTRqAFMFGhiyv/Ww3sAQOyg6XrI
	NuSgDEffZJqqXxOS6cxDGp5r4KmRjnl92QgL8X2m7w==
X-Google-Smtp-Source: AMrXdXvEH43lziyuiy3JXsOkEwajU/+bSz9Xnghpa6Dijw5ubIvCd+qu3ukBdWBU47EY+0O3worMag==
X-Received: by 2002:aa7:c398:0:b0:47f:14a6:a24b with SMTP id k24-20020aa7c398000000b0047f14a6a24bmr5656344edq.21.1671806127691;
        Fri, 23 Dec 2022 06:35:27 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b007c0c1e18e28sm1439722ejh.124.2022.12.23.06.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 06:35:27 -0800 (PST)
Message-ID: <45315757-d5fc-8d90-39e1-d7fd8a7682a4@tessares.net>
Date: Fri, 23 Dec 2022 15:35:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add test-cases for mixed
 v4/v6 subflows
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
 <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/12/2022 13:51, Paolo Abeni wrote:
> Note that we can't guess anymore the listener family based on the
> client target address; use always IPv6.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++----
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index d11d3d566608..6ef4787ad244 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -774,24 +774,17 @@ do_transfer()
>  		addr_nr_ns2=${addr_nr_ns2:9}
>  	fi
>  
> -	local local_addr
> -	if is_v6 "${connect_addr}"; then
> -		local_addr="::"
> -	else
> -		local_addr="0.0.0.0"
> -	fi
> -
>  	extra_srv_args="$extra_args $extra_srv_args"
>  	if [ "$test_link_fail" -gt 1 ];then
>  		timeout ${timeout_test} \
>  			ip netns exec ${listener_ns} \
>  				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> -					$extra_srv_args ${local_addr} < "$sinfail" > "$sout" &
> +					$extra_srv_args "::" < "$sinfail" > "$sout" &
>  	else
>  		timeout ${timeout_test} \
>  			ip netns exec ${listener_ns} \
>  				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> -					$extra_srv_args ${local_addr} < "$sin" > "$sout" &
> +					$extra_srv_args "::" < "$sin" > "$sout" &
>  	fi
>  	local spid=$!
>  
> @@ -2448,6 +2441,45 @@ v4mapped_tests()
>  	fi
>  }
>  
> +mixed_tests()
> +{
> +	# subflow IPv4-mapped to IPv4-mapped

(small detail: the comment is not adapted. I can remove it when applying
the patch if no other modifications are needed. Same just below, the
next test)

> +	if reset "simult IPv4 and IPv6 subflows, first is IPv4"; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow

(linked to my question from patch 1/3)

If I'm not mistaken, by default, mptcp_connect will create an MPTCP
socket with AF_INET family if the initial destination is an IPv4
address, no?
Here should we not try to connect to ::ffff:10.0.1.1 instead (or pass -6
option? Maybe not enough)?

Also, I guess we should have an extra test to make sure a v4 only
sockets is not allowing extra subflows in v6, no?

> +		chk_join_nr 1 1 1
> +	fi
> +
> +	# subflow IPv4-mapped to IPv4-mapped
> +	if reset "simult IPv4 and IPv6 subflows, first is IPv6"; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow

Linked to the previous question: that makes me think we properly don't
propagate the IPV6_V6ONLY socket option (sk_ipv6only) to new subflows
(just before the connect). Now that we can connect to v4 addresses, it
might be an issue. Easy to fix with this I guess:

--------------------- 8< ---------------------
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 582ed93bcc8a..9986681aaf40 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1255,6 +1255,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>         ssk->sk_priority = sk->sk_priority;
>         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
>         ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
> +       ssk->sk_ipv6only = sk->sk_ipv6only;
>         __ip_sock_set_tos(ssk, inet_sk(sk)->tos);
>  
>         if (sk->sk_userlocks & tx_rx_locks) {
--------------------- 8< ---------------------

(+ a test checking that for v6 only socket as well I suppose)

> +		chk_join_nr 1 1 1
> +	fi
> +
> +	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 1 4

Does the limit here mean 1 subflow or 1 extra subflow? (it might answer
my question below)

> +		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
> +		chk_join_nr 1 1 1

Why do you not have an extra subflow in IPv6 between the second IPv6 of
ns2 (subflow,fullmesh) and the main IPV6 of the server on ns1?

> +	fi
> +
> +	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 2 4
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
> +		chk_join_nr 4 4 4

Why do you have so many subflows here? The client has one IPv6 and the
server 2, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
