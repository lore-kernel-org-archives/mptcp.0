Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F900174DD
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 15:30:55 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-982a88ca610so582297666b.2
        for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687275054; x=1689867054;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jeq0MpD4OPxRjZm6HQjvLyMMxEiPDqvtTBVWeeNxtIM=;
        b=DUDsOYTUK71LNfa6ree8KxIGOfMofdjmYdYdaX2aX8UrmTfJKeAdQCxK63dWU+bXZL
         DptjhXO/kzECsuHMDssY3HfIJS4a01q6hHmAr89LCQFxvrDtCZktvGs/C/WoktKkF/c2
         IZ3uZuxRgBNB+zP9YlPGaB9wpu0lQJp6Beo0Est9tmLcyeKYXYko3ZaZ8yKF5UBCkPB2
         Buk3vwMX77f958eCy3jBzrZI5iJX2Hw4gPbq8fppARgVr6Z2HvL6eBEhAHikKibrM8AV
         7+VW5Z/Z8mYWsh1l4zir9aYx/MvxzoOm2K74ajroGEnXnXT6v1pjxB4KZkZg72ZP3806
         w2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275054; x=1689867054;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jeq0MpD4OPxRjZm6HQjvLyMMxEiPDqvtTBVWeeNxtIM=;
        b=WXtudWhrwOiq7/gMyINA0YvYGvii2Ev3zOkrlxcGGq+gLCkIJ7NbaQfYbOBcr6luif
         Wk1uGPvGIolEB25NfrT202OcanWo8Cgq2MmnFP4FKOuhmOBzeBY6r+HfOWUT4imlAHKN
         RSaY5WcG6wbyi2hfCTkKicAf2MA2Huk2VB+HL8E+fEWhpuTuyAVEQlTPjuVh3d9BSPNM
         6tFet9TmWwEYMdWKYF0WkfIMESPglRxTc461O2OdKPDnQ7EM9cB4HOZaTy3SDGfGEMxS
         dlprEmJqsyjGDCRru4hAfEJu8n8Awcph38X9m/mJGkdORbkDutxc9ewU59bjyEOoGDpU
         WLLA==
X-Gm-Message-State: AC+VfDxR9cENlnHnWVlwWhlFzXyMBi/VeQRyWDs+IFJQJ4uN65o0ZrQW
	epV9Nn/yr/UtTcfV2uhtPWheWJW1ISPvkttcB7M=
X-Google-Smtp-Source: ACHHUZ5Xky41qkQoXh2/9tFVlYjC4XlePPqy6onqPbTFw0HyYoIabdAL0b04benutUmVZuAmEw9rZg==
X-Received: by 2002:a17:907:7244:b0:982:985a:8be1 with SMTP id ds4-20020a170907724400b00982985a8be1mr10319147ejc.71.1687275054205;
        Tue, 20 Jun 2023 08:30:54 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bq26-20020a170906d0da00b0096f5b48fe43sm1591267ejb.47.2023.06.20.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:30:53 -0700 (PDT)
Message-ID: <fdea425d-5a7e-4d85-bcfe-4e624ab25e91@tessares.net>
Date: Tue, 20 Jun 2023 17:30:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: mptcpize with shadow socks in android
Content-Language: en-GB
To: parthaz lokesh <parthazlokesh@gmail.com>, mptcp@lists.linux.dev
References: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Parthaz,

On 20/06/2023 13:32, parthaz lokesh wrote:
> I set up a server for MPTCPV1 using (
> https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/ ).
> However, for clients I'm trying to use an android smartphone with
> kernel 5.15v.
> Is there a way I can force tcp sockets to use mptcp sockets in android
> smartphones?

Good question. Personally, I don't know.

When I did experimentations in the past with Android devices, I had to
modify the kernel to add MPTCP support so it was easier for me to either
change the kernel or rebuild the application to force using MPTCP.

> I compiled shadowsocks for android, but is there a similar mptcpize
> command as below that i can execute in android version?
> 
> sudo mptcpize enable shadowsocks-libev.service

mptcpize can also be used to launch a specific command, not just SystemD
services, e.g;

  mptcpize run iperf3 -s

If you launch shadowsocks manually (without the app), I guess you can
use mptcpize. If not, you might need to modify ShadowSocks to create an
IPPROTO_MPTCP socket. I'm sure it might be good to send a PR to add
MPTCP support ;-)

> Any other alternative would also be fine. Can mptcpd daemon make work
> for android also?

Android is quite specific with many isolated process. I don't think
mptcpd can be easily integrated :-/

systemtap can also be used to force an application to create MPTCP
socket but it might not be possible to do that on Android.
Modifying the app might be the "easiest" (and proper) way.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
