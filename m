Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081470
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 08:57:00 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id ga41so2493497ejc.10
        for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 01:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fL/XbjEWOnww6/P4ghSnhn9mf84brZx09xm7TqPjZfY=;
        b=cALu2Jxfjh7ybltKpJeHoZKLfNSzZJSBmXRTrGmjksZTR5ukarfGNqMIXLzxvbOIgP
         Yr4FL8YTf7USU/JtM693J8QpTTf39KkeXPQeh+qheli/QoP9MGzS5t9Z2UQh+tfZL1Tq
         dhMM4JDBPi0iPSCcs8+ZTGWS//uu6cerwOJijrVeTU2IBVpHm4I/U0/GwQWO4HeKc3UA
         c38FSCKwiIac/THV5JBRk/WiYhI79CWOibknhtXXfCmRQRTtFltGs/ZXUDHc3Vq7Uj/a
         9Acj+X8+EjtOT6SkNd+devP+eqGF00EKXD5hMnsYqoFw5ptideFf48JH+GhWK7OoJeQ/
         Gvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fL/XbjEWOnww6/P4ghSnhn9mf84brZx09xm7TqPjZfY=;
        b=MOHW41E7ILTPTVsFM00dB+OA/akcHqQd5J+pR7lj+fFtwmIZ1kOgx6nzpqAQYYnNI3
         r7ZGarL7p4MBGu150ZTtLUnJP+YF5Wpe5Ea38pfhuYgFBCZvNNN5tz6E1wolPJ1eDU76
         VOcjFvVYfZdPjWu2scbaGkwm1emHQCkTE4eLFg9OaM0ZFM7/wXRDRnTRXl+ykv1ioTS4
         NPkRhb79+TlSX+2mbVDHofKmruNyZtKSOsSKrfNuyl9CmhxjjIVsAXTcbcU5uFHZ9Hs6
         PLh0p92LdRbziA8k2tgIW7szKsf0qHSyzoBOYJKwzKWFKmw9TM0YIzRsLflQ4n94CTmK
         qSaw==
X-Gm-Message-State: AOAM532i9TWNwbjGXSEOREG0tH3NclVHGRAprE1D4QHVrNN0WH0K/tWg
	X8x8LD1SUUV1OLfhfXEqU8fpdL3j1tW3iW0K
X-Google-Smtp-Source: ABdhPJwbGRsAlPZGM+8OmvaxBdTucY+Fc+AXm35dKkoMCdZxY7RYVaZ+rLOblX4fpkQV4yuDRDsdrw==
X-Received: by 2002:a17:906:2acc:: with SMTP id m12mr3808549eje.231.1627030619037;
        Fri, 23 Jul 2021 01:56:59 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:d90c:370f:3df2:90ed])
        by smtp.gmail.com with ESMTPSA id cb4sm10382623ejb.72.2021.07.23.01.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 01:56:58 -0700 (PDT)
Subject: Re: [RFC] mptcp: add MPTCP_INFO getsockopt
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
References: <20210722150154.10608-1-fw@strlen.de>
 <a065d16447194006a098e27238be655c901feef7.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <d0e0626d-b564-9e76-b07b-822e02aac291@tessares.net>
Date: Fri, 23 Jul 2021 10:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a065d16447194006a098e27238be655c901feef7.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 23/07/2021 10:49, Paolo Abeni wrote:
> On Thu, 2021-07-22 at 17:01 +0200, Florian Westphal wrote:

(...)

> +1 to pass back the user 2 sizes: one with
> the "this is how much I copied to the buffer" and another with
> "this is how much i would have copied".

+1

>> Alternatively one could overload e.g. the upper 8 bit:
>>
>> getsockopt(fd, SOL_MPTCP, subflow_ids[0] << 24 | SUBFLOW_FOO, ...);
> 
> What about using:
> 
> struct mptcp_subflow_info {
> 	u32 	id;
> 	struct tcp_info info;
> };
> 
> mptcp_subflow_info.id = id;
> getsockopt(fd, SOL_MPTCP, &mptcp_subflow_info, ...);

Indeed, clearer if we can do that :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
