Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE541C11
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:33:04 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso44223115e9.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685543583; x=1688135583;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1+jvhZgTCzRNUnVLUNZoAnXDhopUPwgOzdffntmZSg=;
        b=ISz+V6N9s8DQ1XhDttbUByZCPMLjf6vLSsb7SzF/GAzegwbMCp1Pnr7UfUsuVLpExo
         6qN18JzDINzKL+aQh+S3ZgalhwrGjacwraWVT/HtUiYaxbg2d+co5mRdydgjoqUWpz8P
         k6VnByJBfOato9Bs95wmQ9VdGbc0yRAD5I98As1VUxzs/Np2sxh5eJOxvmJ/t8T7k5fX
         hNN+tHT2hY+h+HAWGWW4zx0eaj9Xy+tnQf3IgosuHln1wOUlHeB64Q/3tMlcy2+RWPfj
         GfpB1i2wmp3KDmvlnrUaMMIgsWrrMa6BiVWnJajHqO4lkuEPdE6EjXhHKNAXBnvLPw0y
         ukJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543583; x=1688135583;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1+jvhZgTCzRNUnVLUNZoAnXDhopUPwgOzdffntmZSg=;
        b=TAiDZxQcw1Wa0kTjx8oh5HJXjyNuvDW73FFkCIZG7QPL7bAExFw2vtWRbCmRoD8s51
         Hs8cy/cJ0b1nOhN7eOqUvqmesMQXXhzxxs7mMaYEPNWuT69dCqiv5waHSQDlPQt8gQH5
         fr7oet15sHgHrY7DQQyfTtfBVcxd1jKKLNLhNNnbdGw+90AuVl35hR2l5j8fH4+6W/cy
         +q2jBYtgXj2xPzdp1I68rL2X2sCqa70Wbe9Qr5UwuKJf04/tjYcQ7kwyqJy3vzteTe2H
         II1lL+LgBkyllSIYZ7cvMn2atlrpRu6PQbVraOGAvRSUfHgOY02JuBQrFBrS6qrZNdbr
         Vtsg==
X-Gm-Message-State: AC+VfDyiUPkDsvsO9qj+FYM8NHp5dZVtrotcFJkU2Gb/+J2bofMZmytd
	MpA/NkzIQq/BWjBPhApr8zMPjko16KvRV02KJyANoAo4
X-Google-Smtp-Source: ACHHUZ7XWAg62mTB0eDUxRTIDPTdzu+OKVHUdzfmC1OtSuvv8gAJ8DNMRcbLwnW3M6VNS0Sw6S6/tw==
X-Received: by 2002:adf:ef87:0:b0:309:4ba8:86a0 with SMTP id d7-20020adfef87000000b003094ba886a0mr4037719wro.17.1685543582882;
        Wed, 31 May 2023 07:33:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b0030af15d7e41sm7013116wrt.4.2023.05.31.07.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:33:02 -0700 (PDT)
Message-ID: <9e104779-9bb4-07a9-a7d4-697bb517202e@tessares.net>
Date: Wed, 31 May 2023 16:33:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v2 0/4] unify PM interfaces
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685067241.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1685067241.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/05/2023 04:16, Geliang Tang wrote:
> v2:
>  - address Matt's comments in v1.
> 
> Unify the three PM interfaces: get_local_id(),
> get_flags_and_ifindex_by_id() and set_flags().
> 
> Geliang Tang (4):
>   mptcp: export local_address
>   mptcp: unify pm get_local_id interfaces
>   mptcp: unify pm get_flags_and_ifindex_by_id
>   mptcp: unify pm set_flags interfaces

Thank you for these patches! Now in our tree (feat. for net-next):

New patches for t/upstream:
- 558812262951: mptcp: export local_address
- 8d31a594a5db: mptcp: unify pm get_local_id interfaces
- a69053aa196c: mptcp: unify pm get_flags_and_ifindex_by_id
- 7488b43424d9: mptcp: unify pm set_flags interfaces
- Results: 3d6d7b126211..d5bf0f97d0f0 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230531T143030

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
