Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D86D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 07:10:13 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id e7so26668308edu.10
        for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cVJbiBboy1l3Ex5mXO1TqNUpkFbiSXvC2bEmtOt51do=;
        b=o3uvJtrcuH/G7imD/Au58YPKPN98NKGlM/g+B1oDZtDbqRb1Wn4OIZOQW9jV95E0IN
         L0Ou+PdFlVMqLSU0ZnVfigJidlWASZ8NrtRuGkxzhotKufy3ZNjQ1irtu6SlCcQGdDCq
         LsODTEAaD1/yXJFdVQHAIsfOFBY1lpO5vLejISh+uDE9asQS2YlnXQRT9WdyK6ymdTOI
         oBO6Cyd2+rGjIJE1SnGocRO6nb9ebp0f3a5jAb4x1jPlzdj67O0tHydByRAAXi/4mMbw
         kzSjVbX9sFxmNwW7Zw7XQLZkJNzMfEdTi3IE/HpPn0XzKBg5HtWXLMV62G6gJW/Alkjh
         j1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cVJbiBboy1l3Ex5mXO1TqNUpkFbiSXvC2bEmtOt51do=;
        b=lXwIvcbMqSD78C7kBxa6cIUGoXsufmMvEFhjAQSvfrPy8UXxd7X5nYjZ2Dx9w/KRVN
         vckeBkcHf8lJ3zv2CEjXhPTlJJAgZ2PEfzee+6FYO4q16bZZS7gEIWqLOXxyDHa7WwN+
         gtRSbnjlDTdcTIQk899/+wWSmvK233WGLmZgO+rR8fYRIRxU7TEUaUMeuOojTP7kSKzu
         +5hVWrJz5GRFJ6tsronedoGF95mMxcw/26TCu575ncL/0jO+/r+8jleH1uerWA1fYO7Z
         LKESlcz+qhlZAhQIdLB8UEbJfnjJqSz3HIx/7SHH2a5uNvLYwbh6uI4eCWRvfKfsPbkE
         Yb9w==
X-Gm-Message-State: AOAM533oGuZX9+horbErGMm1rLNl1ulaQRSITbrlLnOvvRJb452DLSVp
	73ggozE8e6pw+tS/wNUShnmsZ1yy3Xrs3Q==
X-Google-Smtp-Source: ABdhPJxUb5VhQZnEL91I2SJ6ZNy+oArB6BT1PUTEgTaNKWNU7cSgQhqUpHB8lUZMWvgfsQiAyskrqw==
X-Received: by 2002:a05:6402:1255:: with SMTP id l21mr1740882edw.362.1618470611776;
        Thu, 15 Apr 2021 00:10:11 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:4aaf:625b:29ae:a5])
        by smtp.gmail.com with ESMTPSA id c16sm1250634ejx.81.2021.04.15.00.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 00:10:11 -0700 (PDT)
To: David Gow <davidgow@google.com>, Nico Pache <npache@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Brendan Higgins <brendanhiggins@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ext4@vger.kernel.org,
 Networking <netdev@vger.kernel.org>, rafael@kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Theodore Ts'o <tytso@mit.edu>, mathew.j.martineau@linux.intel.com,
 davem@davemloft.net, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, mptcp@lists.linux.dev
References: <cover.1618388989.git.npache@redhat.com>
 <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
 <e26fbcc8-ba3e-573a-523d-9c5d5f84bc46@tessares.net>
 <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
Message-ID: <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net>
Date: Thu, 15 Apr 2021 09:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi David,

Thank you for your very clear reply!

On 15/04/2021 08:01, David Gow wrote:
> On Wed, Apr 14, 2021 at 5:25 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>> Up to the KUnit maintainers to decide ;-)
> 
> To summarise my view: personally, I'd prefer things the way this patch
> works: have everything end in _KUNIT_TEST, even if that enables a
> couple of suites. The extra 'S' on the end isn't a huge problem if you
> have a good reason to particularly want to keep it, though: as long as
> you don't have something like _K_UNIT_VERIFICATION or something
> equally silly that'd break grepping for '_KUNIT_TEST', it's fine be
> me.

Indeed it makes sense: we don't need to split nor to have a meta-Kconfig 
entry. We can then remove the extra 'S' and update our tests suite:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I see that the whole series has been marked as "Not Applicable" on 
Netdev's patchwork:

https://patchwork.kernel.org/project/netdevbpf/patch/0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com/

Like patch 1/6, I can apply it in MPTCP tree and send it later to 
net-next with other patches.
Except if you guys prefer to apply it in KUnit tree and send it to 
linux-next?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
