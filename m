Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37C70
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 15:52:51 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id n2so14334590ejy.7
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yEO7ZaatPcmzbqM34zkJdECphq9qnO/o+FpARxgpmg0=;
        b=tw/N/NGBQKPyIgYay40mnRca4T8d8D5S5rOUcJ9cFFf3xhYM3fQ4uY6eiVKnk84nW5
         SudrZE4BobNqJVTzypmTEnMHHdxvmzt0ECRWO0O9rGT0bklKSlbRdy/OHdctrr1s8wZa
         Z4zvmiFD2imCZaLaJK4IprcRlMPGC1eP1phwa5393Pag5A2mB6xgVZW161Ak0hZdaYRb
         2qxI1ZMC1FJxTD4233DjOsfTaFojOhh7wqFhl3CVMkud3eAYH/SWzLp5Xx/g3ERl8luu
         wEJUsfoEjuO/DVdQzVIZBRmMrdA6TGcbKnc5019UvoCDKacEBrmAOXMm38W5eyNkIH3h
         1QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEO7ZaatPcmzbqM34zkJdECphq9qnO/o+FpARxgpmg0=;
        b=ExljSXRbDuB2Po0vjOtu7oJ9mzrmm4ispq0sAq/KACxEGv+ZAWtOpdzJ2S2fd683bs
         8HdA0YNeVK710QexH4FwCMRlYPRFmmH+LSgjoqsNSl7GIRt8JUvLt676/7h6TXoaqgE+
         BPJDCHJM8pjAYsDXFvwDudc2wH8skUyxSGaEhZhdWzvwqLmBeD0y4dsV684xOGScr0sy
         zxsZyajoWf5RXJtGxMaBja/BAEm9ioYsj/wDse6epichB1mwNqAiZqWoVdqPhHRb4RRa
         hyDDB9pfIpx06j/5/U9LuH33i2pWUJuoEzhpQgZMsZzpH5nUWMsDByocl3Ka0EDOxjuj
         5BLA==
X-Gm-Message-State: AOAM533f/UQXSzUJyu3A8MmFN+DRyTpcVhVgFxXbFVEzwg3T9Ge1oEr4
	RgkuReZiyPsNhCPI/2NoMvT6b+NzT/Dgq/9Pa6s=
X-Google-Smtp-Source: ABdhPJwERQG9+smxS9CNY3eGK+kMYBlkGIWkkAR5LoOF26ApBJHAgI+eU7ZJKIrGMKirzpeEDmQj2Q==
X-Received: by 2002:a17:907:f91:: with SMTP id kb17mr10541059ejc.521.1620402769808;
        Fri, 07 May 2021 08:52:49 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2fa9:2d27:234d:525d])
        by smtp.gmail.com with ESMTPSA id i8sm1758957ejj.68.2021.05.07.08.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 08:52:49 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: receive checksum for
 MP_CAPABLE with data"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <135787a3f77e222df41dc187395cb4f9181191ac.1620355254.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8bdb4cf1-fc74-267a-40d7-cf3559d0d31e@tessares.net>
Date: Fri, 7 May 2021 17:52:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <135787a3f77e222df41dc187395cb4f9181191ac.1620355254.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/05/2021 04:42, Geliang Tang wrote:
> Drop useless braces '{}'.

Good catch!

(I thought CheckPatch was looking at that)

- 020b96ad5730: "squashed" in "mptcp: receive checksum for MP_CAPABLE
with data"

Builds and tests are now queued:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210507T155221
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210507T155221

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
