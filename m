Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFF612F
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 17:39:01 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id r11so10737498edd.5
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678988340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dLzfLofEhd+mib9UCreIgvsgyxYR9o9Vxalbo7IL9VQ=;
        b=3HfduUDEZHVKtYJH14Nkrlj9cIq8qNLgvMVOc+xM40qt30wwwpahDuWTQWhI9H4O9w
         taRbKu+fFZSOqysDLLAUH0c+V17UWqiO5y25FsfFnVV51tAStr2/cyRJ6f3Wx+KsRjR6
         32btrP3CjHcZOo+Yb1FQewsCABHPUyjDGVaKUIFHN4EwRX3FBOttY0TchZJ/AQUGbeWT
         Y5SOqIBKyP63+6e63Et4rwY/hcmy4YzOA/SLrUfdCbJftWHdpy5+UJz2RembQXGlT0W8
         uo54Lj/rQxzWOS8VfBivG86uiSaqr3pE61Pfh3R/f0YxtAWLxuvXx+kgfrpp0k/lBe/N
         eBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLzfLofEhd+mib9UCreIgvsgyxYR9o9Vxalbo7IL9VQ=;
        b=kXdXQ8ohE3xso/tIalmD0Wge8F5/365yHk79jWdp61IAuLfJu58TUBbwS5p1B5ce69
         +ZE74+9p6CKH5XdIeMsThdZ94iO3yKUEVPsrKaGTSzh6EicAdpOT04od8/9MC6sQ4YvC
         7+g7DewpmX3MgU54ZYd10eMnXfeDOQVRlXoM638wqs51ErK7Srzy5oa7Z49ZUrhZjiFz
         ITAGHqoPbgwC8COwzh40B3/yc1VUDXTaBkq286yONuSigojCMdfZNSGY0Q32guICIyLT
         OlZt/5DOvmueOLRNGQ7fc0aU4+pYcKlKRgMyWGqbUCKcFMUg8g/BBu9RcXyC06wwxQzW
         w1bA==
X-Gm-Message-State: AO0yUKUhOELPzPWSEPfFx3nfbgl9AcM0A3AMeCiW1CJZakU/y63OqmzY
	8E++C7UJLSs+9bF/WvAfZ4zsaSGSvdNDCTO/A6nJFBjv
X-Google-Smtp-Source: AK7set/j67Zsms3HNIuZ8cDsx1vYNwMVtKC2VDYNH0U6P0V/ES9awUPxcFGDtX8OwBdFFnGqec4OAw==
X-Received: by 2002:a17:907:9703:b0:931:86cf:9556 with SMTP id jg3-20020a170907970300b0093186cf9556mr85266ejc.23.1678988340208;
        Thu, 16 Mar 2023 10:39:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id gn40-20020a1709070d2800b0092c865883f6sm3771795ejc.85.2023.03.16.10.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:39:00 -0700 (PDT)
Message-ID: <f9c25465-88c1-e756-39dd-63ee1c72d35a@tessares.net>
Date: Thu, 16 Mar 2023 18:38:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-net] mptcp: do not fill info not used by the PM in
 used
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
 <cd9e989c-8ad1-6f42-685d-378c9ce83892@tessares.net>
 <CA+WQbwv4gkAiD8rJRYW_+WUa=dMD97Thk9ABQE8qb7WFZsuaqg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwv4gkAiD8rJRYW_+WUa=dMD97Thk9ABQE8qb7WFZsuaqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 15/03/2023 06:09, Geliang Tang wrote:
> Sorry for the late reply. I think these limits are still useful for
> userspace PM too, although we haven't used them yet. Since we also do
> not allow userspace PM to use addresses without limits.

I think it is better to let the userspace PM daemon managing these
limits itself. I guess that's why the limits have been explicitly
bypassed for this PM, see commit 3fd4c2a2d672 ("mptcp: bypass in-kernel
PM restrictions for non-kernel PMs").

> If you also think it's necessary to use these limits, let's add a
> ticket for this on Github. And I'll look at it.
> 
> If so, I think this patch should be reverted except the var 'val'
> should be dropped indeed. How about only dropping 'val' in this patch?
> WDYT?

I think we should keep this patch and have these limits only used by the
in-kernel PM. Except if you see a case where these limits cannot be
properly handled by the userspace PM daemon?

Also, we might want to avoid the complexity of tracking in the kernel
which ADD_ADDR have been received and how they are being used by the
userspace, etc. But that's a technical detail.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
