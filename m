Content-Type: multipart/mixed; boundary="===============4008711367233854635=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/9] RM_ADDR: remove a list
 of addrs
Date: Tue, 09 Feb 2021 23:31:52 +0800
Message-ID: <CA+WQbwtOYdhcj4nQdAFQWt+rXqGU=mh=tEMag_eX4CNn+5kd4w@mail.gmail.com>
In-Reply-To: 5764998f-17f1-ece6-e8c5-8a2d758c864@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7725

--===============4008711367233854635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Thanks for your reviews.

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
2=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:57=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> On Mon, 8 Feb 2021, Geliang Tang wrote:
>
> > v5:
> > - use struct mptcp_rm_list instead of the ids array.
> > - simplify mptcp_pm_remove_addrs_and_subflows.
> > - apply: tag export/20210207T062839 + patchset "move to next addr and
> > testcases".
> >
>
> Thanks Geliang!
>
> I only had a couple of minor comments doing visual code review, they
> affect individual patches but not the final code. That's all I saw in
> visual code review, I will look at the test output and pcaps tomorrow.
>
> Have you tested what happens if there's an incoming rm_addr with id 0,
> since we never send an ADD_ADDR for the initial subflow?

Id 0 is still not support in this removing address version, since we only
use this code to shutdown and close the subsocket in
mptcp_pm_nl_rm_addr_received/mptcp_pm_nl_rm_subflow_received:

    mptcp_subflow_shutdown(sk, ssk, how);
    mptcp_close_ssk(sk, ssk, subflow);

It's problematic to use them to shutdown and close the initial subflow.

I think we need to use something like:

    mptcp_shutdown(sk, how);
    mptcp_close(sk, timeout);

to deal with the initial subflow, but it doesn't work too. It will take
me some time to solve it.

-Geliang

>
> --
> Mat Martineau
> Intel
--===============4008711367233854635==--
