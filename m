Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F52FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 14:59:03 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id jg16so9517665ejc.1
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N0cVL9O4W3FfniuNgxesWhTr37vcXzzhOygWpkqDcr4=;
        b=flcgBjgaQKiaQpU75AbQRr/7SZC0QwRy8yh2lt+ne7cNKb1YnAtYOjhXg8Nqy3fSde
         u4Z7914IzqrIIVWqUhnRckAPVy2BL+WY61dOvDiIwkkQ1G9LeM7o9Efdvs3smJBWxlvH
         b6SE0qbTvw8Q0UomIBH84apkeMdGPVNg38bwp4qK+1VPbxibew6URZQD3Ci2mIhyJhMS
         FEHynaxZC9lhd7XwmHYJTmLsFH2MFDeD17ku3yOvySRj0TATb3Ncuy38qqqG3Pkbervd
         y+oztmZnpE/oB3HcioUAG4V5vsYVZPOwN5u7WXuWfEfSh4V5kGmqcQ90kpgbw2I1iOQY
         MqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N0cVL9O4W3FfniuNgxesWhTr37vcXzzhOygWpkqDcr4=;
        b=O5UFbLO8cnDuHWwZrTRuOtLDY5D8AMadfS5f5EbPTUU/y9f8NqvzCo9xHshR+vL0TZ
         df/XpLQis8IQ7OH4Hjc0LijX2ariK3tM+Qk/h5+L4flEDHWjRiqSG9TwCmhsM6NAQ713
         DuDgYWJPRmlHdmxzSFU+1wl7oEG4oRZMQRy5ECbV2VL0m4uQaF7xuHSnM4wCC9vmf5g1
         y1VIjT/+1SW5N5uK7w/MLdfBl0sAtxEH67K/leW65vYjWodtg65nAjnxWNdhr5VFf+/h
         +vf1PMC7qQTVtTm6J7/YytaThZP8Dh6koGFBC1BPNiAkMR1JGK7u/5PnHYHNqKue94tH
         ea5g==
X-Gm-Message-State: AOAM530v37IoM0ctbghXubH1a3fuPFVpsVJW1JaGOwNfSC2u4W2pXY+t
	x/c4EuNBVJbo7q7ibs9Ne+6b+wT+CrQOrw==
X-Google-Smtp-Source: ABdhPJwNG6aCD1GjN1r74JBZhIMrX1bvNRw5KnD/z4PKLt05WsJFAY/ErM9R/iFJmKkf1KVMKxMbGA==
X-Received: by 2002:a17:907:7f93:: with SMTP id qk19mr4689577ejc.433.1630681141735;
        Fri, 03 Sep 2021 07:59:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id j5sm2907997ejb.96.2021.09.03.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 07:59:01 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] mptcp: use lockdep_assert_held_once() instead
 of open-codying it
To: Paolo Abeni <pabeni@redhat.com>
References: <837dc50592c4843c4de722a4b9cbad6663458a07.1630680563.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <806f0a0c-565c-654d-7625-beb7eaad6b35@tessares.net>
Date: Fri, 3 Sep 2021 16:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <837dc50592c4843c4de722a4b9cbad6663458a07.1630680563.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/09/2021 16:49, Paolo Abeni wrote:
> We have a few more places where the mptcp code duplicates
> lockdep_assert_held_once(). Let's use the existing macro and
> avoid a bunch of compiler's conditional.

Good idea!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree:

- 63afb2abe5ae: mptcp: use lockdep_assert_held_once() instead of
open-codying it
- Results: 396fa2905e69..7755d2ada382

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210903T145841
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210903T145841

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
