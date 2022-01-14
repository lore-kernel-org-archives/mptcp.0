Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBA2C9C
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 17:48:00 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id m4so36537524edb.10
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=eTVH4TmVpCpHqn6TjLpD3b4St74CHbA8xYXOygfmq5M=;
        b=h0P3O89g1xdwkTEVfhcNvPFv15zXRfcOBEK0x4dsuZEOVVxMV3QH1GoL63FozLkwzL
         VkqAIjcNU5oXCS7xAjPpS2ESjNW72d5AnWTRXuzIvaN+2gQPPuFrjiaVmqoI5tXABekL
         9Q7evPJXkHXo2Kjm/H1fgZGfca+yLaZRQCqzs9Gdx26+QWX8U8VZMhwZ39oRgjjCJP6G
         kC7cO8oysZKIFgDYsL1ni/ZoAFN0T56pIumimoqCfhyJJ40bYOeY19dHa7z4jGbGhh36
         URNN5c7dZtNWeNcYiszOODDWKcVXjOWL1uC8HK0p1pR/w2ROWrQRpeBEPTmeBf/Dp/JO
         yPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eTVH4TmVpCpHqn6TjLpD3b4St74CHbA8xYXOygfmq5M=;
        b=RcrLApdA63t7cTz+A2lGszhRNI06KqqnMr2zKHf6ckIPnVYvqwB2j2zqQqxCCPwxgF
         9Jk1UcxnHEGvBtbunkV8LnSlNLj8lTES5/JiXfzRlUY6F5C7nXUBw3qYB8eS7TmULkZH
         5yCW0wV/Yn4CPwC80D88QgmmyojeONhx+4s1D00WWuNv4Eo11O0ZVDcR5OhxaDD8bS0N
         Cikc/7cizRut6Y2ZpmJ6nU7MA4Zeq83Bg+ONU8QOKjsIsWdNIefDqfaShY9KP8Ybsl77
         i+6f62cD4sNIXDlkT8n9+GWwheAItn+IVG5HVvTek5fo6kxOXk7TrLkZ12zSn4thQhWH
         MoFA==
X-Gm-Message-State: AOAM5317PcNmo/sNMC65olW68sYD557HB8N83dbSI1vA8qrvdFLLekbe
	1L1PmCrG0cgRxJnL41bXCotPPQ==
X-Google-Smtp-Source: ABdhPJzX0034gW9VBV/7QHHN274jvpTi5j389Wg8kMXQ0CbL6rijuh1DpnPC0X5jW6B77nufHZHKCg==
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr8525455ejc.15.1642182478317;
        Fri, 14 Jan 2022 09:47:58 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e62e:56dc:2d31:6b1a? ([2a02:578:8593:1200:e62e:56dc:2d31:6b1a])
        by smtp.gmail.com with ESMTPSA id cw6sm2612396edb.11.2022.01.14.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 09:47:57 -0800 (PST)
Message-ID: <0ea75530-7741-b00b-19ad-9b87bdd1a4b8@tessares.net>
Date: Fri, 14 Jan 2022 18:47:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v2 08/21] mptcp: attempt to add listening
 sockets for announced addrs
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>,
 mptcp@lists.linux.dev
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-9-kishen.maloor@intel.com>
 <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen, Paolo,

On 14/01/2022 16:54, Paolo Abeni wrote:
> I really think we want at list a configuration option, off by default,
> for this feature. Some specific self-test would be a plus.
> 
> It will help reviewing, splitting this series in at least 2 chunks:
> * pre-reqs up to ~this patch
> * user-space PM specific stuff

Good idea, I think it will help indeed. And it will be required when we
will send these patches to netdev.

For me, it makes sense to have more features only for the userspace PM
and of course more flexibility. But we still need to make sure the
in-kernel PM can be controlled to avoid some behaviours. For example,
when sending the command to emit an ADD_ADDR, a parameter could be used
to (try to) create a listening socket as well.

I think an in-kernel PM makes sense for a typical server mainly having
to send ADD_ADDRs and accept subflows. Having a userspace PM daemon can
be costly for such "basic task".

Also a server could also send an ADD_ADDR for an IP that it doesn't
directly "own" and we might save some resources by not creating or
trying to create listening sockets. We could also have a new flag with
'ip mptcp' to create listening sockets for the IP we want to "signal".

I mean: even if it is now easier to create listening sockets, we might
not want to do it all the time.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
