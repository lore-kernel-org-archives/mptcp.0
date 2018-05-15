Content-Type: multipart/mixed; boundary="===============9188325109215440385=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Conference talk ideas, round 2
Date: Tue, 15 May 2018 18:23:01 +0200
Message-ID: <CAKuKrB=-D6XDGRTqqLNWydnz2G9yn15Dq+dj66TPzJrOZ=zHhw@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1805141442370.64899@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 627

--===============9188325109215440385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 15, 2018 at 12:59 AM, Mat Martineau <
mathew.j.martineau(a)linux.intel.com> wrote:

>
> Matthieu,
>
> On Mon, 14 May 2018, Matthieu Baerts wrote:
>
> Hi Mat,
>>
>> On Mon, May 14, 2018 at 6:02 AM, Mat Martineau <
>> mathew.j.martineau(a)linux.intel.com> wrote:
>>
>>       Hello -
>>
>>       We had a meeting last week to discuss reshaping our netdev
>> conference MPTCP talk proposal based on feedback from the committee.
>>       The plan is to re-focus on upstreaming concerns, challenges, and
>> progress.
>>
>>       I worked on outlining some topics that might fit with the talk. I
>> don't think this is exhaustive, and I'm also not saying
>>       everything here is required to be in the talk. I'm looking forward
>> to your comments and additional ideas.
>>
>>
>> Thank you for the list!
>>
>> Should we focus our talk on: Why is adding intrusive protocols like MPTCP
>> to the upstream kernel so complicated?
>>
>>
> I think the complexity of MPTCP is unique in that additional protocols
> don't usually overlap with an existing protocol - especially a protocol as
> heavily used and optimized as TCP. I'm not sure how many MPTCP-like
> protocols are out there, but we definitely can focus on the complexity of
> MPTCP upstreaming. The most similar thing I can think of is the Bluetooth
> L2CAP-ERTM code in the kernel, but the layering there was cleaner (I wrote
> that ERTM kernel code and upstreamed it after maintaining it separately f=
or
> a while - sound familiar?).
>
> In terms of topic priorities, I think the last two top-level bullet points
> (large change logistics and "show us the code") are less important than t=
he
> earlier points.
>
>
> The conference committee announced acceptance of a QUIC talk, and it made
> me think about how QUIC doesn't have these kernel issues since it builds =
on
> UDP. In contrast, the design of MPTCP pushes complexity in to the kernel =
in
> order to look like TCP on the wire and to fit with legacy applications.
>

Thank you Mat for your comments! I tried to compile everything you wrote
here below.


> If you want and if nobody has already started it, I can have a look to
>> prepare a first draft for a description for this talk.
>>
>
> It would be very helpful if you can prepare that draft. Thank you!
>

Here is my new proposal with some comments:

* Title of the submission: Why is adding Multipath TCP to the upstream
> kernel complicated?
>

At the end, it seems it is what we are going to present but feel free to
propose anything else!

We could maybe do a reference to published paper ;-)

    How hard can it be? Adding Multipath TCP to the upstream kernel.

* Label: Moonshot / Nuts and bolts
>

I guess it is more a "Moonshot" but in the Nuts and bolts description it is
written: "These are presentations that might take a deep dive into
implementation and development of technology in Linux kernel networking".
What do you think?

Here are the three possible labels:

   - "Moonshot" - These are sessions about the next big thing in Linux
   kernel networking. If you are thinking about new and exciting technology=
 or
   big idea and want feedback, then consider submitting a "moonshot" propos=
al.
   As an example, the first time XDP was presented in Netdev it would have
   probably have qualified as a "moonshot".
   - "Nuts and bolts" - These are presentations that might take a deep dive
   into implementation and development of technology in Linux kernel
   networking. If you have well tested ideas and code that you would like to
   push forward inclusion and adoption by the community (kernel/user space)
   then consider submitting a "nuts and bolts" proposal. It is also accepta=
ble
   in a "nuts and bolts" session to have a talk to document how things work
   under the covers especially if they are already in deployment in the
   kernel/user space but have never been documented. An example of a "nuts =
and
   bolts" session is DSA which was first described in Netdev 2.1.
   - "Hands on" - These are more what traditionally has been thought of as
   tutorials. These sessions focus on configuring and using Linux kernel
   networking technologies and features. This is an opportunity to share
   deployment experience and wisdom about how to best employ kernel
   technology. To provide a truly "hands on" experience, there should be re=
al
   examples and case studies presented that the audience could try out in r=
eal
   time. Previous Netdev sessions on iptables are good examples of "hands o=
n"
   sessions.

* Submission type: talk
>

Here are more info about what they call a "talk" type:

   - Talk - One or more of authors elaborating on a proposal within a 30
   minute session. A 2-10 pages (not including references) paper submission=
 of
   the talk is required in odt or latex format. "Nuts-and-bolts" as well as
   "moonshot" submissions are a fit here.

I don't know about the 2-10 pages paper. Is it to describe the technology
or what we are going to present? Is it really needed to describe MPTCP?

* Estimate of length of time for presentation: 30 minutes
>

It seems Talk are limited to 30 minutes.

* Description of proposal:
>     A community project is underway to add Multipath TCP to the upstream
> Linux kernel. This talk will briefly introduce the audience to this TCP
> extension (RFC 6824) and mention some use cases already in production. The
> rest of the talk will be dedicated to interactive discussions of the
> challenges in converging on an upstream MPTCP implementation.
>
>     The current MPTCP implementation, already used by millions of devices,
> cannot be proposed upstream as it is due to its too invasive architecture.
> This architecture was good when the protocol was in development and
> research but now that it is stabilised, the design should be revamped for
> an upstream inclusion. But this task is far from being easy as the design
> of MPTCP pushes complexity into the kernel in order to look like TCP on t=
he
> wire and to fit with legacy applications and middleboxes. This makes the
> complexity of this upstream project a bit unique in that additional
> protocols don't usually overlap that much with an existing protocol -
> especially a protocol as heavily used and optimised as TCP.
>
>     During this talk, we will present the different challenges we have
> faced and we are still facing today: from the protocol challenges to the
> design without adversely affecting TCP or networking structures through t=
he
> fundamental challenge of "show us the code" way to have discussions with
> main contributors and maintainers.
>
>     Note that the previous presentation by Octavian at Netdev 0.1 focused
> on the operation of the protocol and migration of the existing MPTCP Linux
> implementation. This talk will more specifically address what "upstream
> MPTCP" looks like, how MPTCP compares to in-kernel TCP users like TLS and
> KCM, the unique challenges in extending TCP for this protocol, and moving
> some functionalities to userspace.
>
>     For more information about this project:
> https://github.com/multipath-tcp/mptcp_net-next/wiki
>

