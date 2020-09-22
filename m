Content-Type: multipart/mixed; boundary="===============0634964554615723531=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 3/3] mptcp: retransmit
 ADD_ADDR when timeout
Date: Tue, 22 Sep 2020 10:29:53 +0800
Message-ID: <CA+WQbwvHuu1FREmKcj0H=MkB0C7isYo51xKa+9hKXJKwZz6Exg@mail.gmail.com>
In-Reply-To: 05497891-40c7-c0d4-0271-5ac24c649a53@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5976

--===============0634964554615723531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8822=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:53=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Paolo
>
> On 21/09/2020 12:24, Paolo Abeni wrote:
> > Hi,
> >
> > Thank you for the prompt turn-over. There is still a somewhat relevant
> > item - the last comment in this patch. The others comments are mostly
> > nit picking, but nice to have.
> >
> > On Mon, 2020-09-21 at 15:30 +0800, Geliang Tang wrote:
> >> This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR
> >> echo
> >> is received. It added a timer with the announced address. When
> >> timeout
> >> occurs, ADD_ADDR will be retransmitted.
> >>
> >> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> >> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> >> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>
> As discussed on IRC, I just applied this patch + the "squash to" one:
>
> - a972ed5d1ec5: mptcp: add struct mptcp_pm_add_entry
> - 39a25e21cbca: mptcp: add sk_stop_timer_sync helper
> - e83b080276ea: mptcp: retransmit ADD_ADDR when timeout
>
> Paolo's ACK has been added to these three patches. I applied these
> patches after Geliang' selftests patches because the timeout feature is
> not validated by any kselftests.

Thanks, as these patches have been applied, I think both issue #49 (ADD_ADD=
R:
echo bit support) and issue #50 (REMOVE_ADDR support) could be closed.

And I'll write the selftest case of these patches later.

-Geliang

>
> - fe8df13fc5d3..8c5acf4c1ab3: result
>
> Note that it would maybe be more interesting to add packetdrill test to
> validate this feature.
>
> Tests + export are going to be started soon.
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============0634964554615723531==--
