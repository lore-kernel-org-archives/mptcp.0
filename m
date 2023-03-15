Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA820EB
	for <mptcp@lists.linux.dev>; Wed, 15 Mar 2023 05:07:45 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso316565wmq.1
        for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678856863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1haGTUoBcYKQZ+kTaaY9CxbzZ+wK5/Rp6WnpjcPSCc=;
        b=ZibntZmG7bYm/tWxzM3wr6WPYWz9KHIR8Zh/cRrD0H7ti7FlJFN90A640I5qm+F4p3
         KcKNjMOMckYam5v+aDAPnrT/D91FWhJ0xnLlp2xFb29ZEgYL7+6BNmXuGMU+0ps0tgvz
         6iV5q3hh18GwRpqkoaVFot6z1aUvSLr8W4D+dEXYL/5A5e2NGl247oOF/DtcnQEZCOAt
         +dkwiqbaH7DLWzCx/ILR460EsjYkQslFOZOR4LPDmwZ4FUYnLga+bk028Wml4hYyeCu6
         vNAdtMAc8bYeZb98QfxfFIS/QOb8bZ7aGqoRCOflwPJxBwggChUunCYA9n7e6YuWZmAC
         YP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678856863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1haGTUoBcYKQZ+kTaaY9CxbzZ+wK5/Rp6WnpjcPSCc=;
        b=6Nr4wOQDSn1bUafio3hQAL9l04FWIodLOmmmcycvU1zfD39HfdNqcTUid/S8hSRci5
         o9+o+KlTmbZVHxjgRKl/XK/JykbtOOgxSuT+fYRjIIulcHcfbleT8voEUdAR9j9RG6XC
         6HqLh46akALtSCOjTTHQ0x+aZl+a5gx2wlN4UqsDaqRAXgFF6foBKVgaK4m4w18s2RUm
         gkPYI+bbcxAwiMBIVLigCXGUF+5oLCP5FjNaSpQh9tv/E3mZF6YS016aU2hOh7RztE3F
         CQDZXAHc4kD+5NTCZvVDQ8YNPcWUuAY7293xQgtE9Xzec+FlWnXLRC5b2w6MUz9fS/zR
         aSnQ==
X-Gm-Message-State: AO0yUKV5jANiqxv/sDOmHVidq1LPIAuMA+am4oxR8llYNgERQ6hCE/pT
	vKb7bgdd+7aY63a/hfHoHmRoxlaGAYcL4cvSCb8=
X-Google-Smtp-Source: AK7set/9LzR9THu3F350G1TOooLhvDri7RQ+01FjN5HHmKh043UYB6dHQu+k9rzWODH0PaJYeyRrHNPcsR67TFjLwZk=
X-Received: by 2002:a05:600c:3ba3:b0:3ed:3080:d016 with SMTP id
 n35-20020a05600c3ba300b003ed3080d016mr524201wms.7.1678856863477; Tue, 14 Mar
 2023 22:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
 <cd9e989c-8ad1-6f42-685d-378c9ce83892@tessares.net>
In-Reply-To: <cd9e989c-8ad1-6f42-685d-378c9ce83892@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 15 Mar 2023 13:09:09 +0800
Message-ID: <CA+WQbwv4gkAiD8rJRYW_+WUa=dMD97Thk9ABQE8qb7WFZsuaqg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: do not fill info not used by the PM in used
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

Sorry for the late reply. I think these limits are still useful for
userspace PM too, although we haven't used them yet. Since we also do
not allow userspace PM to use addresses without limits.

If you also think it's necessary to use these limits, let's add a
ticket for this on Github. And I'll look at it.

If so, I think this patch should be reverted except the var 'val'
should be dropped indeed. How about only dropping 'val' in this patch?
WDYT?

Thanks,
-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B43=E6=
=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 17:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Paolo,
>
> On 23/02/2023 12:20, Matthieu Baerts wrote:
> > Only the in-kernel PM uses the number of address and subflow limits
> > allowed per connection.
> >
> > It then makes more sense not to display such info when other PMs are
> > used not to confuse the userspace by showing limits not being used.
> >
> > While at it, we can get rid of the "val" variable and add indentations
> > instead.
> >
> > Fixes: 3fd4c2a2d672 ("mptcp: bypass in-kernel PM restrictions for non-k=
ernel PMs")
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> Thank you for the review (on IRC).
>
> Now in our tree (feat. for next) without the Fixes tag but with your ACK:
>
> New patches for t/upstream:
> - 5435c97679c1: mptcp: do not fill info not used by the PM in used
> - Results: 6ce53727880d..fc5dcb18c972 (export)
>
> Tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230309=
T093419
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
