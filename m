Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FF2C85
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 16:27:22 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id e3so74424573edu.4
        for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=/fo9JVdijuQqISCL6rVBzHzQnc7h7vGFCihs4W1CoOQ=;
        b=an0HWeVXEJSF1Rx09i3fUd2EWecUfjyUz6Jvh1Kzoqq1F6CsO+iK+ORDyz41XZb1zx
         Wn9T9i/EkWItbhidp8Y+Lo2yZrGTTAFwemmJcLmJLTnkB7j1CW4C2EptL6/mzWR6QXel
         8hC6LPAkJpBz0IrJLpBx+u3Dh23wjkmsAGxWtk7z37imoM0XVHkGN49bgf5qfV0KW5F6
         TlvwS6rugOeHWPSSRRWtoMlfZEGh6Pzuj1wNmQX5K+jxD+Nsqm51yanHi/G8XZtxGcTc
         qnFsYRVWT6XaTziv6sZ2gE6mp5VBK4bexCF2h3ZPXAXFd1pU0wuGSUNiRCOccxyNGpcZ
         ShBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=/fo9JVdijuQqISCL6rVBzHzQnc7h7vGFCihs4W1CoOQ=;
        b=2YUHIN39GV6eDBPJ6O/+t/6w2vSqgheUIfSM2Q2sB8he8XfK2SKdKWRbW+SKsVbjNI
         mIogjCvuouzTog3nI3pcuHGG2YnvFcT1xPYN1YD8DGpuMOVGiLl/roO2cDa0xM6OjH5t
         tTyg35hwhllHsiPVk2nclO7RYrVzuz4mPCCLcu2P2K8DllKTItGvt5WA3IDdtmen5THz
         Mm/7wZ+FXNLGdoq1YvSOJb1etYjVlsW448YTCHfqoprKXOEs3/aLfpA5O+bObOhMRPG1
         xs0fwdz1wBhEYbYD1BljWSofxK3dADPZpAC0ybmn6janGovXRlLNT0mnCDDAkw8sKeq/
         sKWA==
X-Gm-Message-State: AOAM5300I2IJVK79IOAz49tsxbZZp2mIuhTmHJov6Mh5a+BIvUENfAJ5
	/SGHrHqr3BlpxHx/4a0/yEPQpg==
X-Google-Smtp-Source: ABdhPJzHs/zUkT/3JaegnzeJIuNF8tHaZHQUOq1YCyx2t/JLDFDOw/B2kgtT/t173Cu9AWNzWhvJAA==
X-Received: by 2002:aa7:c846:: with SMTP id g6mr75766986edt.75.1638203240331;
        Mon, 29 Nov 2021 08:27:20 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id bd12sm9496800edb.11.2021.11.29.08.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 08:27:19 -0800 (PST)
Message-ID: <ed3efccf-c67f-6a08-d31c-767ef81e225a@tessares.net>
Date: Mon, 29 Nov 2021 17:27:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 0/3] mptcp: support disabling Nagle's algorithm
Content-Language: en-GB
To: Maxim Galaganov <max@internet.ru>, Paolo Abeni <pabeni@redhat.com>
References: <20211123070708.2897469-1-max@internet.ru>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211123070708.2897469-1-max@internet.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxim, Paolo,

On 23/11/2021 08:07, Maxim Galaganov wrote:
> Clients for MPTCP-enabled transparent proxies may experience unwanted
> delays when Nagle's algorithm combines small packets into larger ones.
> 
> This series adds support for TCP_NODELAY socket option in [gs]etsockopt
> for MPTCP sockets. It also adds TCP_CORK support since the two are
> closely coupled.
> 
> Patch 1 exposes __tcp_sock_set_cork() and __tcp_sock_set_nodelay() for
> use in patch 3.
> 
> Patch 2 exposes mptcp_check_and_set_pending() for setting the
> MPTCP_PUSH_PENDING bit when cork is cleared or nodelay is set.
> 
> Patch 3 adds support for getting and setting the cork and nodelay
> sockopts.

Thank you for the patches, the new test and the review!

This series is now in our tree (features for net-next) with Paolo's Ack
and my RvB tags:

- 46bc37d252e9: tcp: expose __tcp_sock_set_cork and __tcp_sock_set_nodelay

- 6d902bda5f72: mptcp: expose mptcp_check_and_set_pending

- 54c2d9725869: mptcp: support TCP_CORK and TCP_NODELAY

- Results: 2cb2e25a2eea..ca3b812b57ae

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211129T162606
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
