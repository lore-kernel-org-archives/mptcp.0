Content-Type: multipart/mixed; boundary="===============9122335027450289065=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 17:52:40 +0200
Message-ID: <CAKuKrBnERdWt-8mhFbUG6SqT9yA+afD02VZT6w1+xFLVD645vQ@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1804300809340.4562@seskerx-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 566

--===============9122335027450289065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On Mon, Apr 30, 2018 at 5:37 PM, Mat Martineau <
mathew.j.martineau(a)linux.intel.com> wrote:

>
> On Sun, 29 Apr 2018, Matthieu Baerts wrote:
>
> Hi Mat,
>>
>> Thank you for your review and input!
>>
>> On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <
>> mathew.j.martineau(a)linux.intel.com> wrote:
>>
>>       Hi Matthieu -
>>
>>       On Fri, 27 Apr 2018, Matthieu Baerts wrote:
>>
>>             Hello,
>>
>>             Following yesterday's discussion about NetDev 0x12, here is a
>> proposition of mail to send to NetDev committee. I
>>             already put some comments. Note that I have followed the
>> submission guidelines from:
>>             https://www.netdevconf.org/0x12/submit-proposal.html#proposa
>> ls
>>
>>             Please comment it before Monday morning. Sorry for the rush
>> but the deadline is the 1st of May :)
>>
>>                   * Name(s) of the submitter(s): Christoph Paasch
>> (Apple), Mat Martineau
>>
>>             (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and
>> myself, Matthieu Baerts (Tessares)
>>
>>             I wrote down the names of people who participated in the
>> discussion in the ML and during the weekly meetings. I can
>>             add more people if more people would like to join the
>> preparation and presentation of this tutorial.
>>             @Christoph, Mat, Peter, Ossama: can I write your names there?
>>
>>
>>       Ossama won't be able to attend. It looks like most sessions have 1
>> or 2 presenters, so I don't know if 4 is too many. I'm sure
>>       they'll give us some feedback if they want to limit the number of
>> presenters.
>>
>>
>> OK thank you!
>> Yes indeed, I am sure they will say something if we are too many.
>>
>>                   * Title of the submission: MPTCP: from the basic to an
>> upstreamable base
>>
>>
>>             We certainly need a better title, please comment!
>>
>>
>>       "Multipath TCP: Present Use Cases and an Upstream Future" ?
>>
>>
>> I was trying to find something that catch the attention but it is maybe
>> not needed for these kind of presentation.
>>
>>             > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
>>
>>             "hands-on" seems to be the correct one according to the
>> Submission Types.
>>             https://www.netdevconf.org/0x12/submit-proposal.html#types
>>
>>
>>       It's a little bit of "nuts & bolts" too, but I agree that hands-on
>> is the better match.
>>
>>
>> Thank you!
>>
>>                   * Submission type (one of talk, presentation,
>> workshop): tutorial,
>>
>>             instructor-led sessions (minimum 1 hour long and not to
>> exceed 1.5 hours. The instructor will go over the technology
>>             either through code review or execution and interact with the
>> attendees.)
>>
>>             I guess there is a typo here: presentation should be replaced
>> by tutorial in the guidelines.
>>
>>                   Estimate of length of time for presentation: 1h
>>
>>
>>             That's what we agreed yesterday but I can change.
>>
>>                   Affiliations of submitters (needed for conflict of
>> interest check): Apple,
>>
>>             Intel, Tessares
>>
>>                   Description of proposal:
>>                       A project to add an implementation of the MultiPath
>> TCP protocol to the
>>
>>             Linux kernel is in progress by a small community. The goal of
>> this tutorial is to discover what is this TCP extension
>>             (RFC 6824), what are the different use-cases already in
>> production by some companies and what are the challenges to
>>             upstream MPTCP. We hope having interactive discussions and
>> getting feedback from experienced developers will help us
>>             in this task of easily bringing MPTCP to all Linux users, a
>> technology already used by millions of people.
>>
>>
>>                       In a bit more detail, we will start with a basic
>> introduction of MPTCP.
>>
>>             A few use-cases will be presented with a demo to explain how
>> useful this protocol is in today's Internet and how it
>>             can be extended with API's like Netlink and BPF.
>>
>>
>>       I recognize how Netlink is associated with a userspace path
>> manager, but what's the BPF extensibility you're referring to?
>>
>>
>> It was only to mention that it would be possible to extend MPTCP with
>> eBPF.
>> Even if it is not already available in the current Open-Source
>> implementation, there is already the possibility to get a version with a
>> programmable scheduler: https://progmp.net
>>
>
> If we don't have something specific to our effort with BPF, I'm not sure
> it belongs in the summary. But I don't have a strong opinion about it.


We are saying that "the [Open-Source] implementation can currently be
extended with netlink and BPF". It can come later :)

            Then we will have some explanations about how MPTCP is
>> currently implemented. This current implementation is quite
>>             intrusive and that is certainly not something we would like
>> to have upstream. We would like to express what we have
>>             in mind to change that, with some samples and initiate
>> discussions.
>>
>>
>>       My edit of the above:
>>
>>       """
>>
>>       A community project is underway to add Multipath TCP to the
>> upstream Linux kernel. This tutorial will introduce the audience to
>>       this TCP extension (RFC 6824), show some use cases already in
>> production, and discuss the challenges in converging on an upstream
>>       MPTCP implementation.
>>
>>
>> Should we insist on the "discussion" part? Like saying: "discuss with the
>> audience"? "have interactive discussions"?
>> It is maybe not needed but it was mainly to express the interactivity, it
>> is a tutorial, not just a "simple" presentation.
>>
>
> I think it's ok to mention that - while I left the word "discuss" in there
> for that reason, maybe that's not obvious or clear enough.
>

It was maybe me, maybe no need to insist :-)

      We will use the current MPTCP implementation to demonstrate the
>> utility of the protocol on today's internet, and to show how this
>>       implementation can currently be extended with netlink and BPF. This
>> not only has practical application for deploying MPTCP now,
>>       but also illustrates how the APIs and code will need to evolve in
>> order to properly coexist with the optimized Linux TCP core we
>>       all rely on. We will discuss our ideas for bringing MPTCP to the
>> upstream kernel so the technology is available to all Linux
>>       users.
>>
>>
>> To "attract" people, should we mention that the current implementation is
>> already used by millions of users?
>> I like how your improve the last bit :-)
>>
>
> Sure. I liked that in your text, but ran out of time figuring out how to
> fit it in to the last sentence :)
>

Could we simply say:

We will use the current MPTCP implementation to demonstrate the utility of
the protocol already used by millions of users on today's Internet

or:

and to show how this implementation - already used by millions of users -
can currently be extended with Netlink and BPF.

>
>
>>       """
>>
>>       Feel free to edit/merge/expand/discard as needed :)
>>
>>
>> Thank you for your edit, it is indeed cleaner!
>>
>>                       For more information about this project:
>>
>>             https://github.com/multipath-tcp/mptcp_net-next/wiki
>>
>>
>> I guess I can keep this, right?
>>
>
> Yes, that was my intent.
>

Will do!

Thank you!

Matthieu



