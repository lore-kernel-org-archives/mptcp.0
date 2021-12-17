Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78894173
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639761578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hf93u/2zTq+YxGEaEtQ8DwGiqLH0/3dE6QYHQUG666M=;
	b=PNGiNjqamlLF27KYPDxz0YfslsZLRVbZ5plRmTkUrroWFVcIJdUzECmjk4zBx5NWZ1pqUE
	N0gKZLV3GwKpKyBWmFYr/YenRG5VsCVxlAPdmvocpTiUhtfwfoU1zjrVktOB9CXn/YRgEG
	pru6hfdlPBps+mcayJXasU+29OM762I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-TGipoToZPUaVe0snZfKJSw-1; Fri, 17 Dec 2021 12:19:37 -0500
X-MC-Unique: TGipoToZPUaVe0snZfKJSw-1
Received: by mail-wm1-f72.google.com with SMTP id bg20-20020a05600c3c9400b0033a9300b44bso1343912wmb.2
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 09:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hf93u/2zTq+YxGEaEtQ8DwGiqLH0/3dE6QYHQUG666M=;
        b=E5GeY6cEEn3V8rr5SjAHIZrvnfMWnbSrIAWyc63W8vttetjSyvy20i6qLOM4BG2lIX
         +JLmFb/ZrOsGMV4+RLIMbctTU00AgmZJlIPcpVcMkn4kVBBIgzbsWOCDuy/4uR8Ye8Vn
         UJYAhzC0dgUxKo/wBIDA3GE7rT8hOZ6XUM6FC1V2/ozpQxu6suK9ZsS7HxsxQdcF9gJD
         vkPOpOrvovMKA+woeq4EQFHCEIFYCraLDJg0ZvPQ/aZw0A+PFHJcT42z/qUX7AMpG1r7
         W/WX9+F4ycMvVDL5HcgxlfFYKHD4P13V7MKP2OZXTd9aD7C5mmiXvQ+hSQvhzLOjP2Zg
         zGmA==
X-Gm-Message-State: AOAM532PYc/6BRz2Hxo9KPeFSgPNeJPREnc2hw7l6xdzRaD8gOnI2F1D
	hWlHnzFQisNUZst9W9VXQlBUPhRDjixwQZPy2Ouv1fJEwSnbe/sjwUJcSYBsEYNlln/HBrF3hNt
	EQhFlCWAsL7xQdBA=
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr3324328wrj.206.1639761576100;
        Fri, 17 Dec 2021 09:19:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVwUu5CN++3pD8Tvric+CQrefLtTI4D7rs0862mpSufikBKZhzJwPMzrwswwcOxtRbqRpoGw==
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr3324313wrj.206.1639761575898;
        Fri, 17 Dec 2021 09:19:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-225-60.dyn.eolo.it. [146.241.225.60])
        by smtp.gmail.com with ESMTPSA id z23sm7254910wmk.19.2021.12.17.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:19:35 -0800 (PST)
Message-ID: <caf7ef30e36c8fb898d8d9de9175aedb6e7ed162.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add tests for
 subflow creation failure"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 17 Dec 2021 18:19:34 +0100
In-Reply-To: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
References: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
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

On Fri, 2021-12-17 at 14:42 +0800, Geliang Tang wrote:
> Align the output logs with others.
> 
> 01 no MPC address reuse with single endpoint syn[ ok ] - synack[ ok ] - ack[ ok ]
> 02 multiple subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
> 03 multiple subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
> 04 multiple subflows, fair usage on close syn[ ok ] - synack[ ok ] - ack[ ok ]
> 05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
> 06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
> 11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
> 
> ->
> 
> 01 no MPC reuse with single endpoint    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 02 multi subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
> 03 multi subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
> 04 multi subflows, fair usage on close  syn[ ok ] - synack[ ok ] - ack[ ok ]
> 05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
> 06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
> 11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index d70621700281..e48ce23d2386 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1069,7 +1069,7 @@ subflows_error_tests()
>  	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
>  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
>  	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "no MPC address reuse with single endpoint" 0 0 0
> +	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
>  
>  	# multiple subflows, with subflow creation error
>  	reset
> @@ -1079,7 +1079,7 @@ subflows_error_tests()
>  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
>  	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
>  	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
> +	chk_join_nr "multi subflows, with failing subflow" 1 1 1
>  
>  	# multiple subflows, with subflow timeout on MPJ
>  	reset
> @@ -1089,7 +1089,7 @@ subflows_error_tests()
>  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
>  	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
>  	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "multiple subflows, with subflow timeout" 1 1 1
> +	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
>  
>  	# multiple subflows, check that the endpoint corresponding to
>  	# closed subflow (due to reset) is not reused if additional
> @@ -1112,7 +1112,7 @@ subflows_error_tests()
>  
>  	# additional subflow could be created only if the PM select
>  	# the later endpoint, skipping the already used one
> -	chk_join_nr "multiple subflows, fair usage on close" 1 1 1
> +	chk_join_nr "multi subflows, fair usage on close" 1 1 1
>  }
>  
>  signal_address_tests()

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

