Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99B18AE0
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 12:02:27 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-977d7bdde43so214557966b.0
        for <mptcp@lists.linux.dev>; Mon, 05 Jun 2023 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685966546; x=1688558546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2IKmybOE6Qqu8xqbL/YToK+8dRCbNjOYoJ8C4rjb34=;
        b=fL/Os788tnEk+koG6vQYnl6UONp8mRhN8tI/Q80A2jg0LX3FRlSFPEj6UhGQgC0qYf
         R7l7opMsCIXl64biXV72WTNsaYfHKxM9c5gYgtP6YXPFp46wo3TS10pdirBmnv0UJZpu
         +59xIa2ELHUsact9ejw89NbNsYgmTxpH4ekUAl+8Yy7jyg3+WxNEOiJX1fZ8I8V/ZGE+
         h6iKXU2b/dxxSlZb1Rn6Av12bJopEWNR20puscJ038MOfd4AO7YhD6PJE217Xglnh0SY
         dMc/h59J09zOUglhxbzVmgSAnXvmEUGUrSgpdmybG7fPt9uvjX0K0432kXXgZV+QC9tQ
         sPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966546; x=1688558546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2IKmybOE6Qqu8xqbL/YToK+8dRCbNjOYoJ8C4rjb34=;
        b=cXaR8Bc9E3OPprypSo4cJYMzwsV420UFv86/nX0X1B39wdC1xaZbbtaE0fas88oiFU
         UEwIexefAvMAnVDv4AopYTa6Bd8lXbwL4JeBY6tIMy7I84RzsD2lg0YbSFOkLbMDAE4r
         X0QMBGfdTdw/hdgy7s72sm7F+44cPTFzE6xfiABUT3CzjxqrT2GRQ3QNyvv069ZLkTz2
         eipJnBWMZw+m/HCtQMZkG/0BqG/ZGHFcworKAYNxbolveTwNcOeiAgMyXuxwF9L/Ckjp
         DADRvor+3+uXex36AKn4SRauzjm8TCN9283BK/C/+vRhdYiaH2O0E5jKT1hhRwB3BEvT
         IgQw==
X-Gm-Message-State: AC+VfDzNvaoMEWd5XSSjd4xTrH1On4UZ+qVK4d0opy2vHifk6RMO13cl
	YOZqcFCYs6ajMB64NW25f9v+AQ==
X-Google-Smtp-Source: ACHHUZ7YNmJN+SIbYjcDVV3t1OiRuo36CuWLmc+OUR8gfiefIlKDAWIbYJWNio8Jno625Y8WCZRaaQ==
X-Received: by 2002:a17:907:845:b0:94e:4b26:233c with SMTP id ww5-20020a170907084500b0094e4b26233cmr5232569ejb.16.1685966545916;
        Mon, 05 Jun 2023 05:02:25 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id e1-20020a170906c00100b009745e1065f1sm4141836ejz.206.2023.06.05.05.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 05:02:25 -0700 (PDT)
Message-ID: <968ddd7f-4923-d025-edfb-130da22db8e2@tessares.net>
Date: Mon, 5 Jun 2023 14:02:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net 1/2] squash-to: "mptcp: track some aggregate
 data counters"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <829e91b37a2fc12a9a43f20204d26adc0572a7d3.1685963110.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <829e91b37a2fc12a9a43f20204d26adc0572a7d3.1685963110.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 05/06/2023 13:06, Paolo Abeni wrote:
> Similar to TCP, we can't acquire the socket lock if msk is in
> TCP_LISTEN status or we risk deadlock.
> 
> Note that the state test is safe since mptcp_listen() moves the msk
> socket into the listener status before acquiring the listener hash
> locks and such test is under the listener hash losk scope, so we
> always observe up-to-date status WRT listener sockets.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this should close both 407 & 408

Thank you for these two patches! They look good to me!

I didn't manually started the CI (Patchew didn't pick them) but I guess
that's fine, I will monitor the results of the next builds.


New patches for t/upstream-net:
- 03bc50090ca8: "squashed" patch 2/2 in "mptcp: fix possible divide by
zero in recvmsg()"
- Results: 99b0d45d8952..115421ae243d (export-net)


New patches for t/upstream:
- 10b9a3cb5dfc: "squashed" patch 1/2 in "mptcp: track some aggregate
data counters"
- 03bc50090ca8: "squashed" patch 2/2 in "mptcp: fix possible divide by
zero in recvmsg()"
- Results: 5f7890e72b9a..bf58b04c9bbb (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230605T115910
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230605T115910


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
