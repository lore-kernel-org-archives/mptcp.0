Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80872
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 17:57:14 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id r25so41831251edq.7
        for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=1L6mUCKypcGh3LE+1bRhRioxAzYG78cjfPvO+lfQEeE=;
        b=OnDSAJ5XmCvwAWoLyIs04Vd7BuCyJFG2gUhh7MPEEZej5s2/Yycah59CZ1UJJ8Ay4O
         fgg2Dc+pCCAvnvEbyapJBeF/pu3ip2B8zPTq3WtD8fHiDSHYDgN5JsmtkLwMR0jq/m7o
         7Txdl7EvUksk0PCAsnVBDPmmojnIXLTq9rxoh9Y3+71dWNwxmg4XxoqWOhcUW04sjInh
         hvSiYg7uyF11F531gaLLvVyYPgw0RhxYxdHoE+m38NqrkqsiPPjZ1TgPMe2ScJijnVZT
         AhIRjOXo91W5NgWkhLelYcZxAZ0fM6xOFZxUj/n8U8NdWILlKueX+W+89l3w7Hb/NcXu
         L3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=1L6mUCKypcGh3LE+1bRhRioxAzYG78cjfPvO+lfQEeE=;
        b=bmt1SLwY/Zvf+vaug1c23N6fIHJ0DDqZRBnOTIJ+cB9kfK+PKpOFPnU6UKTAj7VWYY
         QYrNh3LDdSy+iIwEAS6gMkHVX500fvZNUepKM22x5dkiLrpnnCmIiK/FypBbNYDHEajO
         DCp9xA+h9FMFU5oUYtnSOjZAisenZt7MeBGWm6firvueHkKMO7GmL6uDQniHW7wYxiLd
         NdDVmUTDIi8O3VToSddHUL0ADrWsJlspkUrT480tBtYbbPE/K1ngAQADD1ucrU4ONj/M
         x5r4a+zwnorzJjhuQjyTG0fdr+BYxrX4Zia/qNdUZFaP8v6V2no2Jr9e0NVo65dNAwYl
         xF8A==
X-Gm-Message-State: AOAM531pTK8zc0gVR/cgF542ya2lyLxSmGE/Mz3pX0hTfrf1Lj1sMbmi
	nUEjzCUm9RsLI3kUf7a29OKMnOeLLjpJMUI37g0=
X-Google-Smtp-Source: ABdhPJzVpJcmnzyBDJzb039nh+Vtp2GGrNpIKk4SD2FH0N8zVcvELiRCaJU5WcRIgHaQVnff4aMdKw==
X-Received: by 2002:a17:907:7e8e:: with SMTP id qb14mr39163837ejc.562.1637949432723;
        Fri, 26 Nov 2021 09:57:12 -0800 (PST)
Received: from [192.168.178.33] (213.211.136.227.static.edpnet.net. [213.211.136.227])
        by smtp.gmail.com with ESMTPSA id qf8sm3481784ejc.8.2021.11.26.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:57:12 -0800 (PST)
Message-ID: <f1d607c7-f718-7f32-b1c3-6f297b13e594@tessares.net>
Date: Fri, 26 Nov 2021 18:57:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 mptcp-next 4/4] selftests: mptcp: add tests for subflow
 creation failure
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1637929034.git.pabeni@redhat.com>
 <b4985eeb6e1d04ca82bd6abfcb382da71a2e396b.1637929034.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b4985eeb6e1d04ca82bd6abfcb382da71a2e396b.1637929034.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/11/2021 13:19, Paolo Abeni wrote:
> Verify that, when multiple endpoints are available, subflows
> creation proceed even when the first additional subflow creation
> fails - due to packet drop on the relevant link
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - add missing NF kconfig
>  - add more test-cases (drop, later subflow creation)

Thank you for the modifications!

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..6d342f9985b8 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -975,6 +975,22 @@ chk_link_usage()
>  	fi
>  }
>  
> +wait_for_tw()
> +{
> +	local timeout_ms=$((timeout_poll * 1000))
> +	local time=0
> +	local ns=$1
> +
> +	while [ $time -lt $timeout_ms ]; do
> +		local cnt=`ip netns exec $ns ss -t state time-wait |wc -l`

(no need to change but it is often recommended to use $(...) instead of
`...` because it supports nested commands and is more "visible")

(...)

> @@ -1859,6 +1918,7 @@ usage()
>  {
>  	echo "mptcp_join usage:"
>  	echo "  -f subflows_tests"
> +	echo "  -f subflows_error_tests"

Detail: s/-f/-e/

I can fix it before applying if you didn't already plan to send a new v4 :)

Cheers,
Matt

PS: for the lagging a bit with the reviews!
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
