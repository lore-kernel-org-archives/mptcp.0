Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4A3FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 15:29:51 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id e133so6003240ybh.0
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEydQnCiiB9iy6pnOk/cAGg/1/rtBHcq3DPIzAFNphY=;
        b=hSUaQDMK4O8Ut68DmSUoyerIq/HjsCLsDayNQWB1FJynMeNZXln0F3/aUTnbm8y39I
         rkLW3LfODYhP3/b7uR5g4aNi1am0qJJ1VSfnjaVnJqN2Z7AWTZCmE+WqVDqdwAx903hl
         Ed5BM1FRToqbl4PX3nY9E1zbR+/f/d5vrspqeSiHkFJFsSTBQPBLtblBZPTevVPdfOdU
         1etEgYH91SZv7rIC++eZ4aDUo3AprLZt+EStIhc37YenTf4Az7k9ji2PO9JwU5UhOpeg
         LlnVsEp7rlHJEzbFA8Q+uEBR1GW9ZS02cYBAhhkOrBT8I15H8lGRljTeyIMt6pwSm1EW
         3gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEydQnCiiB9iy6pnOk/cAGg/1/rtBHcq3DPIzAFNphY=;
        b=WW8wD2y/sEcJqYDffJ1Em0EZR/lSw6rNOuwf8rw0kVoS1TMS4VirWCFSHPLnTenbOi
         8bVfrIeudEXqDPYfWbRYwB2lvEv+1TVBn+6fAEkPnCzjl7FeN6bNuALAO4RFmocSDMn9
         5Tj/+viFB/WGywRBNsN+3heKOCaqiz8dHczysoTm6HwQnbXO8ne+gqbS3uTAP/ITFvBF
         UYSkVb/5ukIarBjCC5pSrdh1ULRH45hOOyXjM7M6VffXtsIXiLxfjU6o9FD0IkTmr+Zm
         9bpP8AM4fYZGFZaAoUA5+etznmmp0/i4ku/QnlXjC4znRIBV0CXAAOdAqbG50lLXFs4H
         rolA==
X-Gm-Message-State: AOAM531xDPMJgiNf44o7mV4tqlvQgb53KBlX1391UPebzdPyhsavAx63
	o9yHIsVSdiHrEceSCrr51+8TJT1u0Gx/KY3AxoBSDg==
X-Google-Smtp-Source: ABdhPJz5awbgOKC0zlUDSKhgM3uohHZwxW/JsQQkEsstbjQi6yQpMmzZsV8j+DIAJEvOUGFfzNlU80svca6oG4UqIsI=
X-Received: by 2002:a25:6994:: with SMTP id e142mr88133ybc.364.1630510190355;
 Wed, 01 Sep 2021 08:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
 <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
 <CANn89iJFeM=DgcQpDbaE38uhxTEL6REMWPnVFt7Am7Nuf4wpMw@mail.gmail.com>
 <CANn89iKbgtb84Lb4UOxUCb_WGrfB6ZoD=bVH2O06-Mm6FBmwpg@mail.gmail.com> <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
In-Reply-To: <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Sep 2021 08:29:39 -0700
Message-ID: <CANn89iKxeD0sMe-Qp5dnQ_vX28SGeyW3M857ww4chVsPE-50uw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>, netdev <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxarm@openeuler.org, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 1, 2021 at 8:25 AM Paolo Abeni <pabeni@redhat.com> wrote:
>

> You are way too fast, I was still replying to your previous email,
> asking if I could help :)

All I did was to resurrect this patch (rebase got no conflict) and send it :)

>
> I'll a look ASAP. Please, allow for some latency: I'm way slower!

Thanks Paolo !
