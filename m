Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDCA52
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 17:34:11 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so2908120f8f.1
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683135250; x=1685727250;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgOFzCAAhLMGWgOigE5QKRp3rpy5M3uydfFfUGAanE8=;
        b=qRQqKXvrMPKGAMHP2L+vkXWBgKjUbNao6qF7P/yQsueTRn4drkUYzGkEu00q9TmRjL
         iTk6QZFUxYIKf+29Zl8IOzsYYGSbES4vH/yaL/IDBqa1b5QkerIr6ACEmU1WpeRApy1f
         BK/oR+pBrN1tHpeCrQ7sSxu//DgMy06vlMlfbU9Ac0Ej8uJMPEgo9LMfEmuUlo1Gkh8F
         Ih4PvprKRW5O3djNKTSJqCWo/fLEiwo0CpxCFRF+HlWg2l3SC90wQ/VZ3GKvDe/b2h2O
         fZ3KM7uquy99wZznEhFW965XcwhP4CRKqW4PnXfrno2G7NGI9F8kc+PxpBEN66KqrbGB
         1XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135250; x=1685727250;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgOFzCAAhLMGWgOigE5QKRp3rpy5M3uydfFfUGAanE8=;
        b=TPzt2ZWEpJ0GLzFHuLpWeow9W1BteVDHZE5OM1Pse/bCP0VGpWLU1VwqaQAMApUGMi
         Wg7HFbQ2GxpRZ1ppQTnTroDudgWHAJfMq2zTW2j9O12u0BYM/PuGwhYRtgGJLYCNWZC5
         mse/GVAwHQS7ubvDDd+kZ019e1fJ3wVqsPS4e8EinhD+X5kix5+Lcu1JU10j6CvlQXDW
         n6ci7vSHE9nmUb2UA0VDZeXUcJeK3AWHCh7XeP7uA+nO3XAmMEfDg80kcEa7kfB3ZvQ7
         EU1Pu947uhYpHds5ZETXsYk9ithAJPhpZbHowie7FdGljWkt/eX9fbG/V58uGc95xy7s
         ZZbw==
X-Gm-Message-State: AC+VfDws4Jp9n9FG3Na0xMWgDO/mj4Ra3hW4nPdkj2K01ibfv/jVuq4f
	ggDpHMjrZeXTC39GYYDA9/J72Dp3E9DuKj2EhSw=
X-Google-Smtp-Source: ACHHUZ5bKa+RxBP8ZYOobm5u5DNB3FIfCyoxlJI+u+Y1EfOeJrjVz04BXlwYaK85V6/wEPMMLCj4xQ==
X-Received: by 2002:adf:e943:0:b0:306:4550:f651 with SMTP id m3-20020adfe943000000b003064550f651mr717605wrn.4.1683135250146;
        Wed, 03 May 2023 10:34:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d60c9000000b002fbdb797483sm34098427wrt.49.2023.05.03.10.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 10:34:09 -0700 (PDT)
Message-ID: <1d54989a-490d-c047-9a87-a11c0a66f81a@tessares.net>
Date: Wed, 3 May 2023 19:34:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v10 5/6] mptcp: add addr into pm anno_list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682499136.git.geliang.tang@suse.com>
 <247abcd097c77e86b606dca38179693f8c00d559.1682499136.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <247abcd097c77e86b606dca38179693f8c00d559.1682499136.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/04/2023 10:56, Geliang Tang wrote:
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.
> 
> By doing this, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.

Out of curiosity, why not moving patch 4/6 before 3/6 and squash 3/6 and
this one (5/6) together?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
