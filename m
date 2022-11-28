Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143420E2
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669622690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hk9pD3fCW412P61Xos4wVsgQLnCLnerOijQ3ZMEj0hA=;
	b=d85g8ueKIg6LyFTTEtVT3bx6XbetzGiIjPvDksge2LpLJWx9Rac71ViKcEPtzMM9tk2ZTg
	aNMqD6icQ1vo9ZjVs8Zn8tVsvUw2ISvgJ9Gy3/vm4KKl8wncaweS26Ldu7KW77uEjjTSIL
	9Lm1MC+dH+tkxXBm+4Q1/ZGKUpm6GXs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-FFAteuj6PhSH2XJb-s3zjg-1; Mon, 28 Nov 2022 03:04:48 -0500
X-MC-Unique: FFAteuj6PhSH2XJb-s3zjg-1
Received: by mail-qt1-f200.google.com with SMTP id u31-20020a05622a199f00b003a51fa90654so13612508qtc.19
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 00:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hk9pD3fCW412P61Xos4wVsgQLnCLnerOijQ3ZMEj0hA=;
        b=fEdCjvHUkKaRznA9VqXeo8ixJD3hMw9+1Pu5WpvgWsLdcZC4gYXeHYOXqGPml4QOlG
         QVS+EPVXZs+rfBxtdFI+DVnNfLB2w2HZdVrMEJv+YmMVRJFqnJ2HiLacZ6jsiYq/3XUb
         qr1nuLJUdMF+R92XIopAFy9TjMEu+Loznd1gZBvVILuANBHLdqrT2kKd0ItQQVRs4k58
         RLuoaNed9pvznWo7DhNDEOzu8NwjIfeGJBQyasRA/xT8L7QtNLZBBCkhKM15P+QDOyLb
         C0eN2zvdLMo6HUupBTIK1PiU7OfEig9SoVrDV0Ps6ZCNcd3ZVXiLpBNyx85fSskg1pez
         bLgQ==
X-Gm-Message-State: ANoB5pn2B7OKMae2GfnNemyFsHg6i5WC7zDKrOtsjS4Wnf2/T4OR71SW
	5HCjDiq003Vk3dtOwc/3ZcHhFoPpWLfNHhtYqksjv6pr5RfjOz01LiOHlbAnbgI/eCdypcHeEb/
	+pFY9HHy6dt+wfGc=
X-Received: by 2002:ac8:7492:0:b0:3a5:425b:f865 with SMTP id v18-20020ac87492000000b003a5425bf865mr31851928qtq.589.1669622688054;
        Mon, 28 Nov 2022 00:04:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7sO4WsEFREoq/iTtcmzwjVkTJIdvfMXDpBOmHLONIXqHMl/2cvy0sMLm/jJsHzdMYCXxb3yw==
X-Received: by 2002:ac8:7492:0:b0:3a5:425b:f865 with SMTP id v18-20020ac87492000000b003a5425bf865mr31851911qtq.589.1669622687797;
        Mon, 28 Nov 2022 00:04:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id w30-20020a05620a0e9e00b006faaf6dc55asm7813508qkm.22.2022.11.28.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:04:47 -0800 (PST)
Message-ID: <e1f32a3438e563718778e393394fd5ae036444cb.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/4] selftests: mptcp: make evts global in
 userspace_pm
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 28 Nov 2022 09:04:44 +0100
In-Reply-To: <7b755941b11aeb74e443e3178c07c143986a5227.1669383374.git.geliang.tang@suse.com>
References: <cover.1669383374.git.geliang.tang@suse.com>
	 <7b755941b11aeb74e443e3178c07c143986a5227.1669383374.git.geliang.tang@suse.com>
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
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 2022-11-25 at 21:40 +0800, Geliang Tang wrote:
> @@ -134,18 +140,25 @@ make_connection()
>  
>  	# Capture netlink events over the two network namespaces running
>  	# the MPTCP client and server
> -	local client_evts
> -	client_evts=$(mktemp)
> +	if [ -z "$client_evts" ]; then
> +		client_evts=$(mktemp)
> +	fi
>  	:>"$client_evts"
> +	if [ $client_evts_pid -ne 0 ]; then
> +		kill_wait $client_evts_pid
> +	fi
>  	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
> -	local client_evts_pid=$!
> -	local server_evts
> -	server_evts=$(mktemp)
> +	client_evts_pid=$!
> +	if [ -z "$server_evts" ]; then
> +		server_evts=$(mktemp)
> +	fi
>  	:>"$server_evts"
> +	if [ $server_evts_pid -ne 0 ]; then
> +		kill_wait $server_evts_pid
> +	fi
>  	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
> -	local server_evts_pid=$!
> +	server_evts_pid=$!
>  	sleep 0.5
> -

Minor nit: I would not remove this empty line here.

>  	# Run the server
>  	ip netns exec "$ns1" \
>  	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
> @@ -161,7 +174,6 @@ make_connection()
>  	sleep 1
>  
>  	# Capture client/server attributes from MPTCP connection netlink events
> -	kill_wait $client_evts_pid
>  
>  	local client_token
>  	local client_port
> @@ -173,12 +185,11 @@ make_connection()
>  	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
>  	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
>  				      "$client_evts")
> -	kill_wait $server_evts_pid
>  	server_token=$(grep "type:1," "$server_evts" |
>  		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
>  	server_serverside=$(grep "type:1," "$server_evts" |
>  			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
> -	rm -f "$client_evts" "$server_evts" "$file"
> +	rm -f "$file"

At this point is better to move even 'file' as a global variable, for
the same reason as 'evts'

>  
>  	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
>  		   [ "$server_serverside" = 1 ]

Thanks!

Paolo

