Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45427E
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 12:13:55 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id m18so28738856eji.5
        for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e5nuJPEM4MVTR6MjUBkxPcQC4lQOG33sADeVoQuyIQ=;
        b=W8GMaFcaREAdaB4/18m8wpWIwMO+WTo+QKCDBrRpUd0BZoJ5eR4borZethaZ+LQfT1
         Z+WSHwBe10hSba0gROT8pl5QF9Y6lIHfUNqsjgEhH8jBldIRpy2K6jnmsQp5FlkYQobh
         qcax731R+HxrayVTW0//zsq6TTpGwFxnolROPwqzEkLAX957AXQsigAzfM7NydelMgt8
         uVwbfoo3EhGTD/2/4g0moPJFuzR8Gz3TZlBpca0qCeym76S+bQO1+5NXeB220x/gSk9I
         qIb3jmHedSiSMJHYzN6sk4EnuDVdFyZjG9MDHd5UFYcUDafChUXfErEjmgbfFcKc9Q9c
         LZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e5nuJPEM4MVTR6MjUBkxPcQC4lQOG33sADeVoQuyIQ=;
        b=FdNxJ2CHbKRB9WgAomhIOWakMtIid99yqnDcTgA0hCDSG5fF3lknzyMuMpQCNxnpnN
         Xm3G8POQtpQu3Mzm6z86R2VvkDlerqZYlawEl4JSYAYTpGaq+hQus21OUvGOmPDtxotn
         piLC5RhS2r2ZD1MkyCiowHTJL27F2IiSsaDOhQOQ8gI9ag2EaoTFqzNdB/lzlm5y7Opv
         bSx3zC63kgIiQjyvyywnSMgjNAYAgUwU9t7AWvV5M3KRxeqmlt5vFPIV1sYVjx5QlMmf
         4SWk5pxtuISbC+/3BFzqVSnjdjkS09kKuU1Bxa1vEqRtFU77vjNduMA2jLGESBvLhvwH
         o8JA==
X-Gm-Message-State: ANoB5pl9s+QyP4bUgrZ8RUOzi4PoqFszfYoJTdpWxj/+Q2VKBbZXd3CG
	QXUEqSvqhqXN+zp4ggcT2TO5fQ==
X-Google-Smtp-Source: AA0mqf7l6QeJKlhu9t6iKgURDVuwPkzrO50ZVjvX2kecXksXC/E96qqnbU87y1I9QYFIPKYndKtfEA==
X-Received: by 2002:a17:906:f6d7:b0:7c0:bf7c:19f4 with SMTP id jo23-20020a170906f6d700b007c0bf7c19f4mr38844164ejb.74.1671538433800;
        Tue, 20 Dec 2022 04:13:53 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709063c4700b007c08439161dsm5587190ejg.50.2022.12.20.04.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 04:13:53 -0800 (PST)
Message-ID: <e7432f89-e9fb-9054-77d3-e6d9b9210cc6@tessares.net>
Date: Tue, 20 Dec 2022 13:13:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-next v10 0/6] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, pabeni@redhat.com,
 mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221219102316.627491-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221219102316.627491-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong Dong, Paolo, Mat,

On 19/12/2022 11:23, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we rename 'sk' to 'ssk' in
> mptcp_token_new_connect(). In the 3th patch, we add statistics for mptcp
> socket in use. In the 4th patch, we init the 'sk_prot' field with
> tcp_prot in build_msk. In the 5th patch, we make mptcp_connect can exit
> when receive 'SIGUSR1' with '-r' flag. And in the 6th patch, we add the
> testing for this commit.

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Paolo's ACK:

New patches for t/upstream:
- 3e81eef55e91: mptcp: introduce 'sk' to replace 'sock->sk' in
mptcp_listen()
- f5581c182734: mptcp: init sk->sk_prot in build_msk()
- ab505b464266: mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
- d0633acb8e61: mptcp: add statistics for mptcp socket in use
- b1bf2f9ebe13: selftest: mptcp: exit from copyfd_io_poll() when receive
SIGUSR1
- 1398fc057f98: selftest: mptcp: add test for mptcp socket in use
- Results: c9ea6d26632d..63450d7ce1cd (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221220T121253

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
