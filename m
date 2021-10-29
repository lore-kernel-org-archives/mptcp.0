Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973122C87
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 10:02:50 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id r12so37004434edt.6
        for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/AYa3dBjLkUEXXKyRfvjla3I2Jw8du4paZgbvAUsSHI=;
        b=AOMTsyD+g0oXWieK9niINmhYYqHpU6AR4yty3CptJmG+pRI1Qh3gMjZT39R23atuCA
         Sz2pU9sU3m8Ef044Mg4AEU02mRnMgzDIqNNaRJ/YRKu66XZs/FyeoNiSENJnEN3w7HYB
         4vGm8AETd1yIZKfDmoDY95AqWBdb/E3dx5CPGcyABAAcq5q3eP6qU8pNGTgABGymg2HS
         2tM07k1fA/Rk0Gw67UV+bg2ke6QIXJMCqmKWFg/SRt7TUGOImFCTd0MBsMJJ2CndaYeN
         vwnDBwNCQmtGJ/6FzzCqWNO+NG6H1tUpHZx4T694yotrW/+F9i2nsrt9OUCWlcl6lWN3
         iDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/AYa3dBjLkUEXXKyRfvjla3I2Jw8du4paZgbvAUsSHI=;
        b=mQ3XG4n/XCkItuC2+UTEAbOIEqZNX+DDQIEtWPm2cbvc2HXhFkS93rnE/XLNnp/Tjt
         K8k2gYzb4AXwFRzwJtlenBt9+8ioo+W2J2RM6GTtL+/fePrEf45uw9124sKvQAhx3Jse
         QJU0njm7EgYZB6MBO7JGRWpe9rg6w8IueyISs2NLUVFEh8XQg0C5EKLXahsiC6Zjql3k
         +mwpmI92dSSdlF7EGGRKlEjrPWfLolPi0KiwIlUGsrgaLCmRCVYN5LUeem3MlXpmyDFi
         npHT1YmHCJ66knplekM75RKqGGo74cMMzmA8FLdTl00pfEwfi+ipqPxfFLdWDKxvnvqW
         44zg==
X-Gm-Message-State: AOAM532LnKps7AOTjG5YCZF1kBvrVmo7F8s1uShjFp8XtHsaz4Z5E2IX
	IUOdNMp7u18glRBYPYr2pubuZQ==
X-Google-Smtp-Source: ABdhPJxLutup8y1Tp6RG8LKpjbtv1rNbz4UjKvywwMM/4SrBvWLtjxhLmKpenBua1dVgD4pn4cam/Q==
X-Received: by 2002:a17:907:2cc6:: with SMTP id hg6mr12674926ejc.21.1635501768245;
        Fri, 29 Oct 2021 03:02:48 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id bf5sm2579954edb.81.2021.10.29.03.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 03:02:47 -0700 (PDT)
Message-ID: <04774993-d824-0f62-c55d-bd21e46b99fb@tessares.net>
Date: Fri, 29 Oct 2021 12:02:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version.

On 29/10/2021 06:40, Geliang Tang wrote:
> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.
> 
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/config      |  5 ++
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
>  2 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 0faaccd21447..f522288b2204 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>  CONFIG_NETFILTER_XT_MATCH_BPF=m
>  CONFIG_NF_TABLES_IPV4=y
>  CONFIG_NF_TABLES_IPV6=y
> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_PEDIT=m
> +CONFIG_NET_CLS_ACT=m
> +CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_SCH_INGRESS=m
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..d33cb5ce0ff3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
>  	exit $ksft_skip
>  fi
>  
> +jq -V > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +	echo "SKIP: Could not run all tests without jq tool"
> +	exit $ksft_skip
> +fi
> +
>  print_file_err()
>  {
>  	ls -l "$1" 1>&2
> @@ -232,6 +238,28 @@ link_failure()
>  	done
>  }
>  
> +checksum_failure()
> +{
> +	i="$1"
> +
> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> +	tc -n $ns2 filter add dev ns2eth$i egress \
> +		protocol ip prio 1000 \
> +		flower ip_proto tcp \
> +		action pedit munge offset 148 u32 invert \
> +		pipe csum tcp \
> +		index 100
> +
> +	while true; do
> +		local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
> +				jq '.[1].actions[0].stats.packets')
> +		if [ $pkt -gt 0 ]; then
The CI [1] is complaining about that line:

[09:34:44.063] # RTNETLINK answers: Operation not supported
[09:34:44.107] # ./mptcp_join.sh: line 256: [: null: integer expression
expected
[09:34:44.267] # RTNETLINK answers: Operation not supported
[09:34:44.332] # ./mptcp_join.sh: line 256: [: null: integer expression
expected
(...)

This is displayed in a loop as it is a "while true".

But just before the first one, we had this:

[09:34:43.859] # Error: Cannot find ingress queue for specified device.
[09:34:43.955] # Error: Parent Qdisc doesn't exists.
[09:34:43.959] # We have an error talking to the kernel

I guess the previous "tc" command failed and I also guess you don't have
that on your side, right?

Maybe a missing kconfig?

I guess it is "safer" to abort if one of the tc command fails.

Cheers,
Matt

[1] https://cirrus-ci.com/task/6502115922149376
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
