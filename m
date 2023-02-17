Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C89446
	for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 17:58:49 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id ec30so7541540edb.2
        for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSAEzU30zymrv6GLCYjOeQIiR/J8MnKqeTW6uMiwAYo=;
        b=suJvUrS5oEcK2YxG0thJEDYeq73Oscf4UNQXUMXOGsusWxd3ZdKvsoWGEzpgewoPVo
         uGLRmyFFTbbEUrNSFyniF42K4q1Hz72YVwVvEv8dVuWKgDwKs9jDlWljiTVdgRLxeyB6
         ZjpNAFBC3KDrgOl0daqb8xr02f5RwA0DduL1cbW9VHyW0VHtT3aDvjkrJO9LEB/3OD+Q
         HFN3fB/0zSvHeCTcvtJj7eOiD/ipUAegvJdznDs7rNdWkvt9i2pcHC83/G7Bwi8oQalU
         dQ6hWsrGf1hzUWnYxqzxift1lBnjwHOu10HP8phZG23NJalrWBZsMz7zjx4T3hG4i5sN
         CQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSAEzU30zymrv6GLCYjOeQIiR/J8MnKqeTW6uMiwAYo=;
        b=d8ohGteCK7y7hr6KJGjXb/qHz1uXn2tgAjjaq8XrDWpMu1Xm+Xlu6AsfxdIRgDQLnf
         aGMLnTXdzZTw0Tbwez/ekFPrNgrHel1NE4UCuzVu91AKS4mdjNwcfZJvUcDrFuuWQuzR
         hdVtSIGCtxBsNPfcFrZ4UFtSzr9mi1qnyBQRTmFNxds5ZOrqRMWTQexoj3H0qBoS+4ex
         0j4fBgIN06rB3RggILmsoNsZQQ2iL3Nj/f1fXL5ompngMo0CAP+/MILRzBIs+jPlg0vk
         iuNRvMTyfXMgTJwg1OCUwsFm2XpPNdUV+PAaJSeV1l5+RBAk+TymLWePQNJMC4zOAd2J
         gEIg==
X-Gm-Message-State: AO0yUKWYVSyYWEkLeZctY2Sg2xqmpnONmS5/i3mGH2EED9miu2qudGtQ
	k9FkdtoKdUFNn7BU32I2NqK4hg==
X-Google-Smtp-Source: AK7set/mY9dWr09VnWkg3LgmmUBv/RvsE1uxUIq9KLfYY2O5rhDyvLo+nnUxNRRxtqEtgfxUjfDbIw==
X-Received: by 2002:a17:906:749:b0:8b0:fbd1:1a61 with SMTP id z9-20020a170906074900b008b0fbd11a61mr262493ejb.52.1676656728049;
        Fri, 17 Feb 2023 09:58:48 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c2b7:fcfc:1e01:3a74? ([2a02:578:8593:1200:c2b7:fcfc:1e01:3a74])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090694cc00b008b14bd356d9sm2406107ejy.37.2023.02.17.09.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:58:47 -0800 (PST)
Message-ID: <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
Date: Fri, 17 Feb 2023 18:58:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/02/2023 19:48, Paolo Abeni wrote:
> As reported by Christoph, the mptcp listener shutdown path is prone
> to an UaF issue.

Again, thank you for the two patches!

Now in our tree (fixes for -net) with my RvB tag.

I had a few conflicts when applying them on -net (and later when
propagating them to our tree, see below), I hope that's OK but don't
hesitate to double check if you have the opportunity :)

New patches for t/upstream-net and t/upstream:
- 4f70189ea062: mptcp: use the workqueue to destroy unaccepted sockets
- 477601b8695d: mptcp: fix UaF in listener shutdown
- Results: 2a5c259387e2..de8ae10003bd (export-net)

- 1c2f1e5c434b: conflict in t/mptcp-refactor-passive-socket-initialization
- 1fed9c65e6d5: conflict in t/mptcp-drop-legacy-code
- a5a7fffe5413: conflict in
t/mptcp-fastclose-msk-when-cleaning-unaccepted-sockets
- Results: c6f15583a946..2275e6265ebe (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230217T145032
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230217T145032

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
