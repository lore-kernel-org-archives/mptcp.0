Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882560868
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:27:47 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f61530506aso6000915e9.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684934866; x=1687526866;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nh1ozdqkuyL297IQzekf/SyF/gGadVxOjJloMKiRBTY=;
        b=ndVEAQ68RD8k/baBAhUbgKQcARELDntIUkaV4k55w2PY0Upr+Sw1PWnEUe8tI1egdg
         6unk6+tE3ulRkZdkm/TmbT+FfVDAvp3F9PD9mtPijFemmk01ttM2Jpl1aZbWsxmxpkUp
         Mx5Vwg3i3qqdHDJDyU7+E6oGjelUG1WSJnhXJ182BgwkkXvwyMiao13zuaNfxunB5muS
         /u9NVg/oLrx1ZS76o/KBv1vJRvyPKempoQUcr5WJDPRr1KP+kBpLxzLYjXMl0rWE+Tj9
         Cpa/PPWWRFahjquAAD6IMC/TzN2VA7SigPIx1vHxoFrC2SeVjt60fM2uGQLBMLIhOgIE
         Cgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934866; x=1687526866;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh1ozdqkuyL297IQzekf/SyF/gGadVxOjJloMKiRBTY=;
        b=fAuwppZTZF60GerwKmOwIHWjmqEF8P3mD15HE+5GewfCyGXATjRrhU3cMGbAmp1+gy
         1wiFPoy8+8DIxmy+H8md7ciyMUpP1Y6dywa8qrFNcQrqPGib0jL2EBxa7XD5kD9SuoNr
         2ZFs3eE+4Ytvz+v8E8eLMTFmqlO9qayYDs4wx+YezZFk8nYDN70H4dzJ5ROLJGl96VXJ
         HXUkQhxmnaL/FgrLCX7H/v1tQD/zI3fKMEJ0cBZDSu+mRrB27Q0zNiNTCE62kjnSh6sm
         ociKxYJFv2DI1I+ave6Lfc/7N2UtsI8t/yie3SV78eYchor2InoSQBkRSxKTVo7F35hW
         SCsQ==
X-Gm-Message-State: AC+VfDxMF8QbxYVwUm0teRnSpHV1N6dXhOprrLOQRc5hwFTQ3QmDPLB8
	WLS1O+Xwwug69Bl4OoZ8IFU2P4tgoqYTkpHAu28kyQ==
X-Google-Smtp-Source: ACHHUZ6X6Dh4sKoRKxCl3xzh6fiXF3KUTri7gjRuPkZ4wcYFA4+7Jy6BucIjOnegjKF/wKGfW5nGWw==
X-Received: by 2002:a7b:ce15:0:b0:3f5:ffe2:91c0 with SMTP id m21-20020a7bce15000000b003f5ffe291c0mr9461240wmc.0.1684934865643;
        Wed, 24 May 2023 06:27:45 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id q16-20020adfdfd0000000b0030642f5da27sm14488065wrn.37.2023.05.24.06.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:27:45 -0700 (PDT)
Message-ID: <b1c8500d-15be-38b4-c4a6-ac5c725d97c8@tessares.net>
Date: Wed, 24 May 2023 15:27:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 0/5] update userspace pm mptcp_info fields
 part 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684915182.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1684915182.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/05/2023 10:02, Geliang Tang wrote:
> v15:
>  - drop "mptcp: export remove_anno_list_by_saddr"
>  - drop MPTCP_USER_PM_FLAG_RM_* flags
>  - drop mptcp_pm_alloc_anno_list in mptcp_nl_cmd_sf_create.

Thank you for the v15, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I suggest to apply this series today. Then I will look at my series
(selftests: mptcp: skip tests when features are not supported) and hope
to apply it soon. Then we can look at the part 2 of this series if
that's OK for you.

If you need a hand to rebase your series on top of mine, please tell me!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
