Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38712F34
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 11:31:10 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3112f256941so2785576f8f.1
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687779068; x=1690371068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gERBIlGxI99GWUF5vaQ2d5py6gBnVWIfhGjpgy8WrQY=;
        b=4kXkIzHT/qLl89x2oYW1uEovdzVnJ8deK2tskNpY0Vqf/IxdnzdftkRY8frTWUgtyw
         CKK6kc56rZ8i8eL4uw6u8DlUKCxeJGOcZ8X/ayXZpdeU9m+cm+Xsp2yQhkI6gcwWE3S2
         /wzY/4UANuTFc7fM3sDzOhVkfs7Z7pEmiMYz5p5NMmwqR6uDl+R80epPYR9yBQ3ZKOKy
         sMKZF161rd1RuwL2KfE02XHjfcYybI44BNpPPYvNQASU5BukY1V90JPHEbTp5VrzDUQ/
         rUOVFdr5zqBA/E//qB0zeT7xEtcrvWcpQPoMlP8JAS5RajqbHr0RTrU2R4fhvdcop6et
         +23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779068; x=1690371068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gERBIlGxI99GWUF5vaQ2d5py6gBnVWIfhGjpgy8WrQY=;
        b=RcBTsDhiyp2nkQ6DqAe6bC4pyKr7HGOV9HsNm8alJ4HbffRO2F6Qlr2+GchzxHgeiB
         qjq3MYwXiRamD8AsjP6N0oAiaLxMgLk+Z9UXyAqa4Nk9V9E1FVW3QO005UxyRMeOxZtf
         oBVNBWVp/IXMWs5W6YPYE36SKSu9J/t/Pt5FRGqNGw6aLlqOr5WWA8G5qoIUVWJi5T/D
         uT0En3g+pij1voVkN+np7QSP/mQHiFyUURaqFUuxoHtD3iHf2xp0cNZB/VopHOa+D2ls
         zHQVJxiQIX8Q1+QbJugD8fMQc1Xy+mOhAtlP3odSlMh4hxuunWHjFEgqCNBNOf6F5HRQ
         cfjQ==
X-Gm-Message-State: AC+VfDwc6cmTUaHgmM0LpQMgZyvkMgpSUHLddXcYwytyZpacNxIjKK2i
	WluYJfx8CnaxeCt2rFbUOD2N+Q==
X-Google-Smtp-Source: ACHHUZ4gd2DQ1gOHHln4uGh7opHG+KNoQJ+/BFFusFkbIFvAGuB9jwkJXj/y2y2eInbg43DxH7ivAQ==
X-Received: by 2002:a05:6000:42:b0:313:e2c4:7bc9 with SMTP id k2-20020a056000004200b00313e2c47bc9mr4450859wrx.31.1687779068690;
        Mon, 26 Jun 2023 04:31:08 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b0030e56a9ff25sm7063752wrt.31.2023.06.26.04.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:31:08 -0700 (PDT)
Message-ID: <94a77161-2299-e470-c0d5-c14cf828cd92@tessares.net>
Date: Mon, 26 Jun 2023 13:31:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 1/2] selftests: mptcp: join: fix 'delete and re-add'
 test
To: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang.tang@suse.com
References: <cover.1687522138.git.aclaudi@redhat.com>
 <927493b7ba79d647668e95a34007f48e87c0992a.1687522138.git.aclaudi@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <927493b7ba79d647668e95a34007f48e87c0992a.1687522138.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 23/06/2023 14:19, Andrea Claudi wrote:
> mptcp_join '002 delete and re-add' test currently fails in the 'after
> delete' testcase.

I guess it only fails if you use "-i" option to use "ip mptcp" instead
of "pm_nl_ctl", right?

MPTCP CI doesn't launch the tests with the "-i" option.

Can you mention that it fails only when using "ip mptcp" which is not
the default mode please? It might be good to include that in the title
too not to think the test is broken and the CI didn't complain about that.

BTW, how did you launch mptcp_join.sh selftest to have this test
launched as second position ("002")? With "-Ii"?

(you can remove this "002": it is specific to the way you launched the
test, not using the default mode)

> This happens because endpoint delete includes an ip address while id is
> not 0, contrary to what is indicated in the ip mptcp man page:
> 
> "When used with the delete id operation, an IFADDR is only included when
> the ID is 0."
> 
> This fixes the issue simply not using the $addr variable in
> pm_nl_del_endpoint().

If you do that, are you not going to break other tests? e.g.
- "remove id 0 subflow"
- "remove id 0 address"

(I didn't check all possibilities, maybe not or maybe there are others)

Because if you specify the ID 0, you do need to specify the address, no?

> Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 0ae8cafde439..5424dcacfffa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -678,7 +678,7 @@ pm_nl_del_endpoint()
>  	local addr=$3
>  
>  	if [ $ip_mptcp -eq 1 ]; then
> -		ip -n $ns mptcp endpoint delete id $id $addr
> +		ip -n $ns mptcp endpoint delete id $id

Should you not add "${addr}" only if ${id} == 1?

>  	else
>  		ip netns exec $ns ./pm_nl_ctl del $id $addr
>  	fi

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
