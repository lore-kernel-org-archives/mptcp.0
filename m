Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407E1C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:45 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso198092f8f.0
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681832024; x=1684424024;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Khex4EclKeruQ5sr8l0EapJ/1GcOvTaV/RQIJ/Hz4c=;
        b=Fp+tfXgaPrrqww52dVckzwoV7++zhm/r8ksrpJO78x1INhoZeiTfbvUA2vm3Zzlnnd
         TiLgLEAyKRxlQThyfoDMVp2XjfWlngkI1ldUpR7ghzGA1d7WAOohKRklfWEX45uDf5B6
         boxlV4JKygpiNPEfcQaYJk0igh0bhbI+/GxfOHsKOW/J/iKSnHhM/8HNUNrIO/R4AUjY
         P/iDEZk2gUBYch0Px9X+qvau1L0TEkEqhR5ys4hD38tTxcul9NSpVa+v4j9EmqGaM/l9
         XhJUhCdZF0q8LaqZXuAfcflFoxXW/Q3D9Jja5KBbAzSdXFQB33baiP4HkseE37ZyftKK
         ACiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832024; x=1684424024;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Khex4EclKeruQ5sr8l0EapJ/1GcOvTaV/RQIJ/Hz4c=;
        b=h47lzkZINWAWHWGtzfS6NFXXyNxXWYcBBQzZ7zwgKjVRC8Cg0W0TJD0czOP0eTFfLX
         fXFP3gVrsidjmnQ81gC2pxpeBUrCUMiU8Wng6cHCnkFt05HiPzU/HZ4Zh5WQ7JPtxyNS
         rdTQcp9sUkd0Eho6SMDYXj/Z4B3dbI6mztvSOOkcnOd6o36KEIvbs8qa/aKJbggk6FFL
         PgrDwq4tocIY5IbjKKcuCNe1URelPcYKdXsTb62g3LOiMWNXToIchGEc6idmiBSRCQ+v
         x4eaI4xZqEvfA21FG6LC4UWKzZ7h6aSiFTR/ZlDml8P89/rXlqZasXD/syvt8iw08o8Y
         u92g==
X-Gm-Message-State: AAQBX9ep+ZI/HECr9NF3QV7Nxoj5FmNRMuyp71d7oUKBGtwOHWQeG030
	Rpn6MpolPIrHK/f5BXE6qw+Z/ZaPEHhgFQz33hHS7g==
X-Google-Smtp-Source: AKy350bWcM/oP3ORRuSIxlDYF9HPIUttkFa320LLHuDpmSAD6iB5f6dExgrWgYLlJw3Fj2aaMbo1Mw==
X-Received: by 2002:a5d:63c3:0:b0:2ee:d53b:d9ef with SMTP id c3-20020a5d63c3000000b002eed53bd9efmr2064602wrw.55.1681832024082;
        Tue, 18 Apr 2023 08:33:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id k16-20020adff290000000b002f53fa16239sm13378548wro.103.2023.04.18.08.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:43 -0700 (PDT)
Message-ID: <140ddabe-9d36-37d7-7f54-bc506aabf7e5@tessares.net>
Date: Tue, 18 Apr 2023 17:33:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 7/7] selftests: mptcp: check userspace
 mptcp_info
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

I think you missed my comments I sent on v5. I re-added them here +
additional ones.

On 14/04/2023 11:11, Geliang Tang wrote:
> This patch invokes chk_mptcp_info() to check mptcp_info of userspace PM.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fafd19ec7e1f..bc47b99f47e5 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -842,8 +842,20 @@ do_transfer()
>  				tk=$(grep "type:1," "$evts_ns1" |
>  				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
>  				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
> +				chk_mptcp_info subflows_1

Probably best to do the check after the sleep here just below.

Also, this will print a message before displaying the title of the test,
can you fix that please? → maybe do the checks in endpoint_tests()?

(I'm not a big fan of this sleep: it might take longer on a very
slow/busy environment making the test unstable (or way shorter and we
wait for nothing) → but it was already there before so OK to keep it)

>  				sleep 1
>  				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
> +				addr="::ffff:$addr"
> +				sp=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				da=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> +				dp=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
> +									rip $da rport $dp token $tk

See my comment on patch 2/7, this should be part of patch 2/7 if you
don't mind.

Also, on slow environments, could we not have a situation where the
REMOVE_ADDR signal is sent to the other peer, it directly reacts by
removing the subflow and at the end, this "dsf" command is not doing
anything, causing the test to fail because it expects the listener side
to delete the address.

Should you not first delete the subflow, then send the remove addr? (or
skip the deletion of the subflow command and expect the client to remove
the subflow?)

> +				sleep 1
> +				chk_mptcp_info subflows_0
>  			fi
>  
>  			counter=$((counter + 1))
> @@ -906,11 +918,15 @@ do_transfer()
>  				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
>  				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
>  									rip $da rport $dp token $tk
> +				chk_mptcp_info subflows_1

Here as well: it would be better to do that after the sleep here below
and the message will be printed before the title. → maybe do the checks
in endpoint_tests()?

>  				sleep 1
>  				sp=$(grep "type:10" "$evts_ns2" |
>  				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id

I think this new line and the switch from "chk_rm_nr 0 1" to "chk_rm_nr
1 1" here below should be part of a dedicated commit and mention it is
linked to patch 4/7 ("mptcp: add addr into userspace pm list"). It might
even make sense to add this new dedicated commit just after this patch
4/7, no?

>  				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
>  									rip $da rport $dp token $tk
> +				sleep 1
> +				chk_mptcp_info subflows_0
>  			fi
>  			counter=$((counter + 1))
>  			add_nr_ns2=$((add_nr_ns2 - 1))
> @@ -3123,7 +3139,7 @@ userspace_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
>  		chk_join_nr 1 1 1
> -		chk_rm_nr 0 1
> +		chk_rm_nr 1 1

(see above: to this can go to a dedicated commit)

>  		kill_events_pids
>  	fi
>  }
> @@ -3148,6 +3164,10 @@ endpoint_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>  		pm_nl_check_endpoint 0 "modif is allowed" \
>  			$ns2 10.0.2.2 id 1 flags signal
> +
> +		chk_mptcp_info subflows_1

It might make more sense to add "chk_mptcp_info subflows_1" after each
call to pm_nl_check_endpoint here above, no?

> +		pm_nl_del_endpoint $ns2 1 10.0.2.2

You need to add at least have "sleep 0.5" here I think.
Or better, use:

  wait_rm_addr ${ns2} 1

> +		chk_mptcp_info subflows_0


>  		kill_tests_wait
>  	fi
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
