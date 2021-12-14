Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379468
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639476377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX9htPG7lSb7ZUWeqQ9EItqubta8tmqYumjVEAvoonE=;
	b=SWpP2Aw7eRwqBnhlvT4k4BmmNtXW1dRTHSd5QnUuKKWZIiV+n+2Qu5GjlizDJRX7mPvZmc
	1I1XQS+5ozJpfDzMTbjiQg72PMJ8NM0QhRUKL+kddVJwpgdp12D7DZ7rWEtSio8iZgxQdL
	AwoC/jKYNXuP9yXt53zKYRnwnFsEstQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-M6qo7wFXM8eioQ2GpHB5Mw-1; Tue, 14 Dec 2021 05:06:11 -0500
X-MC-Unique: M6qo7wFXM8eioQ2GpHB5Mw-1
Received: by mail-qk1-f198.google.com with SMTP id bq9-20020a05620a468900b004681cdb3483so16410227qkb.23
        for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 02:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qX9htPG7lSb7ZUWeqQ9EItqubta8tmqYumjVEAvoonE=;
        b=qiT6PdIWARCz6L/OiNYRn0EM9EhiMvOh1ORA/SFeAUqW8U5pHCK77xpm1qf4XBvxn4
         Nf11JqHdrT443FOubAJk1yjYt9ipzrZhnfWELN42sbYrfIx0x0iMDaDQJ5D3UzznTyCu
         KGaYj6UfCSovGiOS9wsqGnTxc/Ycc1QOMvDQZWyTUp5lD6to3xN4nv1ztZLWvAwzaC3U
         v6aKbIx5qRWGDP+1+h6otkHUtMs4FE3hU0pi8so48pgEMixSStYnCaNVeYB9waDsPbyw
         y1oPcIeKoy6u2pBkojWQreoZo6IvqM8DRT3cdRW1EmbrPfgI8B+T9AE7mdZ8Rv4dM+xN
         pt9Q==
X-Gm-Message-State: AOAM532J97laYgHBq0bjhAD9TdwL0zNp6v2GgiOuhm0bz3461yEbTuaO
	LaWI865gQ9mLyuJ89KMADbGKgix4EsbkW22J1wZuOybmb02fc47osOkadTHPwcQkU7gMpYdOSCo
	ujLU72OslATVac+hVeMjBxYNgeIJUPghN0mWK3w+zRR4e0JdxANToximj+E0MPeX2
X-Received: by 2002:a05:620a:1416:: with SMTP id d22mr3048799qkj.6.1639476370858;
        Tue, 14 Dec 2021 02:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMePgtPsFIA62cLV3ZzrSIJmx/qe59BimLPKmSdgJSQRp4Fg/HflH4tC9ql9a3QVGLtIbeqA==
X-Received: by 2002:a05:620a:1416:: with SMTP id d22mr3048769qkj.6.1639476370450;
        Tue, 14 Dec 2021 02:06:10 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id g21sm12309178qtb.62.2021.12.14.02.06.09
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:06:10 -0800 (PST)
Message-ID: <16eef3a103229aa5b9e7074f8ff2bad377c6cac4.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable join
 tests-cases.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Tue, 14 Dec 2021 11:06:07 +0100
