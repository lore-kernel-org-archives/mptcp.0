Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEE14AB5
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 14:05:40 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-991da766865so724899366b.0
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689084338; x=1691676338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VS+/5LCQk1AE1alVhBWzwlxOIMNsBK1hPjs0cH9NVwU=;
        b=M9C/maQtD6tQ/obvotHZa0l9JZbc4NOXQBD+JY63RZ0t3jhKUZg51pYLPVB5lKG9Ep
         qcKeIqRbbwq/d/EvFGI5NYMU+SxGCjFaMqkADwj+n7eJjZk56UkUpMx5jqZLEbhxGvpV
         QtXuLdWrLmX/4J8mXKcBb51vo7jkv6hqE8NdXtNkDLXrPvT4MnX09eFRtF6EmKINHfMZ
         Gf7Rr5VJDgIWHuXtncpEco7att3xqdJvnZ9JdBUqxGNwfu8aQtpNPfDe4CvqCp8Nob6r
         eh7zk2wnPigKtdFIHD1ORJz85BT9ze7NSjGfS6k2RjuUjj3L9c/XLlnvcitmvy31wgdb
         OXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689084338; x=1691676338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS+/5LCQk1AE1alVhBWzwlxOIMNsBK1hPjs0cH9NVwU=;
        b=VshJgy8EU9j5ptL4G7pqqJorqRBgpn8yT/+mBObGCuY2CGXLBXZEHw2sywUzm0Q6Z7
         hP5B1Lb/hD0u4P+Kp3dD+YB8R/9RrVzYfRkAM+iGaUO0YCHmGl8cnNSa53Tkd+N3/RBU
         /ECQzU0Ha2t/uxtriOPy9aqr7Y5cpI0bG0P+FvJv5FmsS13pOAXAy/SsyepumeCDYqQc
         dyJmcHx2WYjDGj+109UABz1OPYhxKNlcrbaxRRn/BoYMiYXY4C4v25LMF9kdX8wx5Y09
         US5GtKHHok3YSZuqcRpx15OtvJfAb9AlPCRF2uo9C3BJNnqIaYanB0NwM4TBVcU+K9uh
         m93g==
X-Gm-Message-State: ABy/qLaL7WxdOxaK+NcupxuFISk0R82tURENOnissY3keLFVQcG+jUKC
	jHZxe7DlWl3DGEzBvfKAYqlTbKe4FBlAR4TGHV2HCA==
X-Google-Smtp-Source: APBJJlHkokQHkejLuiNIJTNYNWmlpeZ5thDZqsZj7eTj+EoPzqhyaDriOgMNH9BvXEpG12ezwIglbQ==
X-Received: by 2002:a17:906:2b11:b0:991:e24f:b288 with SMTP id a17-20020a1709062b1100b00991e24fb288mr13453735ejg.26.1689084338561;
        Tue, 11 Jul 2023 07:05:38 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:311:9dd3:e9de:8b52? ([2a02:578:8593:1200:311:9dd3:e9de:8b52])
        by smtp.gmail.com with ESMTPSA id j8-20020a1709064b4800b009929c09abdfsm1235766ejv.70.2023.07.11.07.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:05:38 -0700 (PDT)
Message-ID: <b8c5b310-0916-8cec-b5bb-6a2b5b56f218@tessares.net>
Date: Tue, 11 Jul 2023 16:05:37 +0200
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
To: parthaz lokesh <parthazlokesh@gmail.com>
Cc: mptcp@lists.linux.dev
References: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
 <fdea425d-5a7e-4d85-bcfe-4e624ab25e91@tessares.net>
 <CAJck1w1pgBQN5RPjXF9crdkcrhN31z0frTwAA8ALk4uzSw0TMQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAJck1w1pgBQN5RPjXF9crdkcrhN31z0frTwAA8ALk4uzSw0TMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Parthaz,

On 11/07/2023 14:43, parthaz lokesh wrote:
> However, on the server side, I followed the tutorial from
> https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/. But,
> mptcp packets are not seen in pcap. only tcp packets are there.

Do you mean that MPTCP options are dropped between the client and the
server side?

Some middleboxes (e.g. firewall) can do that. Often by "accident",
probably a simple configuration option needs to be updated. Most of the
time, the issue can be fixed if it is reported to the right person.

> Do we
> have to redirect application traffic to shadowsocks to make MPTCP
> work? or just below commands should take care of redirection to socks
> and converting any tcp packets to mptcp packets? If so, it is not
> working as expected. Could you please guide?

I'm not sure to follow but the server needs to receive a connection
request with MPTCP options (MP_CAPABLE) to be able to use MPTCP. The
service handling these connection requests needs to use an MPTCP socket
(e.g. forced with 'mptcpize').

You can use "ss -Mape" to list all MPTCP sockets opened on your system.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
