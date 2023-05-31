Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C62583
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 15:21:46 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso44863205e9.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685546504; x=1688138504;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UoJ5pSLdOhGDqU1/u/CuZQ8UPvbD0tAm+RpD8HrjF/g=;
        b=Eh1aOCxwQzPMrFb37p55wRRke7Ijjd/VA1h713jChZ6ZhRfhcVxhYnoeEA7mojkawj
         V0mynpORffWekCGEslWtEUmvY1+E3RPkfvMu1dUwpbdrI/GmYIAULB2GfwccdhZqHhdp
         jtLjwMbUXzpgEYmBB1Dz7MAjoddaRvBMnplAjvmo4v407rS1PQJZgsUOozS4BWJm7qDX
         WZAfByzM8Kng8SgG9568SvWf+KpoKrN+SSsZEjIiRJKGPk9SEovebVeO6QO0Nedrz48i
         tc8dSRKXZ4wAk2XW2mbY2fQX/xlztuov4iTuN+khlNAH7zjJgdDLiBCfEEttN3lBNNil
         MhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546504; x=1688138504;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoJ5pSLdOhGDqU1/u/CuZQ8UPvbD0tAm+RpD8HrjF/g=;
        b=l1c5L7Y6zPxSs70GV4oCdS+QHnYATgP15ey3D0pSuOHhm4rqswKUGJF0jLNcTKspok
         K3bkvQd6nSFprtWOSrGvM8/jM/3P0pOqAkNUUweW64kh1/qFunj/IIICJ8pz9f+ch/Bz
         /FyIgc9RUydaC7H3Sx4xhEkfa/lQ9t53XQODk0XkU0Z3f+0gqH4Z2ubhQTyAEzAvU0QU
         wJc1eyKDT0ryA+q4v+HhTRTl2ILW2RCfB7YvOykfzO1pJ+1rtTQOOhPxTcJNExTaqKq2
         rDHrcIpJ8vVsNHENpOCA10aHdtU8c3YYq4s1ZTN/pCkdsS6IzLqE+cvanONUEhQP8ME8
         UwGQ==
X-Gm-Message-State: AC+VfDyXggJxYkPaK8pXznDD3ZQjnM7Donp1DJw6WAuzj+BolwQXBRSK
	bS92FqK+SzC/apy4Q0WutiDF/ZKAtLpArAEorFgQOCd6
X-Google-Smtp-Source: ACHHUZ7sGaU/1Rc+HuZ0mmnKF3U5Tl9dwAonPu3ko8fVu1T6l8R0Ek3arERn0dkYPcbtqo+zHI3PSA==
X-Received: by 2002:a05:600c:213:b0:3f6:c8c:7048 with SMTP id 19-20020a05600c021300b003f60c8c7048mr4202136wmi.20.1685546504385;
        Wed, 31 May 2023 08:21:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id t16-20020a1c7710000000b003f604793989sm24616405wmi.18.2023.05.31.08.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 08:21:44 -0700 (PDT)
Message-ID: <30825b01-27b2-d909-5aea-f6111a52c9f0@tessares.net>
Date: Wed, 31 May 2023 17:21:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 0/7] update userspace pm mptcp_info fields
 part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685523463.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/05/2023 10:58, Geliang Tang wrote:
> v15:
>  - fix the failures reported by CI in v14.
> 
> v14:
>  - rebased to "selftests: mptcp: skip tests when features are not supported".
>  - patch 1 "selftests: mptcp: skip tests when features are not
>    supported, v2, patches 8-37"

Thank you for this new version!

And good idea to have squashed my patches in patch 1/7 to still have the
CI validating your modification!

I have some questions, see the individual patches.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
