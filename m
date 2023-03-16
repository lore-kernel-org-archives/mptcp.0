Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F986FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 18:26:15 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id cn21so11433731edb.0
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678991173;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=372potJ9PdTnp9rwj4CxH43EYdkR5mxHV9VigjPNtUU=;
        b=VJ7dUJnLtsi7Im6mZDu2LOqhjTUIbmH/NuW9tGRCDoluu/FXemzEVBqLFRRFjFTr3p
         zO65hypVQjb+qfDrmTGPWjn5qpmPDTazGCz/6p/yAxAJNzPXJVk1rVmqlewZNr/G2rf8
         tUEa2tED3DiZxx+jfnigZOrm13vSwAdiLqBlaOrEY4CAhVv3rzTUqwItENTPW7IQMdpC
         0MuxQGtTjBG1XxE1dnP+qa9ZV+rhFF56AAXIsaoMHd3JZGUsVC1q+nbR3tx4vBz5BJJI
         mBJGOsKddF6hkl/cU7BxLrvQBbYyV7hjvdQXYomARqYkDj42lVcc7AFpnEA+dMLOr6pE
         F2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991173;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=372potJ9PdTnp9rwj4CxH43EYdkR5mxHV9VigjPNtUU=;
        b=grh1yOk4s8NjX/Xds6SJxDgVd3o9NF11VKh3z1ItDfwUk5LErF7FoRdVlDMJLfvFcK
         +UvqkFYHt2hVzmyoMcPzR7xy6ffv+iiz9hylQX+Lqbk7ZIqVTRE7QLDJi8NHfYvOKorV
         cy3rm3777aaEs9DZ67JbmvIO/NXCmrFvYCy0GuhOXY8nAINHgzS+O7ydDRI0KPk24Dgh
         DIsphDPi119tqP9x2hfuo3xsQ2JJ7q2KJ0GEaxm2a6ToD+6Sl/sBjcvIdH+85OUwDnz4
         dMu5sD5dsBSJmF2KH9mUwxJrCo58rwIvDAdf3E4tPYGveWa53SxNmkuhMeSS0i9C/UY+
         b+7w==
X-Gm-Message-State: AO0yUKVXvU80uMfVZJJU2WDURLYK0A3yK40m1yzJMnZKfccNW67a3hdR
	ROG2tU/RIVzsWKHdiJLyMoWa/sX+WnolkLqcTgAd3Ltj
X-Google-Smtp-Source: AK7set8w4pJhvebihQm10q0yGe1elnCDzuPWF3O9ZRaOmD+K32GBdCu6axE8pKJ692XznoY/RBgpTw==
X-Received: by 2002:aa7:dd55:0:b0:4fe:9643:4c77 with SMTP id o21-20020aa7dd55000000b004fe96434c77mr508933edw.31.1678991173452;
        Thu, 16 Mar 2023 11:26:13 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm100166edi.36.2023.03.16.11.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:26:13 -0700 (PDT)
Message-ID: <d217309c-a5d6-39ee-0839-7e5ad629058b@tessares.net>
Date: Thu, 16 Mar 2023 19:26:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v5 4/7] mptcp: increase userspace pm
 add_addr_signaled
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <498e1cd7f935d4c0867fa61170895539606989cf.1678778977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <498e1cd7f935d4c0867fa61170895539606989cf.1678778977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/03/2023 08:31, Geliang Tang wrote:
> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> address is announced by userspace PM.

I guess this can be seen as a bug fix: we forgot to increment the
counter for the userspace PM, no?

If yes, we should probably send that to net with a Fixes tag. Maybe:

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
