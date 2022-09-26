Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0F2FAF
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 17:16:26 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id hy2so15511601ejc.8
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u1hIdHaiU3P21Lze8J777j3+Acv2oKkhWoSA0/RDm/k=;
        b=eQcz6u4tZQoz3pKtZbtdFiOAxutjh3WBg4VX8awcW6Zb2MHRUEV8/nrXZ7+WEC4jls
         RRx3SATGaWOwA9zScFNDo5HKdXKVQSuFI57tl146p8n0dVNRO/v1GehIablIqIHR7u6A
         LyOaRzQNe0p1nK47QeKxa5XvJIz3wThck1l3gnfeFTWSQwymMGH9KpfFFk4CM5SlcmU/
         tLCwrssrHlK5vuDhOBGq9/Bqgpwq2IXtjX2wiKr7o+WJat5VzaQvBG85HvvnBajbRlza
         pIKdKwVodZvBTi7RGeMHAWeDWJ2NGYMf3ffMPHpF4jY8qhMdeoYb7r4Eg0eD03t+0ojt
         /ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u1hIdHaiU3P21Lze8J777j3+Acv2oKkhWoSA0/RDm/k=;
        b=Z4RTSfVXWRhhtAj+PzdyS2bzdaz8uEADaGDKKKklWpArKh7YWpOvzDYAXai7J8r9KI
         6QyjItkBX8XRdtVhxJBt/Dh+jwofKfL9QsQzl8vRADAbj7lcWkCu3JclmK/8vIOhAZVG
         FbP+DgrzL18xWvjcxJT8j7A7V3DKH0WDmC/NEVJR1/IL6vAWC8XKg9mLy4slUSPU8y3w
         Z3AlawYMh9s2eibQ+rUUEjMV4RJijHUjPI62OZ1B4woAFAIHoYj/BsIfROPbHoME7S4D
         XXbu1FrXussxVcpDCvsMgVOuQYxwERAEd1kLB3lQBWkotcf9VkoJlYsEMxpy70yfJ1yl
         78Jg==
X-Gm-Message-State: ACrzQf183LB+SlWNsXFCM0JCdhHVB2FSFTupRREPxDAj+g3XHUeQHnpP
	vvfC+YJLg5APlrvgxxG1u2panDrfsISsO72S
X-Google-Smtp-Source: AMsMyM5ieME9q+E7KPxU8t1Gb5NT7K0Ung+mYuXyUQO52231LZI1vHbhtNgTpjyQZgRHVSvgcKbyKw==
X-Received: by 2002:a17:906:2245:b0:715:7c81:e39d with SMTP id 5-20020a170906224500b007157c81e39dmr20291690ejr.262.1664212584449;
        Mon, 26 Sep 2022 10:16:24 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d58b:a76f:9c42:d02a? ([2a02:578:8593:1200:d58b:a76f:9c42:d02a])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7ce0c000000b004570ed2da1bsm4895980edv.38.2022.09.26.10.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:16:24 -0700 (PDT)
Message-ID: <079eb3f1-37c4-37c2-2afc-7a9d8e750af8@tessares.net>
Date: Mon, 26 Sep 2022 19:16:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: use fastclose on more edge
 scenarios"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <0a7720e1aebc9ae8babf8b4881b7ad2acf672352.1664198754.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0a7720e1aebc9ae8babf8b4881b7ad2acf672352.1664198754.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/09/2022 15:26, Paolo Abeni wrote:
> The orginal commit applied fastclose too aggressivly.
> Specifically, we don't need a fastclose after the completion of
> the data_fin handshakr for an orphaned socket.

Thank you for the fix!

Now in our tree:

New patches for t/upstream:
- 3fa214dd96ae: "squashed" in "mptcp: use fastclose on more edge scenarios"
- Results: a24eaf661ebf..e839b37d59fd (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220926T171410


Cheers,
Matt

PS: I also merged the Packetdrill PR and closed the ticket #303 ;)
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