>
> Thanks,
>
> Mat
>
>
>
>
>>             Please feel free to comment this as well. We are still far
>> from the max 350 words limit we found last time. But on
>>             the other hand, I can no longer find this limit on their
>> website :)
>>
>>
>>       Hope the above is helpful. Thanks again for your work on this
>> proposal.
>>
>>
>> Yes it is, thank you for your help!
>>
>> Matthieu
>>
>>
>>
>>       Mat
>>
>>
>>
>>             Thank you for your help!
>>
>>             Have a good day/evening,
>>             Matthieu
>>
>>             On 25/04/2018 21:58, Mat Martineau wrote:
>>
>>                   Hi Matthieu -
>>
>>                   On Fri, 20 Apr 2018, Matthieu Baerts wrote:
>>
>>                         Hello,
>>
>>
>>                         NetDev 0x12 is coming to Montr=C3=A9al this summ=
er:
>> July 11th to 13th, 2018.
>>
>>
>>                         We already talked about this event on this ML and
>> at our weekly meetings but here is a
>>                         summary of the discussions we had:
>>
>>                          - we would like to have a presentation there
>> mainly to get feedback and advice from other
>>                         kernel developers
>>                          - a presentation would clearly indicate that
>> this MPTCP Upstream project exists and we could
>>                         get help from more developers
>>                          - we would like to indicate that having MPTCP
>> upstream is asked by different companies, some
>>                         are even ready to contribute ; it is then
>> important to have MPTCP upstream
>>
>>
>>                         Also note that:
>>
>>                          - David Miller will not be present in Montr=C3=
=A9al
>> [1] but other main contributors should be
>>                         there (we don't have a list)
>>
>>
>>                   Side note, in the past day David reiterated his
>> statement about not attending or supporting the
>>                   conference:
>>
>>                   https://marc.info/?l=3Dlinux-netdev&m=3D15246682720330=
1&w=3D2
>>
>>                          - A presentation by Octavian Purdila about
>> "MPTCP Upstreaming" has already been given in
>>                         2015 (NetDev 0.1) [2]
>>                          - 3 types of presentation are available: talks,
>> tutorials and workshops [3]
>>                          - Call for Presentation Proposals closes on May
>> 1st, 2018.
>>
>>
>>                         The current idea we briefly discussed during our
>> weekly meetings is to give a tutorial:
>>
>>                          - It is not useful to give almost the same
>> presentation as the one of Octavian
>>                          - It will allow us more flexibility somehow to
>> explain what is MPTCP, the different
>>                         use-cases, why it is important to have it
>> upstream and what problems we are currently facing.
>>                          - David Miller and many other kernel developers
>> will go to LPC in November: a good place to
>>                         give a talk this time.
>>
>>
>>                         Do you have any ideas on what we could show in
>> this tutorial?
>>
>>
>>                         I recently discussed with my colleague Olivier
>> Bonaventure who has a lot of experiences in
>>                         giving different introductions and more about
>> MPTCP and here is what he suggests:
>>
>>                          - A first part about a basic introduction of
>> MPTCP
>>                          - Indicate different use-cases -- if possible
>> with a "closed demo" to be sure it is working
>>                         -- asking people to setup something is not easy
>> in 1h, max 1h30.
>>
>>
>>                    From the description at [3], either "instructor-led"
>> 60-90 minute tutorials or "student-participation"
>>                   2-3 hour sessions are possible. The closed demo maps
>> well to their "instructor-led" category. Looking at
>>                   the schedule, the past two Netdev Conferences have had
>> one tutorial each, of 60-70 minutes. I think it
>>                   helps to be closer to an hour in length to hold the
>> audience's attention.
>>
>>                          - Then trying to have interactive discussions or
>> explanations about how MPTCP is currently
>>                         implemented or should be implemented if it goes
>> upstream, e.g.: for MPTCP, we need to have
>>                         extra TCP Options, we need to support
>> middleboxes, we need to link subflows of the same
>>                         connection together, we need a scheduler, a PM,
>> etc.
>>
>>
>>                   It's difficult to predict how interactive an audience
>> will be. I've only attended one Netdev Conference,
>>                   and it seemed like there were a lot more people with
>> expertise and interest in drivers, lower layers
>>                   (XDP, BPF, TC, netfilter), and network
>> topology/simulation. Discussion around middlebox support and the
>>                   userspace API might have more audience interaction. If
>> we want to drive a discussion, we could try to
>>                   strike a balance between topics for the broader
>> audience and those with more knowledge of TCP internals.
>>                   (Hopefully some TCP internals people are still planning
>> to attend)
>>
>>                          - Of course, we should focus our discussions on
>> the upstreaming aspect, e.g. reducing the
>>                         footprint of MPTCP in the current TCP stack: what
>> are we allow to do, what not. It is linked
>>                         to many previous discussions we had on this ML,
>> e.g. why we need more indirect function calls
>>                         and how to reduce the impact, etc.
>>
>>
>>                   The previous talk ([2]) had a section like this. I
>> haven't watched it recently, I should look at it again
>>                   to see what kind of questions the audience was asking.
>> As you mentioned above we should be careful to
>>                   have new content compared to the previous session.
>>
>>                          - If we have time, we could discuss about how
>> users could interact with MPTCP: enable it per
>>                         connection, control the path manager, maybe the
>> scheduler, etc.
>>
>>
>>                         What do you think about this? Feel free to
>> comment and even propose completely different
>>                         ideas!
>>
>>
>>                   Thank you for outlining these ideas. I see that this
>> topic is on our meeting agenda so it will be good to
>>                   discuss the tutorial there.
>>
>>
>>                         [1] https://lists.01.org/pipermail
>> /mptcp/2018-March/000379.html
>>                         [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>>                         [3] https://www.netdevconf.org/0x1
>> 2/submit-proposal.html
>>
>
> --
> Mat Martineau
> Intel OTC
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

--===============9122335027450289065==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgTWF0LDxicj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48
YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgQXByIDMwLCAyMDE4IGF0IDU6Mzcg
UE0sIE1hdCBNYXJ0aW5lYXUgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWF0
aGV3LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdGhldy5q
Lm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgY2xhc3M9IkhPRW5a
YiI+PGRpdiBjbGFzcz0iaDUiPjxicj4KT24gU3VuLCAyOSBBcHIgMjAxOCwgTWF0dGhpZXUgQmFl
cnRzIHdyb3RlOjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KSGkgTWF0LDxicj4KPGJyPgpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IGFuZCBp
bnB1dCE8YnI+Cjxicj4KT24gU2F0LCBBcHIgMjgsIDIwMTggYXQgMjo0NCBBTSwgTWF0IE1hcnRp
bmVhdSAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5j
b20iIHRhcmdldD0iX2JsYW5rIj5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZTx3YnI+bC5j
b208L2E+Jmd0OyB3cm90ZTo8YnI+Cjxicj4KwqAgwqAgwqAgSGkgTWF0dGhpZXUgLTxicj4KPGJy
PgrCoCDCoCDCoCBPbiBGcmksIDI3IEFwciAyMDE4LCBNYXR0aGlldSBCYWVydHMgd3JvdGU6PGJy
Pgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIEhlbGxvLDxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDC
oCBGb2xsb3dpbmcgeWVzdGVyZGF5JiMzOTtzIGRpc2N1c3Npb24gYWJvdXQgTmV0RGV2IDB4MTIs
IGhlcmUgaXMgYSBwcm9wb3NpdGlvbiBvZiBtYWlsIHRvIHNlbmQgdG8gTmV0RGV2IGNvbW1pdHRl
ZS4gSTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgYWxyZWFkeSBwdXQgc29tZSBjb21tZW50cy4gTm90
ZSB0aGF0IEkgaGF2ZSBmb2xsb3dlZCB0aGUgc3VibWlzc2lvbiBndWlkZWxpbmVzIGZyb206PGJy
PgrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy8w
eDEyL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3Byb3Bvc2FscyIgcmVsPSJub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdicj4yL3N1Ym1pdC1w
cm9wb3NhbC5odG1sI3Byb3Bvc2E8d2JyPmxzPC9hPjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDC
oCBQbGVhc2UgY29tbWVudCBpdCBiZWZvcmUgTW9uZGF5IG1vcm5pbmcuIFNvcnJ5IGZvciB0aGUg
cnVzaCBidXQgdGhlIGRlYWRsaW5lIGlzIHRoZSAxc3Qgb2YgTWF5IDopPGJyPgo8YnI+CsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICogTmFtZShzKSBvZiB0aGUgc3VibWl0dGVyKHMpOiBDaHJp
c3RvcGggUGFhc2NoIChBcHBsZSksIE1hdCBNYXJ0aW5lYXU8YnI+Cjxicj4KwqAgwqAgwqAgwqAg
wqAgwqAgKEludGVsKSwgUGV0ZXIgS3J5c3RhZCAoSW50ZWwpLCBPc3NhbWEgT3RobWFuIChJbnRl
bCkgYW5kIG15c2VsZiwgTWF0dGhpZXUgQmFlcnRzIChUZXNzYXJlcyk8YnI+Cjxicj4KwqAgwqAg
wqAgwqAgwqAgwqAgSSB3cm90ZSBkb3duIHRoZSBuYW1lcyBvZiBwZW9wbGUgd2hvIHBhcnRpY2lw
YXRlZCBpbiB0aGUgZGlzY3Vzc2lvbiBpbiB0aGUgTUwgYW5kIGR1cmluZyB0aGUgd2Vla2x5IG1l
ZXRpbmdzLiBJIGNhbjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgYWRkIG1vcmUgcGVvcGxlIGlmIG1v
cmUgcGVvcGxlIHdvdWxkIGxpa2UgdG8gam9pbiB0aGUgcHJlcGFyYXRpb24gYW5kIHByZXNlbnRh
dGlvbiBvZiB0aGlzIHR1dG9yaWFsLjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgQENocmlzdG9waCwg
TWF0LCBQZXRlciwgT3NzYW1hOiBjYW4gSSB3cml0ZSB5b3VyIG5hbWVzIHRoZXJlPzxicj4KPGJy
Pgo8YnI+CsKgIMKgIMKgIE9zc2FtYSB3b24mIzM5O3QgYmUgYWJsZSB0byBhdHRlbmQuIEl0IGxv
b2tzIGxpa2UgbW9zdCBzZXNzaW9ucyBoYXZlIDEgb3IgMiBwcmVzZW50ZXJzLCBzbyBJIGRvbiYj
Mzk7dCBrbm93IGlmIDQgaXMgdG9vIG1hbnkuIEkmIzM5O20gc3VyZTxicj4KwqAgwqAgwqAgdGhl
eSYjMzk7bGwgZ2l2ZSB1cyBzb21lIGZlZWRiYWNrIGlmIHRoZXkgd2FudCB0byBsaW1pdCB0aGUg
bnVtYmVyIG9mIHByZXNlbnRlcnMuPGJyPgo8YnI+Cjxicj4KT0sgdGhhbmsgeW91ITxicj4KWWVz
IGluZGVlZCwgSSBhbSBzdXJlIHRoZXkgd2lsbCBzYXkgc29tZXRoaW5nIGlmIHdlIGFyZSB0b28g
bWFueS48YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBUaXRsZSBvZiB0aGUg
c3VibWlzc2lvbjogTVBUQ1A6IGZyb20gdGhlIGJhc2ljIHRvIGFuIHVwc3RyZWFtYWJsZSBiYXNl
PGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgV2UgY2VydGFpbmx5IG5lZWQgYSBiZXR0
ZXIgdGl0bGUsIHBsZWFzZSBjb21tZW50ITxicj4KPGJyPgo8YnI+CsKgIMKgIMKgICZxdW90O011
bHRpcGF0aCBUQ1A6IFByZXNlbnQgVXNlIENhc2VzIGFuZCBhbiBVcHN0cmVhbSBGdXR1cmUmcXVv
dDsgPzxicj4KPGJyPgo8YnI+Ckkgd2FzIHRyeWluZyB0byBmaW5kIHNvbWV0aGluZyB0aGF0IGNh
dGNoIHRoZSBhdHRlbnRpb24gYnV0IGl0IGlzIG1heWJlIG5vdCBuZWVkZWQgZm9yIHRoZXNlIGtp
bmQgb2YgcHJlc2VudGF0aW9uLjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7ICogTGFi
ZWwgKG9uZSBvZiBtb29uc2hvdCwgbnV0cyYjMzk7biBib2x0cywgaGFuZHMtb24pOiBoYW5kcy1v
bjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtoYW5kcy1vbiZxdW90OyBzZWVtcyB0
byBiZSB0aGUgY29ycmVjdCBvbmUgYWNjb3JkaW5nIHRvIHRoZSBTdWJtaXNzaW9uIFR5cGVzLjxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgPGEgaHJlZj0iaHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcv
MHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCN0eXBlcyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdicj4yL3N1Ym1pdC1wcm9w
b3NhbC5odG1sI3R5cGVzPC9hPjxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIEl0JiMzOTtzIGEgbGl0
dGxlIGJpdCBvZiAmcXVvdDtudXRzICZhbXA7IGJvbHRzJnF1b3Q7IHRvbywgYnV0IEkgYWdyZWUg
dGhhdCBoYW5kcy1vbiBpcyB0aGUgYmV0dGVyIG1hdGNoLjxicj4KPGJyPgo8YnI+ClRoYW5rIHlv
dSE8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBTdWJtaXNzaW9uIHR5cGUg
KG9uZSBvZiB0YWxrLCBwcmVzZW50YXRpb24sIHdvcmtzaG9wKTogdHV0b3JpYWwsPGJyPgo8YnI+
CsKgIMKgIMKgIMKgIMKgIMKgIGluc3RydWN0b3ItbGVkIHNlc3Npb25zIChtaW5pbXVtIDEgaG91
ciBsb25nIGFuZCBub3QgdG8gZXhjZWVkIDEuNSBob3Vycy4gVGhlIGluc3RydWN0b3Igd2lsbCBn
byBvdmVyIHRoZSB0ZWNobm9sb2d5PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCBlaXRoZXIgdGhyb3Vn
aCBjb2RlIHJldmlldyBvciBleGVjdXRpb24gYW5kIGludGVyYWN0IHdpdGggdGhlIGF0dGVuZGVl
cy4pPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIEkgZ3Vlc3MgdGhlcmUgaXMgYSB0eXBvIGhl
cmU6IHByZXNlbnRhdGlvbiBzaG91bGQgYmUgcmVwbGFjZWQgYnkgdHV0b3JpYWwgaW4gdGhlIGd1
aWRlbGluZXMuPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVzdGltYXRlIG9m
IGxlbmd0aCBvZiB0aW1lIGZvciBwcmVzZW50YXRpb246IDFoPGJyPgo8YnI+Cjxicj4KwqAgwqAg
wqAgwqAgwqAgwqAgVGhhdCYjMzk7cyB3aGF0IHdlIGFncmVlZCB5ZXN0ZXJkYXkgYnV0IEkgY2Fu
IGNoYW5nZS48YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQWZmaWxpYXRpb25z
IG9mIHN1Ym1pdHRlcnMgKG5lZWRlZCBmb3IgY29uZmxpY3Qgb2YgaW50ZXJlc3QgY2hlY2spOiBB
cHBsZSw8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgSW50ZWwsIFRlc3NhcmVzPGJyPgo8YnI+
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERlc2NyaXB0aW9uIG9mIHByb3Bvc2FsOjxicj4K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQSBwcm9qZWN0IHRvIGFkZCBhbiBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGUgTXVsdGlQYXRoIFRDUCBwcm90b2NvbCB0byB0aGU8YnI+Cjxicj4K
wqAgwqAgwqAgwqAgwqAgwqAgTGludXgga2VybmVsIGlzIGluIHByb2dyZXNzIGJ5IGEgc21hbGwg
Y29tbXVuaXR5LiBUaGUgZ29hbCBvZiB0aGlzIHR1dG9yaWFsIGlzIHRvIGRpc2NvdmVyIHdoYXQg
aXMgdGhpcyBUQ1AgZXh0ZW5zaW9uPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCAoUkZDIDY4MjQpLCB3
aGF0IGFyZSB0aGUgZGlmZmVyZW50IHVzZS1jYXNlcyBhbHJlYWR5IGluIHByb2R1Y3Rpb24gYnkg
c29tZSBjb21wYW5pZXMgYW5kIHdoYXQgYXJlIHRoZSBjaGFsbGVuZ2VzIHRvPGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCB1cHN0cmVhbSBNUFRDUC4gV2UgaG9wZSBoYXZpbmcgaW50ZXJhY3RpdmUgZGlz
Y3Vzc2lvbnMgYW5kIGdldHRpbmcgZmVlZGJhY2sgZnJvbSBleHBlcmllbmNlZCBkZXZlbG9wZXJz
IHdpbGwgaGVscCB1czxicj4KwqAgwqAgwqAgwqAgwqAgwqAgaW4gdGhpcyB0YXNrIG9mIGVhc2ls
eSBicmluZ2luZyBNUFRDUCB0byBhbGwgTGludXggdXNlcnMsIGEgdGVjaG5vbG9neSBhbHJlYWR5
IHVzZWQgYnkgbWlsbGlvbnMgb2YgcGVvcGxlLjxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIEluIGEgYml0IG1vcmUgZGV0YWlsLCB3ZSB3aWxsIHN0YXJ0IHdp
dGggYSBiYXNpYyBpbnRyb2R1Y3Rpb24gb2YgTVBUQ1AuPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIEEgZmV3IHVzZS1jYXNlcyB3aWxsIGJlIHByZXNlbnRlZCB3aXRoIGEgZGVtbyB0byBleHBs
YWluIGhvdyB1c2VmdWwgdGhpcyBwcm90b2NvbCBpcyBpbiB0b2RheSYjMzk7cyBJbnRlcm5ldCBh
bmQgaG93IGl0PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCBjYW4gYmUgZXh0ZW5kZWQgd2l0aCBBUEkm
IzM5O3MgbGlrZSBOZXRsaW5rIGFuZCBCUEYuPGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgSSByZWNv
Z25pemUgaG93IE5ldGxpbmsgaXMgYXNzb2NpYXRlZCB3aXRoIGEgdXNlcnNwYWNlIHBhdGggbWFu
YWdlciwgYnV0IHdoYXQmIzM5O3MgdGhlIEJQRiBleHRlbnNpYmlsaXR5IHlvdSYjMzk7cmUgcmVm
ZXJyaW5nIHRvPzxicj4KPGJyPgo8YnI+Ckl0IHdhcyBvbmx5IHRvIG1lbnRpb24gdGhhdCBpdCB3
b3VsZCBiZSBwb3NzaWJsZSB0byBleHRlbmQgTVBUQ1Agd2l0aCBlQlBGLjxicj4KRXZlbiBpZiBp
dCBpcyBub3QgYWxyZWFkeSBhdmFpbGFibGUgaW4gdGhlIGN1cnJlbnQgT3Blbi1Tb3VyY2UgaW1w
bGVtZW50YXRpb24sIHRoZXJlIGlzIGFscmVhZHkgdGhlIHBvc3NpYmlsaXR5IHRvIGdldCBhIHZl
cnNpb24gd2l0aCBhPGJyPgpwcm9ncmFtbWFibGUgc2NoZWR1bGVyOiA8YSBocmVmPSJodHRwczov
L3Byb2dtcC5uZXQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcHJv
Z21wLm5ldDwvYT48YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PjwvZGl2PgpJZiB3ZSBkb24m
IzM5O3QgaGF2ZSBzb21ldGhpbmcgc3BlY2lmaWMgdG8gb3VyIGVmZm9ydCB3aXRoIEJQRiwgSSYj
Mzk7bSBub3Qgc3VyZSBpdCBiZWxvbmdzIGluIHRoZSBzdW1tYXJ5LiBCdXQgSSBkb24mIzM5O3Qg
aGF2ZSBhIHN0cm9uZyBvcGluaW9uIGFib3V0IGl0LjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PldlIGFyZSBzYXlpbmcgdGhhdCAmcXVvdDt0aGUgW09wZW4tU291cmNlXSA8c3BhbiBj
bGFzcz0iZ21haWwtIj4gaW1wbGVtZW50YXRpb24gY2FuIGN1cnJlbnRseSBiZSBleHRlbmRlZCB3
aXRoIG5ldGxpbmsgYW5kIEJQRiZxdW90Oy4gSXQgY2FuIGNvbWUgbGF0ZXIgOik8L3NwYW4+PC9k
aXY+PGRpdj48c3BhbiBjbGFzcz0iZ21haWwtIj48L3NwYW4+PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxzcGFuIGNsYXNzPSIiPgo8YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCsKgIMKgIMKgIMKgIMKgIMKg
IFRoZW4gd2Ugd2lsbCBoYXZlIHNvbWUgZXhwbGFuYXRpb25zIGFib3V0IGhvdyBNUFRDUCBpcyBj
dXJyZW50bHkgaW1wbGVtZW50ZWQuIFRoaXMgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBpcyBxdWl0
ZTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgaW50cnVzaXZlIGFuZCB0aGF0IGlzIGNlcnRhaW5seSBu
b3Qgc29tZXRoaW5nIHdlIHdvdWxkIGxpa2UgdG8gaGF2ZSB1cHN0cmVhbS4gV2Ugd291bGQgbGlr
ZSB0byBleHByZXNzIHdoYXQgd2UgaGF2ZTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgaW4gbWluZCB0
byBjaGFuZ2UgdGhhdCwgd2l0aCBzb21lIHNhbXBsZXMgYW5kIGluaXRpYXRlIGRpc2N1c3Npb25z
Ljxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIE15IGVkaXQgb2YgdGhlIGFib3ZlOjxicj4KPGJyPgrC
oCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+Cjxicj4KwqAgwqAgwqAgQSBjb21tdW5pdHkg
cHJvamVjdCBpcyB1bmRlcndheSB0byBhZGQgTXVsdGlwYXRoIFRDUCB0byB0aGUgdXBzdHJlYW0g
TGludXgga2VybmVsLiBUaGlzIHR1dG9yaWFsIHdpbGwgaW50cm9kdWNlIHRoZSBhdWRpZW5jZSB0
bzxicj4KwqAgwqAgwqAgdGhpcyBUQ1AgZXh0ZW5zaW9uIChSRkMgNjgyNCksIHNob3cgc29tZSB1
c2UgY2FzZXMgYWxyZWFkeSBpbiBwcm9kdWN0aW9uLCBhbmQgZGlzY3VzcyB0aGUgY2hhbGxlbmdl
cyBpbiBjb252ZXJnaW5nIG9uIGFuIHVwc3RyZWFtPGJyPgrCoCDCoCDCoCBNUFRDUCBpbXBsZW1l
bnRhdGlvbi48YnI+Cjxicj4KPGJyPgpTaG91bGQgd2UgaW5zaXN0IG9uIHRoZSAmcXVvdDtkaXNj
dXNzaW9uJnF1b3Q7IHBhcnQ/IExpa2Ugc2F5aW5nOiAmcXVvdDtkaXNjdXNzIHdpdGggdGhlIGF1
ZGllbmNlJnF1b3Q7PyAmcXVvdDtoYXZlIGludGVyYWN0aXZlIGRpc2N1c3Npb25zJnF1b3Q7Pzxi
cj4KSXQgaXMgbWF5YmUgbm90IG5lZWRlZCBidXQgaXQgd2FzIG1haW5seSB0byBleHByZXNzIHRo
ZSBpbnRlcmFjdGl2aXR5LCBpdCBpcyBhIHR1dG9yaWFsLCBub3QganVzdCBhICZxdW90O3NpbXBs
ZSZxdW90OyBwcmVzZW50YXRpb24uPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+CkkgdGhp
bmsgaXQmIzM5O3Mgb2sgdG8gbWVudGlvbiB0aGF0IC0gd2hpbGUgSSBsZWZ0IHRoZSB3b3JkICZx
dW90O2Rpc2N1c3MmcXVvdDsgaW4gdGhlcmUgZm9yIHRoYXQgcmVhc29uLCBtYXliZSB0aGF0JiMz
OTtzIG5vdCBvYnZpb3VzIG9yIGNsZWFyIGVub3VnaC48c3BhbiBjbGFzcz0iIj48YnI+PC9zcGFu
PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IHdhcyBtYXliZSBtZSwgbWF5YmUg
bm8gbmVlZCB0byBpbnNpc3QgOi0pPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9IiI+Cgo8YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCsKgIMKgIMKgIFdlIHdpbGwgdXNl
IHRoZSBjdXJyZW50IE1QVENQIGltcGxlbWVudGF0aW9uIHRvIGRlbW9uc3RyYXRlIHRoZSB1dGls
aXR5IG9mIHRoZSBwcm90b2NvbCBvbiB0b2RheSYjMzk7cyBpbnRlcm5ldCwgYW5kIHRvIHNob3cg
aG93IHRoaXM8YnI+CsKgIMKgIMKgIGltcGxlbWVudGF0aW9uIGNhbiBjdXJyZW50bHkgYmUgZXh0
ZW5kZWQgd2l0aCBuZXRsaW5rIGFuZCBCUEYuIFRoaXMgbm90IG9ubHkgaGFzIHByYWN0aWNhbCBh
cHBsaWNhdGlvbiBmb3IgZGVwbG95aW5nIE1QVENQIG5vdyw8YnI+CsKgIMKgIMKgIGJ1dCBhbHNv
IGlsbHVzdHJhdGVzIGhvdyB0aGUgQVBJcyBhbmQgY29kZSB3aWxsIG5lZWQgdG8gZXZvbHZlIGlu
IG9yZGVyIHRvIHByb3Blcmx5IGNvZXhpc3Qgd2l0aCB0aGUgb3B0aW1pemVkIExpbnV4IFRDUCBj
b3JlIHdlPGJyPgrCoCDCoCDCoCBhbGwgcmVseSBvbi4gV2Ugd2lsbCBkaXNjdXNzIG91ciBpZGVh
cyBmb3IgYnJpbmdpbmcgTVBUQ1AgdG8gdGhlIHVwc3RyZWFtIGtlcm5lbCBzbyB0aGUgdGVjaG5v
bG9neSBpcyBhdmFpbGFibGUgdG8gYWxsIExpbnV4PGJyPgrCoCDCoCDCoCB1c2Vycy48YnI+Cjxi
cj4KPGJyPgpUbyAmcXVvdDthdHRyYWN0JnF1b3Q7IHBlb3BsZSwgc2hvdWxkIHdlIG1lbnRpb24g
dGhhdCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBpcyBhbHJlYWR5IHVzZWQgYnkgbWlsbGlv
bnMgb2YgdXNlcnM/PGJyPgpJIGxpa2UgaG93IHlvdXIgaW1wcm92ZSB0aGUgbGFzdCBiaXQgOi0p
PGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+ClN1cmUuIEkgbGlrZWQgdGhhdCBpbiB5b3Vy
IHRleHQsIGJ1dCByYW4gb3V0IG9mIHRpbWUgZmlndXJpbmcgb3V0IGhvdyB0byBmaXQgaXQgaW4g
dG8gdGhlIGxhc3Qgc2VudGVuY2UgOik8c3BhbiBjbGFzcz0iIj48YnI+PC9zcGFuPjwvYmxvY2tx
dW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkNvdWxkIHdlIHNpbXBseSBzYXk6PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luLWxlZnQ6NDBweCI+IDxzcGFuIGNsYXNzPSJnbWFp
bC0iPiBXZSB3aWxsIHVzZSB0aGUgY3VycmVudCBNUFRDUCBpbXBsZW1lbnRhdGlvbiB0byAKZGVt
b25zdHJhdGUgdGhlIHV0aWxpdHkgb2YgdGhlIHByb3RvY29sIGFscmVhZHkgdXNlZCBieSBtaWxs
aW9ucyBvZiB1c2VycyBvbiB0b2RheSYjMzk7cyBJbnRlcm5ldDwvc3Bhbj48L2Rpdj48c3BhbiBj
bGFzcz0iZ21haWwtIj48YnI+PC9zcGFuPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48
c3BhbiBjbGFzcz0iZ21haWwtIj5vcjo8L3NwYW4+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxzcGFuIGNsYXNzPSJnbWFpbC0iPjxicj48L3NwYW4+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXYgc3R5bGU9Im1hcmdpbi1sZWZ0OjQwcHgiPjxzcGFuIGNsYXNzPSJnbWFp
bC0iPmFuZCB0byBzaG93CiBob3cgdGhpcyBpbXBsZW1lbnRhdGlvbiAtIGFscmVhZHkgdXNlZCBi
eSBtaWxsaW9ucyBvZiB1c2VycyAtIGNhbiBjdXJyZW50bHkgYmUgZXh0ZW5kZWQgd2l0aCBOZXRs
aW5rIGFuZCBCUEYuPC9zcGFuPjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0iIj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgrCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVv
dDs8YnI+Cjxicj4KwqAgwqAgwqAgRmVlbCBmcmVlIHRvIGVkaXQvbWVyZ2UvZXhwYW5kL2Rpc2Nh
cmQgYXMgbmVlZGVkIDopPGJyPgo8YnI+Cjxicj4KVGhhbmsgeW91IGZvciB5b3VyIGVkaXQsIGl0
IGlzIGluZGVlZCBjbGVhbmVyITxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBGb3IgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGlzIHByb2plY3Q6PGJyPgo8YnI+CsKg
IMKgIMKgIMKgIMKgIMKgIDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNw
L21wdGNwX25ldC1uZXh0L3dpa2kiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0
dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdDx3YnI+Y3AvbXB0Y3BfbmV0LW5leHQvd2lraTwv
YT48YnI+Cjxicj4KPGJyPgpJIGd1ZXNzIEkgY2FuIGtlZXAgdGhpcywgcmlnaHQ/PGJyPgo8L2Js
b2NrcXVvdGU+Cjxicj48L3NwYW4+ClllcywgdGhhdCB3YXMgbXkgaW50ZW50Ljxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XaWxsIGRvITwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+VGhhbmsgeW91ITwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TWF0dGhpZXU8L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij4KPGJyPgo8YnI+ClRoYW5rcyw8YnI+Cjxicj4KTWF0PGRpdiBjbGFzcz0i
SE9FblpiIj48ZGl2IGNsYXNzPSJoNSI+PGJyPgo8YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgUGxlYXNl
IGZlZWwgZnJlZSB0byBjb21tZW50IHRoaXMgYXMgd2VsbC4gV2UgYXJlIHN0aWxsIGZhciBmcm9t
IHRoZSBtYXggMzUwIHdvcmRzIGxpbWl0IHdlIGZvdW5kIGxhc3QgdGltZS4gQnV0IG9uPGJyPgrC
oCDCoCDCoCDCoCDCoCDCoCB0aGUgb3RoZXIgaGFuZCwgSSBjYW4gbm8gbG9uZ2VyIGZpbmQgdGhp
cyBsaW1pdCBvbiB0aGVpciB3ZWJzaXRlIDopPGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgSG9wZSB0
aGUgYWJvdmUgaXMgaGVscGZ1bC4gVGhhbmtzIGFnYWluIGZvciB5b3VyIHdvcmsgb24gdGhpcyBw
cm9wb3NhbC48YnI+Cjxicj4KPGJyPgpZZXMgaXQgaXMsIHRoYW5rIHlvdSBmb3IgeW91ciBoZWxw
ITxicj4KPGJyPgpNYXR0aGlldTxicj4KPGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgTWF0PGJyPgo8
YnI+Cjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCBUaGFuayB5b3UgZm9yIHlvdXIgaGVscCE8
YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgSGF2ZSBhIGdvb2QgZGF5L2V2ZW5pbmcsPGJyPgrC
oCDCoCDCoCDCoCDCoCDCoCBNYXR0aGlldTxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCBPbiAy
NS8wNC8yMDE4IDIxOjU4LCBNYXQgTWFydGluZWF1IHdyb3RlOjxicj4KPGJyPgrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBIaSBNYXR0aGlldSAtPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE9uIEZyaSwgMjAgQXByIDIwMTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+
Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSGVsbG8sPGJyPgo8YnI+
Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmV0RGV2IDB4MTIgaXMg
Y29taW5nIHRvIE1vbnRyw6lhbCB0aGlzIHN1bW1lcjogSnVseSAxMXRoIHRvIDEzdGgsIDIwMTgu
PGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgV2UgYWxy
ZWFkeSB0YWxrZWQgYWJvdXQgdGhpcyBldmVudCBvbiB0aGlzIE1MIGFuZCBhdCBvdXIgd2Vla2x5
IG1lZXRpbmdzIGJ1dCBoZXJlIGlzIGE8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHN1bW1hcnkgb2YgdGhlIGRpc2N1c3Npb25zIHdlIGhhZDo8YnI+Cjxicj4KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtIHdlIHdvdWxkIGxpa2UgdG8gaGF2ZSBh
IHByZXNlbnRhdGlvbiB0aGVyZSBtYWlubHkgdG8gZ2V0IGZlZWRiYWNrIGFuZCBhZHZpY2UgZnJv
bSBvdGhlcjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAga2VybmVsIGRl
dmVsb3BlcnM8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBhIHBy
ZXNlbnRhdGlvbiB3b3VsZCBjbGVhcmx5IGluZGljYXRlIHRoYXQgdGhpcyBNUFRDUCBVcHN0cmVh
bSBwcm9qZWN0IGV4aXN0cyBhbmQgd2UgY291bGQ8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGdldCBoZWxwIGZyb20gbW9yZSBkZXZlbG9wZXJzPGJyPgrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gd2Ugd291bGQgbGlrZSB0byBpbmRpY2F0ZSB0
aGF0IGhhdmluZyBNUFRDUCB1cHN0cmVhbSBpcyBhc2tlZCBieSBkaWZmZXJlbnQgY29tcGFuaWVz
LCBzb21lPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhcmUgZXZlbiBy
ZWFkeSB0byBjb250cmlidXRlIDsgaXQgaXMgdGhlbiBpbXBvcnRhbnQgdG8gaGF2ZSBNUFRDUCB1
cHN0cmVhbTxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IEFsc28gbm90ZSB0aGF0Ojxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC0gRGF2aWQgTWlsbGVyIHdpbGwgbm90IGJlIHByZXNlbnQgaW4gTW9udHLDqWFsIFsx
XSBidXQgb3RoZXIgbWFpbiBjb250cmlidXRvcnMgc2hvdWxkIGJlPGJyPgrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aGVyZSAod2UgZG9uJiMzOTt0IGhhdmUgYSBsaXN0KTxi
cj4KPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNpZGUgbm90ZSwgaW4gdGhl
IHBhc3QgZGF5IERhdmlkIHJlaXRlcmF0ZWQgaGlzIHN0YXRlbWVudCBhYm91dCBub3QgYXR0ZW5k
aW5nIG9yIHN1cHBvcnRpbmcgdGhlPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25m
ZXJlbmNlOjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRw
czovL21hcmMuaW5mby8/bD1saW51eC1uZXRkZXYmYW1wO209MTUyNDY2ODI3MjAzMzAxJmFtcDt3
PTIiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbWFyYy5pbmZvLz9s
PWxpbnV4LW5ldDx3YnI+ZGV2JmFtcDttPTE1MjQ2NjgyNzIwMzMwMSZhbXA7dz0yPC9hPjxicj4K
PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gQSBwcmVzZW50YXRp
b24gYnkgT2N0YXZpYW4gUHVyZGlsYSBhYm91dCAmcXVvdDtNUFRDUCBVcHN0cmVhbWluZyZxdW90
OyBoYXMgYWxyZWFkeSBiZWVuIGdpdmVuIGluPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAyMDE1IChOZXREZXYgMC4xKSBbMl08YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLSAzIHR5cGVzIG9mIHByZXNlbnRhdGlvbiBhcmUgYXZhaWxhYmxl
OiB0YWxrcywgdHV0b3JpYWxzIGFuZCB3b3Jrc2hvcHMgWzNdPGJyPgrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gQ2FsbCBmb3IgUHJlc2VudGF0aW9uIFByb3Bvc2FscyBj
bG9zZXMgb24gTWF5IDFzdCwgMjAxOC48YnI+Cjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBUaGUgY3VycmVudCBpZGVhIHdlIGJyaWVmbHkgZGlzY3Vzc2VkIGR1
cmluZyBvdXIgd2Vla2x5IG1lZXRpbmdzIGlzIHRvIGdpdmUgYSB0dXRvcmlhbDo8YnI+Cjxicj4K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtIEl0IGlzIG5vdCB1c2VmdWwg
dG8gZ2l2ZSBhbG1vc3QgdGhlIHNhbWUgcHJlc2VudGF0aW9uIGFzIHRoZSBvbmUgb2YgT2N0YXZp
YW48YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBJdCB3aWxsIGFs
bG93IHVzIG1vcmUgZmxleGliaWxpdHkgc29tZWhvdyB0byBleHBsYWluIHdoYXQgaXMgTVBUQ1As
IHRoZSBkaWZmZXJlbnQ8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVz
ZS1jYXNlcywgd2h5IGl0IGlzIGltcG9ydGFudCB0byBoYXZlIGl0IHVwc3RyZWFtIGFuZCB3aGF0
IHByb2JsZW1zIHdlIGFyZSBjdXJyZW50bHkgZmFjaW5nLjxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAtIERhdmlkIE1pbGxlciBhbmQgbWFueSBvdGhlciBrZXJuZWwg
ZGV2ZWxvcGVycyB3aWxsIGdvIHRvIExQQyBpbiBOb3ZlbWJlcjogYSBnb29kIHBsYWNlIHRvPGJy
PgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnaXZlIGEgdGFsayB0aGlzIHRp
bWUuPGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRG8g
eW91IGhhdmUgYW55IGlkZWFzIG9uIHdoYXQgd2UgY291bGQgc2hvdyBpbiB0aGlzIHR1dG9yaWFs
Pzxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEkgcmVj
ZW50bHkgZGlzY3Vzc2VkIHdpdGggbXkgY29sbGVhZ3VlIE9saXZpZXIgQm9uYXZlbnR1cmUgd2hv
IGhhcyBhIGxvdCBvZiBleHBlcmllbmNlcyBpbjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ2l2aW5nIGRpZmZlcmVudCBpbnRyb2R1Y3Rpb25zIGFuZCBtb3JlIGFib3V0
IE1QVENQIGFuZCBoZXJlIGlzIHdoYXQgaGUgc3VnZ2VzdHM6PGJyPgo8YnI+CsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBBIGZpcnN0IHBhcnQgYWJvdXQgYSBiYXNpYyBp
bnRyb2R1Y3Rpb24gb2YgTVBUQ1A8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLSBJbmRpY2F0ZSBkaWZmZXJlbnQgdXNlLWNhc2VzIC0tIGlmIHBvc3NpYmxlIHdpdGgg
YSAmcXVvdDtjbG9zZWQgZGVtbyZxdW90OyB0byBiZSBzdXJlIGl0IGlzIHdvcmtpbmc8YnI+CsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC0tIGFza2luZyBwZW9wbGUgdG8gc2V0
dXAgc29tZXRoaW5nIGlzIG5vdCBlYXN5IGluIDFoLCBtYXggMWgzMC48YnI+Cjxicj4KPGJyPgrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEZyb20gdGhlIGRlc2NyaXB0aW9uIGF0IFszXSwg
ZWl0aGVyICZxdW90O2luc3RydWN0b3ItbGVkJnF1b3Q7IDYwLTkwIG1pbnV0ZSB0dXRvcmlhbHMg
b3IgJnF1b3Q7c3R1ZGVudC1wYXJ0aWNpcGF0aW9uJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAyLTMgaG91ciBzZXNzaW9ucyBhcmUgcG9zc2libGUuIFRoZSBjbG9zZWQgZGVt
byBtYXBzIHdlbGwgdG8gdGhlaXIgJnF1b3Q7aW5zdHJ1Y3Rvci1sZWQmcXVvdDsgY2F0ZWdvcnku
IExvb2tpbmcgYXQ8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRoZSBzY2hlZHVsZSwg
dGhlIHBhc3QgdHdvIE5ldGRldiBDb25mZXJlbmNlcyBoYXZlIGhhZCBvbmUgdHV0b3JpYWwgZWFj
aCwgb2YgNjAtNzAgbWludXRlcy4gSSB0aGluayBpdDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaGVscHMgdG8gYmUgY2xvc2VyIHRvIGFuIGhvdXIgaW4gbGVuZ3RoIHRvIGhvbGQgdGhl
IGF1ZGllbmNlJiMzOTtzIGF0dGVudGlvbi48YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAtIFRoZW4gdHJ5aW5nIHRvIGhhdmUgaW50ZXJhY3RpdmUgZGlzY3Vz
c2lvbnMgb3IgZXhwbGFuYXRpb25zIGFib3V0IGhvdyBNUFRDUCBpcyBjdXJyZW50bHk8YnI+CsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGltcGxlbWVudGVkIG9yIHNob3VsZCBi
ZSBpbXBsZW1lbnRlZCBpZiBpdCBnb2VzIHVwc3RyZWFtLCBlLmcuOiBmb3IgTVBUQ1AsIHdlIG5l
ZWQgdG8gaGF2ZTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXh0cmEg
VENQIE9wdGlvbnMsIHdlIG5lZWQgdG8gc3VwcG9ydCBtaWRkbGVib3hlcywgd2UgbmVlZCB0byBs
aW5rIHN1YmZsb3dzIG9mIHRoZSBzYW1lPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBjb25uZWN0aW9uIHRvZ2V0aGVyLCB3ZSBuZWVkIGEgc2NoZWR1bGVyLCBhIFBNLCBl
dGMuPGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSXQmIzM5O3MgZGlm
ZmljdWx0IHRvIHByZWRpY3QgaG93IGludGVyYWN0aXZlIGFuIGF1ZGllbmNlIHdpbGwgYmUuIEkm
IzM5O3ZlIG9ubHkgYXR0ZW5kZWQgb25lIE5ldGRldiBDb25mZXJlbmNlLDxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYW5kIGl0IHNlZW1lZCBsaWtlIHRoZXJlIHdlcmUgYSBsb3QgbW9y
ZSBwZW9wbGUgd2l0aCBleHBlcnRpc2UgYW5kIGludGVyZXN0IGluIGRyaXZlcnMsIGxvd2VyIGxh
eWVyczxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKFhEUCwgQlBGLCBUQywgbmV0Zmls
dGVyKSwgYW5kIG5ldHdvcmsgdG9wb2xvZ3kvc2ltdWxhdGlvbi4gRGlzY3Vzc2lvbiBhcm91bmQg
bWlkZGxlYm94IHN1cHBvcnQgYW5kIHRoZTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
dXNlcnNwYWNlIEFQSSBtaWdodCBoYXZlIG1vcmUgYXVkaWVuY2UgaW50ZXJhY3Rpb24uIElmIHdl
IHdhbnQgdG8gZHJpdmUgYSBkaXNjdXNzaW9uLCB3ZSBjb3VsZCB0cnkgdG88YnI+CsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHN0cmlrZSBhIGJhbGFuY2UgYmV0d2VlbiB0b3BpY3MgZm9yIHRo
ZSBicm9hZGVyIGF1ZGllbmNlIGFuZCB0aG9zZSB3aXRoIG1vcmUga25vd2xlZGdlIG9mIFRDUCBp
bnRlcm5hbHMuPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoSG9wZWZ1bGx5IHNvbWUg
VENQIGludGVybmFscyBwZW9wbGUgYXJlIHN0aWxsIHBsYW5uaW5nIHRvIGF0dGVuZCk8YnI+Cjxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtIE9mIGNvdXJzZSwgd2Ug
c2hvdWxkIGZvY3VzIG91ciBkaXNjdXNzaW9ucyBvbiB0aGUgdXBzdHJlYW1pbmcgYXNwZWN0LCBl
LmcuIHJlZHVjaW5nIHRoZTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Zm9vdHByaW50IG9mIE1QVENQIGluIHRoZSBjdXJyZW50IFRDUCBzdGFjazogd2hhdCBhcmUgd2Ug
YWxsb3cgdG8gZG8sIHdoYXQgbm90LiBJdCBpcyBsaW5rZWQ8YnI+CsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHRvIG1hbnkgcHJldmlvdXMgZGlzY3Vzc2lvbnMgd2UgaGFkIG9u
IHRoaXMgTUwsIGUuZy4gd2h5IHdlIG5lZWQgbW9yZSBpbmRpcmVjdCBmdW5jdGlvbiBjYWxsczxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYW5kIGhvdyB0byByZWR1Y2Ug
dGhlIGltcGFjdCwgZXRjLjxicj4KPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFRoZSBwcmV2aW91cyB0YWxrIChbMl0pIGhhZCBhIHNlY3Rpb24gbGlrZSB0aGlzLiBJIGhhdmVu
JiMzOTt0IHdhdGNoZWQgaXQgcmVjZW50bHksIEkgc2hvdWxkIGxvb2sgYXQgaXQgYWdhaW48YnI+
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRvIHNlZSB3aGF0IGtpbmQgb2YgcXVlc3Rpb25z
IHRoZSBhdWRpZW5jZSB3YXMgYXNraW5nLiBBcyB5b3UgbWVudGlvbmVkIGFib3ZlIHdlIHNob3Vs
ZCBiZSBjYXJlZnVsIHRvPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBoYXZlIG5ldyBj
b250ZW50IGNvbXBhcmVkIHRvIHRoZSBwcmV2aW91cyBzZXNzaW9uLjxicj4KPGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gSWYgd2UgaGF2ZSB0aW1lLCB3ZSBjb3Vs
ZCBkaXNjdXNzIGFib3V0IGhvdyB1c2VycyBjb3VsZCBpbnRlcmFjdCB3aXRoIE1QVENQOiBlbmFi
bGUgaXQgcGVyPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25uZWN0
aW9uLCBjb250cm9sIHRoZSBwYXRoIG1hbmFnZXIsIG1heWJlIHRoZSBzY2hlZHVsZXIsIGV0Yy48
YnI+Cjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBXaGF0IGRv
IHlvdSB0aGluayBhYm91dCB0aGlzPyBGZWVsIGZyZWUgdG8gY29tbWVudCBhbmQgZXZlbiBwcm9w
b3NlIGNvbXBsZXRlbHkgZGlmZmVyZW50PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZGVhcyE8YnI+Cjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBU
aGFuayB5b3UgZm9yIG91dGxpbmluZyB0aGVzZSBpZGVhcy4gSSBzZWUgdGhhdCB0aGlzIHRvcGlj
IGlzIG9uIG91ciBtZWV0aW5nIGFnZW5kYSBzbyBpdCB3aWxsIGJlIGdvb2QgdG88YnI+CsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpc2N1c3MgdGhlIHR1dG9yaWFsIHRoZXJlLjxicj4KPGJy
Pgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsxXSA8YSBocmVmPSJo
dHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWwvbXB0Y3AvMjAxOC1NYXJjaC8wMDAzNzkuaHRt
bCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy4wMS5vcmcv
cGlwZXJtYWlsPHdicj4vbXB0Y3AvMjAxOC1NYXJjaC8wMDAzNzkuaHRtbDwvYT48YnI+CsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsyXSA8YSBocmVmPSJodHRwczovL3d3dy55
b3V0dWJlLmNvbS93YXRjaD92PXdmdHoyY1U1U1pzIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD88d2JyPnY9d2Z0ejJjVTVTWnM8
L2E+PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbM10gPGEgaHJlZj0i
aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcv
MHgxPHdicj4yL3N1Ym1pdC1wcm9wb3NhbC5odG1sPC9hPjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+
Ci0tPGJyPgpNYXQgTWFydGluZWF1PGJyPgpJbnRlbCBPVEM8L2Rpdj48L2Rpdj48L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyPjxiciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWls
X3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0
ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBzdHlsZT0i
Zm9udC1mYW1pbHk6JnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFjaW5nOm5v
cm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNpbmc6MHB4
IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwIj48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIzIiBzdHls
ZT0icGFkZGluZy1sZWZ0OjVweDtwYWRkaW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2YWxpZ249
InRvcCIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiB0YXJn
ZXQ9Il9ibGFuayI+PGltZyBzcmM9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xvZ28ucG5n
IiBhbHQ9IlRlc3NhcmVzIFNBIiB3aWR0aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0iMCI+PC9h
PjwvdGQ+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWws
c2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxzcGFu
IHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5s
aW5lIj5NYXR0aGlldSBCYWVydHMgfCBSJmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+PC90cj48
dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fu
cy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxhIGhyZWY9
Im1haWx0bzptYXR0aGlldS5iYWVydHMlNDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xvcjpyZ2Io
MCwwLDApO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9Il9ibGFu
ayI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0cj48dGQg
c3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlm
O2ZvbnQtc2l6ZToxMHB4IiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0OmJv
bGQ7Y29sb3I6cmdiKDM3LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNBIHwgSHli
cmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2Fy
ZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNw
bGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNwYW4+wqA8
L3NwYW4+PGJyPjxhIGhyZWY9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTErQXZlbnVl
K0plYW4rTW9ubmV0LCsxMzQ4K090dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxnaXVtIiBz
dHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGlu
ZSIgdGFyZ2V0PSJfYmxhbmsiPjEgQXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEt
TmV1dmUsIEJlbGdpdW08L2E+PC90ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4KPC9kaXY+PC9kaXY+PC9kaXY+Cgo8YnI+CjxkaXY+PGJy
Pjxocj48L2Rpdj48Zm9udCBzaXplPSIxIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFu
YSxzYW5zLXNlcmlmO2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+RElTQ0xBSU1F
Ui48L3NwYW4+PGJyIHN0eWxlPSJmb250LWZhbWlseTpWZXJkYW5hLHNhbnMtc2VyaWY7YmFja2dy
b3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj48Zm9udCBjb2xvcj0iIzAwMDAwMCIgZmFjZT0i
VmVyZGFuYSwgc2Fucy1zZXJpZiIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUs
MjU1KSI+VGhpcyBlbWFpbCBhbmQgYW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNv
bmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlk
dWFsIG9yIGVudGl0eSB0byB3aG9tIHRoZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGhhdmUgcmVj
ZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVhc2Ugbm90aWZ5IHRoZSBzeXN0ZW0gbWFuYWdl
ci4gVGhpcyBtZXNzYWdlIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgaXMg
aW50ZW5kZWQgb25seSBmb3IgdGhlIGluZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBhcmUgbm90IHRo
ZSBuYW1lZCBhZGRyZXNzZWUgeW91IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUg
b3IgY29weSB0aGlzIGUtbWFpbC4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGJ5IGUtbWFpbCBpZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieSBtaXN0YWtlIGFu
ZCBkZWxldGUgdGhpcyBlLW1haWwgZnJvbSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCB5b3UgYXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29w
eWluZywgZGlzdHJpYnV0aW5nIG9yIHRha2luZyBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIG9uIHRo
ZSBjb250ZW50cyBvZiB0aGlzIGluZm9ybWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPC9m
b250PjwvZm9udD4=
--===============9122335027450289065==--
