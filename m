Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8E2115
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:57:29 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id gc14so1147552ejc.5
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681484248; x=1684076248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DM2mW2Rbzq80i13ESUhdjRuNie03MRT+cBj0ZCjad9Q=;
        b=O1urDIL0iVK8fIqb6jvRx//AnvMSlvAViqigw8GkIFRQwMcEzKFOmoRQ3ds/rp0tPQ
         t4BOdSyq1LGN70nqTn9T9piWqIBpvdoF/OCBhokMB7nudO/ZkyJQhV56FKGGn/OVvM60
         XtQgISR7pYEAjBh/GD9vy5vUjHOtGZwmxvVp2yfyoFZDoaTFHVMAfRepSpoSPpdjOyT+
         xVTBXPAxTZsDg1oMfLwruQs6X50IjE+v5ivPxZ2kJ/Wuqu3JR2+KuLrxbdB3WpP61gWY
         zMAnjrFpnTXYEtzPg+udbe+yMY/Z3gOmtg3gdpeNE2ua/t6fluoBV2tdJ5+CGc2xEFiU
         pvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681484248; x=1684076248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DM2mW2Rbzq80i13ESUhdjRuNie03MRT+cBj0ZCjad9Q=;
        b=Ay1+5JNOC8U/Z5ww1H+Z1cGNa/CGfSViMB3xt9WXzV4xt1G+PmVQX+qXJCl7c0l9sq
         IKB0J7PtvrgiGpDo7ie9vXX9xAnKKms3G+AC6y2Jh8k9EiPTEK6/Nl5FivnUhTnQRAce
         PeiSuOpqOiFZiE4oCnw3CAZSTwNLdVSWyNWsmJLEqq6z+9kbiAKlYNkZNalsohdqIBuE
         mBBGBT0A73BmhdYJT1uYG6vPZKXEF7qeZOWjWvqXrQqNwdQc/iVMARmrk28NEGMtM75H
         nP4kbQmBzY/cL6DhT/l/Yd9tF/KEnYFsvVQzh9S5RqWVao6ws61CLVtljxH+PYZw6mCk
         oz3g==
X-Gm-Message-State: AAQBX9ej25ANRoJw+nCJtorob31mjANBta/jIUl2NR/dndWMsddzf/CU
	l3f2fpwKnK2VJOvSZESUv2xv2xkimSQ=
X-Google-Smtp-Source: AKy350bHkOFUpBb3YsaKjCJ11CfDiHR+Lq4nnsJ+NGuM2lOCiYs75yLUnU3A5RILbGNYokF5dMCcIw==
X-Received: by 2002:a17:907:25c9:b0:94e:ef09:544c with SMTP id ae9-20020a17090725c900b0094eef09544cmr1860484ejc.10.1681484247950;
        Fri, 14 Apr 2023 07:57:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::26ef? ([2620:10d:c092:600::2:b2ce])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0094a83007249sm2602686ejb.16.2023.04.14.07.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:57:27 -0700 (PDT)
Message-ID: <e152d8f0-6bf9-f658-f484-f7a18055a664@gmail.com>
Date: Fri, 14 Apr 2023 15:56:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC] io_uring: Pass whole sqe to commands
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, axboe@kernel.dk, davem@davemloft.net,
 dccp@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
 io-uring@vger.kernel.org, kuba@kernel.org, leit@fb.com,
 linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com
References: <20230406144330.1932798-1-leitao@debian.org>
 <20230406165705.3161734-1-leitao@debian.org>
 <ZDdvcSKLa6ZEAhRW@ovpn-8-18.pek2.redhat.com> <ZDgyPL6UrX/MaBR4@gmail.com>
 <ZDi2pP4jgHwCvJRm@ovpn-8-21.pek2.redhat.com>
 <44420e92-f629-f56e-f930-475be6f6a83a@gmail.com>
 <ZDlcXd4K+a2iGbnv@ovpn-8-21.pek2.redhat.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZDlcXd4K+a2iGbnv@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/23 14:59, Ming Lei wrote:
[...]
>>> Will this kind of inconsistency cause trouble for driver? Cause READ
>>> TWICE becomes possible with this patch.
>>
>> Right it might happen, and I was keeping that in mind, but it's not
>> specific to this patch. It won't reload core io_uring bits, and all
> 
> It depends if driver reloads core bits or not, anyway the patch exports
> all fields and opens the window.

If a driver tries to reload core bits and even worse modify io_uring
request without proper helpers, it should be rooted out and thrown
into a bin. In any case cmds are expected to exercise cautiousness
while working with SQEs as they may change. I'd even argue that
hiding it as void *cmd makes it much less obvious.

>> fields cmds use already have this problem.
> 
> driver is supposed to load cmds field just once too, right?

Ideally they shouldn't, but it's fine to reload as long as
the cmd can handle it. And it should always be READ_ONCE()
and so.

>> Unless there is a better option, the direction we'll be moving in is
>> adding a preparation step that should read and stash parts of SQE
>> it cares about, which should also make full SQE copy not
>> needed / optional.
> 
> Sounds good.

-- 
Pavel Begunkov
