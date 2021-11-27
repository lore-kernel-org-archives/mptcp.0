Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38A2C81
	for <mptcp@lists.linux.dev>; Sat, 27 Nov 2021 10:04:40 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id g14so48937043edb.8
        for <mptcp@lists.linux.dev>; Sat, 27 Nov 2021 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Kkpfd8MMYBS09kMLLAxLAKylAHGeM0Wc6dJsJ7IEje4=;
        b=WwHYzHzLxxaaJkdNZ+APO4Dl9le4lHn8jPmWCl+U6zPc1DMn6mq4cCyLZkfdigcaWS
         7ZfW/KHv/vAKm1xDVOdJBsFDJzQ6JQa5wjCN5lb/ZrvMdfVGBWtZ2eKNRU9w+Si5aQq3
         RPsK0wf5QvuPLgogHPk9Lgl3ymAacYgM9UrPUsa/jG8c4GMQJ1eE9wlQ/uY3QH/C1YJC
         rVBo/b6QUEB5gCxIuL973PqEgmGmYHzf1FZsGD5MQQ4hEBRzow4TaAtprSWvWY0yehpq
         CivvzLfI5XJ5k77NLmZbCTGLjEDWhsgjXfUeS7VoK/9vp6hHLGZ1Ub6pIY6LWlAjbbTC
         qLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kkpfd8MMYBS09kMLLAxLAKylAHGeM0Wc6dJsJ7IEje4=;
        b=bPkPOioIj919bKnWck9Yh98OpkYKC4+kXAbMdB7GvmjqkWuTKBLVqY7HkgTB67gvRD
         4jxyHO8aj72RgioSOnL9YQ9HGtleDqIn4juk0YpVcrfpuGqWVVnRkCs9EZkyFncuj6Wr
         S2EzMbNJUkyD3wJ/GR9XArVbVPpC9d7EHjUDaj53QCk/++LyPNZiHnrrK2KDpShwj7Ai
         9kXr8ISGLi4OxomrGTYUb8+JKk4nAVrXx9RHEkphjhyU3Gv25jfaMG6DaHweE1JRxpqb
         t/9INPfy9dzf1EbbH1QIHKsJFN548k6PS4PwpoWvEZtJxHfRWjoKxSTQDt6qFqNtc+37
         849A==
X-Gm-Message-State: AOAM532N/GXMUtyVyDirBHGaxz0WuERW5Oyi+14fbFDe6qgOF0fZmBJp
	kCfWhsGj+QMxnkQr55JQzHC1uUp/vvhx6dYGDIyCDA==
X-Google-Smtp-Source: ABdhPJyrrynL/oZpYUrRSN40QzcUB9NOLZV6lwFWQgPwW0reJqNlLJa9bYROHkvDrvD62F0epGnQkA==
X-Received: by 2002:a05:6402:1a4d:: with SMTP id bf13mr55273395edb.101.1638007479096;
        Sat, 27 Nov 2021 02:04:39 -0800 (PST)
Received: from [192.168.178.33] (213.211.136.227.static.edpnet.net. [213.211.136.227])
        by smtp.gmail.com with ESMTPSA id dz18sm5696320edb.74.2021.11.27.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 02:04:38 -0800 (PST)
Message-ID: <ae2602ea-3851-cd63-2760-77d74d019006@tessares.net>
Date: Sat, 27 Nov 2021 11:04:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 2/2] mptcp: print out reset_reason of MP_RST
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1637630218.git.geliang.tang@suse.com>
 <f7d8547fa832c5d20c13ca950966d6a5222f0e72.1637630218.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f7d8547fa832c5d20c13ca950966d6a5222f0e72.1637630218.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/11/2021 02:23, Geliang Tang wrote:
> This patch printed out the reset_reason of MP_RST in mptcp_parse_option()
> to show that MP_RST is received.

Thank you for looking at that!

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index dc998a14f4cb..085d11666fd6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -336,6 +336,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		flags = *ptr++;
>  		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
>  		mp_opt->reset_reason = *ptr;
> +		pr_debug("MP_RST: reset_reason=%u", mp_opt->reset_reason);

Should we also print the "transient" bit?

And should we also squash this in "mptcp: implement fastclose xmit path"
patch?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
