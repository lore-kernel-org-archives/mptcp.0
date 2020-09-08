Content-Type: multipart/mixed; boundary="===============8651583903742331478=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Tue, 08 Sep 2020 11:56:58 +0800
Message-ID: <CA+WQbwudR_f3OR=SCW0JjW1DfaJO-Br6wx_KmuejfYMB8BnXDg@mail.gmail.com>
In-Reply-To: 7a7efbbd87e07aa1a1178ae0c4a2c56b237b820d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5756

--===============8651583903742331478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2020-09-04 at 13:07 +0800, Geliang Tang wrote:
> > And I want to commit patch 4/8 "mptcp: fix every subflow's local_id is =
zero"
> > and 5/8 "mptcp: fix subflow's remote_id is zero issue" directly to -net=
 as Paolo
> > suggested.
>
> I think you can go ahead and post them upstream. The sooner, the better
> - than we will have to wait for -net merge into net-next to push the
> patches depending on the above ones.
>
> > Some code about subflow's remote_id fixing in the commit "mptcp:
> > add the incoming RM_ADDR support" should be put together in patch 5/8.
> > So in the squash-to patch, I drop the original subflow's remote_id fixi=
ng code.
> >
> > Please give me some suggestions about my squash-to patch.
>
> LGTM ;)

Please help me to squash this squash-to patch (Squash-to: "mptcp: add
the incoming
RM_ADDR support") to the original commit, since some of my patches are depe=
nd on
this changes.

Thanks.

-Geliang

>
> Thanks,
>
> Paolo
>
--===============8651583903742331478==--
