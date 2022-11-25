Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DE23A3
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669358938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgypgHnn+BTJi5Rx4CD2pEIayDm6tnDFTyl4hSKVAF4=;
	b=gpB7mJ9tfLiiKrBbkMQAh6k0Fcb48Dv3kqZhUrG3ZBJuQWr/4R0u5Suo+4vzkgXoqHLU52
	2uE6JDZnmgQXLu5CMpNoYDN026hbwk+9iQpZ2rFMRmMHfSLSmgyZWSLy+Bnmgj2tF2joG/
	mWVcMpYCCReivS411lq/a0dsL3dJnyE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-zJVdK_unN_ygCKcqlePlFw-1; Fri, 25 Nov 2022 01:48:56 -0500
X-MC-Unique: zJVdK_unN_ygCKcqlePlFw-1
Received: by mail-qt1-f200.google.com with SMTP id b20-20020ac844d4000000b003a542f9de3dso3452972qto.7
        for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 22:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgypgHnn+BTJi5Rx4CD2pEIayDm6tnDFTyl4hSKVAF4=;
        b=NBfuy5WOVnOaUvqNMMeeEbBaru1M77a/qL1ZMTGKkCJKS/Guz8YNbl2OpKsTnUE2I2
         Tq0nF52R94TrEQjK2QQal4r4VGPiZoSCcBKiI6VGB0I7SYGWADOrV8pXPbZ9cIa5AsqL
         w4dGhrEz+paNcm9loCOXfnt+7tVHPJ8qK5hmmGcfsU0ciSBnwnIfY3JNESadoZH25hGI
         kxu+aVf8H80dGgaoPESfTU5JRTRoEvLMtIZ4Pv+Q7rEIrh6DS7kxSFmwApOyD7KRj+K+
         BeiHODKhDBRFrkgi59CYg0UJP9B+hZgaZv3TdqVXJxBHzSBr2UjDhSChxDqpEI5bFdto
         3kvQ==
X-Gm-Message-State: ANoB5pnR66A/AkVOtGSsOKe+eVtWu1J26/enMsvDa3f5Dyu/yC3e8hMC
	3CZG2FDW5yXnFrPmEs0+vDHLkii8P47aLosK7wQ/PZld/ZqaJaKYnfF/otJoPxzw9WjxzvoGImn
	uuz4SgLcQwD33lgg=
X-Received: by 2002:a37:b1c5:0:b0:6fb:11d1:dab2 with SMTP id a188-20020a37b1c5000000b006fb11d1dab2mr32995313qkf.75.1669358936069;
        Thu, 24 Nov 2022 22:48:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7IO5hL8KEo/HBfS1UkfKjyG+BJEHgBFc8o3tul1wK0vrDagQrNyPbBnwChwEMNvJLnkz1+Kw==
X-Received: by 2002:a37:b1c5:0:b0:6fb:11d1:dab2 with SMTP id a188-20020a37b1c5000000b006fb11d1dab2mr32995301qkf.75.1669358935768;
        Thu, 24 Nov 2022 22:48:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id d23-20020ac81197000000b00399ad646794sm1786227qtj.41.2022.11.24.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:48:55 -0800 (PST)
Message-ID: <40767d7126fe5344e35e83a1814d5b1589618228.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: listener
 test for in-kernel PM"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 25 Nov 2022 07:48:53 +0100
In-Reply-To: <225d8a6c589e80c89d59ccccdbb2438de78597e4.1669340938.git.geliang.tang@suse.com>
References: <7416de705544121ada6c71199d728e8307223eb0.1669340938.git.geliang.tang@suse.com>
	 <225d8a6c589e80c89d59ccccdbb2438de78597e4.1669340938.git.geliang.tang@suse.com>
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

Hello,

Thank you for the quick turn-around!

On Fri, 2022-11-25 at 09:51 +0800, Geliang Tang wrote:
> Do some cleanups.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 89a30225bbd7..e24884f9c039 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2541,7 +2541,7 @@ verify_listener_events()
>  		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
>  	sport=$(grep "type:$e_type," $evt |
>  		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> -	if [ $family = $AF_INET6 ]; then
> +	if [ $family ] && [ $family = $AF_INET6 ]; then
>  		saddr=$(grep "type:$e_type," $evt |
>  			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
>  	else
> @@ -2549,12 +2549,16 @@ verify_listener_events()
>  			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
>  	fi
>  
> -	if [ $type = $e_type ] && [ $family = $e_family ] &&
> -	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
> +	if [ $type ] && [ $type = $e_type ] &&
> +	   [ $family ] && [ $family = $e_family ] &&
> +	   [ $saddr ] && [ $saddr = $e_saddr ] &&
> +	   [ $sport ] && [ $sport = $e_sport ]; then
>  		stdbuf -o0 -e0 printf "[ ok ]\n"
>  		return 0
>  	fi
> +	fail_test
>  	stdbuf -o0 -e0 printf "[fail]\n"
> +	return 1

I think this is not needed, the caller never checks the fuction return
code, and it's implicitly the exit status of the last command, in this
case 'printf', which should be always successful.

>  }
>  
>  add_addr_ports_tests()
> @@ -2599,8 +2603,8 @@ add_addr_ports_tests()
>  		chk_add_nr 1 1 1
>  		chk_rm_nr 1 1 invert
>  
> -		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
> -		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
> +		verify_listener_events $evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
> +		verify_listener_events $evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
>  		kill_wait $pid
>  		rm -rf $evts

I think we need to make evts global. The goal is removing the created
file when the script is terminated by the user before completion. With
the current code, if the user kills the test script in between the
$evts file creation and the above line, such file will be left-over. 

It looks like that the user-space pm script is not doing the correct
thing wrt such files. I think an additional patch (to be applied deeper
in the patch list than this series) could change evts usage in all the
existing places and then the squash-to patch 3/4 could adjust the new
test.

WDYT?

Thanks!

Paolo



