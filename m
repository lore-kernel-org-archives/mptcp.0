Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC491801E
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 15:25:09 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99357737980so757390466b.2
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689089108; x=1691681108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UMZtKZfQz0vo2WX3TV3WAN13GudU6OPOcqnBwg3yPY=;
        b=62IaLOTul+5Ow101QIYTJz3fncEvPx1A3+kUtvO12Z8eW3pNiUTUL6U0E/Rf84Ewmc
         lNeHNyNhcFYV/9N/jWX6w7u+6ELdPpbKvQ0sqRtzgEVyVb0rHyqV+wSy6EZIQhBgu5r/
         h3osats7X9PgX2I6uxStfSzWbOCPRgbNTZpAYjEoe06aB8Pkhsnah70M7KIhr8mLrzAf
         vTf4Q4IJBbhFrDFuECL05Uxsot8QIv9OukLFZLImvWroyCrf19ONXF1AM5bC06yaaZks
         hB5K5yjbNQxK1v4v7ReLM8TIHFydjhiD5vnzYNGeqYVRLOk9kPbg1TQe+g12N8+DOSEm
         9k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089108; x=1691681108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UMZtKZfQz0vo2WX3TV3WAN13GudU6OPOcqnBwg3yPY=;
        b=Zw1nfTlGU9tpe0TBR8Nggbu5gtpgTxIZeLw73wVOgsrBt+rUz3Um9sO4s5sTv0ffB2
         XJb7vOETdRerNl2jDlc3N3DXzhFj+Aeae7FJax0WRR0zwMRLmdrX4jjD346GO+TJIpia
         Tig2TZavuiMV49c9VXRbuMzu/NOROnFRUuo3OkGVOxo0TiCIKK1UNRiy/t27LzEu3U7K
         FE4o4qVyrcmHUirjix53cW7+1LU3urLOd7xKHGhuXqAflTK9Betwzno4iFkZFlpfKd8J
         Dsq+2aG6wDI4IvuflLuzB/h34OyI6mew1jyfLFJG0+2WSJegiSeNSycaVLYl2Fsg7/yX
         yCxQ==
X-Gm-Message-State: ABy/qLaEtEYil7qr9NS6XCSeh5IyTQNpPDj8jAUSGEETaYFQhKr4CXTy
	R1NLJV5U0/k8dadl4m041pY2g6wBed0elDsAjrsQOA==
X-Google-Smtp-Source: APBJJlHo3pU1kZeqWbgoH5A1vUT4XNVqyuKwF7UocmvgkawaYz9dXgJiurzGYir6A1qsD2CcPowPZQ==
X-Received: by 2002:a17:907:7f89:b0:98d:cacb:888f with SMTP id qk9-20020a1709077f8900b0098dcacb888fmr22170785ejc.49.1689089108043;
        Tue, 11 Jul 2023 08:25:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:311:9dd3:e9de:8b52? ([2a02:578:8593:1200:311:9dd3:e9de:8b52])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906395700b00992a9bd70dasm1326701eje.10.2023.07.11.08.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 08:25:07 -0700 (PDT)
Message-ID: <282ef84f-92fe-efb0-7cc9-0b6abe81381c@tessares.net>
Date: Tue, 11 Jul 2023 17:25:07 +0200
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
 <b8c5b310-0916-8cec-b5bb-6a2b5b56f218@tessares.net>
 <CAJck1w0DrZc_9NEi2OA_TYeawWazsuo4iaLF05Ca_tw51gXYHA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAJck1w0DrZc_9NEi2OA_TYeawWazsuo4iaLF05Ca_tw51gXYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2023 16:28, parthaz lokesh wrote:
> I'm not referring to mptcp flags being dropped by the middle boxes
> between client and server.

OK, then I'm not sure I understood what your setup looks like.
Could you share a small schema please?

In Tessares blog post, I had something like that I think:

> client <-- TCP (SOCKv5) --> proxy client <-- MPTCP (ShadowSocks) --> proxy server <-- tcp --> end server
So with MPTCP between the proxy client and server. Is it what you have?

If I remember well, redsocks is intercepting connections and create a
SOCKSv5 connection to a SOCKS proxy and I think ss-local can be used to
convert SOCKSv5 to ShadownSocks, no?

> I'm browsing in applications at server and expecting that packets to
> be mptcp. So, connections are initiated at server itself in which
> shadowsocks is installed and did mptcpize and checking packet captures
> for mptcp packets. But there are no mptcp packets seen in pcaps.

What is the "server" in your case here? The "proxy client"?

> The tutorial ( https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/)
> works only for incoming connections but not outgoing connections?

If I remember well, I used 'mptcpize' on both the proxy client and proxy
server. It also means that the proxy client can accept MPTCP connection
and the proxy server will try to use MPTCP with the end server.

(I don't know if you are here on the proxy client or proxy server host)

> ss -Mape is showing below output. I think shadowsocks can generate
> mptcp packets in response to mptcp connection requests. But, it cannot
> convert any application's tcp traffic in server to mptcp.

Yes, here we can see the listening sockets. So yes, it supports incoming
MPTCP connections. I guess it only creates connections "on the other
side" when it is needed. So I guess you will need to generate traffic to
see what it tries to do.

> State           Recv-Q          Send-Q                   Local
> Address:Port                   Peer Address:Port         Process
> LISTEN          0               1024
> 0.0.0.0:8388                       0.0.0.0:*             uid:25687
> ino:49300135 sk:1 cgroup:/system.slice/shadowsocks-libev.service <->
> LISTEN          0               1024
> [::]:8388                       [::]:*             uid:25687
> ino:49300132 sk:2 cgroup:/system.slice/shadowsocks-libev.service
> v6only:1 <->

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
