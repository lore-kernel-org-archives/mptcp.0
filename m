Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110746D18
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 16:22:40 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so94781151fa.1
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688487758; x=1691079758;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sxKi5aaJQDZD16X8wrpjsCxKT8foGwrI7uEs1gNqjg=;
        b=656HO9pEEHqm8S8UbzfMKRtTKRC6w8Fn99q+puu23v3Bv2FTpn5V9n+fsIIYQHF0XN
         TyI/X/ETDXolOP4txwuNlojqrgEv5E1kqVQ1S1OkNHF42nBA7xq4egmC3Q2aA12Xqa2R
         efODDNcqLxivKQVQPhvlZxYkQbtBfqC5HDG0G8H1onNLA+PvPV7jP0ZZEomHilQPvulu
         9VorZ2eU4cXDDgfryuXZtpwlW4FEJICH2AcfArjuaPDk3Wzpj5KFjJY2DITLrTBvWccN
         rb/XVAJ0i+pUsrozbHjxRklB8BN4uak5W4QXDD4DtF44slSjFMisbRSVhSh0kFpofAYu
         r2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487758; x=1691079758;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sxKi5aaJQDZD16X8wrpjsCxKT8foGwrI7uEs1gNqjg=;
        b=i3FnLx+AqaWK7XqDXBSWJLUZh7MlXdFFH1Fj6Kq5S5+X1ru6XFIj46oMWkCcZTspin
         Aj3sDKSdJzdfAfQhT5UStcJg7S7GaegpGpP4h7OHyZFuCrDcoeY9tLiHdro1NvDj5YBK
         RJiRZXOxVI96grNCIweohvj6ZwW6Clwu2+7P0EYaCtLrvrpzpmnOXTKx4T6crfbCUJx9
         n0yw3bpEFmb9WEE0ns3WGmUzwQtBrkUyseaS8Hb1KOMvFruYfqKU9aqvTIlGiiNvhSjI
         2+WHtoFTsx5ooUHrk1oT+Wze5l61ckGgyobGm133P2pf8m6fFgwvP9XTlQfvxzG38M6J
         OG/Q==
X-Gm-Message-State: ABy/qLbc+/l0MaxqGZ1t/khEI3Z1mxj2ZddoB0p+PTlpMIE/aTzzXQvp
	0XM1TViixSAMFnnDV023OFbTokJNRfdyFEIEiShyWA==
X-Google-Smtp-Source: APBJJlEKpqDT2eMO+z7/hW6k6liyL9TrIsFgElLOTxM94iWIAL03vk2FeSV82ET0MQf737joRq0YEQ==
X-Received: by 2002:a05:6512:2ed:b0:4f9:571d:c50e with SMTP id m13-20020a05651202ed00b004f9571dc50emr9510262lfq.36.1688487758338;
        Tue, 04 Jul 2023 09:22:38 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:331:7b9f:28d7:4598? ([2a02:578:8593:1200:331:7b9f:28d7:4598])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm5957940edq.85.2023.07.04.09.22.38
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 09:22:38 -0700 (PDT)
Message-ID: <30e29a70-0b10-e809-f0e4-41ae619a3c19@tessares.net>
Date: Tue, 4 Jul 2023 18:22:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: fix 32-bit
 support
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 04/07/2023 18:21, Matthieu Baerts wrote:
> When using pm_nl_ctl to validate userspace path-manager's behaviours, it
> was failing on 32-bit architectures ~half of the time.
> 
> pm_nl_ctl was not reporting any error but the command was not doing what
> it was expected to do. As a result, the expected linked event was not
> triggered after and the test failed.
> 
> This is due to the fact the token given in argument to the application
> was parsed as an integer with atoi(): in a 32-bit arch, if the number
> was bigger than INT_MAX, 2147483647 was used instead.
> 
> This can simply be fixed by using strtoul() instead of atoi().
> 
> The errors have been seen "by change" when manually looking at the
> results from LKFT.

This is a fix for -net of course, I forgot to edit the subject, sorry
for that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
