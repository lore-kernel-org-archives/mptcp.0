Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5056219EF
	for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 20:40:31 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-319694906a4so86179f8f.2
        for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691786429; x=1692391229;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+hGnuZF195K0Kft5kotGH1yZ217MFuNsCzUQMBoQ90=;
        b=TsNyAnE+lD+FowfM+4CfyTrlanzRgUFTXp11fTQcevkZbpZf2gS6qQwBboHWzIO4EX
         UFUKKXMOPjcClGAFC/6S20U88hXqtgkcSjSVVKZQ0cy+05Y0HY/j3Hv0QUlcdfXUBfTG
         rDt4g1Re/nQwtwxoanyGDqChWrUwQ1qxosA2D79h9SNmIDHsRB9BUGwCLVCbXkE4gCsm
         /hmBJvZMsF1WeoaArZf4wjeRlowY/y3BLNP4eAmXuz+cjZlKaUwqdsrhN75O8zG+n1M5
         t32YpkOAN5zsnxc1O7kOJD1M00Xrrg+pPlyE2UC3HymG6/ydsSbgkTgcL5cgZR3AErsf
         sD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691786429; x=1692391229;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+hGnuZF195K0Kft5kotGH1yZ217MFuNsCzUQMBoQ90=;
        b=FcXQmYwmjBWnNfvRMfIUR9UFw2G6fLSMVIzq1vnJECeksfaJJDN6FMci6RG3itRStE
         x5TcICrfLP2UJJRfcfKjynJx+yt3AVUUSlv0kzEZxdafD6ebQ832rJmuXVs1XZhO+AyB
         aVnOzgjy7nTgudmgD87WXv+4lm5VCozmice0bcnqojQO3VZVD6hshWspE8fA2QZr4OXV
         hBlMvUJaFK1iTtPEYkdgKysNC/F2crjvBRiZqQSxbCFOXW0czoXTp+6hI+rKH9iii8+K
         a6VrpwYVDMkrRd8n4XelcC60FfMzlVawCtxto07CDkBUo/qD6B+k+47G8lkY9XWCWPnR
         UwGg==
X-Gm-Message-State: AOJu0YzXN2TjPWjwwRgJqBh1fO0a2Nixp+rGsITMjD6E7G4yZ6rVXbOL
	gOdtkpQrxL8En8sKfjz33nun7YALoPpoWp7ZK1s83w==
X-Google-Smtp-Source: AGHT+IGIRgT7GVUDfdS0z7YtxWaFKAJoKowj0Ezw3996vUcJDyVttc7g6Pkt+MpMQ6JLeBZ9c53x5Q==
X-Received: by 2002:a5d:6b4f:0:b0:317:708e:1c29 with SMTP id x15-20020a5d6b4f000000b00317708e1c29mr2165328wrw.40.1691786429219;
        Fri, 11 Aug 2023 13:40:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d07c:50b8:518e:aa8e? ([2a02:578:8593:1200:d07c:50b8:518e:aa8e])
        by smtp.gmail.com with ESMTPSA id f17-20020adff451000000b00317efb41e44sm6468448wrp.18.2023.08.11.13.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 13:40:28 -0700 (PDT)
Message-ID: <b0e26fb1-bc4f-45a1-9aff-475003f04151@tessares.net>
Date: Fri, 11 Aug 2023 22:40:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Weekly meetings] MoM - 8th of August 2023
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <martineau@kernel.org>
References: <dd5ca99a-df4b-4253-ae45-367e881a5eb4@tessares.net>
Content-Language: en-GB
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <dd5ca99a-df4b-4253-ae45-367e881a5eb4@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 10/08/2023 18:21, Matthieu Baerts wrote:

(...)

>     - Features for other trees:
> 
>         - [d627333533b4] mptcp: refactor push_pending logic (Geliang Tang)
>         - [6c82fef59c01] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> (Geliang Tang)
>         - [e34214022d50] mptcp: add struct mptcp_sched_ops (Geliang Tang)
>         - [1a9a9a5e01f5] mptcp: add a new sysctl scheduler (Geliang Tang)
>         - [e7e924381b00] mptcp: add sched in mptcp_sock (Geliang Tang)
>         - [7ef0a0657704] mptcp: add scheduled in mptcp_subflow_context
> (Geliang Tang)
>         - [f03f04926ad1] mptcp: add sched_data helpers (Geliang Tang)
>         - [354bd4e094bb] mptcp: add scheduler wrappers (Geliang Tang)
>         - [44505f900b4e] mptcp: use get_send wrapper (Geliang Tang)
>         - [037427cc1f31] mptcp: use get_retrans wrapper (Geliang Tang)
>         - [1644cb7a1faf] mptcp: register default scheduler (Geliang Tang):
>             - move "mptcp: add sched_data helpers" lower → TODO

Just did:

New patches for t/upstream:
- ec996909f801: Revert: "mptcp: add sched_data helpers"
- 7d1f6c17ffd6: conflict in t/mptcp-add-scheduler-wrappers
- 0f0b53ff04b2: mptcp: add sched_data helpers 2:
  - I moved the new code at the end
- 94f491eb3eba: tg:msg: remove tmp suffix
- Results: 0c19f8d9b23d..2d42b08369ef (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230811T202752

>             - Mat will check if it is OK to send them
>             - Idea is to send them next week if possible


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
