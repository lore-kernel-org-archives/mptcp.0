Content-Type: multipart/mixed; boundary="===============7111506710287159306=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 0/3] mptcp: create subflow
 for newly added address and testcases
Date: Wed, 23 Dec 2020 18:40:55 +0800
Message-ID: <CA+WQbws0y5KNKkmvPY+773HEn4hYwNsppqm5OGHEDX=tXh7uAQ@mail.gmail.com>
In-Reply-To: 6735a6c406d7126eb94268e858dea3b17ea03013.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7243

--===============7111506710287159306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2020-12-18 at 14:33 -0800, Mat Martineau wrote:
> > On Fri, 18 Dec 2020, Geliang Tang wrote:
> >
> > > v2:
> > > - drop the unused addr parameter in mptcp_nl_add_subflow_or_signal_ad=
dr
> > > - use the pernet *_max values in mptcp_pm_create_subflow_or_signal_ad=
dr
> > > instead of the per-msk values.
> > >
> >
> > Paolo, do you think the per-msk add_addr_signal_max and local_addr_max =
are
> > still needed? It's not clear to me what having pernet and per-msk copies
> > of those values will help accomplish.
>
> Well, that was likely overdesign on my side. I thought it would be
> easier and/or faster have the limit avail in each msk. It looks like
> it's not really the case. I think the same consideration applies to '
> local_addr_max' and 'subflows_max' so I guess we can drop all the
> 'pm.*max' fields.
>
> (in a separate patch)
>

Thanks for your suggestion, I'll write a new patch to drop those *max field=
s.

-Geliang

> Thanks!
>
> Paolo
>
--===============7111506710287159306==--
