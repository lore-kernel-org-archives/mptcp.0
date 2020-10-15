Content-Type: multipart/mixed; boundary="===============4228989318932545960=="
MIME-Version: 1.0
From: yoshi nishida <nsdairy at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Thu, 15 Oct 2020 01:09:55 -0700
Message-ID: <CAO=PVE_C_hYEhAJbNuzBUqFMhAjUUxf1rb11H=ZrPOfduAi=-Q@mail.gmail.com>
In-Reply-To: 5f11e7f7-2100-8b51-36bb-d0f084ab6477@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6310

--===============4228989318932545960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for the reply.
Hmm. I've tried v0.95 mptcp kernel and kernel5.8 on ubuntu20.10.
I tried both version 0 and 1 on v.95, but didn't work. But, I might
miss something.
I will dig into this a bit more as well as some minor issues I noticed
during the weekend.

Thank you so much!
--
Yoshi

On Wed, Oct 14, 2020 at 2:13 AM Matthieu Baerts
<matthieu.baerts(a)tessares.net> wrote:
>
> Hi Yoshi,
>
> On 14/10/2020 11:02, yoshi nishida wrote:
> > Hi Christoph,
> >
> > Sorry for the late reply. Yes, I meant the repo of multipath-tcp.org ke=
rnel.
> > As far as I tested, it seems that they are quite different and they
> > cannot interact with each other.
>
> The upstream version only supports the latest MPTCP protocol: v1. All
> stable versions of the multipath-tcp.org kernel only support the now
> deprecated MPTCPv0 protocol. The development version starts supporting
> MPTCPv1.
>
> I guess you likely tested two implementations only supporting 2
> different versions of the protocols that are incompatible with each other=
s.
>
> Please see this for more details:
>
>
> https://github.com/multipath-tcp/mptcp_net-next/wiki#upstream-vs-out-of-t=
ree-implementations
>
> > But, at least, I understand the situation. Thanks for the explanation!
> > So, if I find a bug in the upstream code, it is ok to send it to the
> > upstreaming list?
>
> Yes please, this version is in development so any feedback is welcome!
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============4228989318932545960==--
