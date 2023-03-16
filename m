Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA536FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 18:28:34 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id eh3so11159002edb.11
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678991312;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCj/dsFUPHt+2zLp66tKlD/mP9lUiEnfSbMNbSEkzLk=;
        b=r487scWEd992sk5utzkVwnI418GwmCi24wXq96eYUq/CkNjudxGvSvBrgzF0jpRmX5
         5VjbvNAuqyGstZqiu4VQKl8xJ5i0IoDODfCbj3UzXMMpS57xblWrs1SGJGWrtJlkk3xy
         p0nNlqg/vNlvaDzOKPzaYwf0UdbKi+iSZCz3MDMOZmXgm7W6F0RHNEpWqssU4S7jdNyZ
         1TQ1l2HV8ipHIhwytDa2wvKjHJ4w4X08KOWq9EIBM++sM+je+ZBY/uzp/muctEEvtOqC
         Rl+yy++ie1yY50hLCAkQzYyd8vP4T5oHyymwYxcxwDglh2KQY89xFZpkVOma4U1G+6hZ
         7XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991312;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCj/dsFUPHt+2zLp66tKlD/mP9lUiEnfSbMNbSEkzLk=;
        b=c9X8GmyF/vZskzTS7J9hNeRjXmSwO6RjpB50Rwg89gJB1jwXreJrUHK2cdELQXPh2T
         CA+fRi2bs8ONc2htSrELtN92sUqsgqX2gHl9+y0ro2eH7jsy1PEY3R1t7QzdVwGSvKKG
         Ta9CoFdDXNVMAaGGZ6LEvzGOC7QJJvBKAfmfBGJqk5fjnuJ0DGcO4YgBudnh2nCGmMo2
         eGLmJJxxZcWFoLJ94d/ok3rVRMtaIEmZoR06I02H4kEc1paZEyyUs8/5lFL0KKsFSGcr
         DlEU/a6DMwUbBPm4YVoR4g8yzZ6z/XRvMJvB1qDFQjuYjRqeMdqZ0t/QRX8n+KFVkx3d
         p3bw==
X-Gm-Message-State: AO0yUKWPyLhwcfaodUI2fo8Te92U3KJz7tccpILw7NUMy5lOqorfSSVu
	G7qyHWn6+P74QSfekdKByXrMJoXiPRnawrrdugZpOvEv
X-Google-Smtp-Source: AK7set+rXqL4kpIMUXrprulrh3yQaM3kUKBOwV+9G1LGKwkPPkSGJBMZOdLqVEq7gBzDNtcUZpfpkQ==
X-Received: by 2002:a17:907:1c81:b0:8b1:304b:8e2c with SMTP id nb1-20020a1709071c8100b008b1304b8e2cmr14622408ejc.0.1678991312479;
        Thu, 16 Mar 2023 11:28:32 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709064fd200b0092be390b51asm4082757ejw.113.2023.03.16.11.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:28:32 -0700 (PDT)
Message-ID: <304751f6-81ce-56b6-812e-d6202348c106@tessares.net>
Date: Thu, 16 Mar 2023 19:28:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v5 7/7] selftests: mptcp: check userspace
 mptcp_info
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/03/2023 08:31, Geliang Tang wrote:
> This patch invokes chk_mptcp_info() to check mptcp_info of userspace PM.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 506120401abe..8ca5accd5c82 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -842,8 +842,11 @@ do_transfer()
>  				tk=$(grep "type:1," "$evts_ns1" |
>  				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
>  				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
> +				chk_mptcp_info subflows_1

Will this not print message before displaying the title of the test?

>  				sleep 1
>  				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
> +				sleep 1

I'm not a big fan of using a sleep here, it is a source of random timing
issues I guess.

Could it possible to wait for an event to stop waiting when this happens
but also with a possible higher limit in case the host running the test
is slow/busy.

Maybe you can use wait_rm_addr?

> +				chk_mptcp_info subflows_0
>  			fi
>  
>  			counter=$((counter + 1))
> @@ -906,11 +909,14 @@ do_transfer()
>  				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
>  				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
>  									rip $da rport $dp token $tk
> +				chk_mptcp_info subflows_1

Same here for the print message before the title? (or maybe enough to
check in endpoint_tests()?)

>  				sleep 1
>  				sp=$(grep "type:10" "$evts_ns2" |
>  				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
>  				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
>  									rip $da rport $dp token $tk
> +				sleep 1

Same here with the sleep. Maybe a "wait_xxx" function?

> +				chk_mptcp_info subflows_0
>  			fi
>  			counter=$((counter + 1))
>  			add_nr_ns2=$((add_nr_ns2 - 1))
> @@ -3148,6 +3154,10 @@ endpoint_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>  		pm_nl_check_endpoint 0 "modif is allowed" \
>  			$ns2 10.0.2.2 id 1 flags signal
> +
> +		chk_mptcp_info subflows_1
> +		pm_nl_del_endpoint $ns2 1 10.0.2.2

Just to be sure: here, the userspace client will send the Netlink
message and wait for the kernel to do the action before stopping, right?
In other words, just after this line, the counter have been updated, no
need to wait?

> +		chk_mptcp_info subflows_0
>  		kill_tests_wait
>  	fi
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
