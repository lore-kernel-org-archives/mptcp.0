Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24641C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:29 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so1593471f8f.3
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681832008; x=1684424008;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOunNPbWT6zy0kWehpvQ4FPGC57HJPNURt1hGDvkETA=;
        b=tKgYoYUHmSwCqbBiJGxF5oj5WxwiIBVm+tg61SXuMZNjRbJUyH1ahuVPALb+a6aiPK
         iHi/X012fRWOEaCbWZEXXw9y4Cls8aLmSDkEuZWTGt0HMFmpRvBoIuiJ+r3ashvlBcp6
         9kj+2jfZWUkwiGIOqS9Ils4lJj0l1Pzagho76W9c6k/HpgBZAr4E4nKj2T0+cuhfuE5c
         LxWEQDopMwZp9n2tXDHUlJYvUTyhxREkk2xJZ1h6kuB+MvClX0t7MdfWEQRTQdy1uJ9V
         llvPn08DK683nd2BXnRPg3y6cBzWzaNM1fsOppkOh8fIlU9ECZL8FP0l9FVRen2GrmB2
         642w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832008; x=1684424008;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOunNPbWT6zy0kWehpvQ4FPGC57HJPNURt1hGDvkETA=;
        b=fKUwOsmrfjJVOiDHJeR1r2iX0q9Ii5cKz+Tr6YwX2F6Cs6gJUMyn4YTqSVbe+z9MAQ
         n6FoeZhZ89Qjbsw0+S1n1ZzKcuQJ5Z3/zGmnCOr10wcpwA74NOwNhfda17vPKI0jHm7h
         EnjvoR655hzBmOAy/tboDYaaWq4MnKNHPr8asgkBF6wm6MFOBvdxpFFIOprPNW/2GNLS
         6X0AE14JK5Mu/7vp/v1V5YAIscFYGDr1J+a7bXTTEKraDosYZ87hEds5KRlugePMJrkI
         TlfPbuf0sWJ81H0HJa+JsyFhEMzldPOe/UinC6X4hZPOxr60Iu2SNEbDwzQs07MQmuLh
         Qo2g==
X-Gm-Message-State: AAQBX9ccXzqC31OYTcLDcdzwEFMgZCd/262+mKQh6YnDzALmkEzrQ1xw
	qgGizoVlDD5lUS30vRGq7VRoYA==
X-Google-Smtp-Source: AKy350ZOdHFtSnTPtcoiBll+fdmLMYKUkySuJRFW03tZLY+YDRvHb44tMwf5T931Aijqz9HsTYKVCA==
X-Received: by 2002:adf:f9cd:0:b0:2f8:f144:a22c with SMTP id w13-20020adff9cd000000b002f8f144a22cmr2104553wrr.62.1681832007804;
        Tue, 18 Apr 2023 08:33:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003f172ec4022sm7300451wmj.18.2023.04.18.08.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:27 -0700 (PDT)
Message-ID: <bba9a21d-6d7d-ee27-301d-378f1091f186@tessares.net>
Date: Tue, 18 Apr 2023 17:33:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 3/7] mptcp: don't clear userspace pm addr id
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <63539b68194e4eb842fa5d784ed5803b0bf69f32.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <63539b68194e4eb842fa5d784ed5803b0bf69f32.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/04/2023 11:11, Geliang Tang wrote:
> Don't clear the addr id in mptcp_userspace_pm_get_local_id(), clear it
> in mptcp_pm_nl_get_local_id() instead.

Even if it makes sense to do it like that, I guess you are preventing an
issue when using mptcp_userspace_pm_get_local_id() in the next patch. Do
you mind to also add a clear reason in the commit message here as well
please?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
