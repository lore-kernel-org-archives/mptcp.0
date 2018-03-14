Content-Type: multipart/mixed; boundary="===============1933216610140301557=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Weekly meeting - 15 March 2018 16:00 UTC (9am PDT,
 5pm CEST)
Date: Wed, 14 Mar 2018 12:54:46 -0700
Message-ID: <20180314195446.GX74937@MacBook-Pro-4.local>
In-Reply-To: CAKuKrBn2XQDmids22F2QKbEQkuQ9D+YUKaVQjqp=OfBR=-hDYA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 375

--===============1933216610140301557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

another item on the topic-list (maybe rather for next week as our list is
already pretty long and I don't yet have very deep thoughts on the issue):

While designing the lockless subflow establishment I realized that our
subflow-establishment routine on the passive opener side is pretty badly
designed.

I want to throw around some ideas as to how to handle this.

There are two problems:
1. Subflow establishment doesn't fit the listener()-design of today's
   stacks:
   Subflows are matching to a higher-level meta-socket based on the token
   that is in the SYN+MP_JOIN. Today's TCP connection establishment simply
   matches on destination-port, optional destination IP and optional
   incoming interface index.
   Thus, MPTCP introduces a completely new way of matching incoming
   connections that require us to parse the TCP-options.
   Today, we call mptcp_lookup_join() which parses the TCP-options in the
   fast-path when there is no matching socket. This is not desirable, and we
   should find a better way of doing it.

2. MPTCP is hooked pretty deeply in tcp_check_req,... We should explore if
   it is easier to transition to kernel_accept() and have a cleaner
   layer-separation where TCP takes care of the handshake without the
   meta-socket and later on this one than attaches the subflow with a
   kernel_accept().


I will give these things some more thought and maybe we can discuss it in
one of the future calls.


Talk to you tomorrow.


Christoph


On 14/03/18 - 18:15:55, Matthieu Baerts wrote:
> Hi Mat,
> =

> Thank you for this email!
> I was going to send one this evening but sorry I was very busy this week =
:-/
> I will make sure to reserve more time for that next week!
> =

> On Wed, Mar 14, 2018 at 5:49 PM, Mat Martineau <
> mathew.j.martineau(a)linux.intel.com> wrote:
> =

> >
> > Our MPTCP upstreaming weekly web conference is scheduled for tomorrow.
> >
> > The list of topics is here: https://annuel2.framapad.org/p
> > /mptcp_upstreaming_20180315
> =

> =

> Thank you for the link!
> I just added a few new topics, mainly inspired from a few mails exchanges
> on the ML. Note that we still need to reorder them:
> =

>     - https://www.mail-archive.com/netdev(a)vger.kernel.org/msg221741.htm=
l =E2=86=92
> indirect calls are expensive
>     - Rao's patches and feedback from upstream
>     - points from last week: Mat: check with other people from Intel what
> could help: create a workshop at Linux plumber conf, meet these people not
> alone.
>     - concrete next steps: what has changed
>     - roadmap to share with community =E2=86=92 goal: hoping people will =
help if
> they know what need to be done
>     - Netlink API
> =

> See you tomorrow, I will be there!
> Matthieu
> =

> -- =

> [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Lou=
vain-la-Neuve,+Belgium>
> =

> -- =

> =

> ------------------------------
> DISCLAIMER.
> This email and any files transmitted with it are confidential and intende=
d =

> solely for the use of the individual or entity to whom they are addressed=
. =

> If you have received this email in error please notify the system manager=
. =

> This message contains confidential information and is intended only for t=
he =

> individual named. If you are not the named addressee you should not =

> disseminate, distribute or copy this e-mail. Please notify the sender =

> immediately by e-mail if you have received this e-mail by mistake and =

> delete this e-mail from your system. If you are not the intended recipien=
t =

> you are notified that disclosing, copying, distributing or taking any =

> action in reliance on the contents of this information is strictly =

> prohibited.

> rm: /Users/cpaasch/tmp/mutt_attach/TFO_Quantil_US: is a directory
> rm: /Users/cpaasch/tmp/mutt_attach/TFO_Quantil_US 2: is a directory

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============1933216610140301557==--
