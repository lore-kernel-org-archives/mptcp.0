Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E168
	for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 14:36:02 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id r11so77837811edd.9
        for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=L/HcTTwaiYDVqlK+n41ZEgJuitsholfkyhfrQQubNL8=;
        b=PHozfD0euT68rQuDTDwL7X8nACuyzFLQkkaN+GHAccCeic1fdnEgkT8SAMdoSUUbxc
         RiTlJ05gVzOwNRXoA0tbvzkwTepOVw086XN0zxEadWnPiLRv8GVux72hlwvEHBjYRO0h
         qg/g6k5lbYvN1FHQRo2P7usboaOh+5m4d5DCOyMT+Djj0JUVnCa9NoG6so4eTYXudDzA
         4jPTMgplO5NTVk8ue7Mzcux3N/JPWO0syY6rwU8UJCC4/q64BlQRC9bpumS4vKEPr+vi
         3z9z7a1jVWjnFz4QJX0m7muzJnBjY82udV7QAF3AzpLDLvXWf8/tHKXMZeET46N3HguZ
         el3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L/HcTTwaiYDVqlK+n41ZEgJuitsholfkyhfrQQubNL8=;
        b=8Rh9b5XSl7gVFUZyAgv+ggSYckVYJnNApJzaxT5ij6dAOKG5br1whMYGPZDu6/4QN4
         hU6EZ+JZjtr2L7XvcUlP7D18H4Wb8zZsfFIFs2+gw4e+Mx3SPVAJOtikj9cBNCI0x+eJ
         m2Mi8Qleuw3eM6Lag2o/f1hfRPpLFH352jsEYJ3Qwvg5VYl1iPG/f72wH9fHcbPW3Teg
         DrQ0sy3SfDt+xleIA2nSYqSJdJLkAXGbXqygKkLTm0P8ULFE9yTMjP9ARYTZodmipU+H
         5Fb4lNyIwBpnfT+ChB2UgTlW9yuMjaLYCil3MNSi507HigXVHBqko1XLRs9WFZowlqtK
         u3rg==
X-Gm-Message-State: AOAM533V1SvZgxaAO5UlK920eiIjuaJ41pLtGRh72jQ+5qBKMm1Lg8QC
	yg4REyYgyUiutSFsHZ5p/SQjsA==
X-Google-Smtp-Source: ABdhPJyPwEeZzNM/s3Rm974Gz56G+NUDOG+OwIUyF3UG2EL6aLkPTGnam8+oRgwNVaB0vZNRzMjSLQ==
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr41355857ejc.126.1637591760401;
        Mon, 22 Nov 2021 06:36:00 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id gn26sm3945831ejc.14.2021.11.22.06.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 06:36:00 -0800 (PST)
Message-ID: <b9951397-8ca2-0ceb-3f99-28957a2791bb@tessares.net>
Date: Mon, 22 Nov 2021 15:35:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 1/2] mptcp: getsockopt: add support for IP_TOS
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20211122112205.16752-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211122112205.16752-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 22/11/2021 12:22, Florian Westphal wrote:
> earlier patch added IP_TOS setsockopt support, this allows to get
> the value set by earlier setsockopt.

Thank you for sharing the patches, good idea to add this!

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 11cda8629993..5626b49c0270 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1066,6 +1066,24 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
>  	return 0;
>  }
>  
> +static int mptcp_put_int8_option(struct mptcp_sock *msk, char __user *optval,
> +				 int __user *optlen, u8 val)
> +{
> +	int len;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	if (len) {

What can be the possible values of 'len' here? Can it be negative?

I'm asking this question because when I'm looking at similar code in
mptcp/sockopt.c, I see different behaviours:

- mptcp_getsockopt_info(): no additional check but we suppose 'len' is
unsigned

- mptcp_put_int_option(): same but we return an error if len < 0

- mptcp_get_subflow_data(): we check if len is not < the expected size

In ipv4/ip_sockglue.c, we check if len < 0

I don't know if we should uniform that and always do:

    if (len < 0 (or expected value))
        return (...);

But I'm fine with the current version if we would never have a negative
value.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
