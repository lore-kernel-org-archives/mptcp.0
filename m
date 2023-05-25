Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D818C11
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:02:43 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30a4ebbda56so2272045f8f.1
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685030562; x=1687622562;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JzndVWtb2GCJramljWrk6QTRYrhSzex1MV6j051m10=;
        b=fWNmE1l1P9iSTkYbakQ523yGtSL17HoihEpvDouNcYjKZKgnPDBsJTUjjgimOc5tm8
         XysUrasBnO4VvcLRQTKYMOeNqL7tDatt82HW8RtMTM0wmtIkMFbaeeLCTl1mOUslpR9e
         nDeE+ym7pvX1XNFaZgOCkfksgzF7eFD2Fd2bxlswGJxPjSgFavjuRVPik7BOVZioBoSh
         bFH2/woiUT/CCJofoVGpYtun2X2bUfVRZJLfZyGKwPlHa7yhDPYOccXZtSjHSPVv5XOi
         vxvVQpf9wpOHPrEqvM4tgtEft86+yYD7s4VWq2fQsOAIWo/S5wGpr7H9VTEG+HlZLPsE
         sXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030562; x=1687622562;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JzndVWtb2GCJramljWrk6QTRYrhSzex1MV6j051m10=;
        b=B4SC2Kxh0qwInpJNnim0yjldTt8VobEwQDyB8LiK/E2eQfx8GcNsmyLDoyGOVP6mAa
         whqSR0Uj7QRFNaiRyVubSeMf/xhmEJ5IfXYQ7vzhUbU9wdrCxDrXkODCEk5UZvA5j6Aa
         t/GieO639VOq5R5KAg6V01Gzsu6a2TKi520adEUQU5KyNg9pXR7V5+0/qbbJaKgs0Pvl
         pJts0ChkzB3pSmj3a6SWt1FAfT4WZzd6BT9Ekf9drg7leI4RFO5OJ4VPAGSsXay9OUc7
         hp8gc3eEQpPfm2XOI3VZjtEGTqJ/SUPKe/jqYAAxwisF3tclWTbm6VpBGQbbMYIC3SRL
         Q+Xw==
X-Gm-Message-State: AC+VfDxSLNYFWITome10cMCvXzI4NcjL57WN1SlUZHCRyf8no30aV9Tg
	jsIPzi2X9PT4hrr+cy30DiAmEi2oJVJdNIy22vo=
X-Google-Smtp-Source: ACHHUZ6qnXVAzzeOoIMn4Tzrdu4/RtJSbp1vkqbZGDUn0r10YM52/tHcFgh0480aItxw81N5IkY7oA==
X-Received: by 2002:a05:6000:114c:b0:30a:bbff:de0b with SMTP id d12-20020a056000114c00b0030abbffde0bmr2145053wrx.43.1685030562083;
        Thu, 25 May 2023 09:02:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b00307bbbecd29sm2228827wru.62.2023.05.25.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:02:41 -0700 (PDT)
Message-ID: <8dc5e3ba-6e50-e36b-2c2a-fa67055d3603@tessares.net>
Date: Thu, 25 May 2023 18:02:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 4/4] mptcp: unify pm set_flags interfaces
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685001897.git.geliang.tang@suse.com>
 <05ba1107fa5edf988fa07856ba359d73bf51f54b.1685001897.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <05ba1107fa5edf988fa07856ba359d73bf51f54b.1685001897.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/05/2023 10:07, Geliang Tang wrote:
> This patch unifies the three PM set_flags() interfaces:
> 
> mptcp_pm_nl_set_flags() in mptcp/pm_netlink.c for the in-kernel PM and
> mptcp_userspace_pm_set_flags() in mptcp/pm_userspace.c for the
> userspace PM.
> 
> They'll be switched in the common PM infterface mptcp_pm_set_flags() in
> mptcp/pm.c.

(...)

> @@ -1916,34 +1948,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>  
>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;
> -	if (addr.addr.family == AF_UNSPEC) {
> -		lookup_by_id = 1;
> -		if (!addr.addr.id)
> -			return -EOPNOTSUPP;

If we move this, it means we could get a different error when the
userspace PM is used. But because AF_UNSPEC should not be used anyway
with the userspace PM, I guess that's fine. So all good, no need to change.

> -	}
> -
> -	if (token)
> -		return mptcp_userspace_pm_set_flags(net, token, &addr, &remote, bkup);

(...)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
