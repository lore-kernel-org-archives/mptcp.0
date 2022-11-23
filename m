Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C41FA3
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669204520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Jxv+u6Llcj9EdYnXlKFoQSeYAGl9AIsE2DTXeKqmqo=;
	b=TmGNNdeiFcQpLt1gejOrlFQvCwms+8HTxE4gu9TNSlYNd8EXJVSJljU0jGF4BKNDvcMrpw
	WyyontSrKZsJt1f7zsfc44zmDwZTIwi6/ZofKK8cisdm4HnqUqID2yo/Thi7FUOidZ9q95
	eJiEBJQfkalI73EL328mCovEOZAza60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-Amwgo2uqNkiYWAocttMwrA-1; Wed, 23 Nov 2022 06:55:19 -0500
X-MC-Unique: Amwgo2uqNkiYWAocttMwrA-1
Received: by mail-wm1-f69.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so9518887wmb.7
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 03:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Jxv+u6Llcj9EdYnXlKFoQSeYAGl9AIsE2DTXeKqmqo=;
        b=B7J5YuvqxvKu4DLvdfFV5yBDDh2uZ68yHJRAItejs4uVbd0XX/YfxMpiv4rlUyZ1hO
         PMXkZhfL1v6QOP1q0u/iOSVmUzyaMFbk/pfseVR6JrH6oiZnKGFd37N2WSJxnzaaHc8m
         8hbRGGFoWQmdPtCJekRn8fPf5HT3gzr7F355VRP/mzghBexdFc58sVjT1ggSvyHBDHkk
         sk17LAl3+fBq3hMAE6OR9HDiKZlBPqwsqNYgmd9IyMLKF+yzzJMZc+NWApqdD2vhJEIZ
         XjdVM7huc4AdcjMoJuOom883kLlRFi7Flo8aNya/sppCjdxFRh6nOT/vVQg1P6iqKHwR
         wjGg==
X-Gm-Message-State: ANoB5pnt46GWfLYv9ImIpF5+uJ8oxExYPxcSjtvsmVzZeEu14inaP542
	yoiD1WPmjjn4S2cZIAu2sIb8ClJcTcQJ8HEHRU89bfHn2L+E4rrpBUAtB6zZ90tB1QdO5ywI6ZT
	EPXVpG68+HQS7z/o=
X-Received: by 2002:a05:6000:12d1:b0:236:71fe:c9c5 with SMTP id l17-20020a05600012d100b0023671fec9c5mr16522125wrx.677.1669204517860;
        Wed, 23 Nov 2022 03:55:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7LavH/rIQZ27Brh7SynlIcK8hAizkmyfzG6cnUxdtG2HUKPrtPR5ppy4zln+jvQf80IMMtVw==
X-Received: by 2002:a05:6000:12d1:b0:236:71fe:c9c5 with SMTP id l17-20020a05600012d100b0023671fec9c5mr16522108wrx.677.1669204517596;
        Wed, 23 Nov 2022 03:55:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id y9-20020a5d4ac9000000b00241ce5d605dsm10897209wrs.110.2022.11.23.03.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:55:17 -0800 (PST)
Message-ID: <12e2fa8c76de3b572433f11607d4314c06334b10.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 3/4] selftests: mptcp: listener test for
 userspace PM
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 23 Nov 2022 12:55:16 +0100
In-Reply-To: <25f1826e79124415086fe3d6ceb139e2ec80a756.1668662624.git.geliang.tang@suse.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
	 <25f1826e79124415086fe3d6ceb139e2ec80a756.1668662624.git.geliang.tang@suse.com>
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

On Thu, 2022-11-17 at 13:31 +0800, Geliang Tang wrote:
> This patch adds test coverage for listening sockets created by the
> userspace path manager in userspace_pm.sh.
> 
> It adds a new test named test_listener() and a new verifying helper
> verify_listener_events(). The new output looks like this:
> 
>  CREATE_SUBFLOW 10.0.2.2 (ns2) => 10.0.2.1 (ns1)              [OK]
>  DESTROY_SUBFLOW 10.0.2.2 (ns2) => 10.0.2.1 (ns1)             [OK]
>  MP_PRIO TX                                                   [OK]
>  MP_PRIO RX                                                   [OK]
>  CREATE_LISTENER 10.0.2.2:37106				      [OK]
>  CLOSE_LISTENER 10.0.2.2:37106				      [OK]
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../selftests/net/mptcp/userspace_pm.sh       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 08a88ea47a29..40801279ebdf 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -11,6 +11,8 @@ ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
>  REMOVED=7          # MPTCP_EVENT_REMOVED
>  SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
>  SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
> +LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> +LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
>  
>  AF_INET=2
>  AF_INET6=10
> @@ -808,11 +810,91 @@ test_prio()
>  	fi
>  }
>  
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
> +		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
> +			$e_saddr $e_sport
> +	elif [ $e_type = $LISTENER_CLOSED ]; then
> +		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
> +			$e_saddr $e_sport
> +	fi
> +
> +	type=$(grep "type:$e_type," $evt |
> +	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
> +	family=$(grep "type:$e_type," $evt |
> +		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
> +	sport=$(grep "type:$e_type," $evt |
> +		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
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
> +		stdbuf -o0 -e0 printf "[OK]\n"
> +		return 0
> +	fi
> +	stdbuf -o0 -e0 printf "[FAIL]\n"
> +	exit 1

This has similar issues to the patch 4/4, with the main difference that
we dont need the test_fail call here: exit 1 is enough.


@Geliang: could you please take care of the follow-up here, too?

Thanks!

Paolo

