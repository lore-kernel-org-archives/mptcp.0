Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4704A52
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 17:34:02 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so53443095e9.3
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683135241; x=1685727241;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3nY2GnRY75jgPaYvo2ljEqTcH6nmD1NzzqeFFCmExM=;
        b=4NhJDB08r86LskajX/dPorzFeBOp9E2oM0g2HMtxtCE1IW39B3dtTtaUBW96pCA3AH
         /8x68zXewBZhH02RXEu9P3Bo2y6usFIOutgfL7hOHYbtD5+pI9KIRGkj8EspwbsEKa1n
         MC3C3kJaTfODKT26tEqsGwNc6tDrtaVYm1irFJZrI2QzTOSHFofOIokucJ4QS7lhwL+r
         eS1v7FQToE8DymXeAZ8BKXIuI21m2elFHLi6TgM8Zz0psUadiB9PeBJjGYZNknXwFNsj
         EgfXW7FogPMBPF9aMQYQYAmS4rEzsSvPguB5T9X4ArlvkQX5mqSWb/ElOUQnflEllj6r
         LOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135241; x=1685727241;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3nY2GnRY75jgPaYvo2ljEqTcH6nmD1NzzqeFFCmExM=;
        b=hotuY45/Ggq6VBcmqYIcD//cip7yUpzn0gIwkTj3/DbgdZ6NlMtM8ddl2rcEtmCF6E
         9FwRdP9DToBxMrcUMuB3+G63/RF9/jY1IoNDUON0MuNA7/+3wl6k034D63xk5R/ZSVHc
         3p98oNBp/ofGy5Dtlo05b01zKA07ieGS260URgOm/O9M81z6vJ2UjHuFzYeRmgJcSRfc
         D9foQkWPxboiR6u4PM3XhrBgArW0VTTd+FtLzaPxdHMzkyfkHZ4+s3zNvQ2IM/cVn7pZ
         m4MnfQism75c5rizSW3jb8N+iq2HxC8UIE/vXa4ing03CrfiLQZWxNpKgfclnqewAnEH
         JNmg==
X-Gm-Message-State: AC+VfDzuK5cVYjsVbkL5EToO8QKoRqWPvf2jDK+BEcYib87Hcx6PSTL2
	dPE+8Qjsi6f98U9XAHXuORAjgw==
X-Google-Smtp-Source: ACHHUZ7Ar0UQJUUA2fPwHUeVBsA+wP0ecX8ixDHTjQ7JGt+jwZGmhFd1nfYCYSA9xwvazmpaDzLf8g==
X-Received: by 2002:a1c:6a14:0:b0:3f1:7324:c81d with SMTP id f20-20020a1c6a14000000b003f17324c81dmr16358175wmc.14.1683135240734;
        Wed, 03 May 2023 10:34:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f18b942338sm2513285wmc.3.2023.05.03.10.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 10:34:00 -0700 (PDT)
Message-ID: <658236c6-dd35-dd20-b72a-8794fab1d36a@tessares.net>
Date: Wed, 3 May 2023 19:33:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v10 2/6] selftests: mptcp: update userspace pm
 addr tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682499136.git.geliang.tang@suse.com>
 <2663cbe9ab1203202f2ae587475abc36fa93e4fb.1682499136.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2663cbe9ab1203202f2ae587475abc36fa93e4fb.1682499136.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/04/2023 10:56, Geliang Tang wrote:
> This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
> nl_cmd_remove").
> 
> To align with what is done by the in-kernel PM, update userspace pm addr
> selftests, by sending a remove_subflows command together after the
> remove_addrs command.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 26310c17b4c6..67d5d724266a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -850,6 +850,14 @@ do_transfer()
>  				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
>  				sleep 1
>  				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id

Out of curiosity, why did you have to move this command before the
destruction of the subflow (just below)? Is it because since v10, we
cannot remove the subflow if the subflow has been destroyed?

For the moment, I guess it is OK because if I'm not mistaken, we don't
check that the subflow destruction has been done, right?

If at some points we do verify the following command is doing what we
expect to do, my fear is that the next command might not work if we are
unlucky: when the RM_ADDR from the previous step will be received, the
other peer will destroy the associated subflows, no? If yes and if it is
done quicker than launching the following command, the subflow could
already be destroyed and the following command might fail, no?

Maybe that's not an issue because we don't check for errors in pm_nl_ctl
(which is maybe not a good thing but that's another problem). So fine to
keep this like that, right?

> +				sp=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				da=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> +				dp=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
> +							lport $sp rip $da rport $dp token $tk
>  			fi
>  
>  			counter=$((counter + 1))

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
