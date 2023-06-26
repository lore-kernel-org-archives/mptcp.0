Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300A2F34
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 11:32:20 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fa8ce2307dso18826345e9.2
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687779138; x=1690371138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtIGb3DGs6ORxwMHh2zIr61s5YjYStV/ELWxg6zJayk=;
        b=q8MYEDztUITruAnWoW3MK7K2brQhw57sFUlJhK/DE4DhILVbnOurOgAkGF8S75EYAL
         8XTuhTWdzYW6mTavRR9tu3/b3Iw47VzjDKWMLSHtyDj9+uLr9Wo9+Nv0B4itcwac4eu+
         VUaxMMnkyoz04MOH/qRBk1NMdsClpXKv+p1Ud12cVOHIGjUz4dXXHwO1orrANep96Y2X
         H7bKjrLymxUsirLTSTha3imv/9dfyLs1qf6I0K7riw3lfa9+KOpG9HTilDyEO99Kbz3E
         VVel6FDdun1AS9sqj1s9X9re3wHk3UDHqMVd0lJdcl6AQvoYShyTBeHJNMc9Sl2DA/Qh
         UaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779138; x=1690371138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtIGb3DGs6ORxwMHh2zIr61s5YjYStV/ELWxg6zJayk=;
        b=J36Y1JOMBOj/AJFblJty65TXBnTnKs/go0w3ceekCLAVB4rP+NAGaCcxLX3On3L8/y
         DQnj4abWT7FVtB983NKcsKMigL/Tury2ELw3nbRt87F6wZSV222SBxIQ4U1dOXVNyn1H
         R477SxguMwap7V5kwHREjElfi+13uvTVW0T8LnWHxXCA9+svhUK7RYt14pK+mtom8ssh
         nF7u2WBeZdmGJ+T1rnc2Pf4dlSNSnyvuJkhZqIV7Q5f4DRJ6ytb/El1O3Ajd7mL0XLaK
         o+a5/PplRx0dPiIG+63MxnrRp3haqbpTM7OufKqxX0x8qCKFFUz4PF3L7x1ZSxxJcscU
         xA1A==
X-Gm-Message-State: AC+VfDxKPX3PFLEgQw+3aICStcynVcAiAE7vo2L1GUFmseWwVL4/2Deg
	DfXrkO+w2wi35M35nv7c6HDTIw==
X-Google-Smtp-Source: ACHHUZ7MVi2YOfP5h4JdlOhtJLj4TNwX54QtQb76jF+k9lSJ67Jqk8JaGJ6YPe88htpSVu4e7D7jkw==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b64 with SMTP id w3-20020a1cf603000000b003f8f80e7b64mr32422604wmc.17.1687779138570;
        Mon, 26 Jun 2023 04:32:18 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f8d770e935sm10466775wmj.0.2023.06.26.04.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:32:18 -0700 (PDT)
Message-ID: <30ecb04c-47b1-fdf8-d695-e9b9b2198319@tessares.net>
Date: Mon, 26 Jun 2023 13:32:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 2/2] selftests: mptcp: join: fix 'implicit EP' test
Content-Language: en-GB
To: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang.tang@suse.com
References: <cover.1687522138.git.aclaudi@redhat.com>
 <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 23/06/2023 14:19, Andrea Claudi wrote:
> mptcp_join '001 implicit EP' test currently fails because of two
> reasons:

Same as on patch 1/2: can you remove "001" and mention it is only
failing when using "ip mptcp" ("-i" option) please?

> - iproute v6.3.0 does not support the implicit flag, fixed with
>   iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
>   flag")

Thank you for that!

Out of curiosity: why is it in iproute2-next (following net-next tree,
for v6.5) and not in iproute2 tree (following -net / Linus tree: for v6.4)?

> - pm_nl_check_endpoint wrongly expects the ip address to be repeated two
>   times in iproute output, and does not account for a final whitespace
>   in it.
> 
> This fixes the issue trimming the whitespace in the output string and
> removing the double address in the expected string.
> 
> Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 5424dcacfffa..6c3525e42273 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -768,10 +768,11 @@ pm_nl_check_endpoint()
>  	fi
>  
>  	if [ $ip_mptcp -eq 1 ]; then
> +		# get line and trim trailing whitespace
>  		line=$(ip -n $ns mptcp endpoint show $id)
> +		line="${line% }"
>  		# the dump order is: address id flags port dev
> -		expected_line="$addr"
> -		[ -n "$addr" ] && expected_line="$expected_line $addr"
> +		[ -n "$addr" ] && expected_line="$addr"
>  		expected_line="$expected_line $id"
>  		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
>  		[ -n "$dev" ] && expected_line="$expected_line $dev"

It looks good, no need to change anything here but later (not for -net
anyway), we should probably parse the JSON output of "ip -j mptcp" instead.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
