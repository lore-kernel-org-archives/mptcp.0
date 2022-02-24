Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BD7A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:57:30 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id w37so1934117pga.7
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LgHgjo+HGq6D7tsUmZvRs2OMZe2yhUodUud+crc+LO8=;
        b=TLU+KlkHteOb13YXo9mJ13jneapSrp/IATi/dZEcDMoukb2BrY3/vK76+Ew2U9cpRE
         Yue0Nu5w+ATAC8knuo2+TJSUC0w8kbmiU34+9AM/e+UzNOVngDnuxuY5v23EkG9QTzaG
         1mRXa8RI44bJ1avKBt5al+jzWgiXrpdzJ/WMm+UPr2oNcFjSZBttQYX+4IsGN+eHTVLl
         KXxVSgXbFsJwZ1x2O+0DX5beQOh4qVlpJfVeTpWFg85SVEcmmMUMai7VZi66NpVM1BKb
         455S4VUYGvVfQLnawzY9uTFeoSgATesTeLbcZcSuYReQ6OFTX3Z3/R/N3zGTobI0apTq
         Brag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LgHgjo+HGq6D7tsUmZvRs2OMZe2yhUodUud+crc+LO8=;
        b=n/wlcpBmCVjQWMDQRnhWIgS/K6gSGmn/hFKxGkI0MPj2VfcUJk0QoZ0pD2T/J8Vj80
         GTf7vNLJbyMWH7MN3QscXYqPRe0dAWEQCfalsK6YcgQsv5dX5FDAVnhElOohXqfPEeVx
         E3xDa/S0CRVO0TIi983mNlN1SGWq2C+vT55PWc1Y1PmmI5XTAykkKsNqICpXfcNPwFfh
         LOQHhhqp58K6xXpBINILrWvGOx/oC7peOwNt11mn5ZKbwtFmcu7RAoh5lmiR8b4zUGIN
         linFkIjporPFRifbQUMZ08iGi7yVjQ4s1YMJd4er++MTOj+YODAimyQDi4gV8LEzNmCP
         oz4Q==
X-Gm-Message-State: AOAM533kEYYpvLiGEkEE31jx7XHzKDqALctPfwof834i05MiNHFIqu4c
	oyE4odZ61Fp7Qqs0nRr1Vf7WwNV7OPvkrfMRkEu42bZN75MWZA==
X-Google-Smtp-Source: ABdhPJzmmmpm5pqQLkRk2VRiVBXWtVo6IkncakVdjejsQef12E8LajmxADWvqSggBodvQOTEg22AYKmg+pXWsO30y2Q=
X-Received: by 2002:a05:6a00:809:b0:4f1:14bb:40b1 with SMTP id
 m9-20020a056a00080900b004f114bb40b1mr3275547pfk.69.1645714649755; Thu, 24 Feb
 2022 06:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1645325178.git.geliang.tang@suse.com> <95c31835-f6e9-ff75-0f9b-2edb78d8e455@tessares.net>
 <20220223225611.GA9540@bogon> <dacfb400-0d9d-eb6a-25e2-0d952ba58bf9@tessares.net>
In-Reply-To: <dacfb400-0d9d-eb6a-25e2-0d952ba58bf9@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 24 Feb 2022 22:58:04 +0800
Message-ID: <CA+WQbwur+zr0WEH2DA8_wxJhiF=Z6HO6yHrPrR=6Op6bPd=t5g@mail.gmail.com>
Subject: Re: [PATCH RESEND mptcp-next v2 00/12] fclose and mp_fail testcases
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B 21:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 23/02/2022 23:56, Geliang Tang wrote:
> > Hi Matt,
> >
> > Thank you so much for applying all these patches. I have two extra
> > requests about the order of these patches here.
> >
> > 1. Move the commit "selftests: mptcp: adjust output alignment for more
> > tests" before "mptcp: add the mibs for MP_FASTCLOSE". Otherwise, it'll
> > break the output alignment. Since 'nr_blank' is defined in the former,
> > and used in the fastclose series.
>
> Good point. With TopGit, it is not as easy as moving commits with a 'git
> rebase -i', just easier to have something wrong when doing these
> manipulation. But that's not impossible and at the end, I'm used to.
>
> - bd41af654d7f: selftests: mptcp: adjust output alignment for more tests
> - Results: 4bbd9add0797..369cbca2200f =E2=86=92 empty: good!
>
> > 2. Move the commit "selftests: mptcp: add infinite map mibs check" befo=
re
> > "selftests: mptcp: add invert check in check_transfer". Since the forme=
r
> > is more related to the previous commit "mptcp: add mib for infinite map
> > sending" than the latter.
>
> - 259143ec3e7f: selftests: mptcp: add infinite map mibs check
> - Results: 369cbca2200f..287a6bb7ec08 =E2=86=92 empty: good!
>
> > No conflicts occurred. And the order of them all is like this:
>
> Same, no conflicts. Should be better now!

Great! Thanks.

>
> Builds and tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220224=
T133344
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-v=
alidation.yml?query=3Dbranch:export
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
