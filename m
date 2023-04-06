Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101948BE0
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 15:08:53 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id r29so39820629wra.13
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680793732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plDn9ZfrLqIGlNUKNGWNc0OQRPWonyCB+UZVQY+/Jys=;
        b=hlTW4h40tzUd9EZBChhvvrt2dK0bK6AJBO2sDttu6fkro2RSXSoSKxg/PtLyuzikun
         wxVfn9UxLMOuXAmtDlbLZVw+mOmn67Tci+Df0ooWSfJFj2CX79fYdv9Jwwf7mVTpOt4n
         bnXUGnpJmqKQMTTV7bH/SFsEMnkWKGeHR9eY5l/QV/vm+CO49z16mwzgj7i03D8p4JD3
         RdkX1LSTj9k6ZLfHT5efCmKkaaJ3RDuUwDiUODsqDrLa/jqvV95Y99LUFVafAXlxh0J2
         AerU9ayrQbkCnlaIooa8S2/7uyKPfFCyBhaHK0XxuJii/iS0CGZ58tOIC9dYKdRaUwQr
         emuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plDn9ZfrLqIGlNUKNGWNc0OQRPWonyCB+UZVQY+/Jys=;
        b=JWKKzl4THn8YjYTuSS71Gs39AdQhMpPZBjJOK3FZWOTMH8Ioj2OaHCZFX2bMR9UTwV
         qUoJIDeaoYCIBerbkrea81tctXQXRNh4T4IUENwhd2oakxhPL01eJhPwTP8moSobxq4v
         GD6f+M75P8odYYbR446qMtp5C9fa0gZ6NMRZnB5bkRbuOzqAFyEr/j2iKnFdt9F9yR4G
         W8AQSgbA8tLGTuBZGBw9WmnAY1f5zmMF3OqxoHPcKW1xjLhI08iDI6RFAljlZkAczNTb
         xbeON5VlknJbGVAnSy0DPRR/e702ABy91a3F7vmcWWfVuKAMqC6uKv1j5PXCCfD//Xj7
         CNGQ==
X-Gm-Message-State: AAQBX9fwhwmhOAYzzqHIiB1vhMjhsjXbsZEGvtfP84qpoYYMs2aPLFWe
	GTbgntlzEpqZBeS5uWyXXe2kDuLPVz3c9Eaqp+dJ/g==
X-Google-Smtp-Source: AKy350Zvdn6wdR6zJRG6bXXDEU9kWqUIhRlANwHQKfux0P96icBqVpZw65usoscwTZVxX6cPBfLnSg==
X-Received: by 2002:adf:dd91:0:b0:2da:3ef5:5a39 with SMTP id x17-20020adfdd91000000b002da3ef55a39mr4720675wrl.14.1680793732025;
        Thu, 06 Apr 2023 08:08:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:96d8:3be1:720d:ea61? ([2a02:578:8593:1200:96d8:3be1:720d:ea61])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d4742000000b002e6423cb207sm1939901wrs.112.2023.04.06.08.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 08:08:51 -0700 (PDT)
Message-ID: <38e23250-2264-c3a9-3df1-1c3f6fe3b86c@tessares.net>
Date: Thu, 6 Apr 2023 17:08:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-net 0/2] mptcp: a couple of fixup
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <cover.1680733942.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1680733942.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/04/2023 00:47, Paolo Abeni wrote:
> Hopefully addressing for good issues/371
> 
> There are actually several different problems that pop-up in random
> order with the repro from such issue.

Thank you for the fixes! They look good to me!

New patches for t/upstream-net and t/upstream:
- 3ac6e434b228: "squashed" patch 1/2 in "mptcp: fix accept vs worker race"
- 8e2c8f661424: "squashed" patch 2/2 in "mptcp: stops worker on
unaccepted sockets at listener close"
- Results: 5b4478bd1afd..e8ce70ce4423 (export-net)
- Results: a73afdaa7080..2d58f6944092 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230406T150700
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230406T150700

Cheers,
Matt

> @Christoph: could you please have a spin in your testbed?

@Christoph: you can now use the export branch ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
