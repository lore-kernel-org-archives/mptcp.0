Content-Type: multipart/mixed; boundary="===============7631017838173665759=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: net-next currently broken ?!?
Date: Tue, 19 Jan 2021 12:22:36 +0800
Message-ID: <CA+WQbwu0PBEySU6h0SEahJgiS_UvixCCQUZy-iAkH-EZTzJUHw@mail.gmail.com>
In-Reply-To: eb713663eac1d8867586cc7b71fe5c3072f52101.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7419

--===============7631017838173665759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:07=E5=86=99=E9=81=93=EF=BC=9A
>
> (or it's just me lacking coffee?!?)
>
> I just tried plain net-next at
>
> commit 213b97b125808aa220ba460a7af09d8f3772f669
> Merge: 20efd2c79afb 1fef8544bf41
> Author: Jakub Kicinski <kuba(a)kernel.org>
> Date:   Sat Jan 16 19:06:01 2021 -0800
>
>     Merge branch 'net-fix-the-features-flag-in-sctp_gso_segment'
>
> selftests mptcp_connect.sh randomly fail with data corruption: the
> amount of transferred data is correct, the fail contains some chunk of
> random data.
>
> Can anybody else replicate the above?

I just tested it, and got the mptcp_connect.sh failure too. I'll try to
find out which commit breaks it today, and give you the feedback.

-Geliang

>
> Thanks,
>
> Paolo
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============7631017838173665759==--
