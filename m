Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681017E
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 12:32:56 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id b15so20528604edn.4
        for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sb+ReE7Q3gNB2yNK4M7Wes7Vr9UhYukQitRQ/3OMfg0=;
        b=YnesfxqXpb3ov/NPO08Lj4DIVvH0MQp5WDqqs1H8DpAXb9OGD7uZpbQQR9H13ySKEu
         v677vNeD19n+oDhQXVY8aGPeejWpGKQzzrFmxqeY+7Szh88MTq7TgU23tJVaiRXcY96M
         zp/7VsUesn/dr39o9B8qwZL3pLtsAtk5mRxvhUHJxnCnG/fOkI9341CxJopTN/foIm80
         fyjLi+CtzN8oJypW3RfsUZbQdB7W4MNTwYP9pGtt1RAIp0VzWwccPwUnjkOfFIHxQQHp
         K8bW/MRL7WrgnN0DHS0MIme5jJWxYgVmukqcHXo+udxJwBs0VPTcaycH8uiSa0QZKl+b
         IWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sb+ReE7Q3gNB2yNK4M7Wes7Vr9UhYukQitRQ/3OMfg0=;
        b=tsypGgXQOz8KoyiIsL131eU9dbgOOHXZn86eE+VSqS8AV/5Fi6CterOrNBKzwhYltV
         T2iru8A3eP9p8XCFvYYURbFGczwncgu86w228kDdWAIbb44IMacBnpXo3eMhjPQM2EMj
         VAF1GWB1unkRWyQQ7xGJV3hQUdWrxLQE/jP6qaqKTu6YtpCZf3yQxJSWBuN2+ckd3Dnf
         vVLaXRLjBAVa3PlGKxxTxqrcGF9TxVqfT/95t94SfSoBFe0eTGnReyE8qDVTJRPBxlvn
         1z3PFxEVB7guIOC8hmLm8ux64YPgDdls2wdgaMc7hEF4BGeHPiyS6RMUOLZD/13BtGVp
         19IA==
X-Gm-Message-State: AOAM530a1Ia3ik2SfA3Tth7ghMGdjyT24nmA+jBVhUXHFnP5KXKiR9iB
	y2emvNvwmjcltle+6Q4hNac1iA==
X-Google-Smtp-Source: ABdhPJxHI54IehFxZVwHIDPOa94R6k7goHCw3GFQa7F7tBOWAh9nZQO2r3WmfkMCnsaEHvcWZacCQQ==
X-Received: by 2002:a05:6402:40cb:b0:419:42de:65b6 with SMTP id z11-20020a05640240cb00b0041942de65b6mr4396137edb.66.1648557174504;
        Tue, 29 Mar 2022 05:32:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:505b:327f:c6b6:495c? ([2a02:578:8593:1200:505b:327f:c6b6:495c])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b006daa26de2fbsm6914727ejc.153.2022.03.29.05.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:32:54 -0700 (PDT)
Message-ID: <f5f24cb1-5388-ca0f-7c58-91387f245181@tessares.net>
Date: Tue, 29 Mar 2022 14:32:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v2] mptcp: add pm_nl_pernet helpers
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Florian,

On 23/03/2022 11:53, Geliang Tang wrote:
> This patch added two pm_nl_pernet related helpers pm_nl_get_pernet() and
> pm_nl_get_pernet_from_msk(). Ues them instead of using net_generic()
> directly.
> 
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  v2:
>  - add pm_nl_get_pernet_from_msk as Florian suggested.

Thank you for the patch, review and suggestion!

This patch has been applied in our tree (feat. for net-next) with the
updated commit message and Mat's RvB tag.

New patches for t/upstream:
- a1dc2cd25b87: mptcp: add pm_nl_pernet helpers
- Results: 0a8da9d7fec9..55ba7616f0ca (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220329T123126
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