In-Reply-To: <6d17baa5f8bb4dcd6b63fb3dee790743c878478e.1639417229.git.pabeni@redhat.com>
References: <6d17baa5f8bb4dcd6b63fb3dee790743c878478e.1639417229.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Mon, 2021-12-13 at 18:40 +0100, Paolo Abeni wrote:
> MPTCP join self-tests are a bit fragile as they reply on
> delays instead of events to catch-up with the expected
> sockets states.
> 
> Replace the delay with state checking where possible and
> reduce the number of sleeps in the most complex scenarios.
> 
> This will both reduce the tests run-time and will improve
> stability.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 58 ++++++++++++++-----
>  1 file changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 55b0d03f485c..505745b44e02 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -238,6 +238,37 @@ is_v6()
>  	[ -z "${1##*:*}" ]
>  }
>  
> +# $1: ns, $2: port
> +wait_local_port_listen()
> +{
> +	local listener_ns="${1}"
> +	local port="${2}"
> +
> +	local port_hex i
> +
> +	port_hex="$(printf "%04X" "${port}")"
> +	for i in $(seq 10); do
> +		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}
> +
> +# $1: ns, $2: endpoint id
> +wait_address_deleted()
> +{
> +	local ns="${1}"
> +	local addr="${2}"
> +	local cnt
> +
> +	for i in $(seq 10); do
> +		cnt=$(ss -tON ${ns} state big src = ${addr} | wc -l)
> +		[ "$cnt" != 0 ] || break;
> +		sleep 0.1
> +	done
> +}
> +
>  do_transfer()
>  {
>  	listener_ns="$1"
> @@ -307,7 +338,7 @@ do_transfer()
>  	fi
>  	spid=$!
>  
> -	sleep 1
> +	wait_local_port_listen "${listener_ns}" "${srv_port}"
>  
>  	if [ "$test_link_fail" -eq 0 ];then
>  		timeout ${timeout_test} \
> @@ -324,10 +355,13 @@ do_transfer()
>  	fi
>  	cpid=$!
>  
> +	# let the mptcp subflow be established in background before
> +	# do endpoint manipulation
> +	[ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
> +
>  	if [ $addr_nr_ns1 -gt 0 ]; then
>  		let add_nr_ns1=addr_nr_ns1
>  		counter=2
> -		sleep 1
>  		while [ $add_nr_ns1 -gt 0 ]; do
>  			local addr
>  			if is_v6 "${connect_addr}"; then
> @@ -339,7 +373,6 @@ do_transfer()
>  			let counter+=1
>  			let add_nr_ns1-=1
>  		done
> -		sleep 1
>  	elif [ $addr_nr_ns1 -lt 0 ]; then
>  		let rm_nr_ns1=-addr_nr_ns1
>  		if [ $rm_nr_ns1 -lt 8 ]; then
> @@ -347,22 +380,18 @@ do_transfer()
>  			pos=1
>  			dump=(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
>  			if [ ${#dump[@]} -gt 0 ]; then
> -				sleep 1
> -
>  				while [ $counter -le $rm_nr_ns1 ]
>  				do
>  					id=${dump[$pos]}
>  					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> -					sleep 1
> +					wait_address_deleted ${listener_ns} ${dump[-1]}
>  					let counter+=1
>  					let pos+=5
>  				done
>  			fi
>  		elif [ $rm_nr_ns1 -eq 8 ]; then
> -			sleep 1
>  			ip netns exec ${listener_ns} ./pm_nl_ctl flush
>  		elif [ $rm_nr_ns1 -eq 9 ]; then
> -			sleep 1
>  			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
>  		fi
>  	fi
> @@ -373,10 +402,13 @@ do_transfer()
>  		addr_nr_ns2=${addr_nr_ns2:9}
>  	fi
>  
> +	# if newly added endpoints must be deleted, give the background msk
> +	# some time to created them
> +	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
> +
>  	if [ $addr_nr_ns2 -gt 0 ]; then
>  		let add_nr_ns2=addr_nr_ns2
>  		counter=3
> -		sleep 1
>  		while [ $add_nr_ns2 -gt 0 ]; do
>  			local addr
>  			if is_v6 "${connect_addr}"; then
> @@ -388,7 +420,6 @@ do_transfer()
>  			let counter+=1
>  			let add_nr_ns2-=1
>  		done
> -		sleep 1
>  	elif [ $addr_nr_ns2 -lt 0 ]; then
>  		let rm_nr_ns2=-addr_nr_ns2
>  		if [ $rm_nr_ns2 -lt 8 ]; then
> @@ -396,19 +427,17 @@ do_transfer()
>  			pos=1
>  			dump=(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
>  			if [ ${#dump[@]} -gt 0 ]; then
> -				sleep 1
> -
>  				while [ $counter -le $rm_nr_ns2 ]
>  				do
> +					# rm_addr are serialized, allow the previous one to complete
>  					id=${dump[$pos]}
>  					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
> -					sleep 1
> +					wait_address_deleted ${connector_ns} ${dump[-1]}
>  					let counter+=1
>  					let pos+=5
>  				done
>  			fi
>  		elif [ $rm_nr_ns2 -eq 8 ]; then
> -			sleep 1
>  			ip netns exec ${connector_ns} ./pm_nl_ctl flush
>  		elif [ $rm_nr_ns2 -eq 9 ]; then
>  			local addr
> @@ -417,7 +446,6 @@ do_transfer()
>  			else
>  				addr="10.0.1.2"
>  			fi
> -			sleep 1
>  			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
>  		fi
>  	fi

Self nack, this version has still a few issues. I already dropped it
from patchwork. I will send a v2 soon.

Cheers,

Paolo

