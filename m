Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE32583
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 15:22:11 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so60812645e9.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685546530; x=1688138530;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L67xWi+uhBK7K+GK8DmqaFRX1xfTohajAgMgzyxL7fk=;
        b=VJ3Sd8UNXcsYdyCm/rJNYmeEnswQqBloXdyOzQ8Th+P2OCpmnxSeIvtIoVv6ed4ngr
         5m+NHo5z2UnRv/Qb416D9yFw6qztBbPVaVjIIdVx+XSi6pzw/F9W56pMVDxia40x4q3c
         WwIzD8wccnFhZo0b+pNsfJuXB3UOrBN49SXZG9b8Tdh3pvQjvQ6w1murwZQXr+6V0sN7
         9H7hpYIXoeq7UBEApzAfY4KwdTOq/+UmQQwCJahmpTaJOSBL3msY1XmfDH+JC3WJAuT6
         lykuONdl4EFNIGFMso5o1rgzQoxobAgIA4THYG8hpQ/LqoI3U8YgclffrVFTti56KrKo
         98/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546530; x=1688138530;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L67xWi+uhBK7K+GK8DmqaFRX1xfTohajAgMgzyxL7fk=;
        b=AAYGGMhcCKKy0rI4CToogX9N7T3CzES6SPyEnkxUcDMgGQSKVpGnqbxeAQ2lFww4OR
         xrxA8sbqHD1ppdRwsaqHWPWGUWOFtsz44CMwCejX6zYECqyE0sW7gtfO3bJwjAHETeyz
         B+naP2j3YfP9Uk4+FBnutBBSdx4d+KTse3oVJFr8dvHxUXs1rRvEL9cCUSih+j2lC4cm
         YM3Wh5MYN4W5ts3FtwcDKPrx7z+ew9kMOx60nnFKI5t767SnWSGXDum/lHdFp0z9Ec9+
         YnXxCwsBFufxtZE1xcsZEQjfsrQYeqCVyma7AQNwCsREdeYY/jRHVetIUuMm0DFHOLDz
         7S5g==
X-Gm-Message-State: AC+VfDyGIOPhzpLoyvD2JGw/WM45aBU1TE0mn9FL6G7Kjq8JTxaJTKEF
	IUw3O19j614718cQCHDmVJ0JWlAYE66OvshjxS3IbC9V
X-Google-Smtp-Source: ACHHUZ7jFOBRlvw5rh3OO41AXYrAykXeYDg2iLIrvjbOEYTE84KX163dF09UN/V7ja4J7G7/FuRIsg==
X-Received: by 2002:a7b:c8ce:0:b0:3f6:444:b33e with SMTP id f14-20020a7bc8ce000000b003f60444b33emr4411720wml.30.1685546530327;
        Wed, 31 May 2023 08:22:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b003f17af4c4e0sm24905935wmc.9.2023.05.31.08.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 08:22:10 -0700 (PDT)
Message-ID: <641ce948-38cd-c220-47eb-9313e6ca1850@tessares.net>
Date: Wed, 31 May 2023 17:22:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 3/7] selftests: mptcp: test userspace pm
 out of transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685523463.git.geliang.tang@suse.com>
 <afd8f08766de7ccde5f6088f23c09e174d288c34.1685523463.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <afd8f08766de7ccde5f6088f23c09e174d288c34.1685523463.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/05/2023 10:58, Geliang Tang wrote:
> This patch moves userspace pm tests out of do_transfer(). Move add
> addrese test into a new function userspace_pm_add_addr(), and remove
> address test into userspace_pm_rm_addr(). Move add subflow test into
> userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

Indeed, it is clearer like that.

(...)

> @@ -3288,11 +3305,18 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns1
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_addr 10.0.2.1 10
> +		sleep 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> +		userspace_pm_rm_addr 10.0.2.1 10
> +		wait_rm_addr $ns1 1
>  		chk_rm_nr 1 1 invert
>  		kill_events_pids
> +		wait $tests_pid
>  	fi
>  
>  	# userspace pm create destroy subflow
> @@ -3300,10 +3324,16 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns2
>  		pm_nl_set_limits $ns1 0 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		userspace_pm_add_sf 10.0.3.2 20
> +		sleep 1

(I'm not a big fan of this "sleep 1" (and in the previous test) but we
were already doing that before in do_transfer() so OK)

>  		chk_join_nr 1 1 1
> +		userspace_pm_rm_sf 10.0.3.2 20

Here, we should wait before checking the number of removed subflows, no?
Before, it was probably OK because there were a few stuffs between
run_tests where the SF was removed and chk_rm_nr() but now, it is done
directly after.

The best would be something similar to wait_mpj() (or a "sleep 1"
because we have one just before?)

>  		chk_rm_nr 1 1
>  		kill_events_pids
> +		wait $tests_pid
>  	fi
>  }
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
