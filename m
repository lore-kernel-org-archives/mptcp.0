Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985E19A
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 14:35:24 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id vm8so5592173ejc.2
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wL7pD563D5ZyaMuSARJ3H/TDysye2xgnYOU0JKiIV14=;
        b=cv/MwmlbE+z7DbkyHYuqp87SGHgZyHAvsBrbwovf3w6114/addeW+AWOhGCG7gqvQ2
         ocaIh/bbSnEqO4jNipWKPJfQ1x+NB+SgQft0D51aMLGDrtgsQnH4XSZ+vr3NaptoUyCu
         iLOEYNin8tmvJsdcQkZVIF4tyYzb8DJnubbIpAmHalKLg3G3aBj2Nru5E2TOnd2H3BLE
         M34kzCnVwtT7I7h7Wo1OPzG67SE+mmc5rmv02ylyJD56BOvCAHrv85bfSD0f7V1lt6K4
         dsptz8Aor0hLn0Ss5X8iBL1j9VSI95avrhfM0OkZ3ZymSMIu1ypwnOYF5hCK0P1bgZOl
         52eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wL7pD563D5ZyaMuSARJ3H/TDysye2xgnYOU0JKiIV14=;
        b=CJ83m8qN/Yn+/+Xr2VOvVjA/K0cC2VZOt/FpvkfS7sI9BpJMrKcF7bCXC97TZybcos
         7eFs/qlnyWYd0qz4FT/9tNPIS8CusRiq5qlqWaNoDeZKeniwR8qZreeqkEDCNGnG5WTC
         2n8REYLWVr8dGznHCM5/xxFn4nyvcdxyTODckZ97z8FhxvIgGSc+3pb10u2xGfhpTGQo
         IzkO8rbCC6iHEL522sjkVTF86XTK6cIIQiKEM/etIQyfwbyjI5BXQl1YSxuQfYjfFrKi
         ZQIof2EdKKHYXpe2y3RnpvkW6QX9VspYJdWga7mfj2Ve8RvArzcyXJbaVd2ZlWVlhCht
         6RBg==
X-Gm-Message-State: AFqh2krU11QFCrx42kqFWMpoV55bJcLtF1gq1uMRqwn10ArZB9OgB79R
	xa3l3+7lwuTJki+Fw16hFYrp9oLXbhBnQy6svsuuUg==
X-Google-Smtp-Source: AMrXdXtaRu99m5f2D7tgi7WsZbLz8ssave9554bkMoF/ScVpn5JUTJcB1u5jKYf6eCBfvBUrivQk1w==
X-Received: by 2002:a17:906:4f14:b0:7c1:98e:ed20 with SMTP id t20-20020a1709064f1400b007c1098eed20mr7834665eju.35.1671806123194;
        Fri, 23 Dec 2022 06:35:23 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm1428766ejn.198.2022.12.23.06.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 06:35:22 -0800 (PST)
Message-ID: <93c4e8a6-4797-9c10-5ae5-7499d6e2bed4@tessares.net>
Date: Fri, 23 Dec 2022 15:35:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next 1/3] mptcp: explicitly specify sock family at
 subflow creation time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
 <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671799401.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671799401.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/12/2022 13:51, Paolo Abeni wrote:
> Let the caller specify the to-be-created subflow family. No
> functional change intended, will be leveraged by the next
> patch.

(...)

> @@ -1673,8 +1675,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
>  	if (unlikely(!sk->sk_socket))
>  		return -EINVAL;
>  
> -	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
> -			       &sf);
> +	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);

Mmh, I don't know if we can do that: it means we no longer inherit the
'sk_family'. With the modification, it means if the initial socket is
created in v4 only (AF_INET), we will still be able to create subflows
in IPv6, right?

Somehow, I like the idea because with today's Internet, it is normal for
a client to have both IPv4 and IPv6 addresses. Then we avoid people
creating AF_INET sockets and complaining they cannot have additional
IPv6 subflows.

But on the other hand, there is no more way to force having v4 only
subflows, no?
And I guess listening sockets will have to be created with AF_INET6 to
accept additional v6 subflows.

WDYT?
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
