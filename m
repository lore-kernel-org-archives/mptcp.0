Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A0168
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 08:55:34 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id w14so5848122edc.8
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y+D3h7ZweYwgOkxoaI/Ex78lUK0xKc1dKJLFsIsKY3Q=;
        b=bbWUY/KaNS0pxSR32UezNmYvuMVizJte2qdlTNnMWxkJXS4N6Fh/18gzQwjax3dJDE
         3/HF6gIojNMdLiUqGseE6n30ViAf+Rt2jEsQN4n/b2fmWxIeaJXhRHuwy2Gapm4VXMQJ
         ozQaOdBoGgzkyQobJsABpI6iCKScjYEeoU+whMVPiZHCqlwzosIaAeU7KfL2IOYAAJ1u
         GhU367vZybJunbUKAS+ZIBxXrnpR/J5QRpNR0fy3LZv02IlFaFuxMt6LE08hHbyI6o4J
         +LAWLTg96xgIQQ3Ivly1Xy9THvpAYjNqhbhUl+kxcL+vhjThhdm7Isg/PKUOIyfQhToY
         +c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+D3h7ZweYwgOkxoaI/Ex78lUK0xKc1dKJLFsIsKY3Q=;
        b=dWQmaHVwnZtYPdF7g637HdwC2TOqNXJCqc4/pOJYcYS4CErHvhrkRpOOGBm7X//GsY
         CLPG8Wa5by6dGfgKwpFbPSYqxjk9NRZ5ZvNzmotteuW0PeaFxl0FVeTfL+UJ117jr4ec
         ummBXSJ/cg4epJWgx4cLC2ogGxvcI9wWtwAGVdWAJKsgFzJ1VQQSTrZk95idqe/NaJ83
         SNhN4uG3XVpNQHcSwzrz3Hh/hp6o+ml6G11jbSN/kBj9zyQVQMJgmzQbT3azdNypdIbv
         YlvzgN/jsiwvFApJrUoh4y3y7tKUYyhUHU7o4+CYrAIog2Ml7DvZHRYcmbCELclnfrE3
         2eIg==
X-Gm-Message-State: AOAM531gJ8hOBc6axru+Qxh5834ETccUmKWUlYdA1Yxx60tvnljAmMTb
	IqWlcGvfYqZ65CUomYDEmMC14J3pFX4+e+rJO8w=
X-Google-Smtp-Source: ABdhPJwyhPJ2E+4kZrh3wavsoQLPDYPgCIKdGwLeICGCXakMW2WPIuiCzTDFu2zMoxWl0aLW+I18Uw==
X-Received: by 2002:a50:954c:: with SMTP id v12mr48915669eda.313.1626944133253;
        Thu, 22 Jul 2021 01:55:33 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id k8sm12076963edr.92.2021.07.22.01.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 01:55:32 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <67cd742a1da03b8633e4837c45991860236af431.1626857584.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add
 testcase for active-back"
Message-ID: <63bcc8e8-cd71-a117-cf9b-dc0054336e26@tessares.net>
Date: Thu, 22 Jul 2021 10:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <67cd742a1da03b8633e4837c45991860236af431.1626857584.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 21/07/2021 10:56, Geliang Tang wrote:
> Drop the debug logs and make the output aligned:

Good idea!

> 05 backup flow used, bidi, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                         add[ ok ] - echo  [ ok ]
>                                         stale             [ ok ]
>                                         link usage        [ ok ]

I wonder if it would not be even clearer to display one item per line, e.g.:


05 backup flow used, bidi, link failure:
     syn        [ ok ]
     synack     [ ok ]
     ack        [ ok ]
     add        [ ok ]
     echo       [ ok ]
     stale      [ ok ]
     link usage [ ok ]
06 (...)

But that is for another patch anyway. I can look at that later when
trying to make this test more reliable by removing fixed values for
"sleep" and others if nobody is already looking at that.

> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 220154cb92a7..d0518487b874 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -228,7 +228,6 @@ link_failure()
>  
>  	for l in $FAILING_LINKS; do
>  		veth="ns1eth$l"
> -		echo "link $veth down" 1>&2
>  		ip -net "$ns" link set "$veth" down
>  	done
>  }
> @@ -634,7 +633,7 @@ chk_stale_nr()
>  	local stale_nr
>  	local recover_nr
>  
> -	printf "%-39s %s" " " "stale"
> +	printf "%-39s %s" " " "stale             "
>  	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
>  	[ -z "$stale_nr" ] && stale_nr=0
>  	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
> @@ -878,7 +877,7 @@ chk_link_usage()
>  	local tx_rate=$((tx_link * 100 / $tx_total))
>  	local tolerance=5
>  
> -	printf "%-39s %s" " " "link usage "
> +	printf "%-39s %s" " " "link usage        "

Do you mind if I change this when applying the patch to avoid plenty of
spaces?

  printf "%-39s %-18s" " " "stale"
  printf "%-39s %-18s" " " "link usage"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
