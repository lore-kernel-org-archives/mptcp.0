Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5B2F23
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 04:12:54 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id y9so3905811pjf.1
        for <mptcp@lists.linux.dev>; Sun, 06 Feb 2022 20:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gv3QFX/3/rleXnqRKZrlroe9dICIgF6nDnbL97/G2Tc=;
        b=QnCYVX/IZGVJclgXxtNWt3XJj8LA89/c6/3zvofueZHIxm47wEJH64DKZ+9FcMuux0
         cwFkvqqXPOzxlI1mme3IibnLIsb4Ia9VAHPIBgD+tCKz7ZBVZKGZtc/lG5SJ6NnrZIFQ
         2ggI94a2BVPR4k4ug76xqP5ZFrWYKxApmGweMCoMShRA05zrtNybxBv/ku6qPSBAUTzs
         z/bUMVCSckPf9WgRJTht0CVWNZ/f0vu9QV7bVw6C3WOhrtFLKuA6qo/JCS/ivsm/rP74
         WqoUpKcoATZqqJPoIuPcMrA8Cp0loSSpNn+EkNglkGJzRIglB2AaD56od66F1MiLk77C
         H4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gv3QFX/3/rleXnqRKZrlroe9dICIgF6nDnbL97/G2Tc=;
        b=4dx4QY+UQsX+j3OPyTF3z2gGmfIyPHuFPgGw+7ta7TsPop9RY/D4GNSHuDKRQRvmsM
         h3SfGMZkLCCw8WbM2Lot1KtcT7DqJAlh+uq+n3xIRyEuzn9I15rnaXBIYgrpwR7tSGJJ
         sTGcg+EeXxyjMykIGdFb7L1k0Ea6LtLFpN9TDDPIDm60eLOEoGSktIsXRTE4M/nskiO8
         D6zOtuQrTPTU6Lco+f6f7qhTLtoF5dTEd5pi3GDXhGRjWXKAtZSyK6py76FeeqVEpg1e
         iaRE5EWSzQ0OVCUaHERryJpG+o3X0wKPthosMpLHiD7l0GimTA5jaBYLzk4fgOFD79fY
         it1A==
X-Gm-Message-State: AOAM530Yr/TwDUq0FuKF5NMFm6F/Z9muCUXzEd+BKHp24sTJjupX2kpu
	Ii++Z5mt9pROJBhSbWFxU9nC24cmkefV/Oa7nJg=
X-Google-Smtp-Source: ABdhPJyMy9mLob1kcfXklRdsKoTfPLhKZl+nBvCn9LJTIdp8BlzV9hR6LYyLpeeUy4kqfkXi3zpr0zAdvddGUgl9lRI=
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr16399289pjb.82.1644207174229;
 Sun, 06 Feb 2022 20:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1643110285.git.geliang.tang@suse.com> <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com> <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
In-Reply-To: <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 7 Feb 2022 12:13:16 +0800
Message-ID: <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 01:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Mat, Geliang,
>
> On 27/01/2022 01:07, Mat Martineau wrote:
> > On Tue, 25 Jan 2022, Geliang Tang wrote:
> >
> >> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
> >> checksum failures.
> >>
> >
> > This patch is working well with the inverted byte detection, thanks!
>
> The public CI seems quite happy with the new version, good work :)
>
> Here is its report:
>
> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal:
>   - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
>   - Task: https://cirrus-ci.com/task/4993794666921984
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/summa=
ry.txt
>
> - KVM Validation: debug:
>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join =F0=9F=
=94=B4:
>   - Task: https://cirrus-ci.com/task/4682233209421824
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/summa=
ry.txt
>
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
>
> But if you look at the logs [1], there are probably 3 last things to
> improve:
>
> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
>
> This line is repeated 90+ times:
>
>   tc action pedit offset 162 out of bounds
>
> (we talked about this one at the last meeting with ideas on how to
> reduce/get rid of them)
>

Dose 'tc + iptables' work for our case?

Use iptables to select the packets with enough data. Then use tc to
edit the selected packets only. (I don't know how to do it yet.)

Here's a link about this:

https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_iptabl=
es
.
'''
Using tc + iptables

Iptables has a method called fwmark that can be used to mark packets
across interfaces.

First, this makes packets marked with 6, to be processed by the 1:30 class

# tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flowid 1:=
30

This sets that mark 6, using iptables

# iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6

You can then use iptables normally to match packets and then mark them
with fwmark.
'''

> But also this one now, repeated 40+ times with different offsets:
>
>   file received by server has inverted byte at 106565
>

These inverted byte logs will not be there if we add the code to drop
the bad data in future. (I haven't figured out how to implement this
yet.) Right now, just let them be there.

> And one last thing, we can see that now we have more than 99 tests, the
> alignement is no longer OK :)
>
>
>   # 101 1 MP_FAIL, single subflow            syn[ ok ] - synack[ ok ]...
>   #                                         sum[ ok ] - csum  [ ok ]
>   #                                         ftx[ ok ] - frx   [ ok ]
>   #                                         itx[ ok ] - irx   [ ok ]
>
> A very small detail, up to you to fix it or not ;)
>

I'll update this in the next version.

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
