Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D2173
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 09:11:13 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id b7so13041430edd.6
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 01:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xLlM+xYEfG1SVPryFo4Rh3jsuAcln5HJScW+C5uq4ck=;
        b=w5AMBBIbW6yLsafKTs0liCwpu1RIDhTZuldO732+OqMfZx28pEMB/0wqxY1oUxXr+1
         dCYqGev/XLGw43bsuKxqqoI5jrvWe9mI76UxylBxtpYx3hY0YuXtU6h5QZvz2pYy0+g7
         F8T3JAvO/N4ZG7tJ/BwkSakAYtVIO7o6CCEoG2ZVuc32NbpPcADjcBgS58geX2CSA3r1
         HrKBsIDAezqUpKDUkkN9aVmHdtCQD/MnxFGgJbeyUnsVaFQwkidA5Bdu0o3P6c/btWHF
         XyKnok7qaTUUKNG8lt/ZI+XaSsQiqP8NKo431z4e0HUmrI3ke7qMLABG1pcHvjyeG4S0
         0YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xLlM+xYEfG1SVPryFo4Rh3jsuAcln5HJScW+C5uq4ck=;
        b=tQXTNb+oGT1DnAlPGX1FgEcJoLVGMm/8BfL4+E2JIaO0JmTRCYHXOVXBb4oXi4mTVn
         Etn2pclj7CXQC70WN0aihiJfyjsoHv7NstlV6dKmS7hUvdfdrPru6l67ngO+tNdpRCyP
         F59RzAFVdshgNC3NkJDfEtwORUyKyuST4Veq8cKdTvzsSuKQsujdL6Oqa8PI1kBExrH4
         8DkLTF2VIPwyXHCGuOIO/ROBo21WzWLrr6RgTdYQPQ5sohH1RaIB+n3QHYHFHZte1/kp
         kidGSHJniqNbnWq7bhHZQe6hxBXi4HqYCUTGOB3PWdabKKwr4WOtXzzXfk4RQqIJb5Y4
         DwPw==
X-Gm-Message-State: AOAM533GaOdeSHX0i9jaHdAKK/phk29vsPCJkOOj4YBPLpQ1nFVD/B/d
	CjN9k0PZw+S+U8Ftt4BhvbRNART0jBbTLQ==
X-Google-Smtp-Source: ABdhPJzEiKqayLAGX5+qoG26ECLgSPF+7uArQ+aSqxxe5aGh5YE3jPbon5o72tHUfG1N4/T1lHAXtQ==
X-Received: by 2002:a05:6402:6cd:: with SMTP id n13mr319260edy.248.1639559471932;
        Wed, 15 Dec 2021 01:11:11 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id h10sm685893edj.1.2021.12.15.01.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 01:11:11 -0800 (PST)
Message-ID: <f86282ac-0bb4-7190-75d1-5d975016e591@tessares.net>
Date: Wed, 15 Dec 2021 10:11:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/12/2021 12:51, Paolo Abeni wrote:
> MPTCP join self-tests are a bit fragile as they reply on
> delays instead of events to catch-up with the expected
> sockets states.
> 
> Replace the delay with state checking where possible and
> reduce the number of sleeps in the most complex scenarios.
> 
> This will both reduce the tests run-time and will improve
> stability.

Again, thank you for looking at that!

> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - fix ipv6 addr handling
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++-----
>  1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 8f49bbd4a201..7014391d750e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -238,6 +238,42 @@ is_v6()
>  	[ -z "${1##*:*}" ]
>  }
>  
> +# $1: ns, $2: port
> +wait_local_port_listen()
> +{
> +	local listener_ns="${1}"
> +	local port="${2}"
> +
> +	local port_hex i
> +
> +	port_hex="$(printf "%04X" "${port}")"
> +	for i in $(seq 10); do

I think it is safe to increase the number of iterations. Most of the
time, we will never reach the maximum.

> +		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
> +			break
> +		sleep 0.1
> +	done

Probably here, we should exit with an error, no?

> +}
> +
> +# $1: ns, $2: endpoint id
> +wait_address_deleted()
> +{
> +	local ns="${1}"
> +	local addr="${2}"
> +	local cnt

May you declare "i" as local too please?

> +
> +	# 'ss' will trim everything from the rightmost ':' on looking
> +	# for a trailing port number. Append a colon to avoid ipv6
> +	# address corruption
> +	is_v6 ${addr} && addr="inet6:$addr:"
> +
> +	for i in $(seq 10); do

Same here, maybe OK to increase it to 20 or much more and exit with an
error if the address has not been deleted on time.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
