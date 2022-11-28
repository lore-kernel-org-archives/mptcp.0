Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E58F5D
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669652715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxa4nDCZAymcswk2rDa9V9kjEH27S+UD7dRdfTBDYss=;
	b=Aou3LnzKCVhpm6L6xMQXewUzwG6y6I60neg02a6aZV3nyV1ZOt1TwzKCVKUpyiOhCdrE9M
	i29YObQGycVmiRNLZ5KYtGrZ8Bu6Bu+DQbFHLzGpOwJeQFKlwOO08nhxnEM9Hc4k6Q3964
	KLlAaCdwfRbl65NkWiSGuAfPBhDXG3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-ss5xk6BLOAOO-0p-pDxAFg-1; Mon, 28 Nov 2022 11:25:14 -0500
X-MC-Unique: ss5xk6BLOAOO-0p-pDxAFg-1
Received: by mail-wm1-f72.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso3879565wml.7
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 08:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dxa4nDCZAymcswk2rDa9V9kjEH27S+UD7dRdfTBDYss=;
        b=0cJpyppkue7PZ+aBSALUqVsp7MB+lPp9+RcHOJtr+xYqlcO9vZvnOxGU4ApD6/ZNOf
         7SGXxLRzZtdr0sWKGcKD9J8r6SDo2UeC29FClN6RXOmv9kYUE8acchrhVEamx26BAE63
         QpHhLvdLXU76FkCztuAJNOcYLUYnTNdNIc3h0D2Q1tUusLRd+EjtrFVf8WukWIIIfTh2
         fKhztPpopak7Nq6JXZ1kEPYv3tT5kei7njaFibDmaGBx2r0aNO400G98uyZhNcuJlZn4
         gCqAPWeVpHsT2J2AnR03nRDu8Fcdr4Fd2QiBNzQs5+y6/6d81wFq9iSdoFU05aPBzoy2
         miFw==
X-Gm-Message-State: ANoB5pn90z33hV1kbG//GwL0oiumqLFYKm083cBjKRvn6ggh423POgm2
	NsmS8/C2kjQWFWMdjPlFiR4EMi9x/33t7PVBCO3lV2xrsc9tZ9ou7g77+U6gOg23wpfHcGrrZ7W
	sR0H4QnIcckzymDo=
X-Received: by 2002:a05:600c:21c6:b0:3c7:19a6:8146 with SMTP id x6-20020a05600c21c600b003c719a68146mr39276040wmj.158.1669652712381;
        Mon, 28 Nov 2022 08:25:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7l+2F4Dtd48sW15vjBWXC5lBTcfvh0jHYYPg6mpsl/jra6Nx8EhoJ5jKxnPrO+3oXQ6djCqQ==
X-Received: by 2002:a05:600c:21c6:b0:3c7:19a6:8146 with SMTP id x6-20020a05600c21c600b003c719a68146mr39276031wmj.158.1669652712155;
        Mon, 28 Nov 2022 08:25:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d5184000000b0024219b1cb1bsm2556702wrv.60.2022.11.28.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:25:11 -0800 (PST)
Message-ID: <9d53995db918e005c403125c53f0341cd886fbbc.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: make evts
 global in userspace_pm, v3"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 28 Nov 2022 17:25:10 +0100
In-Reply-To: <20221128090048.15799-1-geliang.tang@suse.com>
References: <20221128090048.15799-1-geliang.tang@suse.com>
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

On Mon, 2022-11-28 at 17:00 +0800, Geliang Tang wrote:
> Please update the commit log:
> 
> '''
> 
> This patch makes server_evts and client_evts global in userspace_pm.sh,
> then these two variables could be used in test_announce(), test_remove()
> and test_subflows(). The local variable 'evts' in these three functions
> then could be dropped.
> 
> Also move local variable 'file' as a global one.
> 
> '''
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index f21da6119ad8..009b9d466e4b 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -17,6 +17,7 @@ LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
>  AF_INET=2
>  AF_INET6=10
>  
> +file=""
>  server_evts=""
>  client_evts=""
>  server_evts_pid=0
> @@ -52,7 +53,7 @@ cleanup()
>  {
>  	echo "cleanup"
>  
> -	rm -f "$client_evts" "$server_evts" "$file"
> +	rm -rf $file $client_evts $server_evts
>  
>  	# Terminate the MPTCP connection and related processes
>  	if [ $client4_pid -ne 0 ]; then
> @@ -121,8 +122,9 @@ make_file()
>  
>  make_connection()
>  {
> -	local file
> -	file=$(mktemp)
> +	if [ -z "$file" ]; then
> +		file=$(mktemp)
> +	fi
>  	make_file "$file" "client"
>  
>  	local is_v6=$1
> @@ -190,7 +192,6 @@ make_connection()
>  		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
>  	server_serverside=$(grep "type:1," "$server_evts" |
>  			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
> -	rm -f "$file"
>  
>  	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
>  		   [ "$server_serverside" = 1 ]

LGTM (together with
https://patchwork.kernel.org/project/mptcp/list/?series=699400
)

Acked-by: Paolo Abeni <pabeni@redhat.com>

