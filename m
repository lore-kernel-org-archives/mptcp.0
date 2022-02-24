Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A381878
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 12:59:32 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a23so4176906eju.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 04:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=cjzZOrWk+jvupdMajXIOC/gXieKAlZtuOVmcG9gErDo=;
        b=BSi8hBo/Jt8DPOhNnCAMF8ySqDfi54aVf4eHJ2BY0s4vNEWvg6UvWeG11N0lpZcNn+
         4tKHoSJC6EPiMRbP2e5z+itcCVqSkk208OND6nmMWfUoDBCP7nqU8m7ts5KVHOVlFkcK
         TQKMgvHQtMB2oxtJyT4fT2UZBn9vO8aH3AGm1jsQPX1V9PlEj2QMXzvFPL2VFhbDht6U
         VF0ZcqvVie5zq5e0abxIuo5frcjUH+BrI7dy4nEUGAdnNrPT6+mE3dz1jbvvvsK80hl0
         lt1p4r8z9gbXBNCAte3WwXj73gLbyprncQB2vLdIlr3GSMscnkZOXO42bM60bXgcVPC/
         xJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cjzZOrWk+jvupdMajXIOC/gXieKAlZtuOVmcG9gErDo=;
        b=ywa5Oymsz+dL3lbdYpU1KaONKEV+K6g8Vqllo51i4cvaRsQHzA9blAOaZqv1aGWudU
         //gR+bb0rN1SCa8LFHTcuj4QBFiMXghCpzJqcHBl+QYpSjDVjRx7bbf1k2FgLZLspfsc
         T7vIUqC0+VfQoXvatylWw2IGeRnwX/LIohMYxA1SPYAl2+I4NdOm0e4rGM4bZgpqgR6m
         xJZNqD+Ncjt82Hw/kXPqCjzl/xIVE1AU7GH+8pYgtOSSffrZtA+3a50MBntI7rrLXNfB
         v0zEcstazCpkiNpGxy/JE8fRkVuToop/0+NOi6vUrN6iXO1wXK7eTGyqTgC6efqle+ty
         EeBg==
X-Gm-Message-State: AOAM532w2e8ij/N1dGhYV/VeFnTPn5nfyxw5a6w55X5cvJHx5utwgorC
	OqMJtF4Ely076VTmDJ9HeSQCCWuux5oix5a6
X-Google-Smtp-Source: ABdhPJyXuwIP6T5UOFPOopV7vJ6BJhEqSEU/dxSAYqcFUBwKYxXdF0rJvrH7EsJJcW5KmdZrHSHk3A==
X-Received: by 2002:a17:906:ae4a:b0:6d0:9eee:e951 with SMTP id lf10-20020a170906ae4a00b006d09eeee951mr2157624ejb.2.1645707570861;
        Thu, 24 Feb 2022 04:59:30 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id qt13sm1298730ejb.151.2022.02.24.04.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 04:59:30 -0800 (PST)
Message-ID: <fc008f61-562f-e870-721c-7f0a217b825a@tessares.net>
Date: Thu, 24 Feb 2022 13:59:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add the
 MP_FASTCLOSE mibs check"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <981a7ec4e8d14bffba4d4251d491ff70fb2eeba3.1645658270.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <981a7ec4e8d14bffba4d4251d491ff70fb2eeba3.1645658270.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 24/02/2022 00:35, Geliang Tang wrote:
> This following code appeared in another commit "selftests: mptcp: add infinite map
> mibs check":
> 
>         echo -n " - fclzrx"
> -       count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}'`
> +       count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
>         [ -z "$count" ] && count=0
>         if [ "$count" != "$fclose_rx" ]; then
>                 echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
> 
> It's better to squash it here. With this patch, it will be dropped from the commit
> "selftests: mptcp: add infinite map mibs check" automatically.

Thank you for having catch that and thank you for the patch and review!

- 73df33204c5f: "squashed" in "selftests: mptcp: add the MP_FASTCLOSE
mibs check"
- Results: b87ff0ea9dce..4bbd9add0797

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220224T125917
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
