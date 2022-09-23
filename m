Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E754409
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 17:48:34 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 30so1207676edw.5
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DNFEWfHmA1WB09NgmM0lgkFbKL75s+sjS9Ip/1Le5sw=;
        b=jpHj30vVi4LmWmgXClhD2i7XsiBGCKZIq3k9I0iuMeqSacDedCU3vzIW35qkm6l9ts
         cGGeQ0Rpk33gTl76O/HCf68a3HtyE6l6/sR3mREVFiIy3uxv8Bz6KtmS8dbY6lJ2cGcS
         1OMBEUoCzkde1TssCvBPQTuZeB5IhowaoQD2kXhe+TAPDQBesGouhvkAlOlBqpfP2n1U
         ykwoybsbsapYZywNcSHSCiNHGRQpjhtyHfWjjvVHmLkbium3C75jcVh8pllL0d8f6+pE
         F8uSrqQQloQqNZfUlOPX0Dhdy4laEp7+CeVXyoViBRpmI2lCcy3QhV1feeZZYCJ9A0rD
         fikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DNFEWfHmA1WB09NgmM0lgkFbKL75s+sjS9Ip/1Le5sw=;
        b=JKIOR9pbYhRuzX6n4NuXQQoCyRGriMEV2FVkYN2KJbmCTIIho69d9axC01+eSWKuPC
         Bjzx33Czq/hDPbG5LDxneVmh2ibMfM++krbd0NLpQ+2m4y5N4ogQw2YYQKbaQNV5033h
         uBCWA6BaNCaLQ7PgYhZOSP5tXJ2+VZDXMuW7y+JfD/xz5caqQ6eriQv4vIjYdE95TZtk
         TVyaU3giuwSZ7NJTJTSwLXMEujHkci/zSqs+wEiskNB74i8v4r7dmRdkQ4lEGmuFOUsL
         fm6j8bMCp4/ueEzjlEX8iV9mw8442T7BZUFXt6KvHzQLYKghymoLMik/RshtqGU+Qgd/
         zkDA==
X-Gm-Message-State: ACrzQf0KFyvjzqDlndNQPnxNqDCAFmu4UAsqo7yTRZ5xzjUzfXFPQvYB
	xFl4aiLdH9pMjgUi8B4sop0FyzBFL7FewJlP
X-Google-Smtp-Source: AMsMyM55M3l9f62K6dW3lSR6UvYQqw/zM1FXBs13AE3RMebFxR+Jo6xZ2rC6hQz0hkgE8mSIw5Fb+w==
X-Received: by 2002:a05:6402:5290:b0:453:5942:4ef8 with SMTP id en16-20020a056402529000b0045359424ef8mr9802744edb.180.1663955313082;
        Fri, 23 Sep 2022 10:48:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:88fa:5b33:b9f2:f574? ([2a02:578:8593:1200:88fa:5b33:b9f2:f574])
        by smtp.gmail.com with ESMTPSA id q14-20020a056402032e00b00456988774c8sm1468253edw.57.2022.09.23.10.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:48:32 -0700 (PDT)
Message-ID: <b5617ee2-3bfc-01ba-10fc-9e4dc2613031@tessares.net>
Date: Fri, 23 Sep 2022 19:48:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next v3 0/4] mptcp: add support for
 TCP_FASTOPEN_CONNECT, sender side only
Content-Language: en-GB
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>, mptcp@lists.linux.dev
References: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Benjamin, Paolo,

On 23/09/2022 14:19, Benjamin Hesmans wrote:
> The series only considers the sender side.
> 
> Compared to the previous RFC patches, these ones focus on
> the sender side only. It corresponds to the 4 first patches from the RFC
> series.
> 
> The sending part is less complex and even if it looks like we are
> converging for the receive part, there are still discussions on-going
> there.
> 
> Again, thank you Dmytro for the previous work done. As already discussed
> on the ML and meeting, this approach was slightly different from what
> Dmytro originally proposed. Here tcp_sendmsg_fastopen() is exported and
> re-used and TCP_FASTOPEN_CONNECT is supported.
> 
> MSG_FASTOPEN will be handled by Dmytro's patches.
> 
> Individual changelogs have been added per patch.
> 
> We would like to credit Sébastien Barré, Gregory Detal, Olivier
> Bonaventure and Christoph Paasch for the original idea of supporting TFO
> in MPTCP, see https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/
> 
> It would be very nice to have these patches accepted in the future
> kernel 6.1 which will be the next LTS picked by many vendors: the
> modifications are quite small, well isolated and re-using what is done
> in TCP for years.

Thank you for the v3 and the review!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (feat. for net-next) without a small typo
(s/Signed-of-by/Signed-off-by/) before Paolo's patches to propagate the
FastClose errors (an extra patch has been added to modify Paolo's series
to take into account the new code from TFO):

New patches for t/upstream:
- 663904b20bf3: mptcp: add TCP_FASTOPEN_CONNECT socket option
- 9b4ba0258cd4: tcp: export tcp_sendmsg_fastopen
- 7ee00b1a8316: mptcp: handle defer connect in mptcp_sendmsg
- 91b572e341d3: mptcp: poll allow write call before actual connect

- e203d313c6a9: Squash to "mptcp: propagate fastclose error": use
'do_error' defined in this patch from Paolo

- Results: 617e33bdd07f..7830189b084e (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220923T174545

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
