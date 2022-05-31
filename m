Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9219210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:12:17 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso1968982pjf.5
        for <mptcp@lists.linux.dev>; Tue, 31 May 2022 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1iKsUEgudfcQ7l0rUYmR4q404rHZqhlzJ7bUdyTzSI=;
        b=mKG/x46XLIBmFVfiDapNKsHGy7xUYxKJgygRq/iO6bSb6jOzWfiPjUvNUfLC42bHvv
         RAAjG55iFWc1n/YrlsTPzwj1SAALZvGugnu/acYq6BY5MnmhN9M/ToEqNl20Ju/t4dx+
         i5Q3iK0URo9HpwsoeaSZO4N7AaJy6PEJl0CukFRdMKKaAiHzSe+NIzygZ5aioLp+ZKtY
         u0O4N7ntBL6FT/o19jglliGviWD1+I3R/LseH6x7UCXbiiSAE4/Y71CBubM4jA20BUQN
         oqyOYEp3gXUDvopXMB8t8/7aLRL62dr5wKlieajGHfN9Uw5TOClLbwAnPT0P/2BP1SN8
         N2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1iKsUEgudfcQ7l0rUYmR4q404rHZqhlzJ7bUdyTzSI=;
        b=XZf6hAXiybhD0ZylovA8WwHqrg8EwH9E9crZqOf+APFOTuilxbSSEaPWRtKfdsLGsk
         8aIB1Hq14AbkXMSjtHiJCCHtS/1adox2IbhpLVVa+H3nWmkBblSPGqX+KoLjjoQSpcQO
         V89Ygkzsj//I+Cah3V9pfJDfSELUOj/aSWryrpx77oyt7/MVykw6qEPTckMwqUHAKsco
         k8WeP8i1Wy3L9OwXDCmA8YaSQQtXQrwA+Hap6CuOFGi5bE8lyRj3PWBigAyW4b1JpIse
         j2nuvjdlr/xB2aMb1RfetXPlYCxo2w1cr2v5SnCZ8qdSvuKxyUu0MhUvpuXKQDr/3Nbh
         ot/A==
X-Gm-Message-State: AOAM532RAfkHp9/tQD2HIp1qV5Zeo0uep+HKqaVq8jD3NgpqmFYEsn3A
	eUGOQ79p6eyGBdbGwci0Nhgvww8pCi7/AGg5yjw=
X-Google-Smtp-Source: ABdhPJxTEtv1xMRGlpaLRsduQeftYWePoY9FQ5iqlAos2T0VlWtCDenG5oy6xiRDu244YP+TQQIH7UQTeEnGPfGR2kc=
X-Received: by 2002:a17:902:8203:b0:15f:4423:6e9c with SMTP id
 x3-20020a170902820300b0015f44236e9cmr60724878pln.25.1653988337112; Tue, 31
 May 2022 02:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d0566f954ee527d31c37f118602e0c4b7d9f1654.1653790818.git.geliang.tang@suse.com>
 <0059e366a67740ebff64ed024fa1bf4f743a7d28.camel@redhat.com>
In-Reply-To: <0059e366a67740ebff64ed024fa1bf4f743a7d28.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 31 May 2022 17:12:24 +0800
Message-ID: <CA+WQbwvWfVVPBgCB8i-2-2NqiUFF1zEbHLsz=1WxPkCZm4kGhg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] mptcp: move is_scheduled into mptcp_subflow_context
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

> Hello,
>
> On Sun, 2022-05-29 at 10:21 +0800, Geliang Tang wrote:
> > This patch should be squashed into "BPF packet scheduler" v3.
> >
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>
> It looks like this patch should be squashed into several existing ones.
> perhaps is simpler if you provied a git tree to pull the new revision
> for this series ???

Thanks Paolo, I merged it in v4, and here's my git tree with full patches:
https://github.com/geliangtang/mptcp_net-next.

-Geliang

>
> Thanks!
>
> Paolo
>
>
