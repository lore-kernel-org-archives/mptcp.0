Content-Type: multipart/mixed; boundary="===============3830774516094719795=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Thu, 26 Apr 2018 14:25:24 -0700
Message-ID: <ab963222-29d5-d93d-ae42-f3fd6e3be948@oracle.com>
In-Reply-To: 20180426205206.GA19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 558

--===============3830774516094719795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/26/2018 01:52 PM, Christoph Paasch wrote:
>
> This kind of lock-taking also causes trouble with RCU LOCKDEP debugging -=
 as
> I mentioned in a previous e-mail.
I have not looked into it so I can not comment. I am sure we will find a =

way to address it.
>
> And beyond that, it requires that everytime a TCP-change is being done, o=
ne
> needs to take MPTCP into account. E.g., when upstream added the SOCK_DEST=
ROY
> interface (and Samsung backported it to v4.4), there were panics on Andro=
id
> devices (https://github.com/multipath-tcp/mptcp/issues/170).
>
> Avoid taking the meta-socket lock on subflow-work allows for much easier
> maintenance in the long-term.
The bug that you have pointed out is a run of the mill bug that we see =

everyday, there is nothing special about it.

Taking meta lock actually simplifies things a lot and has reduced =

maintainable cost, not taking the meta lock will create timing issues =

left and right. So we are just trading one headache with another.

Holding meta lock should not be piped up unnecessarily. Yes, if possible =

if should be changed, plus our patch has only 6 cases in TCP.

Shoaib.

[1] If MPTCP is built on top of TCP, any change in TCP will always have =

to worry about MPTCP particularly in the control path. There is a =

overhead of adding MPTCP on TCP and no one can argue against it.

>
>
> Christoph
>


--===============3830774516094719795==--
