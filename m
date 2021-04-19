Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5C2F84
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 07:40:29 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id m20so5751057uah.0
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 00:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VIr1L+x0KMjslWLfGf5hIF0vYoVyKryX0VbeLPhjXY=;
        b=TdrfvkAbmxzdWeZvPf1eCW3ZFxFH48n2kJNr9nicuBujKkRn8iFFj6Swa9SypVGRZs
         32ZBqIfAkAwv9tg4MN33p/38v/rUCOWEZ4axHEkhILiqDUYzcONh2VJnwrgUBGXBdWa8
         2G32gmIrGhCKrN4sig+5+f23Tw5IjfRYSc/g+B7wg5ZA93a69Rp9/x6d+Pi+vFS7gDez
         Wpzgry0YXhw236UylNT5UOpB5hJgJmohOwklRAy6plLnM2lEFc0Rfsu1hQYt0c+ruRnJ
         JbeLKwoGGU6Pksij/kihIt4XIYwlLlxvz4o8pibb6ogyXX9Lw8Qr2nk/tt5PSBelaLRc
         3MGA==
X-Gm-Message-State: AOAM530OiP+EJtBaCIBbgpvxujEtVfTfq1KR/OaqTd5LxXAOgI2vvSI4
	Y/4WAkD9nJ6FPdx5UYdXu7nUpkmr18lwe1r/KdA=
X-Google-Smtp-Source: ABdhPJwwXmXRA54KsUIVTR+3h20psdWGNGLb0sv7M0Wa6xBFjtt5vw5IgsA9I8yZw3/8pDlvTRTO5cNvRqQf/YEF4l8=
X-Received: by 2002:a9f:3852:: with SMTP id q18mr5818471uad.58.1618818028444;
 Mon, 19 Apr 2021 00:40:28 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1618388989.git.npache@redhat.com> <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
 <e26fbcc8-ba3e-573a-523d-9c5d5f84bc46@tessares.net> <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
 <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net> <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
In-Reply-To: <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Apr 2021 09:40:17 +0200
Message-ID: <CAMuHMdWfYHjNOmPSEbPOJeqniQoCG=8PD8KA8xDWXo3WggdQ_w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
To: David Gow <davidgow@google.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, Nico Pache <npache@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brendan Higgins <brendanhiggins@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Sat, Apr 17, 2021 at 6:24 AM David Gow <davidgow@google.com> wrote:
> > Like patch 1/6, I can apply it in MPTCP tree and send it later to
> > net-next with other patches.
> > Except if you guys prefer to apply it in KUnit tree and send it to
> > linux-next?
>
> Given 1/6 is going to net-next, it makes sense to send this out that
> way too, then, IMHO.
> The only slight concern I have is that the m68k test config patch in
> the series will get split from the others, but that should resolve
> itself when they pick up the last patch.

I can apply the m68k test config patch when all other parts have
entered mainline.  Note that I would have made the same changes
myself anyway, on -rc1 defconfig refresh.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
