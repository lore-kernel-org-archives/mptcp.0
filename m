Content-Type: multipart/mixed; boundary="===============7964657481664998587=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 19:37:50 +0200
Message-ID: <CAKuKrBn3HEXNoAZ3fv_iniGUuJONUM2=u28H+yzSTAEU8Rx0aw@mail.gmail.com>
In-Reply-To: 20180430162501.GO19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 574

--===============7964657481664998587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 6:25 PM, Christoph Paasch <cpaasch(a)apple.com> wro=
te:

> On 30/04/18 - 08:37:01, Mat Martineau wrote:
> >
> > On Sun, 29 Apr 2018, Matthieu Baerts wrote:
> >
> > > Hi Mat,
> > >
> > > Thank you for your review and input!
> > >
> > > On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <
> mathew.j.martineau(a)linux.intel.com> wrote:
> > >
> > >       Hi Matthieu -
> > >
> > >       On Fri, 27 Apr 2018, Matthieu Baerts wrote:
> > >
> > >             Hello,
> > >
> > >             Following yesterday's discussion about NetDev 0x12, here
> is a proposition of mail to send to NetDev committee. I
> > >             already put some comments. Note that I have followed the
> submission guidelines from:
> > >             https://www.netdevconf.org/0x12/submit-proposal.html#
> proposals
> > >
> > >             Please comment it before Monday morning. Sorry for the
> rush but the deadline is the 1st of May :)
> > >
> > >                   * Name(s) of the submitter(s): Christoph Paasch
> (Apple), Mat Martineau
> > >
> > >             (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and
> myself, Matthieu Baerts (Tessares)
> > >
> > >             I wrote down the names of people who participated in the
> discussion in the ML and during the weekly meetings. I can
> > >             add more people if more people would like to join the
> preparation and presentation of this tutorial.
> > >             @Christoph, Mat, Peter, Ossama: can I write your names
> there?
> > >
> > >
> > >       Ossama won't be able to attend. It looks like most sessions have
> 1 or 2 presenters, so I don't know if 4 is too many. I'm sure
> > >       they'll give us some feedback if they want to limit the number
> of presenters.
> > >
> > >
> > > OK thank you!
> > > Yes indeed, I am sure they will say something if we are too many.
> > >
> > >                   * Title of the submission: MPTCP: from the basic to
> an upstreamable base
> > >
> > >
> > >             We certainly need a better title, please comment!
> > >
> > >
> > >       "Multipath TCP: Present Use Cases and an Upstream Future" ?
> > >
> > >
> > > I was trying to find something that catch the attention but it is
> maybe not needed for these kind of presentation.
> > >
> > >             > * Label (one of moonshot, nuts'n bolts, hands-on):
> hands-on
> > >
> > >             "hands-on" seems to be the correct one according to the
> Submission Types.
> > >             https://www.netdevconf.org/0x12/submit-proposal.html#types
> > >
> > >
> > >       It's a little bit of "nuts & bolts" too, but I agree that
> hands-on is the better match.
> > >
> > >
> > > Thank you!
> > >
> > >                   * Submission type (one of talk, presentation,
> workshop): tutorial,
> > >
> > >             instructor-led sessions (minimum 1 hour long and not to
> exceed 1.5 hours. The instructor will go over the technology
> > >             either through code review or execution and interact with
> the attendees.)
> > >
> > >             I guess there is a typo here: presentation should be
> replaced by tutorial in the guidelines.
> > >
> > >                   Estimate of length of time for presentation: 1h
> > >
> > >
> > >             That's what we agreed yesterday but I can change.
> > >
> > >                   Affiliations of submitters (needed for conflict of
> interest check): Apple,
> > >
> > >             Intel, Tessares
> > >
> > >                   Description of proposal:
> > >                       A project to add an implementation of the
> MultiPath TCP protocol to the
> > >
> > >             Linux kernel is in progress by a small community. The goal
> of this tutorial is to discover what is this TCP extension
> > >             (RFC 6824), what are the different use-cases already in
> production by some companies and what are the challenges to
> > >             upstream MPTCP. We hope having interactive discussions and
> getting feedback from experienced developers will help us
> > >             in this task of easily bringing MPTCP to all Linux users,
> a technology already used by millions of people.
> > >
> > >
> > >                       In a bit more detail, we will start with a basic
> introduction of MPTCP.
> > >
> > >             A few use-cases will be presented with a demo to explain
> how useful this protocol is in today's Internet and how it
> > >             can be extended with API's like Netlink and BPF.
> > >
> > >
> > >       I recognize how Netlink is associated with a userspace path
> manager, but what's the BPF extensibility you're referring to?
> > >
> > >
> > > It was only to mention that it would be possible to extend MPTCP with
> eBPF.
> > > Even if it is not already available in the current Open-Source
> implementation, there is already the possibility to get a version with a
> > > programmable scheduler: https://progmp.net
> >
> > If we don't have something specific to our effort with BPF, I'm not sure
> it
> > belongs in the summary. But I don't have a strong opinion about it.
>
> I agree that we don't need BPF in the summary here. We can talk about its
> potential during the presentation though. But, here in the summary it is a
> bit more distracting IMO.
>

We can remove it, no problem!

Can we then say: (...) be extended with API's like Netlink.


>
> >
> > >
> > >             Then we will have some explanations about how MPTCP is
> currently implemented. This current implementation is quite
> > >             intrusive and that is certainly not something we would
> like to have upstream. We would like to express what we have
> > >             in mind to change that, with some samples and initiate
> discussions.
> > >
> > >
> > >       My edit of the above:
> > >
> > >       """
> > >
> > >       A community project is underway to add Multipath TCP to the
> upstream Linux kernel. This tutorial will introduce the audience to
> > >       this TCP extension (RFC 6824), show some use cases already in
> production, and discuss the challenges in converging on an upstream
> > >       MPTCP implementation.
> > >
> > >
> > > Should we insist on the "discussion" part? Like saying: "discuss with
> the audience"? "have interactive discussions"?
> > > It is maybe not needed but it was mainly to express the interactivity,
> it is a tutorial, not just a "simple" presentation.
> >
> > I think it's ok to mention that - while I left the word "discuss" in
> there
> > for that reason, maybe that's not obvious or clear enough.
>
> I think that "discuss with the audience" or "have interactive discussions"
> makes it more clear what we want to achieve.
>

OK, I will then mention it!
Thank you for your comments!

Matthieu


>
>
> Christoph
>
> > >       We will use the current MPTCP implementation to demonstrate the
> utility of the protocol on today's internet, and to show how this
> > >       implementation can currently be extended with netlink and BPF.
> This not only has practical application for deploying MPTCP now,
> > >       but also illustrates how the APIs and code will need to evolve
> in order to properly coexist with the optimized Linux TCP core we
> > >       all rely on. We will discuss our ideas for bringing MPTCP to the
> upstream kernel so the technology is available to all Linux
> > >       users.
> > >
> > >
> > > To "attract" people, should we mention that the current implementation
> is already used by millions of users?
> > > I like how your improve the last bit :-)
> >
> > Sure. I liked that in your text, but ran out of time figuring out how to
> fit
> > it in to the last sentence :)
> >
> > >
> > >       """
> > >
> > >       Feel free to edit/merge/expand/discard as needed :)
> > >
> > >
> > > Thank you for your edit, it is indeed cleaner!
> > >
> > >                       For more information about this project:
> > >
> > >             https://github.com/multipath-tcp/mptcp_net-next/wiki
> > >
> > >
> > > I guess I can keep this, right?
> >
> > Yes, that was my intent.
> >
> >
> > Thanks,
> >
> > Mat
> >
> >
> > >
> > >             Please feel free to comment this as well. We are still far
> from the max 350 words limit we found last time. But on
> > >             the other hand, I can no longer find this limit on their
> website :)
> > >
> > >
> > >       Hope the above is helpful. Thanks again for your work on this
> proposal.
> > >
> > >
> > > Yes it is, thank you for your help!
> > >
> > > Matthieu
> > >
> > >
> > >
> > >       Mat
> > >
> > >
> > >
> > >             Thank you for your help!
> > >
> > >             Have a good day/evening,
> > >             Matthieu
> > >
> > >             On 25/04/2018 21:58, Mat Martineau wrote:
> > >
> > >                   Hi Matthieu -
> > >
> > >                   On Fri, 20 Apr 2018, Matthieu Baerts wrote:
> > >
> > >                         Hello,
> > >
> > >
> > >                         NetDev 0x12 is coming to Montr=C3=A9al this s=
ummer:
> July 11th to 13th, 2018.
> > >
> > >
> > >                         We already talked about this event on this ML
> and at our weekly meetings but here is a
> > >                         summary of the discussions we had:
> > >
> > >                          - we would like to have a presentation there
> mainly to get feedback and advice from other
> > >                         kernel developers
> > >                          - a presentation would clearly indicate that
> this MPTCP Upstream project exists and we could
> > >                         get help from more developers
> > >                          - we would like to indicate that having MPTCP
> upstream is asked by different companies, some
> > >                         are even ready to contribute ; it is then
> important to have MPTCP upstream
> > >
> > >
> > >                         Also note that:
> > >
> > >                          - David Miller will not be present in
> Montr=C3=A9al [1] but other main contributors should be
> > >                         there (we don't have a list)
> > >
> > >
> > >                   Side note, in the past day David reiterated his
> statement about not attending or supporting the
> > >                   conference:
> > >
> > >                   https://marc.info/?l=3Dlinux-
> netdev&m=3D152466827203301&w=3D2
> > >
> > >                          - A presentation by Octavian Purdila about
> "MPTCP Upstreaming" has already been given in
> > >                         2015 (NetDev 0.1) [2]
> > >                          - 3 types of presentation are available:
> talks, tutorials and workshops [3]
> > >                          - Call for Presentation Proposals closes on
> May 1st, 2018.
> > >
> > >
> > >                         The current idea we briefly discussed during
> our weekly meetings is to give a tutorial:
> > >
> > >                          - It is not useful to give almost the same
> presentation as the one of Octavian
> > >                          - It will allow us more flexibility somehow
> to explain what is MPTCP, the different
> > >                         use-cases, why it is important to have it
> upstream and what problems we are currently facing.
> > >                          - David Miller and many other kernel
> developers will go to LPC in November: a good place to
> > >                         give a talk this time.
> > >
> > >
> > >                         Do you have any ideas on what we could show in
> this tutorial?
> > >
> > >
> > >                         I recently discussed with my colleague Olivier
> Bonaventure who has a lot of experiences in
> > >                         giving different introductions and more about
> MPTCP and here is what he suggests:
> > >
> > >                          - A first part about a basic introduction of
> MPTCP
> > >                          - Indicate different use-cases -- if possible
> with a "closed demo" to be sure it is working
> > >                         -- asking people to setup something is not
> easy in 1h, max 1h30.
> > >
> > >
> > >                    From the description at [3], either
> "instructor-led" 60-90 minute tutorials or "student-participation"
> > >                   2-3 hour sessions are possible. The closed demo maps
> well to their "instructor-led" category. Looking at
> > >                   the schedule, the past two Netdev Conferences have
> had one tutorial each, of 60-70 minutes. I think it
> > >                   helps to be closer to an hour in length to hold the
> audience's attention.
> > >
> > >                          - Then trying to have interactive discussions
> or explanations about how MPTCP is currently
> > >                         implemented or should be implemented if it
> goes upstream, e.g.: for MPTCP, we need to have
> > >                         extra TCP Options, we need to support
> middleboxes, we need to link subflows of the same
> > >                         connection together, we need a scheduler, a
> PM, etc.
> > >
> > >
> > >                   It's difficult to predict how interactive an
> audience will be. I've only attended one Netdev Conference,
> > >                   and it seemed like there were a lot more people with
> expertise and interest in drivers, lower layers
> > >                   (XDP, BPF, TC, netfilter), and network
> topology/simulation. Discussion around middlebox support and the
> > >                   userspace API might have more audience interaction.
> If we want to drive a discussion, we could try to
> > >                   strike a balance between topics for the broader
> audience and those with more knowledge of TCP internals.
> > >                   (Hopefully some TCP internals people are still
> planning to attend)
> > >
> > >                          - Of course, we should focus our discussions
> on the upstreaming aspect, e.g. reducing the
> > >                         footprint of MPTCP in the current TCP stack:
> what are we allow to do, what not. It is linked
> > >                         to many previous discussions we had on this
> ML, e.g. why we need more indirect function calls
> > >                         and how to reduce the impact, etc.
> > >
> > >
> > >                   The previous talk ([2]) had a section like this. I
> haven't watched it recently, I should look at it again
> > >                   to see what kind of questions the audience was
> asking. As you mentioned above we should be careful to
> > >                   have new content compared to the previous session.
> > >
> > >                          - If we have time, we could discuss about how
> users could interact with MPTCP: enable it per
> > >                         connection, control the path manager, maybe
> the scheduler, etc.
> > >
> > >
> > >                         What do you think about this? Feel free to
> comment and even propose completely different
> > >                         ideas!
> > >
> > >
> > >                   Thank you for outlining these ideas. I see that this
> topic is on our meeting agenda so it will be good to
> > >                   discuss the tutorial there.
> > >
> > >
> > >                         [1] https://lists.01.org/
> pipermail/mptcp/2018-March/000379.html
> > >                         [2] https://www.youtube.com/watch?
> v=3Dwftz2cU5SZs
> > >                         [3] https://www.netdevconf.org/
> 0x12/submit-proposal.html
> >
> > --
> > Mat Martineau
> > Intel OTC
>
>


-- =

[image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
<https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Louva=
in-la-Neuve,+Belgium>

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============7964657481664998587==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgQXByIDMwLCAyMDE4IGF0IDY6MjUgUE0sIENocmlzdG9w
aCBQYWFzY2ggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBs
ZS5jb20iIHRhcmdldD0iX2JsYW5rIj5jcGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3
cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBjbGFzcz0iSE9FblpiIj48ZGl2IGNsYXNzPSJoNSI+T24gMzAvMDQvMTggLSAwODozNzowMSwg
TWF0IE1hcnRpbmVhdSB3cm90ZTo8YnI+CiZndDsgPGJyPgomZ3Q7IE9uIFN1biwgMjkgQXByIDIw
MTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+CiZndDsgPGJyPgomZ3Q7ICZndDsgSGkgTWF0
LDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IFRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcg
YW5kIGlucHV0ITxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IE9uIFNhdCwgQXByIDI4LCAy
MDE4IGF0IDI6NDQgQU0sIE1hdCBNYXJ0aW5lYXUgJmx0OzxhIGhyZWY9Im1haWx0bzptYXRoZXcu
ai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tIj5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguPHdi
cj5pbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8Kg
IMKgIMKgIMKgSGkgTWF0dGhpZXUgLTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqBPbiBGcmksIDI3IEFwciAyMDE4LCBNYXR0aGlldSBCYWVydHMgd3JvdGU6PGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEhlbGxvLDxicj4KJmd0OyAm
Z3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBGb2xsb3dpbmcgeWVzdGVyZGF5
JiMzOTtzIGRpc2N1c3Npb24gYWJvdXQgTmV0RGV2IDB4MTIsIGhlcmUgaXMgYSBwcm9wb3NpdGlv
biBvZiBtYWlsIHRvIHNlbmQgdG8gTmV0RGV2IGNvbW1pdHRlZS4gSTxicj4KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqBhbHJlYWR5IHB1dCBzb21lIGNvbW1lbnRzLiBOb3RlIHRoYXQgSSBo
YXZlIGZvbGxvd2VkIHRoZSBzdWJtaXNzaW9uIGd1aWRlbGluZXMgZnJvbTo8YnI+CiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgPGEgaHJlZj0iaHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcv
MHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCNwcm9wb3NhbHMiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzx3YnI+MHgxMi9zdWJtaXQt
cHJvcG9zYWwuaHRtbCM8d2JyPnByb3Bvc2FsczwvYT48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgUGxlYXNlIGNvbW1lbnQgaXQgYmVmb3JlIE1vbmRheSBt
b3JuaW5nLiBTb3JyeSBmb3IgdGhlIHJ1c2ggYnV0IHRoZSBkZWFkbGluZSBpcyB0aGUgMXN0IG9m
IE1heSA6KTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAqIE5hbWUocykgb2YgdGhlIHN1Ym1pdHRlcihzKTogQ2hyaXN0b3BoIFBhYXNjaCAo
QXBwbGUpLCBNYXQgTWFydGluZWF1PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoChJbnRlbCksIFBldGVyIEtyeXN0YWQgKEludGVsKSwgT3NzYW1hIE90aG1h
biAoSW50ZWwpIGFuZCBteXNlbGYsIE1hdHRoaWV1IEJhZXJ0cyAoVGVzc2FyZXMpPGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEkgd3JvdGUgZG93biB0aGUg
bmFtZXMgb2YgcGVvcGxlIHdobyBwYXJ0aWNpcGF0ZWQgaW4gdGhlIGRpc2N1c3Npb24gaW4gdGhl
IE1MIGFuZCBkdXJpbmcgdGhlIHdlZWtseSBtZWV0aW5ncy4gSSBjYW48YnI+CiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgYWRkIG1vcmUgcGVvcGxlIGlmIG1vcmUgcGVvcGxlIHdvdWxkIGxp
a2UgdG8gam9pbiB0aGUgcHJlcGFyYXRpb24gYW5kIHByZXNlbnRhdGlvbiBvZiB0aGlzIHR1dG9y
aWFsLjxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBAQ2hyaXN0b3BoLCBNYXQsIFBl
dGVyLCBPc3NhbWE6IGNhbiBJIHdyaXRlIHlvdXIgbmFtZXMgdGhlcmU/PGJyPgomZ3Q7ICZndDsg
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoE9zc2FtYSB3b24mIzM5O3Qg
YmUgYWJsZSB0byBhdHRlbmQuIEl0IGxvb2tzIGxpa2UgbW9zdCBzZXNzaW9ucyBoYXZlIDEgb3Ig
MiBwcmVzZW50ZXJzLCBzbyBJIGRvbiYjMzk7dCBrbm93IGlmIDQgaXMgdG9vIG1hbnkuIEkmIzM5
O20gc3VyZTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqB0aGV5JiMzOTtsbCBnaXZlIHVzIHNvbWUg
ZmVlZGJhY2sgaWYgdGhleSB3YW50IHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgcHJlc2VudGVycy48
YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBPSyB0aGFuayB5b3Uh
PGJyPgomZ3Q7ICZndDsgWWVzIGluZGVlZCwgSSBhbSBzdXJlIHRoZXkgd2lsbCBzYXkgc29tZXRo
aW5nIGlmIHdlIGFyZSB0b28gbWFueS48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBUaXRsZSBvZiB0aGUgc3VibWlzc2lvbjogTVBUQ1A6
IGZyb20gdGhlIGJhc2ljIHRvIGFuIHVwc3RyZWFtYWJsZSBiYXNlPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFdlIGNlcnRhaW5s
eSBuZWVkIGEgYmV0dGVyIHRpdGxlLCBwbGVhc2UgY29tbWVudCE8YnI+CiZndDsgJmd0OyA8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgJnF1b3Q7TXVsdGlwYXRoIFRDUDog
UHJlc2VudCBVc2UgQ2FzZXMgYW5kIGFuIFVwc3RyZWFtIEZ1dHVyZSZxdW90OyA/PGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgSSB3YXMgdHJ5aW5nIHRvIGZpbmQg
c29tZXRoaW5nIHRoYXQgY2F0Y2ggdGhlIGF0dGVudGlvbiBidXQgaXQgaXMgbWF5YmUgbm90IG5l
ZWRlZCBmb3IgdGhlc2Uga2luZCBvZiBwcmVzZW50YXRpb24uPGJyPgomZ3Q7ICZndDsgPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsgKiBMYWJlbCAob25lIG9mIG1vb25zaG90
LCBudXRzJiMzOTtuIGJvbHRzLCBoYW5kcy1vbik6IGhhbmRzLW9uPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2hhbmRzLW9uJnF1b3Q7IHNlZW1z
IHRvIGJlIHRoZSBjb3JyZWN0IG9uZSBhY2NvcmRpbmcgdG8gdGhlIFN1Ym1pc3Npb24gVHlwZXMu
PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5l
dGRldmNvbmYub3JnLzB4MTIvc3VibWl0LXByb3Bvc2FsLmh0bWwjdHlwZXMiIHJlbD0ibm9yZWZl
cnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzx3YnI+MHgx
Mi9zdWJtaXQtcHJvcG9zYWwuaHRtbCM8d2JyPnR5cGVzPC9hPjxicj4KJmd0OyAmZ3Q7IDxicj4K
Jmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBJdCYjMzk7cyBhIGxpdHRsZSBiaXQg
b2YgJnF1b3Q7bnV0cyAmYW1wOyBib2x0cyZxdW90OyB0b28sIGJ1dCBJIGFncmVlIHRoYXQgaGFu
ZHMtb24gaXMgdGhlIGJldHRlciBtYXRjaC48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8
YnI+CiZndDsgJmd0OyBUaGFuayB5b3UhPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogU3VibWlzc2lvbiB0eXBlIChvbmUgb2YgdGFsaywg
cHJlc2VudGF0aW9uLCB3b3Jrc2hvcCk6IHR1dG9yaWFsLDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBpbnN0cnVjdG9yLWxlZCBzZXNzaW9ucyAobWluaW11
bSAxIGhvdXIgbG9uZyBhbmQgbm90IHRvIGV4Y2VlZCAxLjUgaG91cnMuIFRoZSBpbnN0cnVjdG9y
IHdpbGwgZ28gb3ZlciB0aGUgdGVjaG5vbG9neTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqBlaXRoZXIgdGhyb3VnaCBjb2RlIHJldmlldyBvciBleGVjdXRpb24gYW5kIGludGVyYWN0
IHdpdGggdGhlIGF0dGVuZGVlcy4pPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoEkgZ3Vlc3MgdGhlcmUgaXMgYSB0eXBvIGhlcmU6IHByZXNlbnRhdGlvbiBz
aG91bGQgYmUgcmVwbGFjZWQgYnkgdHV0b3JpYWwgaW4gdGhlIGd1aWRlbGluZXMuPGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVzdGltYXRl
IG9mIGxlbmd0aCBvZiB0aW1lIGZvciBwcmVzZW50YXRpb246IDFoPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFRoYXQmIzM5O3Mg
d2hhdCB3ZSBhZ3JlZWQgeWVzdGVyZGF5IGJ1dCBJIGNhbiBjaGFuZ2UuPGJyPgomZ3Q7ICZndDsg
PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFmZmlsaWF0aW9ucyBv
ZiBzdWJtaXR0ZXJzIChuZWVkZWQgZm9yIGNvbmZsaWN0IG9mIGludGVyZXN0IGNoZWNrKTogQXBw
bGUsPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEludGVs
LCBUZXNzYXJlczxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBEZXNjcmlwdGlvbiBvZiBwcm9wb3NhbDo8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgQSBwcm9qZWN0IHRvIGFkZCBhbiBpbXBsZW1lbnRh
dGlvbiBvZiB0aGUgTXVsdGlQYXRoIFRDUCBwcm90b2NvbCB0byB0aGU8YnI+CiZndDsgJmd0OyA8
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgTGludXgga2VybmVsIGlzIGluIHByb2dy
ZXNzIGJ5IGEgc21hbGwgY29tbXVuaXR5LiBUaGUgZ29hbCBvZiB0aGlzIHR1dG9yaWFsIGlzIHRv
IGRpc2NvdmVyIHdoYXQgaXMgdGhpcyBUQ1AgZXh0ZW5zaW9uPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoChSRkMgNjgyNCksIHdoYXQgYXJlIHRoZSBkaWZmZXJlbnQgdXNlLWNhc2Vz
IGFscmVhZHkgaW4gcHJvZHVjdGlvbiBieSBzb21lIGNvbXBhbmllcyBhbmQgd2hhdCBhcmUgdGhl
IGNoYWxsZW5nZXMgdG88YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdXBzdHJlYW0g
TVBUQ1AuIFdlIGhvcGUgaGF2aW5nIGludGVyYWN0aXZlIGRpc2N1c3Npb25zIGFuZCBnZXR0aW5n
IGZlZWRiYWNrIGZyb20gZXhwZXJpZW5jZWQgZGV2ZWxvcGVycyB3aWxsIGhlbHAgdXM8YnI+CiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgaW4gdGhpcyB0YXNrIG9mIGVhc2lseSBicmluZ2lu
ZyBNUFRDUCB0byBhbGwgTGludXggdXNlcnMsIGEgdGVjaG5vbG9neSBhbHJlYWR5IHVzZWQgYnkg
bWlsbGlvbnMgb2YgcGVvcGxlLjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCBJbiBhIGJpdCBtb3JlIGRl
dGFpbCwgd2Ugd2lsbCBzdGFydCB3aXRoIGEgYmFzaWMgaW50cm9kdWN0aW9uIG9mIE1QVENQLjxi
cj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBBIGZldyB1c2Ut
Y2FzZXMgd2lsbCBiZSBwcmVzZW50ZWQgd2l0aCBhIGRlbW8gdG8gZXhwbGFpbiBob3cgdXNlZnVs
IHRoaXMgcHJvdG9jb2wgaXMgaW4gdG9kYXkmIzM5O3MgSW50ZXJuZXQgYW5kIGhvdyBpdDxicj4K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBjYW4gYmUgZXh0ZW5kZWQgd2l0aCBBUEkmIzM5
O3MgbGlrZSBOZXRsaW5rIGFuZCBCUEYuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoEkgcmVjb2duaXplIGhvdyBOZXRsaW5rIGlzIGFzc29jaWF0
ZWQgd2l0aCBhIHVzZXJzcGFjZSBwYXRoIG1hbmFnZXIsIGJ1dCB3aGF0JiMzOTtzIHRoZSBCUEYg
ZXh0ZW5zaWJpbGl0eSB5b3UmIzM5O3JlIHJlZmVycmluZyB0bz88YnI+CiZndDsgJmd0OyA8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBJdCB3YXMgb25seSB0byBtZW50aW9uIHRoYXQgaXQg
d291bGQgYmUgcG9zc2libGUgdG8gZXh0ZW5kIE1QVENQIHdpdGggZUJQRi48YnI+CiZndDsgJmd0
OyBFdmVuIGlmIGl0IGlzIG5vdCBhbHJlYWR5IGF2YWlsYWJsZSBpbiB0aGUgY3VycmVudCBPcGVu
LVNvdXJjZSBpbXBsZW1lbnRhdGlvbiwgdGhlcmUgaXMgYWxyZWFkeSB0aGUgcG9zc2liaWxpdHkg
dG8gZ2V0IGEgdmVyc2lvbiB3aXRoIGE8YnI+CiZndDsgJmd0OyBwcm9ncmFtbWFibGUgc2NoZWR1
bGVyOiA8YSBocmVmPSJodHRwczovL3Byb2dtcC5uZXQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vcHJvZ21wLm5ldDwvYT48YnI+CiZndDsgPGJyPgomZ3Q7IElmIHdl
IGRvbiYjMzk7dCBoYXZlIHNvbWV0aGluZyBzcGVjaWZpYyB0byBvdXIgZWZmb3J0IHdpdGggQlBG
LCBJJiMzOTttIG5vdCBzdXJlIGl0PGJyPgomZ3Q7IGJlbG9uZ3MgaW4gdGhlIHN1bW1hcnkuIEJ1
dCBJIGRvbiYjMzk7dCBoYXZlIGEgc3Ryb25nIG9waW5pb24gYWJvdXQgaXQuPGJyPgo8YnI+Cjwv
ZGl2PjwvZGl2PkkgYWdyZWUgdGhhdCB3ZSBkb24mIzM5O3QgbmVlZCBCUEYgaW4gdGhlIHN1bW1h
cnkgaGVyZS4gV2UgY2FuIHRhbGsgYWJvdXQgaXRzPGJyPgpwb3RlbnRpYWwgZHVyaW5nIHRoZSBw
cmVzZW50YXRpb24gdGhvdWdoLiBCdXQsIGhlcmUgaW4gdGhlIHN1bW1hcnkgaXQgaXMgYTxicj4K
Yml0IG1vcmUgZGlzdHJhY3RpbmcgSU1PLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+
PGRpdj5XZSBjYW4gcmVtb3ZlIGl0LCBubyBwcm9ibGVtITwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+Q2FuIHdlICB0aGVuIHNheTogKC4uLikgYmUgZXh0ZW5kZWQgd2l0aCBBUEkmIzM5O3MgbGlr
ZSBOZXRsaW5rLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij4KPHNwYW4gY2xhc3M9IiI+PGJyPgomZ3Q7IDxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBUaGVuIHdlIHdpbGwgaGF2ZSBzb21l
IGV4cGxhbmF0aW9ucyBhYm91dCBob3cgTVBUQ1AgaXMgY3VycmVudGx5IGltcGxlbWVudGVkLiBU
aGlzIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXMgcXVpdGU8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgaW50cnVzaXZlIGFuZCB0aGF0IGlzIGNlcnRhaW5seSBub3Qgc29tZXRoaW5n
IHdlIHdvdWxkIGxpa2UgdG8gaGF2ZSB1cHN0cmVhbS4gV2Ugd291bGQgbGlrZSB0byBleHByZXNz
IHdoYXQgd2UgaGF2ZTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBpbiBtaW5kIHRv
IGNoYW5nZSB0aGF0LCB3aXRoIHNvbWUgc2FtcGxlcyBhbmQgaW5pdGlhdGUgZGlzY3Vzc2lvbnMu
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoE15
IGVkaXQgb2YgdGhlIGFib3ZlOjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgQSBjb21tdW5pdHkgcHJvamVjdCBpcyB1bmRlcndheSB0byBhZGQgTXVsdGlwYXRoIFRDUCB0
byB0aGUgdXBzdHJlYW0gTGludXgga2VybmVsLiBUaGlzIHR1dG9yaWFsIHdpbGwgaW50cm9kdWNl
IHRoZSBhdWRpZW5jZSB0bzxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqB0aGlzIFRDUCBleHRlbnNp
b24gKFJGQyA2ODI0KSwgc2hvdyBzb21lIHVzZSBjYXNlcyBhbHJlYWR5IGluIHByb2R1Y3Rpb24s
IGFuZCBkaXNjdXNzIHRoZSBjaGFsbGVuZ2VzIGluIGNvbnZlcmdpbmcgb24gYW4gdXBzdHJlYW08
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgTVBUQ1AgaW1wbGVtZW50YXRpb24uPGJyPgomZ3Q7ICZn
dDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgU2hvdWxkIHdlIGluc2lzdCBvbiB0aGUg
JnF1b3Q7ZGlzY3Vzc2lvbiZxdW90OyBwYXJ0PyBMaWtlIHNheWluZzogJnF1b3Q7ZGlzY3VzcyB3
aXRoIHRoZSBhdWRpZW5jZSZxdW90Oz8gJnF1b3Q7aGF2ZSBpbnRlcmFjdGl2ZSBkaXNjdXNzaW9u
cyZxdW90Oz88YnI+CiZndDsgJmd0OyBJdCBpcyBtYXliZSBub3QgbmVlZGVkIGJ1dCBpdCB3YXMg
bWFpbmx5IHRvIGV4cHJlc3MgdGhlIGludGVyYWN0aXZpdHksIGl0IGlzIGEgdHV0b3JpYWwsIG5v
dCBqdXN0IGEgJnF1b3Q7c2ltcGxlJnF1b3Q7IHByZXNlbnRhdGlvbi48YnI+CiZndDsgPGJyPgom
Z3Q7IEkgdGhpbmsgaXQmIzM5O3Mgb2sgdG8gbWVudGlvbiB0aGF0IC0gd2hpbGUgSSBsZWZ0IHRo
ZSB3b3JkICZxdW90O2Rpc2N1c3MmcXVvdDsgaW4gdGhlcmU8YnI+CiZndDsgZm9yIHRoYXQgcmVh
c29uLCBtYXliZSB0aGF0JiMzOTtzIG5vdCBvYnZpb3VzIG9yIGNsZWFyIGVub3VnaC48YnI+Cjxi
cj4KPC9zcGFuPkkgdGhpbmsgdGhhdCAmcXVvdDtkaXNjdXNzIHdpdGggdGhlIGF1ZGllbmNlJnF1
b3Q7IG9yICZxdW90O2hhdmUgaW50ZXJhY3RpdmUgZGlzY3Vzc2lvbnMmcXVvdDs8YnI+Cm1ha2Vz
IGl0IG1vcmUgY2xlYXIgd2hhdCB3ZSB3YW50IHRvIGFjaGlldmUuPGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2Pk9LLCBJIHdpbGwgdGhlbiBtZW50aW9uIGl0ITwvZGl2PjxkaXY+
VGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzITwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TWF0
dGhpZXU8L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij4KPHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgi
Pjxicj4KPGJyPgo8YnI+CkNocmlzdG9waDxicj4KPC9mb250Pjwvc3Bhbj48ZGl2IGNsYXNzPSJI
T0VuWmIiPjxkaXYgY2xhc3M9Img1Ij48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgV2Ugd2lsbCB1
c2UgdGhlIGN1cnJlbnQgTVBUQ1AgaW1wbGVtZW50YXRpb24gdG8gZGVtb25zdHJhdGUgdGhlIHV0
aWxpdHkgb2YgdGhlIHByb3RvY29sIG9uIHRvZGF5JiMzOTtzIGludGVybmV0LCBhbmQgdG8gc2hv
dyBob3cgdGhpczxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBpbXBsZW1lbnRhdGlvbiBjYW4gY3Vy
cmVudGx5IGJlIGV4dGVuZGVkIHdpdGggbmV0bGluayBhbmQgQlBGLiBUaGlzIG5vdCBvbmx5IGhh
cyBwcmFjdGljYWwgYXBwbGljYXRpb24gZm9yIGRlcGxveWluZyBNUFRDUCBub3csPGJyPgomZ3Q7
ICZndDvCoCDCoCDCoCDCoGJ1dCBhbHNvIGlsbHVzdHJhdGVzIGhvdyB0aGUgQVBJcyBhbmQgY29k
ZSB3aWxsIG5lZWQgdG8gZXZvbHZlIGluIG9yZGVyIHRvIHByb3Blcmx5IGNvZXhpc3Qgd2l0aCB0
aGUgb3B0aW1pemVkIExpbnV4IFRDUCBjb3JlIHdlPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoGFs
bCByZWx5IG9uLiBXZSB3aWxsIGRpc2N1c3Mgb3VyIGlkZWFzIGZvciBicmluZ2luZyBNUFRDUCB0
byB0aGUgdXBzdHJlYW0ga2VybmVsIHNvIHRoZSB0ZWNobm9sb2d5IGlzIGF2YWlsYWJsZSB0byBh
bGwgTGludXg8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgdXNlcnMuPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgVG8gJnF1b3Q7YXR0cmFjdCZxdW90OyBwZW9wbGUs
IHNob3VsZCB3ZSBtZW50aW9uIHRoYXQgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXMgYWxy
ZWFkeSB1c2VkIGJ5IG1pbGxpb25zIG9mIHVzZXJzPzxicj4KJmd0OyAmZ3Q7IEkgbGlrZSBob3cg
eW91ciBpbXByb3ZlIHRoZSBsYXN0IGJpdCA6LSk8YnI+CiZndDsgPGJyPgomZ3Q7IFN1cmUuIEkg
bGlrZWQgdGhhdCBpbiB5b3VyIHRleHQsIGJ1dCByYW4gb3V0IG9mIHRpbWUgZmlndXJpbmcgb3V0
IGhvdyB0byBmaXQ8YnI+CiZndDsgaXQgaW4gdG8gdGhlIGxhc3Qgc2VudGVuY2UgOik8YnI+CiZn
dDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCZxdW90OyZxdW90OyZx
dW90Ozxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBGZWVsIGZyZWUgdG8g
ZWRpdC9tZXJnZS9leHBhbmQvZGlzY2FyZCBhcyBuZWVkZWQgOik8YnI+CiZndDsgJmd0OyA8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBUaGFuayB5b3UgZm9yIHlvdXIgZWRpdCwgaXQgaXMg
aW5kZWVkIGNsZWFuZXIhPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoMKgIMKgIEZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRoaXMgcHJv
amVjdDo8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgPGEg
aHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvd2lr
aSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL211
bHRpcGF0aC08d2JyPnRjcC9tcHRjcF9uZXQtbmV4dC93aWtpPC9hPjxicj4KJmd0OyAmZ3Q7IDxi
cj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IEkgZ3Vlc3MgSSBjYW4ga2VlcCB0aGlzLCByaWdo
dD88YnI+CiZndDsgPGJyPgomZ3Q7IFllcywgdGhhdCB3YXMgbXkgaW50ZW50Ljxicj4KJmd0OyA8
YnI+CiZndDsgPGJyPgomZ3Q7IFRoYW5rcyw8YnI+CiZndDsgPGJyPgomZ3Q7IE1hdDxicj4KJmd0
OyA8YnI+CiZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoFBsZWFzZSBmZWVsIGZyZWUgdG8gY29tbWVudCB0aGlzIGFzIHdlbGwuIFdlIGFyZSBzdGls
bCBmYXIgZnJvbSB0aGUgbWF4IDM1MCB3b3JkcyBsaW1pdCB3ZSBmb3VuZCBsYXN0IHRpbWUuIEJ1
dCBvbjxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB0aGUgb3RoZXIgaGFuZCwgSSBj
YW4gbm8gbG9uZ2VyIGZpbmQgdGhpcyBsaW1pdCBvbiB0aGVpciB3ZWJzaXRlIDopPGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoEhvcGUgdGhlIGFi
b3ZlIGlzIGhlbHBmdWwuIFRoYW5rcyBhZ2FpbiBmb3IgeW91ciB3b3JrIG9uIHRoaXMgcHJvcG9z
YWwuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgWWVzIGl0IGlz
LCB0aGFuayB5b3UgZm9yIHlvdXIgaGVscCE8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBN
YXR0aGlldTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqBNYXQ8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgVGhhbmsgeW91IGZv
ciB5b3VyIGhlbHAhPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoEhhdmUgYSBnb29kIGRheS9ldmVuaW5nLDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqBNYXR0aGlldTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqBPbiAyNS8wNC8yMDE4IDIxOjU4LCBNYXQgTWFydGluZWF1IHdyb3RlOjxicj4KJmd0OyAm
Z3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBIaSBNYXR0aGll
dSAtPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoE9uIEZyaSwgMjAgQXByIDIwMTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+CiZndDsg
Jmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
SGVsbG8sPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5ldERldiAweDEyIGlzIGNvbWluZyB0byBN
b250csOpYWwgdGhpcyBzdW1tZXI6IEp1bHkgMTF0aCB0byAxM3RoLCAyMDE4Ljxicj4KJmd0OyAm
Z3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBXZSBhbHJlYWR5IHRhbGtlZCBhYm91dCB0aGlzIGV2ZW50IG9uIHRoaXMg
TUwgYW5kIGF0IG91ciB3ZWVrbHkgbWVldGluZ3MgYnV0IGhlcmUgaXMgYTxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdW1tYXJ5IG9mIHRoZSBkaXNj
dXNzaW9ucyB3ZSBoYWQ6PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgLSB3ZSB3b3VsZCBsaWtlIHRvIGhhdmUgYSBwcmVz
ZW50YXRpb24gdGhlcmUgbWFpbmx5IHRvIGdldCBmZWVkYmFjayBhbmQgYWR2aWNlIGZyb20gb3Ro
ZXI8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKga2Vy
bmVsIGRldmVsb3BlcnM8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgwqAtIGEgcHJlc2VudGF0aW9uIHdvdWxkIGNsZWFybHkgaW5kaWNhdGUgdGhhdCB0
aGlzIE1QVENQIFVwc3RyZWFtIHByb2plY3QgZXhpc3RzIGFuZCB3ZSBjb3VsZDxicj4KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnZXQgaGVscCBmcm9tIG1v
cmUgZGV2ZWxvcGVyczxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqDCoC0gd2Ugd291bGQgbGlrZSB0byBpbmRpY2F0ZSB0aGF0IGhhdmluZyBNUFRDUCB1
cHN0cmVhbSBpcyBhc2tlZCBieSBkaWZmZXJlbnQgY29tcGFuaWVzLCBzb21lPGJyPgomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFyZSBldmVuIHJlYWR5IHRv
IGNvbnRyaWJ1dGUgOyBpdCBpcyB0aGVuIGltcG9ydGFudCB0byBoYXZlIE1QVENQIHVwc3RyZWFt
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFsc28gbm90ZSB0aGF0Ojxicj4KJmd0OyAmZ3Q7IDxi
cj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoC0gRGF2
aWQgTWlsbGVyIHdpbGwgbm90IGJlIHByZXNlbnQgaW4gTW9udHLDqWFsIFsxXSBidXQgb3RoZXIg
bWFpbiBjb250cmlidXRvcnMgc2hvdWxkIGJlPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRoZXJlICh3ZSBkb24mIzM5O3QgaGF2ZSBhIGxpc3QpPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFNpZGUgbm90ZSwgaW4gdGhlIHBhc3QgZGF5IERhdmlkIHJlaXRlcmF0ZWQg
aGlzIHN0YXRlbWVudCBhYm91dCBub3QgYXR0ZW5kaW5nIG9yIHN1cHBvcnRpbmcgdGhlPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbmZlcmVuY2U6PGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxhIGhyZWY9
Imh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LW5ldGRldiZhbXA7bT0xNTI0NjY4MjcyMDMzMDEm
YW1wO3c9MiIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9tYXJjLmlu
Zm8vP2w9bGludXgtPHdicj5uZXRkZXYmYW1wO209MTUyNDY2ODI3MjAzMzAxJmFtcDt3PTI8L2E+
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgLSBBIHByZXNlbnRhdGlvbiBieSBPY3RhdmlhbiBQdXJkaWxhIGFib3V0ICZx
dW90O01QVENQIFVwc3RyZWFtaW5nJnF1b3Q7IGhhcyBhbHJlYWR5IGJlZW4gZ2l2ZW4gaW48YnI+
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMjAxNSAoTmV0
RGV2IDAuMSkgWzJdPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoMKgLSAzIHR5cGVzIG9mIHByZXNlbnRhdGlvbiBhcmUgYXZhaWxhYmxlOiB0YWxrcywg
dHV0b3JpYWxzIGFuZCB3b3Jrc2hvcHMgWzNdPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgLSBDYWxsIGZvciBQcmVzZW50YXRpb24gUHJvcG9zYWxz
IGNsb3NlcyBvbiBNYXkgMXN0LCAyMDE4Ljxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxi
cj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBUaGUgY3Vy
cmVudCBpZGVhIHdlIGJyaWVmbHkgZGlzY3Vzc2VkIGR1cmluZyBvdXIgd2Vla2x5IG1lZXRpbmdz
IGlzIHRvIGdpdmUgYSB0dXRvcmlhbDo8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAtIEl0IGlzIG5vdCB1c2VmdWwgdG8g
Z2l2ZSBhbG1vc3QgdGhlIHNhbWUgcHJlc2VudGF0aW9uIGFzIHRoZSBvbmUgb2YgT2N0YXZpYW48
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAtIEl0
IHdpbGwgYWxsb3cgdXMgbW9yZSBmbGV4aWJpbGl0eSBzb21laG93IHRvIGV4cGxhaW4gd2hhdCBp
cyBNUFRDUCwgdGhlIGRpZmZlcmVudDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB1c2UtY2FzZXMsIHdoeSBpdCBpcyBpbXBvcnRhbnQgdG8gaGF2ZSBp
dCB1cHN0cmVhbSBhbmQgd2hhdCBwcm9ibGVtcyB3ZSBhcmUgY3VycmVudGx5IGZhY2luZy48YnI+
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAtIERhdmlk
IE1pbGxlciBhbmQgbWFueSBvdGhlciBrZXJuZWwgZGV2ZWxvcGVycyB3aWxsIGdvIHRvIExQQyBp
biBOb3ZlbWJlcjogYSBnb29kIHBsYWNlIHRvPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdpdmUgYSB0YWxrIHRoaXMgdGltZS48YnI+CiZndDsgJmd0
OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgRG8geW91IGhhdmUgYW55IGlkZWFzIG9uIHdoYXQgd2UgY291bGQgc2hvdyBp
biB0aGlzIHR1dG9yaWFsPzxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJIHJlY2VudGx5IGRpc2N1
c3NlZCB3aXRoIG15IGNvbGxlYWd1ZSBPbGl2aWVyIEJvbmF2ZW50dXJlIHdobyBoYXMgYSBsb3Qg
b2YgZXhwZXJpZW5jZXMgaW48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ2l2aW5nIGRpZmZlcmVudCBpbnRyb2R1Y3Rpb25zIGFuZCBtb3JlIGFib3V0
IE1QVENQIGFuZCBoZXJlIGlzIHdoYXQgaGUgc3VnZ2VzdHM6PGJyPgomZ3Q7ICZndDsgPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgLSBBIGZpcnN0
IHBhcnQgYWJvdXQgYSBiYXNpYyBpbnRyb2R1Y3Rpb24gb2YgTVBUQ1A8YnI+CiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAtIEluZGljYXRlIGRpZmZlcmVu
dCB1c2UtY2FzZXMgLS0gaWYgcG9zc2libGUgd2l0aCBhICZxdW90O2Nsb3NlZCBkZW1vJnF1b3Q7
IHRvIGJlIHN1cmUgaXQgaXMgd29ya2luZzxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAtLSBhc2tpbmcgcGVvcGxlIHRvIHNldHVwIHNvbWV0aGluZyBp
cyBub3QgZWFzeSBpbiAxaCwgbWF4IDFoMzAuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsg
PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgRnJvbSB0aGUgZGVz
Y3JpcHRpb24gYXQgWzNdLCBlaXRoZXIgJnF1b3Q7aW5zdHJ1Y3Rvci1sZWQmcXVvdDsgNjAtOTAg
bWludXRlIHR1dG9yaWFscyBvciAmcXVvdDtzdHVkZW50LXBhcnRpY2lwYXRpb24mcXVvdDs8YnI+
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMi0zIGhvdXIgc2Vzc2lvbnMg
YXJlIHBvc3NpYmxlLiBUaGUgY2xvc2VkIGRlbW8gbWFwcyB3ZWxsIHRvIHRoZWlyICZxdW90O2lu
c3RydWN0b3ItbGVkJnF1b3Q7IGNhdGVnb3J5LiBMb29raW5nIGF0PGJyPgomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRoZSBzY2hlZHVsZSwgdGhlIHBhc3QgdHdvIE5ldGRl
diBDb25mZXJlbmNlcyBoYXZlIGhhZCBvbmUgdHV0b3JpYWwgZWFjaCwgb2YgNjAtNzAgbWludXRl
cy4gSSB0aGluayBpdDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBo
ZWxwcyB0byBiZSBjbG9zZXIgdG8gYW4gaG91ciBpbiBsZW5ndGggdG8gaG9sZCB0aGUgYXVkaWVu
Y2UmIzM5O3MgYXR0ZW50aW9uLjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoC0gVGhlbiB0cnlpbmcgdG8gaGF2ZSBpbnRl
cmFjdGl2ZSBkaXNjdXNzaW9ucyBvciBleHBsYW5hdGlvbnMgYWJvdXQgaG93IE1QVENQIGlzIGN1
cnJlbnRseTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpbXBsZW1lbnRlZCBvciBzaG91bGQgYmUgaW1wbGVtZW50ZWQgaWYgaXQgZ29lcyB1cHN0cmVh
bSwgZS5nLjogZm9yIE1QVENQLCB3ZSBuZWVkIHRvIGhhdmU8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXh0cmEgVENQIE9wdGlvbnMsIHdlIG5lZWQg
dG8gc3VwcG9ydCBtaWRkbGVib3hlcywgd2UgbmVlZCB0byBsaW5rIHN1YmZsb3dzIG9mIHRoZSBz
YW1lPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNv
bm5lY3Rpb24gdG9nZXRoZXIsIHdlIG5lZWQgYSBzY2hlZHVsZXIsIGEgUE0sIGV0Yy48YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgSXQmIzM5O3MgZGlmZmljdWx0IHRvIHByZWRpY3QgaG93IGludGVyYWN0aXZlIGFu
IGF1ZGllbmNlIHdpbGwgYmUuIEkmIzM5O3ZlIG9ubHkgYXR0ZW5kZWQgb25lIE5ldGRldiBDb25m
ZXJlbmNlLDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhbmQgaXQg
c2VlbWVkIGxpa2UgdGhlcmUgd2VyZSBhIGxvdCBtb3JlIHBlb3BsZSB3aXRoIGV4cGVydGlzZSBh
bmQgaW50ZXJlc3QgaW4gZHJpdmVycywgbG93ZXIgbGF5ZXJzPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoChYRFAsIEJQRiwgVEMsIG5ldGZpbHRlciksIGFuZCBuZXR3
b3JrIHRvcG9sb2d5L3NpbXVsYXRpb24uIERpc2N1c3Npb24gYXJvdW5kIG1pZGRsZWJveCBzdXBw
b3J0IGFuZCB0aGU8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdXNl
cnNwYWNlIEFQSSBtaWdodCBoYXZlIG1vcmUgYXVkaWVuY2UgaW50ZXJhY3Rpb24uIElmIHdlIHdh
bnQgdG8gZHJpdmUgYSBkaXNjdXNzaW9uLCB3ZSBjb3VsZCB0cnkgdG88YnI+CiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyaWtlIGEgYmFsYW5jZSBiZXR3ZWVuIHRvcGlj
cyBmb3IgdGhlIGJyb2FkZXIgYXVkaWVuY2UgYW5kIHRob3NlIHdpdGggbW9yZSBrbm93bGVkZ2Ug
b2YgVENQIGludGVybmFscy48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKEhvcGVmdWxseSBzb21lIFRDUCBpbnRlcm5hbHMgcGVvcGxlIGFyZSBzdGlsbCBwbGFubmlu
ZyB0byBhdHRlbmQpPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgLSBPZiBjb3Vyc2UsIHdlIHNob3VsZCBmb2N1cyBvdXIg
ZGlzY3Vzc2lvbnMgb24gdGhlIHVwc3RyZWFtaW5nIGFzcGVjdCwgZS5nLiByZWR1Y2luZyB0aGU8
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9vdHBy
aW50IG9mIE1QVENQIGluIHRoZSBjdXJyZW50IFRDUCBzdGFjazogd2hhdCBhcmUgd2UgYWxsb3cg
dG8gZG8sIHdoYXQgbm90LiBJdCBpcyBsaW5rZWQ8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdG8gbWFueSBwcmV2aW91cyBkaXNjdXNzaW9ucyB3ZSBo
YWQgb24gdGhpcyBNTCwgZS5nLiB3aHkgd2UgbmVlZCBtb3JlIGluZGlyZWN0IGZ1bmN0aW9uIGNh
bGxzPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFu
ZCBob3cgdG8gcmVkdWNlIHRoZSBpbXBhY3QsIGV0Yy48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsg
Jmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVGhlIHByZXZp
b3VzIHRhbGsgKFsyXSkgaGFkIGEgc2VjdGlvbiBsaWtlIHRoaXMuIEkgaGF2ZW4mIzM5O3Qgd2F0
Y2hlZCBpdCByZWNlbnRseSwgSSBzaG91bGQgbG9vayBhdCBpdCBhZ2Fpbjxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0byBzZWUgd2hhdCBraW5kIG9mIHF1ZXN0aW9u
cyB0aGUgYXVkaWVuY2Ugd2FzIGFza2luZy4gQXMgeW91IG1lbnRpb25lZCBhYm92ZSB3ZSBzaG91
bGQgYmUgY2FyZWZ1bCB0bzxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBoYXZlIG5ldyBjb250ZW50IGNvbXBhcmVkIHRvIHRoZSBwcmV2aW91cyBzZXNzaW9uLjxicj4K
Jmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqDCoC0gSWYgd2UgaGF2ZSB0aW1lLCB3ZSBjb3VsZCBkaXNjdXNzIGFib3V0IGhvdyB1c2Vy
cyBjb3VsZCBpbnRlcmFjdCB3aXRoIE1QVENQOiBlbmFibGUgaXQgcGVyPGJyPgomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbm5lY3Rpb24sIGNvbnRyb2wg
dGhlIHBhdGggbWFuYWdlciwgbWF5YmUgdGhlIHNjaGVkdWxlciwgZXRjLjxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzPyBGZWVsIGZyZWUgdG8gY29t
bWVudCBhbmQgZXZlbiBwcm9wb3NlIGNvbXBsZXRlbHkgZGlmZmVyZW50PGJyPgomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkZWFzITxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBUaGFuayB5b3UgZm9yIG91dGxpbmluZyB0aGVzZSBpZGVhcy4gSSBzZWUgdGhhdCB0aGlzIHRv
cGljIGlzIG9uIG91ciBtZWV0aW5nIGFnZW5kYSBzbyBpdCB3aWxsIGJlIGdvb2QgdG88YnI+CiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlzY3VzcyB0aGUgdHV0b3JpYWwg
dGhlcmUuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFsxXSA8YSBocmVmPSJodHRwczovL2xpc3Rz
LjAxLm9yZy9waXBlcm1haWwvbXB0Y3AvMjAxOC1NYXJjaC8wMDAzNzkuaHRtbCIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy4wMS5vcmcvPHdicj5waXBlcm1h
aWwvbXB0Y3AvMjAxOC1NYXJjaC88d2JyPjAwMDM3OS5odG1sPC9hPjxicj4KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBbMl0gPGEgaHJlZj0iaHR0cHM6Ly93
d3cueW91dHViZS5jb20vd2F0Y2g/dj13ZnR6MmNVNVNacyIgcmVsPSJub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/PHdicj52PXdmdHoyY1U1
U1pzPC9hPjxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBbM10gPGEgaHJlZj0iaHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJv
cG9zYWwuaHRtbCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cu
bmV0ZGV2Y29uZi5vcmcvPHdicj4weDEyL3N1Ym1pdC1wcm9wb3NhbC5odG1sPC9hPjxicj4KJmd0
OyA8YnI+CiZndDsgLS08YnI+CiZndDsgTWF0IE1hcnRpbmVhdTxicj4KJmd0OyBJbnRlbCBPVEM8
YnI+Cjxicj4KPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFs
bCI+PGJyPi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWls
PSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRp
dj48ZGl2IGRpcj0ibHRyIj48dGFibGUgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O1RpbWVzIE5l
dyBSb21hbiZxdW90OztsZXR0ZXItc3BhY2luZzpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQt
dHJhbnNmb3JtOm5vbmU7d29yZC1zcGFjaW5nOjBweCIgd2lkdGg9IjEwMCUiIGJvcmRlcj0iMCI+
PHRib2R5Pjx0cj48dGQgcm93c3Bhbj0iMyIgc3R5bGU9InBhZGRpbmctbGVmdDo1cHg7cGFkZGlu
Zy1yaWdodDo1cHgiIHdpZHRoPSIxMCIgdmFsaWduPSJ0b3AiIGFsaWduPSJsZWZ0Ij48YSBocmVm
PSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPjxpbWcgc3JjPSJodHRw
Oi8vd3d3LnRlc3NhcmVzLm5ldC9zaWdsb2dvLnBuZyIgYWx0PSJUZXNzYXJlcyBTQSIgd2lkdGg9
IjgwIiBoZWlnaHQ9IjgwIiBib3JkZXI9IjAiPjwvYT48L3RkPjx0ZCBzdHlsZT0icGFkZGluZzow
cHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEwcHgi
IGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48c3BhbiBzdHlsZT0iZm9udC13ZWlnaHQ6Ym9sZDtj
b2xvcjpyZ2IoMzcsODMsMTU1KTtkaXNwbGF5OmlubGluZSI+TWF0dGhpZXUgQmFlcnRzIHwgUiZh
bXA7RCBFbmdpbmVlcjwvc3Bhbj48L3RkPjwvdHI+PHRyPjx0ZCBzdHlsZT0icGFkZGluZzowcHg7
Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEwcHgiIGhl
aWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzJTQw
dGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9u
ZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJl
cy5uZXQ8YnI+PC9hPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZh
bWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgYWxpZ249Imxl
ZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rp
c3BsYXk6aW5saW5lIj5UZXNzYXJlcyBTQSB8IEh5YnJpZCBBY2Nlc3MgU29sdXRpb25zPGJyPjwv
c3Bhbj48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgc3R5bGU9ImNvbG9yOnJnYigw
LDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0iX2JsYW5r
Ij53d3cudGVzc2FyZXMubmV0PC9hPjxzcGFuPsKgPC9zcGFuPjxicj48YSBocmVmPSJodHRwczov
L3d3dy5nb29nbGUuY29tL21hcHM/cT0xK0F2ZW51ZStKZWFuK01vbm5ldCwrMTM0OCtPdHRpZ25p
ZXMtTG91dmFpbi1sYS1OZXV2ZSwrQmVsZ2l1bSIgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7dGV4
dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0iX2JsYW5rIj4xIEF2ZW51
ZSBKZWFuIE1vbm5ldCwgMTM0OCBMb3V2YWluLWxhLU5ldXZlLCBCZWxnaXVtPC9hPjwvdGQ+PC90
cj48L3Rib2R5PjwvdGFibGU+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cjwv
ZGl2PjwvZGl2PgoKPGJyPgo8ZGl2Pjxicj48aHI+PC9kaXY+PGZvbnQgc2l6ZT0iMSI+PHNwYW4g
c3R5bGU9ImZvbnQtZmFtaWx5OlZlcmRhbmEsc2Fucy1zZXJpZjtiYWNrZ3JvdW5kLWNvbG9yOnJn
YigyNTUsMjU1LDI1NSkiPkRJU0NMQUlNRVIuPC9zcGFuPjxiciBzdHlsZT0iZm9udC1mYW1pbHk6
VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PGZv
bnQgY29sb3I9IiMwMDAwMDAiIGZhY2U9IlZlcmRhbmEsIHNhbnMtc2VyaWYiIHN0eWxlPSJiYWNr
Z3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiPlRoaXMgZW1haWwgYW5kIGFueSBmaWxlcyB0
cmFuc21pdHRlZCB3aXRoIGl0IGFyZSBjb25maWRlbnRpYWwgYW5kIGludGVuZGVkIHNvbGVseSBm
b3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCBvciBlbnRpdHkgdG8gd2hvbSB0aGV5IGFyZSBh
ZGRyZXNzZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IgcGxlYXNl
IG5vdGlmeSB0aGUgc3lzdGVtIG1hbmFnZXIuIFRoaXMgbWVzc2FnZSBjb250YWlucyBjb25maWRl
bnRpYWwgaW5mb3JtYXRpb24gYW5kIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBpbmRpdmlkdWFs
IG5hbWVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgbmFtZWQgYWRkcmVzc2VlIHlvdSBzaG91bGQgbm90
IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlIG9yIGNvcHkgdGhpcyBlLW1haWwuIFBsZWFzZSBub3Rp
ZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSBlLW1haWwgaWYgeW91IGhhdmUgcmVjZWl2ZWQg
dGhpcyBlLW1haWwgYnkgbWlzdGFrZSBhbmQgZGVsZXRlIHRoaXMgZS1tYWlsIGZyb20geW91ciBz
eXN0ZW0uIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgeW91IGFyZSBub3Rp
ZmllZCB0aGF0IGRpc2Nsb3NpbmcsIGNvcHlpbmcsIGRpc3RyaWJ1dGluZyBvciB0YWtpbmcgYW55
IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBpbmZvcm1hdGlvbiBp
cyBzdHJpY3RseSBwcm9oaWJpdGVkLjwvZm9udD48L2ZvbnQ+
--===============7964657481664998587==--
