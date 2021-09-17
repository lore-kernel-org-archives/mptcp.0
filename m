Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4763FC3
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 16:48:12 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id b64so19433193qkg.0
        for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wR3Cge17MmW0C/wFwIkuwW0vhWinSIKQL4zslzCVJSM=;
        b=TOyudvBR6pecijFVuc93gHbV2tInqmXi3fFOhiyk9nAFHgfcdCUf6txaS6yXwW6HUV
         bjgGfwKhJJj1s6kfMqeskkE8bbGqmCmAbaxT36donNMXIeJK5+J/F1OWXCiGFW9TRGJf
         vNpNstshLKA/Yo+AnV1PHZH+gDLdnH9DSRLAjtbWf2WFXxG4dQyivSKCelFPBOxUM0OT
         JQuzgWRfA16AlA7sBF1DXoPPHW3NBVY7b4eKRSPyjGhe4SwkeVY6MuapeFCqsnKSRzAm
         FrUKGNTnk/ijKT3SJBDf9hvx3YKBeoIhxbq8DUrd/E0yMkjdI4HFGB+UR51qfBJwMVG5
         DR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wR3Cge17MmW0C/wFwIkuwW0vhWinSIKQL4zslzCVJSM=;
        b=orN1VQIlumc9CIm4wSG/nGxDdJmaGnWtMkgNRazI7K1g0DdkF67bQGH5RM4S+ngcXE
         8mWhWONY5vk9vURs3gbuNLcgKer1j29a+tt57y8H9gWywaXgstIqnxK2nLiYpXJx3ncD
         1YffurG3qrgKQn3+4caUdthwZAPAvwxnWtYiznzF1n/UuSU5pKxaLDE3B6gcRaaYIjq/
         Jkn7nc2CxW2SKN7FzM2zu26n4a6HuUzox7EGz+lwB+HXfb33hf+qBPejLtDLAZMvjJc4
         I1IkM8VQ/e/UPh0yW7EOzbMpdX2XJsxWgVpJVAwdkwPB+oO/vAWx3XLGiwjQhXAYnXwB
         b+kw==
X-Gm-Message-State: AOAM530Fl9T2pBHRIGFkDt3dXcfR1glnmL3biycuymC1Gl5IrCVb6NkU
	mDbiNY1PIiZ2qAHd4CZMPLgke1kpnYtM457DsOBOYw==
X-Google-Smtp-Source: ABdhPJx/RMx7Jy1FxwshuCXU4vaskb7Aw4Mde0Qdeag3JDzQ+DzMXYmk4uDor8koAs0zFuRQ4d4o3QjbgAkCsNhpO2M=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr15755593yba.225.1631897288414;
 Fri, 17 Sep 2021 09:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1631888517.git.pabeni@redhat.com>
In-Reply-To: <cover.1631888517.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Sep 2021 09:47:57 -0700
Message-ID: <CANn89iLOL0er35k=G=BeDKtOcA6Rn3n3k+pgVQX8bVFdA1w_Dw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] net: remove sk skb caches
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 17, 2021 at 8:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Eric noted we would be better off reverting the sk
> skb caches.
>
> MPTCP relies on such a feature, so we need a
> little refactor of the MPTCP tx path before the mentioned
> revert.
>
> The first patch avoids that the next one will cause a name
> clash. The second exposes additional TCP helpers. The 3rd patch
> changes the MPTCP code to do locally the whole skb allocation
> and updating, so it does not rely anymore on core TCP helpers
> for that nor the sk skb cache.
>
> As a side effect, we can drop the tcp_build_frag helper.
>
> Finally, we can pull Eric's revert.
>
> Note that patch 3/5 will conflict with the pending -net fix
> for a recently reported syzkaller splat.
>

Thanks for working on this Paolo !