That is around 300 words. I don't think we need to mention all technical
bits from Mat's list but I do think it could be interesting to use this
list as a base for both the 2-10 pages paper and the talk itself. Again I
am not sure the paper is really needed but it can be useful to prepare the
talk as well. That is why I just prepared a first draft on ShareLatex:
https://www.sharelatex.com/read/mdnhtfgxpkhg

The beginning is mainly inspired by this paper, I guess/hope it is fine as
I am co-author and the goal is not to publish the paper:
https://inl.info.ucl.ac.be/system/files/PAM2016_54-deconinck.pdf
The rest is Mat's list. If we want to go in this direction, I can convert
bullet points into sentences if they were not magically converted during my
night :)
Unfortunately with ShareLatex, you need an account to edit text. Then you
can go to https://www.sharelatex.com/8294638822ybsnsmmwkzcp

Of course, feel free to comment this new proposal, rewrite it completely
with a better English if needed and edit the paper on ShareLatex! :)

Best regards,
Matthieu


>
>
> Mat
>
>
>
>
>> Best regards,
>> Matthieu
>>
>>       * Why is adding MPTCP to the upstream kernel complicated?
>>
>>           * Differences in requirements and features from existing
>> implementation
>>
>>               * Every TCP socket affected vs. staying out of the way for
>> normal TCP
>>
>>               * Multipath protocol development and research vs giving TCP
>> users/maintainers weight
>>
>>           * Protocol challenges
>>
>>               * Coupled receive windows across TCP subflows
>>
>>               * Behavior change for duplicate acks
>>
>>               * Per-packet metadata (tx path) and option writing
>>
>>               * TCP option parsing - packets are currently dropped after
>> options are parsed
>>
>>               * Collapse/coalesce of skbs after receive - per-packet
>> headers lost in TCP layer
>>
>>           * Must do all this without adversely affecting TCP or
>> networking structs (like sk_buff)
>>
>>               * TCP performance not reduced
>>
>>               * Memory requirements for TCP not increased
>>
>>               * Maintainability not made harder
>>
>>           * Compare to KCM, which adds metadata to each stream, didn't
>> require TCP changes
>>
>>       * What fits well in the networking subsystem
>>
>>           * Some connection code (callbacks exist)
>>
>>           * Creating a new socket type for MPTCP
>>
>>           * New ULP capability
>>
>>               * No rules yet for multiple users, because TLS is the only
>> user
>>
>>           * In-kernel sockets
>>
>>           * do_tcp_sendpages() to send data buffered at the connection
>> level
>>
>>           * tcp_read_sock() to get incoming skbs
>>
>>       * What's a challenge in the networking subsystem
>>
>>           * Indirect calls are now more expensive
>>
>>           * MPTCP builds on TCP in a unique way
>>
>>       * What we have tried
>>
>>           * Identify where other features could use TCP extension
>> capabilities and merge before MPTCP
>>
>>               * Options framework used by TCP-MD5 and SMC
>>
>>               * Didn't work out - expensive indirect calls and no MPTCP
>> frame of reference for the maintainer
>>
>>           * Sharing code demonstrating architectural approaches that use
>> current upstream netdev functionality
>>
>>           * Moving components to userspace
>>
>>           * Forking and reducing functionality of existing MPTCP code ba=
se
>>
>>       * Large change logistics
>>
>>           * Reshaping code in to a reviewable patch set or patch sets.
>> Implement functionality in stages?
>>
>>       * Fundamental challenge of "show us the code" - must decide what
>> seems upstreamable, implement it, share, and iterate.
>>
>>
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

