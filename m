Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0368
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 13:27:18 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id l25so8247673eda.11
        for <mptcp@lists.linux.dev>; Wed, 08 Dec 2021 05:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vE4rTskBUEHZSMzu6FklMclI2tVnxWRhcTk9pDXpv3o=;
        b=k1R9c+FiUAKO7HuaDoPBhkW01LAzXk1JCMU6XHtpTe54Pv8Vg57Ibar3WliU26ig6p
         zEtEgVRZ78mLIaAYSjpW5hOPu808zQ0RSg5PotkYJnKS+Y+kDwoteUr6GVVlS28K2Lk9
         L0N7jRJSGNvVONU49vB+pgih3Aec1UUxSmPP28yBbE+CKAGIXDKu5Ciylgyx6HcbnQUE
         e9sn/uFPwQlPTgkCvwRcmK0TsUo8fbQU4l3fNRS8fUNXqexzDRtonQBmXLwzAZtEejp8
         Rfo4DZ0MV/xYPXsv+v21l2s4Kmx2MNmZUrvV1UUP2u2JMG43MIh/dUxPtgQ70xMseSuf
         ynCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vE4rTskBUEHZSMzu6FklMclI2tVnxWRhcTk9pDXpv3o=;
        b=hZzuyMXPVvau0OJ5VRT3bUfeqiJxeIMh/NmKw36frzaTZfGu2U2ss6SoYXSlLgfDbH
         i02/1zKjdMejmFyZ8fYtqEIb21WyUj+gp2Y69NE95WWVQh6Out7BeGjraktT8VloZVjl
         YS7oI5cegXbgUksVBGrV4BLKXbrSQu5AyLbGWzqRVG6CQT7jSu7CWfkPtirYEOwy/oMg
         sGkj31LPU7vWdTq93po3KPJijkAvc8NAoAiFtNIqMSW7vZHv9420IjjWYliWQ7YXZK9e
         10o+Hb/eTqNGW7T2cImkXmQ6XID75h4xFdonjVl0vj6HdjfvRyCHd/uh9GXYhw6eySou
         rv6Q==
X-Gm-Message-State: AOAM533fMtQ1ZDoDcii2ZE5d2M217vUEMAoB5WxJSr7/u3UuvXnx52PC
	tL2lEp1twuuNSl2Diu1BSwGBlA==
X-Google-Smtp-Source: ABdhPJyZvwVEEDqgPEbHyq8Yd90Erf7u2plMBOJ721mKNwl20elt3Im6cyoXfJkFK04UgMvD1agHkA==
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr7455899ejh.501.1638970036644;
        Wed, 08 Dec 2021 05:27:16 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9dd5:a52b:99d6:b584? ([2a02:578:8593:1200:9dd5:a52b:99d6:b584])
        by smtp.gmail.com with ESMTPSA id s2sm1611553ejn.96.2021.12.08.05.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:27:16 -0800 (PST)
Message-ID: <3d159120-5a6b-865f-9322-b5e853f68d96@tessares.net>
Date: Wed, 8 Dec 2021 14:27:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v4] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>
References: <cover.1638762825.git.geliang.tang@suse.com>
 <cbe88a11722b5d7ce89760410a90c237870bb4f2.1638762863.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cbe88a11722b5d7ce89760410a90c237870bb4f2.1638762863.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/12/2021 04:59, Geliang Tang wrote:
> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.

Thank you for the new version!

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..7a9dec7fa648 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -160,6 +160,48 @@ reset_with_allow_join_id0()
>  	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
>  }
>  
> +# Modify TCP payload without corrupting the TCP packet
> +#
> +# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
> +# packets carrying enough data.
> +# Once it is done, the TCP Checksum field is updated so the packet
> +# is still considered as valid at the TCP level.
> +# But because the MPTCP checksum, covering the TCP options and data,
> +# has not been updated, we will detect the modification and emit an
> +# MP_FAIL: what we want to validate here.
> +#
> +# Please note that this rule will produce this pr_info() message for
> +# each TCP ACK packets not carrying enough data:
> +#
> +#     tc action pedit offset 162 out of bounds
> +#
> +# But this should be limited to a very few numbers of packets as we
> +# restrict this rule to outgoing TCP traffic with only the ACK flag
> +# + except the 3rd ACK, only packets carrying data should be seen in
> +# this direction.
> +reset_with_fail()
> +{
> +	reset
> +
> +	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
> +	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
> +
> +	checksum=1
> +
> +	make_file "$cin" "client" 20480
> +	make_file "$sin" "server" 20480

I don't think you can call make_file() with cin and sin: it means all
tests running after will have a different size than the expected one,
no? I guess you should generate files in another variable than $[cs]in.

Also, we should really make sure not to have a lot of pr_info() messages
that will cause confusion and issues if they are too many. To avoid that
and as written in the comment above, only the server in ns2 should send
data otherwise the server might send a lot of pure ACK and cause a lot
of pr_info() from tc. Maybe easier to use $cin with the default one byte
and $sin (using another variable, see above) 20480.

(...)

> +fail_tests()
> +{
> +	# multiple subflows
> +	reset_with_fail 2
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_2"
> +	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> +
> +	# single subflow
> +	reset_with_fail 1
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_1"
> +	chk_join_nr "MP_FAIL test, single subflow" 0 0 0 1 1

With a single flow, are you not going to have an error because one side
didn't fully receive the expected file?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
