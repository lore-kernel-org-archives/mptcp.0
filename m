Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BC29CA
	for <mptcp@lists.linux.dev>; Sat, 16 Oct 2021 00:04:28 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so91023ote.6
        for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/iylAugV3LdmU4TvzAuM19NopCOvOZ+RsYIdcERlXg=;
        b=NsHs684w/VANWgOXHfLiL/skgg8r/vhArjIUiBOj66nV8Zj4cKuy7YHijSiYD9mdVt
         2jXsf6cLNNqS+38z1tiSMCl9kUQ0AWgPgY6ctIuVQt6cZ2LUlpcBla6MDRM445KnopR+
         nTFc09zuRn8vjTYYUqDrA+KEqFQg8vxSmAYnZgS9jfm6Ua9hwTW3b1dIvykAaKn1gSOB
         MecWIP4IvMW6THJSegG3adQwy7ourk11U/Hssj5LMBnQeklNIRN1QdnOzx2VyZpRozRN
         fLzyZM6dAjECRe8HPKsow3bHBPGtLCgqpjZqplxdNE3cRICOzzsFNKnkdvtsgcwNkbjj
         /3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/iylAugV3LdmU4TvzAuM19NopCOvOZ+RsYIdcERlXg=;
        b=cqvJQJbKbz0glCFN4xBgHEmWByuOOTcD9Js1OaJv+iZbQj1XcMCA6T3ak7YnNO5K+W
         YpS2i7bMfj5J50yvF+A2LefpFYT+86FelIzt5+sZU4l+jvwoH26UeE9y8fxCuDs+aUqL
         sNQ3uLiO/kkaRxIk3fIn58jmiJBUPlIzWaB40wAU/0YpGUP8qlgypYZ1JjN8BuUyNwOm
         WG0uEpbXR8GMQO6gnStGDPod3ptcSSz3ZdXtz0EMIpxyfcI2sO8Cu4jQSOPSfWPXCNY0
         Ds8RZOhoqsb54VaY2buex0+6bgMBsZGGuM94FPSWqJLEtyZzna+3vp6YSOWTMc8+poco
         4TgA==
X-Gm-Message-State: AOAM531z2NLCtsytwjDt5uA54FCKSEVDjOAFhinSq2c2DI+gwAyjuY/O
	zS2b3B+p4Mvgcq+1J3JI4G7NWyFyPB7e5A==
X-Google-Smtp-Source: ABdhPJxzT8RqgGBlo4EBCwRSGHnusG0Cz9sBOlhtfcIG12apx+zndRQ3TvWB1+YQ0TjU/mY/6JhIrg==
X-Received: by 2002:a05:6830:236b:: with SMTP id r11mr10601610oth.145.1634342667580;
        Fri, 15 Oct 2021 17:04:27 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.34])
        by smtp.googlemail.com with ESMTPSA id c9sm1494236otn.77.2021.10.15.17.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 17:04:27 -0700 (PDT)
Subject: Re: [PATCH iproute2-next] mptcp: cleanup include section.
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, mptcp@lists.linux.dev
References: <30bdb5729425940823e87450c29bfdcff918d62e.1634053020.git.pabeni@redhat.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <ea8eb254-287c-f6a6-04ed-26aa50c299bb@gmail.com>
Date: Fri, 15 Oct 2021 18:04:26 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <30bdb5729425940823e87450c29bfdcff918d62e.1634053020.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/12/21 9:39 AM, Paolo Abeni wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> 
> David reported ipmptcp breaks hard the build when updating the
> relevant kernel headers.
> 
> We should be more careful in the header section, explicitly
> including all the required dependencies respecting the usual order
> between systems and local headers.
> 
> Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Notes:
> - sorry for the long turn-around time
> - all English errors added by me
> - I [mis]understood Stephen's patch was the preferred one, and I took
>   the liberty to send the patch on his behalf. Please educate me if
>   I somewhat screwed-up this badly
> ---
>  ip/ipmptcp.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

applied before the latest sync and it worked before and after. thank you!

