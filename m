Content-Type: multipart/mixed; boundary="===============4611801053421864547=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Wed, 28 Feb 2018 14:41:56 -0800
Message-ID: <20180228224156.GB15661@MacBook-Pro-4.local>
In-Reply-To: CAKuKrB=HtSKuoQ-egoxxN_yvB9XGCfQJkjLKn6HJWSBES272TQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 322

--===============4611801053421864547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/02/18 - 18:01:20, Matthieu Baerts wrote:
> Hi Mat, Christoph,
> =

> On Tue, Feb 27, 2018 at 7:50 PM, Mat Martineau <
> mathew.j.martineau(a)linux.intel.com> wrote:
> =

> >
> > Hi Christoph,
> >
> > On Mon, 26 Feb 2018, Christoph Paasch wrote:
> >
> > Hello,
> >>
> >> as for next steps after the submission of the TCP-option framework to
> >> netdev
> >> and DaveM's feedback on it.
> >>
> >> Even if the submission got rejected, I think we still have a very usef=
ul
> >> set
> >> of patches here. The need for a framework might pop up again in the
> >> future,
> >> and so these patches could come in handy.
> >> Mat, maybe you can put our latest submission on your kernel.org-git re=
po
> >> just so that we don't lose track of these patches?
> >>
> >
> > Done: https://git.kernel.org/pub/scm/linux/kernel/git/martineau/li
> > nux.git/log/?h=3Dmd5
> =

> =

> By chance, did you get some feedbacks from people interested by this
> framework?
> Or even from Eric Dumazet who wanted to clean TCP MD5 part if I am not
> wrong. It is maybe not what he wanted.

Yeah, feedback was disappointingly scarce :/

It probably was not what he had completely in mind, as he didn't talk about
a TCP-option framework but simply about moving TCP-MD5 code out of the
TCP-stack. So, with our proposal we went a bit further.

> =

> * There is still the open question of the API, path-management,... Tessar=
es
> >>  has some experience with that, so maybe they can provide some ideas h=
ere.
> >>
> >
> > We (at OTC) are working on a generic netlink proposal for path manageme=
nt
> > as well.
> >
> =

> At Tessares, we were going to propose a new PM supporting Netlink for a
> management from userspace. There is a short paper describing it:
> http://www.tessares.net/tessares-founders-win-an-ietf-award/
> =

> Even if we think that having a PM customisable via BPF could be even
> better, this PM has still some values. It is mature, should be ready to be
> shared but we first need to rebase it on the latest kernel. We can discuss
> about that in a separate email if you want :)
> =

> Note that the PDF of the short paper is also available there:
> http://www.tessares.net/wp-content/uploads/2016/06/SMAPP-Towards-Smart-Mu=
ltipath-TCP-enabled-APPlications.pdf
> =

> =

> > * The size of the skb. Well, we have been discussing this for quite a
> >> while :)
> >>  One option is always to have a lookup table as they do for the
> >>  TLS-records. That will hurt performance, but at least it's a step
> >> forward.
> >>  And we have a bunch of other ideas that might be worth exploring as w=
ell.
> >>  If I'm not mistaken, Rao had an approach that could work as well, rig=
ht?
> >>
> >
> > This is what I'm working on now. For outgoing packets, I have a way to
> > optionally allocate sk_buffs with extra control block space. For incomi=
ng
> > packets, my initial experiment is with preventing packet coalesce/colla=
pse
> > so TCP options are still in the skb headroom. I don't consider that a
> > long-term solution, though. Some kind of lookup table will probably be
> > needed.
> >
> =

> That looks interesting!
> =

> On some systems with hardware acceleration to bypass the main CPU for
> established connections, I guess they also have to modify the skb to share
> info between the main CPU and another component.
> Do you have any ideas how they are doing that? It is maybe not a real
> problem for them to increase the size of the skb if most of the traffic
> goes in the "fast path".

TLS is a good example. They actually do have a lookup table where the driver
is calling back into the TCP-stack to get the TLS-record information.

