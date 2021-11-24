Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98368
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 09:52:40 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id o20so7632777eds.10
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tyidGiNDfkFNSZJLoXUz2P+oLhyQaeh2kEo772jGmIc=;
        b=btDbCMP7QlkXSQDHM+lbJhtCInnBAwhOkiahsixEO7yIWXFTuO72kjOFkzH4bzSdhB
         6EAt4fDdCIUqbnFMyXwX7I1eabaa46bBVbyCVCpvoVwdFPkzjMcuxJuRpPBL1wXVzABf
         ueBPN7HAHAz1qkKmGa6rXHH7EUvg0dHMt4K+1SYuFDEfLxhL2LziyFGlvA0+zA8rFIik
         1rNb10Yy9Wlf/a5RWP00/0SH7rVUVrfNZtstfqsFvBYaNsZiN6+/UJarOSQncN55S/Ay
         1MEuflQJKwX8r6NdgVbsxq640jY4MlOHT26WD9G6nW8yfEoM5vnyUvKtMMjqUP/RTmrD
         j0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tyidGiNDfkFNSZJLoXUz2P+oLhyQaeh2kEo772jGmIc=;
        b=LyoaG1viel1OZi+pn+lsomVyVw/Exm82kbv3nhv//sfVVv2gamDaUuOhHOk2tVRXgE
         DX9sIgZKVdIjujkBlXBCPtxRTxPjVvtJdPF0XaInN0MI/CdJcbc7ZXiXJv8lRomls39u
         O4W2jxMEuF1YD8HLC6ji+B86YZIHoQxZc9s8PrHU23RGy+Up4Svh0VcUYjpCngnLNPOq
         gL/JpWJRKYsnXi9wKSd7O70txdP3gWY73l0W+LVmZto1XzkPxXo/FiZKJKxiSIASlFmV
         TjlY0/EE2pgr+CmY8ko4Igy36k/Bhgu1ztUcuY5bRKt8nPdk7wSpaQcdxLuGSsX7nzNE
         IwwA==
X-Gm-Message-State: AOAM5302ZgXFeTF0szb8Wq6+2oBzHkhn/odhoepcVuWaPdcnTXxnHcWk
	8dps2tTZ5fWKTvg9KzDV8LtkO6mv5IfjEA==
X-Google-Smtp-Source: ABdhPJzYlkBQqjS2iqVkO5bWEipPu41n6XpTZ8quZCWVPV4Aotva5QDQ1V78GM4YTx/UISem53dqzA==
X-Received: by 2002:a17:907:1c82:: with SMTP id nb2mr17955918ejc.218.1637747558371;
        Wed, 24 Nov 2021 01:52:38 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id gz26sm6396487ejc.100.2021.11.24.01.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 01:52:37 -0800 (PST)
Message-ID: <62f3321d-f416-77ec-f488-12372b998fbe@tessares.net>
Date: Wed, 24 Nov 2021 10:52:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 1/3] mptcp: clean-up MPJ option writing.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: Phil Greenland <phil@quantulum.co.uk>, mptcp@lists.linux.dev
References: <cover.1637684792.git.pabeni@redhat.com>
 <5e98a57b75ff1d45305bc5b6ba7fcbd24d355b65.1637684792.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5e98a57b75ff1d45305bc5b6ba7fcbd24d355b65.1637684792.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/11/2021 17:37, Paolo Abeni wrote:
> Check for all MPJ variant at once, this reduces the number
> of conditionals traversed on average and will simplify the
> next patch.
> 
> No functional change intended.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Good idea!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
