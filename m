Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C43258B
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:25:31 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id d2so28329280ejy.1
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=87iGSZHhLKC7RK5wnQSrWJX8PqNz4L9Cn+IZNU6y1U0=;
        b=07VxVFYkHcv7fsFfyIsc/zoh01e35Te3Cp4alM09x3+Xe1seA1h/rlTe99qibbO6o4
         dpImToA3Yj2hammi4USGnKFiy1PomZOLkbQfTZ6b12KiyM0Hqz96bSemk3Bx0aNe2wkc
         NUnyLLMn7mwVlAKv2CZ7IliGun1jC2LW3QmNKMO4XpOEl3IepyGE+oF2DjrQkO01JKB9
         yYz6wSK2u9p/E12x3a4ZBA9chjmO/4IXEQD+TGarYoee5f4XAUUvegoYGBbotofiMEKS
         EIMIC8CH1XQDGgRy72zZGInma5MYjePkBmPNk5hqTUi2o677KafJ6Jx9/SQxiZ57uO5I
         Bbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=87iGSZHhLKC7RK5wnQSrWJX8PqNz4L9Cn+IZNU6y1U0=;
        b=Y6FzGXiav65TSrbsJIZXSPB3kDWBEMOt8hRxjUdVO0yhRuX3FncOJti8lgprarnJIW
         QUZXZCke1HYMmnpOZInlaZDl04kAK3f5sSZiEfZP0Hg1ZyGpe+bEHtXHM/qoMCwVCfLs
         Q+AJXgpbH3VF2pjWmKB+Er+canKqAqm3KiHDVCiO+jGtjmsGXDo+G6Sx3uWnfWcr2dEu
         AvzaF0leoOSO9sFyyYYKeVsspTQcZddD8eCWKafJqcCTz66eL02jCfhiGoQo3g7xyDbE
         dFb6/IiDX6m93K/4owcs3R80aiut1BwNdG5QzIB6EX4BknZg/VDn5OxzTdQhu7PNR9iD
         MZtQ==
X-Gm-Message-State: AJIora+n8xLzYD3JEVuE9zb+THBnN6Yalvt2lcfRSy+5+QnufYV5K2/O
	Vn/UKMg8x5x2r+A7wbNBnAarxA==
X-Google-Smtp-Source: AGRyM1veN0LqfKCp8pLI9HCqq/PULs9QJ7ocOeloyjSAJcOsW4+X1zdOeT2XhzB1aTOeuxNpIpBZIA==
X-Received: by 2002:a17:906:11d:b0:712:abf:3210 with SMTP id 29-20020a170906011d00b007120abf3210mr39738521eje.292.1657128329524;
        Wed, 06 Jul 2022 10:25:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c688:fc49:57d7:6b4c? ([2a02:578:8593:1200:c688:fc49:57d7:6b4c])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b0043a45dc7158sm7984831edb.72.2022.07.06.10.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 10:25:29 -0700 (PDT)
Message-ID: <936ab7db-5658-ebf1-d794-7d7499ade4d9@tessares.net>
Date: Wed, 6 Jul 2022 19:25:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-net] mptcp: fix subflow traveral at disconnect time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 06/07/2022 13:18, Paolo Abeni wrote:
> At disconnect time the MPTCP protocol traverse the subflows
> list closing each of them. In some circumstances - MPJ subflow,
> passive MPTCP socket, the latter operation can remove the
> subflow from the list, invalidating the current iterator.
> 
> Address the issue using the safe list traversing helper
> variant.

Thank you for the patch and the review!

Now in our tree (fix for -net) with Mat's RvB tag and without a typo in
the commit title spot by "checkpatch --codespell" (s/traveral/traversal)

New patches for t/upstream-net:
- 58ff490b91bb: mptcp: fix subflow traversal at disconnect time
- Results: baadb06447f4..521c161b5a7b (export-net)

New patches for t/upstream:
- 58ff490b91bb: mptcp: fix subflow traversal at disconnect time
- Results: bf96db80c6d5..16136c6f92f3 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220706T172158
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220706T172158

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
