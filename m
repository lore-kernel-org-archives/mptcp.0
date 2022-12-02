Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB67B
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 11:12:58 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id fy37so10733114ejc.11
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 03:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6NhsYUlqqIq8iJiYiksjvN/HTRgcOQ9z1jZhCvGrRQ=;
        b=kvroVxEJJLu5rwo0iz0lM3OsKrszt3+WiokSAMwWLnt1+7gT1d2CSiGhCOTe/kGYjK
         BWssOYHdW8ftLtYFmR4OyNFgJ211eFj01pb5ZWanvZCUT8B+4qlljrCKpa9ew8um1Wkt
         D0usCLoKvGpz7LWhJ1ZfojioXyMT4F5VEqn4QJfKetVZux6E4+0lVOsUKcm1vcDlphX1
         J3qgMxIUgtjgGeBlXWqzGjconsO0KTWdoSws/PGssaqXRDl1F4YHLnxplAHvXm/CVTM/
         HERLBHUgYsnTw2IX14GRgIb2NGHHE6POZskv+tYoh83+CMyYv2JKqz5EpJ26/9vcZfvy
         oYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6NhsYUlqqIq8iJiYiksjvN/HTRgcOQ9z1jZhCvGrRQ=;
        b=Ryi7XoU+kp5GryHu72cW0arkRdghn904dRBcOpLtIWjzPpeFewWMb2Ukk3/APRzAiq
         NlccsEjdRmDK0gP4cP1IggVEcdO9H/LwHmuA+uPQVNsTIViW2cJSmEtfpmSvuE9xdaaw
         AADX0FGQRJ+nxeHAdVczBTlWzqYm3ukFyGPNrJPmR98MI7ES+Djn88CTqE/YWhpAvSc0
         lsaNd1Gk/6LC9MAqtZxpKOXwT5lCKXhLd2TI3agc870tFp9ksv29ToH64o5Fs4SebRQZ
         A8lAiiacV4kKjWZlZPQm3enJSFvm4XZ7/p5sxRBY35vAvOAB+INkWARbLfyMMxxAKBp8
         KKNw==
X-Gm-Message-State: ANoB5pnCT1HeZjzac6uj+97FbWOGAcZh7nQabu4adQtl7ivi2anwEvZu
	csW8GcYeSl8sObzt3QHAPBrjmdpOBoy7n414
X-Google-Smtp-Source: AA0mqf4IWbORbiJVZD1IH/i59XzbN/BCnZl7fbPupPED9jNO0XK36tFC8Ll6gw4JtZR0Z7v1tScLGQ==
X-Received: by 2002:a17:906:bce9:b0:7ad:960d:3a4d with SMTP id op9-20020a170906bce900b007ad960d3a4dmr41629549ejb.522.1669979576516;
        Fri, 02 Dec 2022 03:12:56 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bj15-20020a170906b04f00b007b5903e595bsm2880005ejb.84.2022.12.02.03.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 03:12:56 -0800 (PST)
Message-ID: <381e36a1-f3b0-6a4e-d32c-2f6306c74a86@tessares.net>
Date: Fri, 2 Dec 2022 12:12:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-next] mptcp: use nlmsg_free instead of kfree_skb
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>
References: <20221202053736.2980-1-geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221202053736.2980-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 02/12/2022 06:37, Geliang Tang wrote:
> Use nlmsg_free() instead of kfree_skb() in pm_netlink.c.

Now applied in our tree (feat. for net-next) with my RvB and the commit
message slightly modified as suggested before (we will still modify it
if needed).

New patches for t/upstream:
- 32ad7937c18e: mptcp: use nlmsg_free instead of kfree_skb
- Results: a7affd41927a..7c308902a06c (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221202T110835

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
