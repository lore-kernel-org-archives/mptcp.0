Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B56FCB
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 13:52:26 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id xd13so30397390ejb.4
        for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681739544; x=1684331544;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW3ir3pNcu8iEW4vVakiINroAgOWLO5lZBwSFsFBBSg=;
        b=tCpyfWj8p7g7HYO8gApzLbwFSDxTGdgZDXaf4M15IEOfv2qPF80LZ1vHVJHv5sYaau
         s9zoombn+Nz3n514TLbTJwZ1Z9NQF0LZBHrsDmU5x8BkFDPMI62Dt4UTCJgDQzSle1Nw
         RMsg3LOEycQnIu+iHkzrD75cDRefLlmJuJ2ijKSXNICQ+6bor1Kvco5LfjQIWsLC2cxp
         HkWHVyLTBY1V/869C0HXPh1leU28DJe/dLT7yzJJjx2C7dMwMXovP73c1QAdKFLpawLN
         pwbnUGH1igsxYeKMXyFuSp449E2cwMFnqMgJDpwxAjnD4jeYghBTpvoSvbV+wS9HcWyD
         OsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739544; x=1684331544;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lW3ir3pNcu8iEW4vVakiINroAgOWLO5lZBwSFsFBBSg=;
        b=SHD3E+AX2lzvdzD8rBqsjc34XOPaXqHguDPJ2iiagL3wrKRIx6s3JV+86XO2M9nIUx
         FgraY7CtByTwwQHuYXpmTUgp7KQjA60+bg3hXeL6AlIbwLd0kKCPSoow5cB9SwtoqV5l
         3dX0KJpp70HUX5eBz0q++updXcFKngFOAziNvUZjgmyKwy643emVk1MtPsYS7pmOLjEf
         9l52a5b+WwjD76yzb2B7lrSvdQPmL7hEpH+nKzorEg1cGVyNyFMb1CarX6HW7t2xiYgO
         UKQq3LYmWq6P+WlpZGjcLHotEK0dxQVR+rWEg4XwiV1WZ7UcvV9AdE89cMXakv1wx5ea
         Rd2g==
X-Gm-Message-State: AAQBX9fUuJhDRt8XyHGiOJIKq4YWTL0kNQ1kclAIqFl1OgSin2MMvhj1
	K8MrI4aqsyPRTp5SigRTGg60lXMZAlYAA2tG0OHoCw==
X-Google-Smtp-Source: AKy350aXLrO19IWe785LBmfAqMVlK39jmeq/U6olKd/GoscUDXVrr6Z8bOc+jjCoZF5rE60b5van+g==
X-Received: by 2002:a17:907:3c07:b0:92b:6b6d:2daf with SMTP id gh7-20020a1709073c0700b0092b6b6d2dafmr6276075ejc.77.1681739544610;
        Mon, 17 Apr 2023 06:52:24 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id v25-20020a170906381900b0094f3f222d34sm2729390ejc.56.2023.04.17.06.52.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:52:24 -0700 (PDT)
Message-ID: <6bbe26ed-9079-d826-4b07-276e4ade8c16@tessares.net>
Date: Mon, 17 Apr 2023 15:52:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: fix accept vs worker race"
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230417134134.1636540-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230417134134.1636540-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 17/04/2023 15:41, Matthieu Baerts wrote:
> Just move the declaration of __mptcp_unaccepted_force_close() lower to
> avoid conflicts when merging with the current net-next, see
> commit ddb1a072f858 ("mptcp: move first subflow allocation at mpc access
> time").
> 
> By doing that, I can send our two last patches queued for -net without
> creating conflicts.
> 
> At the end, __mptcp_unaccepted_force_close() is declared after
> mptcp_cancel_work() (but before __mptcp_close()).
> 
> I'm going to apply this patch and then sent the two fix to netdev. I
> hope that's OK!

Just did:

New patches for t/upstream:
- d8d5315ec77f: "squashed" in "mptcp: fix accept vs worker race"
- 680788b99efb: conflict in top-bases/t/DO-NOT-MERGE-git-markup-net-next
(fix the previous conflict resolution)
- Results: 9787cab4f315..9a0205674b16 (export-net)
- Results: 1fcf1c7d50dc..f43ad21ca737 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230417T134909
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230417T134909

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
