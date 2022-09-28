Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1EEA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 10:00:34 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id l14so26012193eja.7
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+s1X28ywrVcsaU82H1Ve14loBaCngrJ5sCMnjCvxUhs=;
        b=rI5VhHiWOPAlYZtMbQoVsBTFFXqLMFrXmDof3DfijUAEISym/nUIVozMvD+8jbfGfF
         mb4ya7LrOWbLcYiNwEC5wi8k6iTR47WM+Y7j6kaYwNpRDG8++8gnJzI8E+Ua3dMStPLL
         FhykBCaj4F9xulYQ8NgzCrkuEOxIZXaq/xVHyPcL6jdCD6/4W/bk7jCmDaCYblFGUA04
         IGP12PsjGv0uoQQnMtf3hcBeKD7eweWBTla+NxJgMCo9kXuj9psxBOZQXXKQ9WdkW+L6
         quUIXeNsLjJcSvHWFimm89yCopItPkpsCmiw8KKKKuTDhMNn+IEDpr5I4rv7LPl63AaC
         bQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+s1X28ywrVcsaU82H1Ve14loBaCngrJ5sCMnjCvxUhs=;
        b=DZXGnbL90qrBhxhapkVIws+0cnaKNunyXI+ET2Bhd44UTVv1tlmCYTtoUPNjuBWY6j
         V/RuYu+5zscitrhnArM19j2EHMrc24XIF1uCNU8sPpNc3VyycRDsZXmwO9h4WN8Zn7nW
         5EWne+0olkv+fb4ZfM8rUzt8xI1cYfNMugA3KguGqEFkyO0GXqT/koVvXTEJ2TKUCrI0
         Z8x6QwTestjUQe4PodukTURwH6sqS6m+V3w0gdLdWkDLrHxpQCDWqNqyg1RbbzprDqXQ
         YyyVoaGk9XbAu86ySxeQLczxetjayGvMz23mCH88pJi1W7+c4IgYQPN4jjlVuQ1QJ0dX
         iHtw==
X-Gm-Message-State: ACrzQf0jeVhYhpr/bQnGZ68ozNJHkU1c/fir6nPzqTc6es974nnP0tNc
	8ZArk6t7ZiM6gqsX0cdo6q93Lw==
X-Google-Smtp-Source: AMsMyM5rRaMpZDWjaIwl4+K1kO1WAvbOIH93Q94Oajc87QdqO2gmajvNUEEjtkCvnM0U4Q3Hl/GD/w==
X-Received: by 2002:a17:906:6a2a:b0:782:356e:4207 with SMTP id qw42-20020a1709066a2a00b00782356e4207mr26897521ejc.167.1664359232366;
        Wed, 28 Sep 2022 03:00:32 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6518:6c3b:2826:5305? ([2a02:578:8593:1200:6518:6c3b:2826:5305])
        by smtp.gmail.com with ESMTPSA id r8-20020aa7da08000000b00456f2dbb379sm3004320eds.62.2022.09.28.03.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 03:00:31 -0700 (PDT)
Message-ID: <acc4d56a-c615-153b-1154-35071d223496@tessares.net>
Date: Wed, 28 Sep 2022 12:00:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: use new helper for
 TCP_DEFER_ACCEPT
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
 <96ec8c7534425d2693aaa6b03cd7272adc4e6438.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <96ec8c7534425d2693aaa6b03cd7272adc4e6438.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 28/09/2022 11:46, Paolo Abeni wrote:
> On Wed, 2022-09-28 at 11:18 +0200, Matthieu Baerts wrote:
>> mptcp_setsockopt_sol_tcp_defer() was doing the same thing as
>> mptcp_setsockopt_first_sf_only() except for the returned code in case of
>> error.
>>
>> Ignoring the error is needed to mimic how TCP_DEFER_ACCEPT is handled
>> when used with "plain" TCP sockets.
>>
>> The specific function for TCP_DEFER_ACCEPT can be replaced by the new
>> mptcp_setsockopt_first_sf_only() helper and errors can be ignored to
>> stay compatible with TCP. A bit of cleanup.
>>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> 
> You can/should drop the above tag ;)

You suggested to remove mptcp_setsockopt_sol_tcp_defer() but I
understand your request :)

Thank you for the review!

I can wait for Mat to review it as he suggested the whole code :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
