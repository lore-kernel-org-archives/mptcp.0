Content-Type: multipart/mixed; boundary="===============0011134690375393487=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 net-next 5/5] mptcp: implement delegated actions
Date: Sat, 23 Jan 2021 08:10:37 +0100
Message-ID: <fab5f9f2abdc478702fc7f9a831de418a1234e38.camel@redhat.com>
In-Reply-To: 20210122152355.761ff148@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 7475

--===============0011134690375393487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-01-22 at 15:23 -0800, Jakub Kicinski wrote:
> On Fri, 22 Jan 2021 09:25:07 +0100 Paolo Abeni wrote:
> > > Do you need it because of locking?  =

> > =

> > This infrastructure is used to avoid the workqueue usage in the MPTCP
> > receive path (to push pending data). With many mptcp connections
> > established that would be very bad for tput and latency. This
> > infrastructure is not strictly needed from a functinal PoV, but I was
> > unable to find any other way to avoid the workqueue usage.
> =

> But it is due to locking or is it not? Because you're running the
> callback in the same context, so otherwise why not just call the
> function directly? Can't be batching, it's after GRO so we won't =

> batch much more.

Thank you for the feedback. =


Let me try to elaborate a bit more on this. When processing the input
packet (MPTCP data ack) on the MPTCP subflow A, under the subflow A
socket lock, we possibly need to push some data via a different subflow
B - depending on the MPTCP packet scheduler decision. We can't try to
acquire the B subflow socket lock due to ABBA deadlock.

Either the workqueue usage and this infra avoid the deadlock breaking
the locks chain.

Should not have any bad iteraction with threaded NAPI nor busy polling,
but I don't have experimented yet. Placing that on my TODO list.

Thanks!

Paolo

--===============0011134690375393487==--