--===============9188325109215440385==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUdWUsIE1heSAxNSwgMjAxOCBhdCAxMjo1
OSBBTSwgTWF0IE1hcnRpbmVhdSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpt
YXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWF0aGV3
LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGJyPgpNYXR0aGlldSw8
c3BhbiBjbGFzcz0iIj48YnI+Cjxicj4KT24gTW9uLCAxNCBNYXkgMjAxOCwgTWF0dGhpZXUgQmFl
cnRzIHdyb3RlOjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KSGkgTWF0LDxicj4KPGJyPgpPbiBNb24sIE1heSAxNCwgMjAxOCBhdCA2OjAyIEFN
LCBNYXQgTWFydGluZWF1ICZsdDs8YSBocmVmPSJtYWlsdG86bWF0aGV3LmoubWFydGluZWF1QGxp
bnV4LmludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5p
bnRlPHdicj5sLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4KPGJyPgrCoCDCoCDCoCBIZWxsbyAtPGJy
Pgo8YnI+CsKgIMKgIMKgIFdlIGhhZCBhIG1lZXRpbmcgbGFzdCB3ZWVrIHRvIGRpc2N1c3MgcmVz
aGFwaW5nIG91ciBuZXRkZXYgY29uZmVyZW5jZSBNUFRDUCB0YWxrIHByb3Bvc2FsIGJhc2VkIG9u
IGZlZWRiYWNrIGZyb20gdGhlIGNvbW1pdHRlZS48YnI+CsKgIMKgIMKgIFRoZSBwbGFuIGlzIHRv
IHJlLWZvY3VzIG9uIHVwc3RyZWFtaW5nIGNvbmNlcm5zLCBjaGFsbGVuZ2VzLCBhbmQgcHJvZ3Jl
c3MuPGJyPgo8YnI+CsKgIMKgIMKgIEkgd29ya2VkIG9uIG91dGxpbmluZyBzb21lIHRvcGljcyB0
aGF0IG1pZ2h0IGZpdCB3aXRoIHRoZSB0YWxrLiBJIGRvbiYjMzk7dCB0aGluayB0aGlzIGlzIGV4
aGF1c3RpdmUsIGFuZCBJJiMzOTttIGFsc28gbm90IHNheWluZzxicj4KwqAgwqAgwqAgZXZlcnl0
aGluZyBoZXJlIGlzIHJlcXVpcmVkIHRvIGJlIGluIHRoZSB0YWxrLiBJJiMzOTttIGxvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIGNvbW1lbnRzIGFuZCBhZGRpdGlvbmFsIGlkZWFzLjxicj4KPGJyPgo8
YnI+ClRoYW5rIHlvdSBmb3IgdGhlIGxpc3QhPGJyPgo8YnI+ClNob3VsZCB3ZSBmb2N1cyBvdXIg
dGFsayBvbjogV2h5IGlzIGFkZGluZyBpbnRydXNpdmUgcHJvdG9jb2xzIGxpa2UgTVBUQ1AgdG8g
dGhlIHVwc3RyZWFtIGtlcm5lbCBzbyBjb21wbGljYXRlZD88YnI+Cjxicj4KPC9ibG9ja3F1b3Rl
Pgo8YnI+PC9zcGFuPgpJIHRoaW5rIHRoZSBjb21wbGV4aXR5IG9mIE1QVENQIGlzIHVuaXF1ZSBp
biB0aGF0IGFkZGl0aW9uYWwgcHJvdG9jb2xzIGRvbiYjMzk7dCB1c3VhbGx5IG92ZXJsYXAgd2l0
aCBhbiBleGlzdGluZyBwcm90b2NvbCAtIGVzcGVjaWFsbHkgYSBwcm90b2NvbCBhcyBoZWF2aWx5
IHVzZWQgYW5kIG9wdGltaXplZCBhcyBUQ1AuIEkmIzM5O20gbm90IHN1cmUgaG93IG1hbnkgTVBU
Q1AtbGlrZSBwcm90b2NvbHMgYXJlIG91dCB0aGVyZSwgYnV0IHdlIGRlZmluaXRlbHkgY2FuIGZv
Y3VzIG9uIHRoZSBjb21wbGV4aXR5IG9mIE1QVENQIHVwc3RyZWFtaW5nLiBUaGUgbW9zdCBzaW1p
bGFyIHRoaW5nIEkgY2FuIHRoaW5rIG9mIGlzIHRoZSBCbHVldG9vdGggTDJDQVAtRVJUTSBjb2Rl
IGluIHRoZSBrZXJuZWwsIGJ1dCB0aGUgbGF5ZXJpbmcgdGhlcmUgd2FzIGNsZWFuZXIgKEkgd3Jv
dGUgdGhhdCBFUlRNIGtlcm5lbCBjb2RlIGFuZCB1cHN0cmVhbWVkIGl0IGFmdGVyIG1haW50YWlu
aW5nIGl0IHNlcGFyYXRlbHkgZm9yIGEgd2hpbGUgLSBzb3VuZCBmYW1pbGlhcj8pLjxicj4KPGJy
PgpJbiB0ZXJtcyBvZiB0b3BpYyBwcmlvcml0aWVzLCBJIHRoaW5rIHRoZSBsYXN0IHR3byB0b3At
bGV2ZWwgYnVsbGV0IHBvaW50cyAobGFyZ2UgY2hhbmdlIGxvZ2lzdGljcyBhbmQgJnF1b3Q7c2hv
dyB1cyB0aGUgY29kZSZxdW90OykgYXJlIGxlc3MgaW1wb3J0YW50IHRoYW4gdGhlIGVhcmxpZXIg
cG9pbnRzLjxicj4KPGJyPgo8YnI+ClRoZSBjb25mZXJlbmNlIGNvbW1pdHRlZSBhbm5vdW5jZWQg
YWNjZXB0YW5jZSBvZiBhIFFVSUMgdGFsaywgYW5kIGl0IG1hZGUgbWUgdGhpbmsgYWJvdXQgaG93
IFFVSUMgZG9lc24mIzM5O3QgaGF2ZSB0aGVzZSBrZXJuZWwgaXNzdWVzIHNpbmNlIGl0IGJ1aWxk
cyBvbiBVRFAuIEluIGNvbnRyYXN0LCB0aGUgZGVzaWduIG9mIE1QVENQIHB1c2hlcyBjb21wbGV4
aXR5IGluIHRvIHRoZSBrZXJuZWwgaW4gb3JkZXIgdG8gbG9vayBsaWtlIFRDUCBvbiB0aGUgd2ly
ZSBhbmQgdG8gZml0IHdpdGggbGVnYWN5IGFwcGxpY2F0aW9ucy48c3BhbiBjbGFzcz0iIj48YnI+
PC9zcGFuPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+VGhhbmsgeW91IE1h
dCBmb3IgeW91ciBjb21tZW50cyEgSSB0cmllZCB0byBjb21waWxlIGV2ZXJ5dGhpbmcgeW91IHdy
b3RlIGhlcmUgYmVsb3cuPC9kaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0iIj4KCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPgpJZiB5b3Ugd2FudCBhbmQgaWYgbm9ib2R5IGhhcyBhbHJl
YWR5IHN0YXJ0ZWQgaXQsIEkgY2FuIGhhdmUgYSBsb29rIHRvIHByZXBhcmUgYSBmaXJzdCBkcmFm
dCBmb3IgYSBkZXNjcmlwdGlvbiBmb3IgdGhpcyB0YWxrLjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+
PC9zcGFuPgpJdCB3b3VsZCBiZSB2ZXJ5IGhlbHBmdWwgaWYgeW91IGNhbiBwcmVwYXJlIHRoYXQg
ZHJhZnQuIFRoYW5rIHlvdSE8c3BhbiBjbGFzcz0iSE9FblpiIj48Zm9udCBjb2xvcj0iIzg4ODg4
OCI+PGJyPjwvZm9udD48L3NwYW4+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRp
dj5IZXJlIGlzIG15IG5ldyBwcm9wb3NhbCB3aXRoIHNvbWUgY29tbWVudHM6PGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PiogVGl0bGUgb2YgdGhlIHN1Ym1pc3Npb246IFdoeSBp
cyBhZGRpbmcgTXVsdGlwYXRoIFRDUCB0byB0aGUgdXBzdHJlYW0ga2VybmVsIGNvbXBsaWNhdGVk
PzwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkF0IHRoZSBlbmQsIGl0IHNl
ZW1zIGl0IGlzIHdoYXQgd2UgYXJlIGdvaW5nIHRvIHByZXNlbnQgYnV0IGZlZWwgZnJlZSB0byBw
cm9wb3NlIGFueXRoaW5nIGVsc2UhPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XZSBjb3VsZCBt
YXliZSBkbyBhIHJlZmVyZW5jZSB0byBwdWJsaXNoZWQgcGFwZXIgOy0pPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj7CoMKgwqAgSG93IGhhcmQgY2FuIGl0IGJlPyBBZGRpbmcgTXVsdGlwYXRoIFRD
UCB0byB0aGUgdXBzdHJlYW0ga2VybmVsLjxicj48L2Rpdj4KPGJyPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVm
dDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PgoqIExh
YmVsOiBNb29uc2hvdCAvIE51dHMgYW5kIGJvbHRzPC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2PjxkaXY+SSBndWVzcyBpdCBpcyBtb3JlIGEgJnF1b3Q7TW9vbnNob3QmcXVvdDsgYnV0
IGluIHRoZSBOdXRzIGFuZCBib2x0cyBkZXNjcmlwdGlvbiBpdCBpcyB3cml0dGVuOiAmcXVvdDtU
aGVzZSBhcmUgcHJlc2VudGF0aW9ucyB0aGF0IG1pZ2h0IHRha2UgYQoJICAgICAgZGVlcCBkaXZl
IGludG8gaW1wbGVtZW50YXRpb24gYW5kIGRldmVsb3BtZW50IG9mIHRlY2hub2xvZ3kgaW4gTGlu
dXgga2VybmVsCgkgICAgICBuZXR3b3JraW5nJnF1b3Q7LjwvZGl2PjxkaXY+V2hhdCBkbyB5b3Ug
dGhpbms/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5IZXJlIGFyZSB0aGUgdGhyZWUgcG9zc2li
bGUgbGFiZWxzOjxicj48L2Rpdj48ZGl2Pjx1bD4KCSAgICA8bGk+JnF1b3Q7TW9vbnNob3QmcXVv
dDsgLSBUaGVzZSBhcmUgc2Vzc2lvbnMgYWJvdXQgdGhlIG5leHQgYmlnIHRoaW5nIGluCgkgICAg
ICBMaW51eCBrZXJuZWwgbmV0d29ya2luZy4gSWYgeW91IGFyZSB0aGlua2luZyBhYm91dCBuZXcg
YW5kIGV4Y2l0aW5nIHRlY2hub2xvZ3kKCSAgICAgIG9yIGJpZyBpZGVhIGFuZCB3YW50IGZlZWRi
YWNrLCB0aGVuIGNvbnNpZGVyIHN1Ym1pdHRpbmcgYSAmcXVvdDttb29uc2hvdCZxdW90OyBwcm9w
b3NhbC4KCSAgICAgIEFzIGFuIGV4YW1wbGUsIHRoZSBmaXJzdCB0aW1lIFhEUCB3YXMgcHJlc2Vu
dGVkIGluIE5ldGRldiBpdCB3b3VsZCBoYXZlCgkgICAgICBwcm9iYWJseSBoYXZlIHF1YWxpZmll
ZCBhcyBhICZxdW90O21vb25zaG90JnF1b3Q7LjwvbGk+CgkgICAgPGxpPiZxdW90O051dHMgYW5k
IGJvbHRzJnF1b3Q7IC0gVGhlc2UgYXJlIHByZXNlbnRhdGlvbnMgdGhhdCBtaWdodCB0YWtlIGEK
CSAgICAgIGRlZXAgZGl2ZSBpbnRvIGltcGxlbWVudGF0aW9uIGFuZCBkZXZlbG9wbWVudCBvZiB0
ZWNobm9sb2d5IGluIExpbnV4IGtlcm5lbAoJICAgICAgbmV0d29ya2luZy4gSWYgeW91IGhhdmUg
d2VsbCB0ZXN0ZWQgaWRlYXMgYW5kIGNvZGUgdGhhdCB5b3Ugd291bGQgbGlrZSB0byBwdXNoCgkg
ICAgICBmb3J3YXJkIGluY2x1c2lvbiBhbmQgYWRvcHRpb24gYnkgdGhlIGNvbW11bml0eSAoa2Vy
bmVsL3VzZXIgc3BhY2UpIHRoZW4KCSAgICAgIGNvbnNpZGVyIHN1Ym1pdHRpbmcgYSAmcXVvdDtu
dXRzIGFuZCBib2x0cyZxdW90OyBwcm9wb3NhbC4gSXQgaXMgYWxzbyBhY2NlcHRhYmxlIGluIGEK
CSAgICAgICZxdW90O251dHMgYW5kIGJvbHRzJnF1b3Q7IHNlc3Npb24gdG8gaGF2ZSBhIHRhbGsg
dG8gZG9jdW1lbnQgaG93IHRoaW5ncyB3b3JrIHVuZGVyIHRoZQoJICAgICAgY292ZXJzIGVzcGVj
aWFsbHkgaWYgdGhleSBhcmUgYWxyZWFkeSBpbiBkZXBsb3ltZW50IGluIHRoZSBrZXJuZWwvdXNl
ciBzcGFjZQoJICAgICAgYnV0IGhhdmUgbmV2ZXIgYmVlbiBkb2N1bWVudGVkLiBBbiBleGFtcGxl
IG9mIGEgJnF1b3Q7bnV0cyBhbmQgYm9sdHMmcXVvdDsgc2Vzc2lvbiBpcyBEU0EKCSAgICAgIHdo
aWNoIHdhcyBmaXJzdCBkZXNjcmliZWQgaW4gTmV0ZGV2IDIuMS48L2xpPgoJICAgIDxsaT4mcXVv
dDtIYW5kcyBvbiZxdW90OyAtIFRoZXNlIGFyZSBtb3JlIHdoYXQgdHJhZGl0aW9uYWxseSBoYXMg
YmVlbiB0aG91Z2h0CgkgICAgICBvZiBhcyB0dXRvcmlhbHMuIFRoZXNlIHNlc3Npb25zIGZvY3Vz
IG9uIGNvbmZpZ3VyaW5nIGFuZCB1c2luZyBMaW51eCBrZXJuZWwKCSAgICAgIG5ldHdvcmtpbmcg
dGVjaG5vbG9naWVzIGFuZCBmZWF0dXJlcy4gVGhpcyBpcyBhbiBvcHBvcnR1bml0eSB0byBzaGFy
ZQoJICAgICAgZGVwbG95bWVudCBleHBlcmllbmNlIGFuZCB3aXNkb20gYWJvdXQgaG93IHRvIGJl
c3QgZW1wbG95IGtlcm5lbCB0ZWNobm9sb2d5LiBUbwoJICAgICAgcHJvdmlkZSBhIHRydWx5ICZx
dW90O2hhbmRzIG9uJnF1b3Q7IGV4cGVyaWVuY2UsIHRoZXJlIHNob3VsZCBiZSByZWFsIGV4YW1w
bGVzIGFuZCBjYXNlCgkgICAgICBzdHVkaWVzIHByZXNlbnRlZCB0aGF0IHRoZSBhdWRpZW5jZSBj
b3VsZCB0cnkgb3V0IGluIHJlYWwgdGltZS4gUHJldmlvdXMgTmV0ZGV2CgkgICAgICBzZXNzaW9u
cyBvbiBpcHRhYmxlcyBhcmUgZ29vZCBleGFtcGxlcyBvZiAmcXVvdDtoYW5kcyBvbiZxdW90OyBz
ZXNzaW9ucy48L2xpPgoJICA8L3VsPjwvZGl2Pgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj4KKiBTdWJtaXNzaW9uIHR5
cGU6IHRhbGs8L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5IZXJlIGFyZSBt
b3JlIGluZm8gYWJvdXQgd2hhdCB0aGV5IGNhbGwgYSAmcXVvdDt0YWxrJnF1b3Q7IHR5cGU6PC9k
aXY+PGRpdj48dWw+PGxpPlRhbGsgLSBPbmUgb3IgbW9yZSBvZiBhdXRob3JzIGVsYWJvcmF0aW5n
IG9uIGEgcHJvcG9zYWwgd2l0aGluCgkgICAgICBhIDMwIG1pbnV0ZSBzZXNzaW9uLiBBIDItMTAg
cGFnZXMgKG5vdCBpbmNsdWRpbmcgcmVmZXJlbmNlcykgcGFwZXIgc3VibWlzc2lvbgoJICAgICAg
b2YgdGhlIHRhbGsgaXMgcmVxdWlyZWQgaW4gb2R0IG9yIGxhdGV4IGZvcm1hdC4gJnF1b3Q7TnV0
cy1hbmQtYm9sdHMmcXVvdDsgYXMgd2VsbCBhcwoJICAgICAgJnF1b3Q7bW9vbnNob3QmcXVvdDsg
c3VibWlzc2lvbnMgYXJlIGEgZml0IGhlcmUuPC9saT48L3VsPjwvZGl2Pgo8ZGl2PkkgZG9uJiMz
OTt0IGtub3cgYWJvdXQgdGhlIDItMTAgcGFnZXMgcGFwZXIuIElzIGl0IHRvIGRlc2NyaWJlIHRo
ZSAKdGVjaG5vbG9neSBvciB3aGF0IHdlIGFyZSBnb2luZyB0byBwcmVzZW50PyBJcyBpdCByZWFs
bHkgbmVlZGVkIHRvIApkZXNjcmliZSBNUFRDUD88YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPgoqIEVzdGltYXRlIG9mIGxlbmd0aCBvZiB0aW1lIGZvciBwcmVzZW50YXRpb246IDMwIG1p
bnV0ZXM8YnI+PC9ibG9ja3F1b3RlPgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IHNlZW1zIFRhbGsg
YXJlIGxpbWl0ZWQgdG8gMzAgbWludXRlcy48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PgoqIERlc2NyaXB0aW9uIG9mIHByb3Bvc2FsOjxicj4KwqAgwqAgQSBjb21tdW5pdHkgcHJvamVj
dCBpcyB1bmRlcndheSB0byBhZGQgTXVsdGlwYXRoIFRDUCB0byB0aGUgdXBzdHJlYW0KIExpbnV4
IGtlcm5lbC4gVGhpcyB0YWxrIHdpbGwgYnJpZWZseSBpbnRyb2R1Y2UgdGhlIGF1ZGllbmNlIHRv
IHRoaXMgVENQCiBleHRlbnNpb24gKFJGQyA2ODI0KSBhbmQgbWVudGlvbiBzb21lIHVzZSBjYXNl
cyBhbHJlYWR5IGluIHByb2R1Y3Rpb24uIApUaGUgcmVzdCBvZiB0aGUgdGFsayB3aWxsIGJlIGRl
ZGljYXRlZCB0byBpbnRlcmFjdGl2ZSBkaXNjdXNzaW9ucyBvZiB0aGUKIGNoYWxsZW5nZXMgaW4g
Y29udmVyZ2luZyBvbiBhbiB1cHN0cmVhbSBNUFRDUCBpbXBsZW1lbnRhdGlvbi48YnI+PGJyPjxk
aXY+CsKgIMKgIFRoZSBjdXJyZW50IE1QVENQIGltcGxlbWVudGF0aW9uLCBhbHJlYWR5IHVzZWQg
YnkgbWlsbGlvbnMgb2YgCmRldmljZXMsIGNhbm5vdCBiZSBwcm9wb3NlZCB1cHN0cmVhbSBhcyBp
dCBpcyBkdWUgdG8gaXRzIHRvbyBpbnZhc2l2ZSAKYXJjaGl0ZWN0dXJlLiBUaGlzIGFyY2hpdGVj
dHVyZSB3YXMgZ29vZCB3aGVuIHRoZSBwcm90b2NvbCB3YXMgaW4gCmRldmVsb3BtZW50IGFuZCBy
ZXNlYXJjaCBidXQgbm93IHRoYXQgaXQgaXMgc3RhYmlsaXNlZCwgdGhlIGRlc2lnbiAKc2hvdWxk
IGJlIHJldmFtcGVkIGZvciBhbiB1cHN0cmVhbSBpbmNsdXNpb24uIEJ1dCB0aGlzIHRhc2sgaXMg
ZmFyIGZyb20gCmJlaW5nIGVhc3kgYXMgdGhlIGRlc2lnbiBvZiBNUFRDUCBwdXNoZXMgY29tcGxl
eGl0eSBpbnRvIHRoZSBrZXJuZWwgaW4gCm9yZGVyIHRvIGxvb2sgbGlrZSBUQ1Agb24gdGhlIHdp
cmUgYW5kIHRvIGZpdCB3aXRoIGxlZ2FjeSBhcHBsaWNhdGlvbnMgCmFuZCBtaWRkbGVib3hlcy48
c3BhbiBjbGFzcz0iZ21haWwtaW0iPiBUaGlzIG1ha2VzIHRoZSBjb21wbGV4aXR5IG9mIHRoaXMg
dXBzdHJlYW0gcHJvamVjdCBhIGJpdCB1bmlxdWUgaW4gdGhhdCBhZGRpdGlvbmFsIHByb3RvY29s
cyBkb24mIzM5O3QgCnVzdWFsbHkgb3ZlcmxhcCB0aGF0IG11Y2ggd2l0aCBhbiBleGlzdGluZyBw
cm90b2NvbCAtIGVzcGVjaWFsbHkgYSBwcm90b2NvbCBhcyAKaGVhdmlseSB1c2VkIGFuZCBvcHRp
bWlzZWQgYXMgVENQLjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgwqDCoCAKRHVy
aW5nIHRoaXMgdGFsaywgd2Ugd2lsbCBwcmVzZW50IHRoZSBkaWZmZXJlbnQgY2hhbGxlbmdlcyB3
ZSBoYXZlIGZhY2VkCiBhbmQgd2UgYXJlIHN0aWxsIGZhY2luZyB0b2RheTogZnJvbSB0aGUgcHJv
dG9jb2wgY2hhbGxlbmdlcyB0byB0aGUgCmRlc2lnbiB3aXRob3V0IGFkdmVyc2VseSBhZmZlY3Rp
bmcgVENQIG9yIG5ldHdvcmtpbmcgc3RydWN0dXJlcyB0aHJvdWdoIAp0aGUgZnVuZGFtZW50YWwg
Y2hhbGxlbmdlIG9mICZxdW90O3Nob3cgdXMgdGhlIGNvZGUmcXVvdDsgd2F5IHRvIGhhdmUgZGlz
Y3Vzc2lvbnMgCndpdGggbWFpbiBjb250cmlidXRvcnMgYW5kIG1haW50YWluZXJzLjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgwqDCoAogTm90ZSB0aGF0IHRoZSBwcmV2aW91cyBwcmVz
ZW50YXRpb24gYnkgT2N0YXZpYW4gYXQgTmV0ZGV2IDAuMSBmb2N1c2VkIApvbiB0aGUgb3BlcmF0
aW9uIG9mIHRoZSBwcm90b2NvbCBhbmQgbWlncmF0aW9uIG9mIHRoZSBleGlzdGluZyBNUFRDUCAK
TGludXggaW1wbGVtZW50YXRpb24uIFRoaXMgdGFsayB3aWxsIG1vcmUgc3BlY2lmaWNhbGx5IGFk
ZHJlc3Mgd2hhdCAKJnF1b3Q7dXBzdHJlYW0gTVBUQ1AmcXVvdDsgbG9va3MgbGlrZSwgaG93IE1Q
VENQIGNvbXBhcmVzIHRvIGluLWtlcm5lbCBUQ1AgdXNlcnMgCmxpa2UgVExTIGFuZCBLQ00sIHRo
ZSB1bmlxdWUgY2hhbGxlbmdlcyBpbiBleHRlbmRpbmcgVENQIGZvciB0aGlzIApwcm90b2NvbCwg
YW5kIG1vdmluZyBzb21lIGZ1bmN0aW9uYWxpdGllcyB0byB1c2Vyc3BhY2UuPGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+CsKgIMKgIEZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRoaXMg
cHJvamVjdDogPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3Bf
bmV0LW5leHQvd2lraSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9n
aXRodWIuY29tL211bHRpcGF0aC10PHdicj5jcC9tcHRjcF9uZXQtbmV4dC93aWtpPC9hPjwvZGl2
PjwvYmxvY2txdW90ZT4KPGRpdj48YnI+PC9kaXY+PGRpdj5UaGF0IGlzIGFyb3VuZCAzMDAgd29y
ZHMuIEkgZG9uJiMzOTt0IHRoaW5rIHdlIG5lZWQgdG8gCm1lbnRpb24gYWxsIHRlY2huaWNhbCBi
aXRzIGZyb20gTWF0JiMzOTtzIGxpc3QgYnV0IEkgZG8gdGhpbmsgaXQgY291bGQgYmUgCmludGVy
ZXN0aW5nIHRvIHVzZSB0aGlzIGxpc3QgYXMgYSBiYXNlIGZvciBib3RoIHRoZSAyLTEwIHBhZ2Vz
IHBhcGVyIGFuZAogdGhlIHRhbGsgaXRzZWxmLiBBZ2FpbiBJIGFtIG5vdCBzdXJlIHRoZSBwYXBl
ciBpcyByZWFsbHkgbmVlZGVkIGJ1dCBpdCAKY2FuIGJlIHVzZWZ1bCB0byBwcmVwYXJlIHRoZSB0
YWxrIGFzIHdlbGwuIFRoYXQgaXMgd2h5IEkganVzdCBwcmVwYXJlZCBhCiBmaXJzdCBkcmFmdCBv
biBTaGFyZUxhdGV4OiA8YSBocmVmPSJodHRwczovL3d3dy5zaGFyZWxhdGV4LmNvbS9yZWFkL21k
bmh0Zmd4cGtoZyI+aHR0cHM6Ly93d3cuc2hhcmVsYXRleC5jb20vcmVhZC9tZG5odGZneHBraGc8
L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUKIGJlZ2lubmluZyBpcyBtYWlubHkgaW5z
cGlyZWQgYnkgdGhpcyBwYXBlciwgSSBndWVzcy9ob3BlIGl0IGlzIGZpbmUgYXMgSQogYW0gY28t
YXV0aG9yIGFuZCB0aGUgZ29hbCBpcyBub3QgdG8gcHVibGlzaCB0aGUgcGFwZXI6IAo8YSBocmVm
PSJodHRwczovL2lubC5pbmZvLnVjbC5hYy5iZS9zeXN0ZW0vZmlsZXMvUEFNMjAxNl81NC1kZWNv
bmluY2sucGRmIj5odHRwczovL2lubC5pbmZvLnVjbC5hYy5iZS9zeXN0ZW0vZmlsZXMvUEFNMjAx
Nl81NC1kZWNvbmluY2sucGRmPC9hPjwvZGl2PjxkaXY+VGhlIHJlc3QgaXMgTWF0JiMzOTtzIGxp
c3QuIElmIHdlIHdhbnQgdG8gZ28gaW4gdGhpcyBkaXJlY3Rpb24sIEkgY2FuIGNvbnZlcnQgYnVs
bGV0IHBvaW50cyBpbnRvIHNlbnRlbmNlcyBpZiB0aGV5IHdlcmUgbm90IG1hZ2ljYWxseSBjb252
ZXJ0ZWQgZHVyaW5nIG15IG5pZ2h0IDopPC9kaXY+PGRpdj5VbmZvcnR1bmF0ZWx5CiB3aXRoIFNo
YXJlTGF0ZXgsIHlvdSBuZWVkIGFuIGFjY291bnQgdG8gZWRpdCB0ZXh0LiBUaGVuIHlvdSBjYW4g
Z28gdG8gCjxhIGhyZWY9Imh0dHBzOi8vd3d3LnNoYXJlbGF0ZXguY29tLzgyOTQ2Mzg4MjJ5YnNu
c21td2t6Y3AiPmh0dHBzOi8vd3d3LnNoYXJlbGF0ZXguY29tLzgyOTQ2Mzg4MjJ5YnNuc21td2t6
Y3A8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PZiBjb3Vyc2UsIGZlZWwgZnJlZSB0byBj
b21tZW50IHRoaXMgbmV3IHByb3Bvc2FsLCByZXdyaXRlIGl0IGNvbXBsZXRlbHkgd2l0aCBhIGJl
dHRlciBFbmdsaXNoIGlmIG5lZWRlZCBhbmQgZWRpdCB0aGUgcGFwZXIgb24gU2hhcmVMYXRleCEg
Oik8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgcmVnYXJkcyw8L2Rpdj48ZGl2Pk1hdHRo
aWV1PGJyPjwvZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+PHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPgo8YnI+
Cjxicj4KTWF0PC9mb250Pjwvc3Bhbj48ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9Img1
Ij48YnI+Cjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij4KPGJyPgpCZXN0IHJlZ2FyZHMsPGJyPgpNYXR0aGlldTxicj4KPGJyPgrCoCDCoCDCoCAq
IFdoeSBpcyBhZGRpbmcgTVBUQ1AgdG8gdGhlIHVwc3RyZWFtIGtlcm5lbCBjb21wbGljYXRlZD88
YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgKiBEaWZmZXJlbmNlcyBpbiByZXF1aXJlbWVudHMgYW5k
IGZlYXR1cmVzIGZyb20gZXhpc3RpbmcgaW1wbGVtZW50YXRpb248YnI+Cjxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKiBFdmVyeSBUQ1Agc29ja2V0IGFmZmVjdGVkIHZzLiBzdGF5aW5nIG91dCBv
ZiB0aGUgd2F5IGZvciBub3JtYWwgVENQPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgICog
TXVsdGlwYXRoIHByb3RvY29sIGRldmVsb3BtZW50IGFuZCByZXNlYXJjaCB2cyBnaXZpbmcgVENQ
IHVzZXJzL21haW50YWluZXJzIHdlaWdodDxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCAqIFByb3Rv
Y29sIGNoYWxsZW5nZXM8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBDb3VwbGVkIHJl
Y2VpdmUgd2luZG93cyBhY3Jvc3MgVENQIHN1YmZsb3dzPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgICogQmVoYXZpb3IgY2hhbmdlIGZvciBkdXBsaWNhdGUgYWNrczxicj4KPGJyPgrCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqIFBlci1wYWNrZXQgbWV0YWRhdGEgKHR4IHBhdGgpIGFuZCBvcHRp
b24gd3JpdGluZzxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIFRDUCBvcHRpb24gcGFy
c2luZyAtIHBhY2tldHMgYXJlIGN1cnJlbnRseSBkcm9wcGVkIGFmdGVyIG9wdGlvbnMgYXJlIHBh
cnNlZDxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIENvbGxhcHNlL2NvYWxlc2NlIG9m
IHNrYnMgYWZ0ZXIgcmVjZWl2ZSAtIHBlci1wYWNrZXQgaGVhZGVycyBsb3N0IGluIFRDUCBsYXll
cjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCAqIE11c3QgZG8gYWxsIHRoaXMgd2l0aG91dCBhZHZl
cnNlbHkgYWZmZWN0aW5nIFRDUCBvciBuZXR3b3JraW5nIHN0cnVjdHMgKGxpa2Ugc2tfYnVmZik8
YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBUQ1AgcGVyZm9ybWFuY2Ugbm90IHJlZHVj
ZWQ8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBNZW1vcnkgcmVxdWlyZW1lbnRzIGZv
ciBUQ1Agbm90IGluY3JlYXNlZDxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIE1haW50
YWluYWJpbGl0eSBub3QgbWFkZSBoYXJkZXI8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgKiBDb21w
YXJlIHRvIEtDTSwgd2hpY2ggYWRkcyBtZXRhZGF0YSB0byBlYWNoIHN0cmVhbSwgZGlkbiYjMzk7
dCByZXF1aXJlIFRDUCBjaGFuZ2VzPGJyPgo8YnI+CsKgIMKgIMKgICogV2hhdCBmaXRzIHdlbGwg
aW4gdGhlIG5ldHdvcmtpbmcgc3Vic3lzdGVtPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgICogU29t
ZSBjb25uZWN0aW9uIGNvZGUgKGNhbGxiYWNrcyBleGlzdCk8YnI+Cjxicj4KwqAgwqAgwqAgwqAg
wqAgKiBDcmVhdGluZyBhIG5ldyBzb2NrZXQgdHlwZSBmb3IgTVBUQ1A8YnI+Cjxicj4KwqAgwqAg
wqAgwqAgwqAgKiBOZXcgVUxQIGNhcGFiaWxpdHk8YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKiBObyBydWxlcyB5ZXQgZm9yIG11bHRpcGxlIHVzZXJzLCBiZWNhdXNlIFRMUyBpcyB0aGUg
b25seSB1c2VyPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgICogSW4ta2VybmVsIHNvY2tldHM8YnI+
Cjxicj4KwqAgwqAgwqAgwqAgwqAgKiBkb190Y3Bfc2VuZHBhZ2VzKCkgdG8gc2VuZCBkYXRhIGJ1
ZmZlcmVkIGF0IHRoZSBjb25uZWN0aW9uIGxldmVsPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgICog
dGNwX3JlYWRfc29jaygpIHRvIGdldCBpbmNvbWluZyBza2JzPGJyPgo8YnI+CsKgIMKgIMKgICog
V2hhdCYjMzk7cyBhIGNoYWxsZW5nZSBpbiB0aGUgbmV0d29ya2luZyBzdWJzeXN0ZW08YnI+Cjxi
cj4KwqAgwqAgwqAgwqAgwqAgKiBJbmRpcmVjdCBjYWxscyBhcmUgbm93IG1vcmUgZXhwZW5zaXZl
PGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgICogTVBUQ1AgYnVpbGRzIG9uIFRDUCBpbiBhIHVuaXF1
ZSB3YXk8YnI+Cjxicj4KwqAgwqAgwqAgKiBXaGF0IHdlIGhhdmUgdHJpZWQ8YnI+Cjxicj4KwqAg
wqAgwqAgwqAgwqAgKiBJZGVudGlmeSB3aGVyZSBvdGhlciBmZWF0dXJlcyBjb3VsZCB1c2UgVENQ
IGV4dGVuc2lvbiBjYXBhYmlsaXRpZXMgYW5kIG1lcmdlIGJlZm9yZSBNUFRDUDxicj4KPGJyPgrC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqIE9wdGlvbnMgZnJhbWV3b3JrIHVzZWQgYnkgVENQLU1ENSBh
bmQgU01DPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgICogRGlkbiYjMzk7dCB3b3JrIG91
dCAtIGV4cGVuc2l2ZSBpbmRpcmVjdCBjYWxscyBhbmQgbm8gTVBUQ1AgZnJhbWUgb2YgcmVmZXJl
bmNlIGZvciB0aGUgbWFpbnRhaW5lcjxicj4KPGJyPgrCoCDCoCDCoCDCoCDCoCAqIFNoYXJpbmcg
Y29kZSBkZW1vbnN0cmF0aW5nIGFyY2hpdGVjdHVyYWwgYXBwcm9hY2hlcyB0aGF0IHVzZSBjdXJy
ZW50IHVwc3RyZWFtIG5ldGRldiBmdW5jdGlvbmFsaXR5PGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKg
ICogTW92aW5nIGNvbXBvbmVudHMgdG8gdXNlcnNwYWNlPGJyPgo8YnI+CsKgIMKgIMKgIMKgIMKg
ICogRm9ya2luZyBhbmQgcmVkdWNpbmcgZnVuY3Rpb25hbGl0eSBvZiBleGlzdGluZyBNUFRDUCBj
b2RlIGJhc2U8YnI+Cjxicj4KwqAgwqAgwqAgKiBMYXJnZSBjaGFuZ2UgbG9naXN0aWNzPGJyPgo8
YnI+CsKgIMKgIMKgIMKgIMKgICogUmVzaGFwaW5nIGNvZGUgaW4gdG8gYSByZXZpZXdhYmxlIHBh
dGNoIHNldCBvciBwYXRjaCBzZXRzLiBJbXBsZW1lbnQgZnVuY3Rpb25hbGl0eSBpbiBzdGFnZXM/
PGJyPgo8YnI+CsKgIMKgIMKgICogRnVuZGFtZW50YWwgY2hhbGxlbmdlIG9mICZxdW90O3Nob3cg
dXMgdGhlIGNvZGUmcXVvdDsgLSBtdXN0IGRlY2lkZSB3aGF0IHNlZW1zIHVwc3RyZWFtYWJsZSwg
aW1wbGVtZW50IGl0LCBzaGFyZSwgYW5kIGl0ZXJhdGUuPGJyPgo8YnI+CjwvYmxvY2txdW90ZT4K
PGJyPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPgotLTxi
cj4KTWF0IE1hcnRpbmVhdTxicj4KSW50ZWwgT1RDPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwv
ZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWdu
YXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxk
aXY+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48dGFibGUgc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OztsZXR0ZXItc3BhY2luZzpub3JtYWw7
dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3JtOm5vbmU7d29yZC1zcGFjaW5nOjBweCIgd2lk
dGg9IjEwMCUiIGJvcmRlcj0iMCI+PHRib2R5Pjx0cj48dGQgcm93c3Bhbj0iMyIgc3R5bGU9InBh
ZGRpbmctbGVmdDo1cHg7cGFkZGluZy1yaWdodDo1cHgiIHdpZHRoPSIxMCIgdmFsaWduPSJ0b3Ai
IGFsaWduPSJsZWZ0Ij48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgdGFyZ2V0PSJf
YmxhbmsiPjxpbWcgc3JjPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldC9zaWdsb2dvLnBuZyIgYWx0
PSJUZXNzYXJlcyBTQSIgd2lkdGg9IjgwIiBoZWlnaHQ9IjgwIiBib3JkZXI9IjAiPjwvYT48L3Rk
Pjx0ZCBzdHlsZT0icGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMt
c2VyaWY7Zm9udC1zaXplOjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48c3BhbiBzdHls
ZT0iZm9udC13ZWlnaHQ6Ym9sZDtjb2xvcjpyZ2IoMzcsODMsMTU1KTtkaXNwbGF5OmlubGluZSI+
TWF0dGhpZXUgQmFlcnRzIHwgUiZhbXA7RCBFbmdpbmVlcjwvc3Bhbj48L3RkPjwvdHI+PHRyPjx0
ZCBzdHlsZT0icGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2Vy
aWY7Zm9udC1zaXplOjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48YSBocmVmPSJtYWls
dG86bWF0dGhpZXUuYmFlcnRzJTQwdGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCww
KTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPm1h
dHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ8YnI+PC9hPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxl
PSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250
LXNpemU6MTBweCIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2Nv
bG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5UZXNzYXJlcyBTQSB8IEh5YnJpZCBB
Y2Nlc3MgU29sdXRpb25zPGJyPjwvc3Bhbj48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5l
dCIgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTpp
bmxpbmUiIHRhcmdldD0iX2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxzcGFuPsKgPC9zcGFu
Pjxicj48YSBocmVmPSJodHRwczovL3d3dy5nb29nbGUuY29tL21hcHM/cT0xK0F2ZW51ZStKZWFu
K01vbm5ldCwrMTM0OCtPdHRpZ25pZXMtTG91dmFpbi1sYS1OZXV2ZSwrQmVsZ2l1bSIgc3R5bGU9
ImNvbG9yOnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRh
cmdldD0iX2JsYW5rIj4xIEF2ZW51ZSBKZWFuIE1vbm5ldCwgMTM0OCBMb3V2YWluLWxhLU5ldXZl
LCBCZWxnaXVtPC9hPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PC9kaXY+CjwvZGl2PjwvZGl2PgoKPGJyPgo8ZGl2Pjxicj48aHI+PC9kaXY+
PGZvbnQgc2l6ZT0iMSI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OlZlcmRhbmEsc2Fucy1zZXJp
ZjtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiPkRJU0NMQUlNRVIuPC9zcGFuPjxi
ciBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tncm91bmQtY29sb3I6
cmdiKDI1NSwyNTUsMjU1KSI+PGZvbnQgY29sb3I9IiMwMDAwMDAiIGZhY2U9IlZlcmRhbmEsIHNh
bnMtc2VyaWYiIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiPlRoaXMg
ZW1haWwgYW5kIGFueSBmaWxlcyB0cmFuc21pdHRlZCB3aXRoIGl0IGFyZSBjb25maWRlbnRpYWwg
YW5kIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCBvciBlbnRp
dHkgdG8gd2hvbSB0aGV5IGFyZSBhZGRyZXNzZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
ZW1haWwgaW4gZXJyb3IgcGxlYXNlIG5vdGlmeSB0aGUgc3lzdGVtIG1hbmFnZXIuIFRoaXMgbWVz
c2FnZSBjb250YWlucyBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kIGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBpbmRpdmlkdWFsIG5hbWVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgbmFtZWQgYWRk
cmVzc2VlIHlvdSBzaG91bGQgbm90IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlIG9yIGNvcHkgdGhp
cyBlLW1haWwuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSBlLW1haWwg
aWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgYnkgbWlzdGFrZSBhbmQgZGVsZXRlIHRo
aXMgZS1tYWlsIGZyb20geW91ciBzeXN0ZW0uIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQgeW91IGFyZSBub3RpZmllZCB0aGF0IGRpc2Nsb3NpbmcsIGNvcHlpbmcsIGRpc3Ry
aWJ1dGluZyBvciB0YWtpbmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMg
b2YgdGhpcyBpbmZvcm1hdGlvbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLjwvZm9udD48L2ZvbnQ+
--===============9188325109215440385==--
