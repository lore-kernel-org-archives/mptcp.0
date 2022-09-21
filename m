Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFA2F56
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:52:45 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id jm5so4564373plb.13
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nwgeFPsWbwJWQW2TMazkdA8PGABV3b1mLW9foyfZWTM=;
        b=UimtHnPwVeIA0DeOltmesBwTJ04v6WyBg4FKJgSYl4XvLI2ws6HvisGRp+kWj0r3bp
         YsMNSU+EigL95SdxnTiLRleAXSvTTT9aJlXyc4Ij0D48wkBuiuwrRiuPTvxPI9dSQZsu
         QqSsjxlMC1gqgtOly2UdTvavNBEaxcknesu+JNnuqTU9vxFenRO5peMEkNvbzE2LRlxB
         gAjIVgXlRFO1sL0gDS0Am+iWmEqfwGMRb1Egzm6bRsBAxr0hCLHyYAw+QFu4I64GaACi
         ExcD+PhT8cQAngY36ANiVOQO1czL0aH+FCeuh7fbkNM8i9Oo4Tk9sLvjEtxDpNWD3b74
         A/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nwgeFPsWbwJWQW2TMazkdA8PGABV3b1mLW9foyfZWTM=;
        b=6AfLXmxsbGEvn12DL/3VzjHttsKMofQLYSCvBUaNb/Fw7PAXU2nIBecXFFdWRT0aVP
         rl0e7rfbFq1DOpqIpAv9aNwJC6SamApClD1pnkUis5hztJt6T1cjTbd5fh9OOtwhIMDd
         YSDkqMFF6562qy7vo9ekSLbMj9NX22RBHxyyBJxXxCXjkHwuYcS+k7bokqPGyW3mW1tr
         1jF3hUipotrvJOjXCmo5b8qRRUoqt+QwbOxi8auEh1seh7r9z+Tpp7w88oibufgB3cnw
         3soMgM025MvUY2rNmRTViZ5MZGwehUhyVXlVHkRXnYF1i2HYgFJUrmcJ1Sf8xY36Ha0S
         ZVtg==
X-Gm-Message-State: ACrzQf3NXXRw/I6FnIhTOcTZqSwzXHFtBXczUAePpCpJpX4R22nnE1Gr
	cmZ5fKBJZJiVqZEfggJwWZB+G8mAb3nKIYwAMXQ=
X-Google-Smtp-Source: AMsMyM4/RiocWANMoHC6yn9LOW5F0ARwFb6NYuq7Svtvus9cIugyZPnH20QlR1LVSxXZgQ6qaA7yXupKIBOy25qxvms=
X-Received: by 2002:a17:90b:2504:b0:203:5b24:e84b with SMTP id
 ns4-20020a17090b250400b002035b24e84bmr9104472pjb.188.1663764765539; Wed, 21
 Sep 2022 05:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220921120442.320727-1-imagedong@tencent.com>
 <20220921120442.320727-3-imagedong@tencent.com> <1f5efd69-3507-1086-1499-c2014c75c673@tessares.net>
In-Reply-To: <1f5efd69-3507-1086-1499-c2014c75c673@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Sep 2022 20:52:34 +0800
Message-ID: <CADxym3YtVoNRJKiJxfmcD2yZ5zepj_1nSwO4BEnG5soiZVQUiw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: add statistics for mptcp socket
 in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 8:42 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong,
>
> On 21/09/2022 14:04, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> > Therefore, we can get the count of used mptcp socket from
> > /proc/net/protocols:
>
> (...)
>
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index c0b5b4628f65..675de024de10 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -116,6 +116,7 @@
> >  #define MPTCP_WORK_EOF               3
> >  #define MPTCP_FALLBACK_DONE  4
> >  #define MPTCP_WORK_CLOSE_SUBFLOW 5
> > +#define MPTCP_DESTROIED              6
>
> I'm only reacting here about the name (I didn't check the rest in
> details) but do you mind using MPTCP_DESTROYED with a Y instead of I please
> When it is written using capital letters, it is better to avoid such
> typos :)
>

Oops, it's my mistake!

Thanks!
Menglong Dong

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
