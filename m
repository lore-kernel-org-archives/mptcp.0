Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B537B
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 15:02:10 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id m30so29737090wrb.1
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=yBVVDeRPf9F8XV6vcFsRyKPY0mK9vNH9729v40fOL/U=;
        b=oOKk2vR6IDO3cPwVAuWPzoq+5qtqTfj/0TGXwNBTDZhdu4HJgVkhy2QRkf7Z/rj0Lh
         dVT1ylba3v8jUnCzRjcLxhtiCx4XTajbhuVIpN8j6nO6FtqHndU7MaVSYcuZ17zOXFd9
         xVRfEoT84BdgtXo8uMNNNrBsPdt0VjcmDLmz6kwcowxtCS87Di0Ok7ZLpoBfR6xMQLF4
         +oCLWVgeCzU8KeJwIOMvve4j3zHmMk92yFCopWpsXEJzo5BPYqkT5ZLrA4+CzIaSvdOx
         /0YgAUVReezsGHtI6APZLuiCz5wFtMTx4zKACXr0SxKKj9fgQgHL/EyiBlZU7Omcx3TW
         47/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yBVVDeRPf9F8XV6vcFsRyKPY0mK9vNH9729v40fOL/U=;
        b=eFoBxj3rQ32C8cPWFSDePVjZnEEs5+jfBkCB1mzV2R1ZEPg4vfg++n7PGQIGY8kEFG
         9jskNooXhJEP2Bgj19POQmhFnLx7EWRlKK3JqhVoU5htjSw0j4dw43PRPUdnOZKLb6bh
         M/jN5NI7RcFol1sIfV59y21ZFwPeB6GOMTxJXXM85A8eaPoIemYdgooR156o8qmgD5F+
         3qdfTRXZ1rLQrCrsxDcOZn0D9TjceMKmFshoTQsUZxWi0ZxlD4F/UZcp55HSnKOVRIT1
         DJyIqAFihMKJqkusRn3hy5e2vr/D6Lf8mjtVK8L+pGWmwEVvAHiNAtsHWnRP0TkthH84
         jXWA==
X-Gm-Message-State: AOAM532MoC2mbWfTdk7kB8zfUP8rCNC1/8h+rDQAW4PDpxmVKbmesOmR
	7e4gQaFVRKhkT6PsbBybC98ZUA==
X-Google-Smtp-Source: ABdhPJzdxs+xWIQofIRB2X8FwbfQ2be9Uw+f9FVV4DbFwHatW6FNF/lZSBMgasid4P2zHbSmAO88HQ==
X-Received: by 2002:a5d:64aa:0:b0:204:1c92:a9b5 with SMTP id m10-20020a5d64aa000000b002041c92a9b5mr32799wrp.380.1648652528500;
        Wed, 30 Mar 2022 08:02:08 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0038caf684679sm7124963wmq.0.2022.03.30.08.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 08:02:07 -0700 (PDT)
Message-ID: <3b7b3802-e9a1-a29c-32e8-d53c51678d1b@tessares.net>
Date: Wed, 30 Mar 2022 17:02:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v3 0/4] mptcp: inet diag listen dump support
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20220329113523.19793-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220329113523.19793-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 29/03/2022 13:35, Florian Westphal wrote:
> Changes in v3: fix intendation, fix uninitialised var (Mat)
> 	       extend mptcp diag tests
> 
> Changes in v2: drop patch 4 and prefer msk->first (Paolo Abeni)
> 
> Done in a not-very-elegant way:
> Iterate over tcp listen hash, then pick out the tcp sockets
> with mptcp-ctx structure attached, then take the conn->sk for dumping.
> 
> First patch is preparation/cleanup.
> Second patch gets rid of locking to avoid a lockdep splat.
> If the socket lock is really needed (I don't see where) I can workaround
> this by dropping locks temporarily when iterating the listen hash table,
> but its a bit more awkward.
> 
> Sample output:
> ss -Mil
> State        Recv-Q Send-Q Local Address:Port  Peer Address:Port
> LISTEN       0      20     127.0.0.1:12000     0.0.0.0:*
>          subflows_max:2

Thank you for these patches and reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 0432b1c61654: mptcp: diag: switch to context structure
- ba9e26b62530: mptcp: remove locking in mptcp_diag_fill_info
- b433728093dd: mptcp: listen diag dump support
- a9cc2c58bf79: selftests/mptcp: add diag listen tests
- Results: ccc95f7c14d9..3b82e3d7eed2 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220330T150002
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