We had discussed this with people from Mellanox that proposed the
TLS hardware offloading: https://lists.01.org/pipermail/mptcp/2017-November=
/000165.html

> > Any other comments, suggestions,...? :-)
> >>
> >
> > I had these thoughts on evolving the multipath-tcp.org kernel fork last
> > summer (excerpt from https://lists.01.org/pipermail
> > /mptcp/2017-July/000064.html), which I think are still relevant:
> >
> > """
> >
> > One approach is to attempt to merge the multipath-tcp.org fork. This is
> > an implementation in which the multipath-tcp.org community has invested=
 a
> > lot of time and effort, and it is in production for major applications =
(see
> > https://tools.ietf.org/html/rfc8041). This is a tremendous amount of co=
de
> > to review at once (even separating out modules), and currently doesn't =
fit
> > with what the maintainers have asked for (non-intrusive, sk_buff size,
> > MPTCP by default). I don't think the maintainers would consider merging
> > such an extensive piece of git history, especially where there are a fa=
ir
> > number of commits without an "mptcp:" label on the subject line or with=
out
> > a DCO signoff (https://www.kernel.org/doc/html/latest/process/submittin=
g-p
> > atches.html#sign-your-work-the-developer-s-certificate-of-origin). Toda=
y,
> > the fork is at kernel v4.4 and current upstream development is at
> > v4.13-rc1, so the fork would have to catch up and stay current. (2018 n=
ote:
> > Christoph has merged up to more recent kernels now)
> >
> > The other extreme is to rewrite from scratch. This would allow incremen=
tal
> > development with maintainer review from the start, but doesn't take
> > advantage of existing code.
> >
> > The most realistic approach is somewhere in between, where we write new
> > code that fits maintainer expectations and utilize components from the
> > fork where licensing allows and the code fits. We'll have to find the
> > right balance: over-reliance on new code could take extra time, but
> > constantly reworking the fork and keeping it up-to-date with net-next is
> > also a lot of overhead.
> >
> > """
> >
> > Gregory and Matthieu, do you have any thoughts on where the right balan=
ce
> > is on evolving the fork vs. adding new code?
> >
> =

> We think we don't need to rewrite it from scratch. MPTCP code is conseque=
nt
> and complex but having a fork will not simplify it a lot if we want to
> continue supporting middle boxes, fallback to TCP, etc. Most of the MPTCP
> code is then reusable and some didn't really change for years now.
> =

> We clearly understand that the current implementation cannot go upstream.
> It is not just a question of git history but mostly the fact the code is
> too intrusive as you both said. We agree that this doesn't need a full
> rewrite but some adaptations from both the upstream side and the current
> MPTCP implementation.
> =

> Sorry for not really giving new thoughts but we agree with all points
> written by Christoph :-)
> =

> What we also think is that this upstreaming job is not easy. The best is
> certainly to well organise that and prepare as a team here questions/RFC =
to
> netdev.
> I am personally not used to work on big changes on the same subject betwe=
en
> different organisations but we guess it would be helpful to organise
> regular (virtual) meetings to share plans of what can be done by who.

Yes, that would be good! Just a short weekly sync could be useful.

Do you have a Webex or other means to set this up?


Looking forward to the netlink PM! :-)


Christoph


> =

> Unlike Gregory, I guess I don't have the same high knowledge you all have
> here regarding the overall Linux network stack but then I would be happy =
to
> also help on improving the organisation if this can allow me to be quickly
> efficient on the help I can provide here :)
> =

> On my side, as a first concrete step, I will work towards lockless subflow
> >> establishment. In tcp_v4_rcv, we are currently taking the meta-level l=
ock
> >> when the socket-lookup matches on a request-socket. Now that TCP suppo=
rts
> >> lockless listeners, MPTCP should do that as well.
> >>
> >
> > I'll work on getting my team's MPTCP socket type code posted to
> > git.kernel.org, and getting our generic netlink proposal posted to this
> > list.
> >
> =

> We can also work on our side to accelerate the sharing of our netlink PM.
> =

> Best regards,
> Matt, ok Matthieu :-)
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

--===============4611801053421864547==--
