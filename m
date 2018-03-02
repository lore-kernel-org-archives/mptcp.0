Content-Type: multipart/mixed; boundary="===============8011982855369073512=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Fri, 02 Mar 2018 16:03:25 +0100
Message-ID: <CAKuKrBmH39FMa=0Q4VJJa0AhXeayEmd_SvC5e0dFdeJfft-CMA@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1803011143000.24753@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 339

--===============8011982855369073512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Christoph,

On Thu, Mar 1, 2018 at 9:05 PM, Mat Martineau <mathew.j.martineau(a)linux.i=
nte
l.com> wrote:

> On Thu, 1 Mar 2018, Christoph Paasch wrote:
>
> On 01/03/18 - 18:05:40, Matthieu Baerts wrote:
>>
>>> Hi Christoph,
>>>
>>> On Wed, Feb 28, 2018 at 11:41 PM, Christoph Paasch <cpaasch(a)apple.com>
>>> wrote:
>>>
>>> Yeah, feedback was disappointingly scarce :/
>>>>
>>>> It probably was not what he had completely in mind, as he didn't talk
>>>> about
>>>> a TCP-option framework but simply about moving TCP-MD5 code out of the
>>>> TCP-stack. So, with our proposal we went a bit further.
>>>>
>>>>
>>> Or maybe simply unlucky with who was available at this time to have a
>>> look
>>> at them :)
>>>
>>>
>>> TLS is a good example. They actually do have a lookup table where the
>>>> driver
>>>> is calling back into the TCP-stack to get the TLS-record information.
>>>>
>>>> We had discussed this with people from Mellanox that proposed the
>>>> TLS hardware offloading: https://lists.01.org/
>>>> pipermail/mptcp/2017-November/000165.html
>>>>
>>>
>>>
>>> Thank you for the link!
>>>
>>> Yes, that would be good! Just a short weekly sync could be useful.
>>>
>>>>
>>>> Do you have a Webex or other means to set this up?
>>>>
>>>>
>>> I think I can setup a webex (even if it is less fun to use that on a
>>> Linux
>>> desktop :) ). We already used talky.io, more Linux friendly if we need
>>> to
>>> share screen and others, maybe not needed.
>>>
>>
>> talky.io is fine for me as well.
>>
>
> I haven't used it before, but it looks like a fine option. Thank you for
> setting this up.
>

The good thing is that we can have a public URL, just in case someone else
would help for this upstreaming task: https://talky.io/mptcp_upstreaming

I can also define a shared key if needed.

Another issue may be the time. I think you are all in the west coast of the
>>> US :-)
>>> But I am sure I can find time on the evening for a short meeting!
>>>
>>
>> Ideally for me, it would be at 9am (for you 6pm). Otherwise, I can make
>> 8am
>> as well (5pm for you).
>>
>> I don't know what the opinion of the others is on the timing.
>>
>
> I'm also in the Pacific time zone, as are my coworkers Peter and Ossama.
> Personally, 9am works better.
>

9am (6pm here) is good for me!

When would you like to have our first meeting? At 6pm, I should not have
any other meetings.
Exceptionally I will not be available this Tuesday 6th of March. Just to
propose a date, what about Wednesday 7th of March?

Looking forward to the netlink PM! :-)
>>>>
>>>>
>>> I hope I will have time very soon to clean this.
>>> Mat, do you prefer to talk about that directly by commenting the patches
>>> on
>>> mptcp-dev ML?
>>>
>>
> That's fine with me. I did read the paper (unfortunately I hadn't come
> across it before!), and it looks like our approaches have a lot in common=
 -
> it will be informative to compare the details.
>

Good idea! I will work on the rebase/clean-up and send it to mptcp-dev ML.
I will add you in cc.

From earlier in this sub-thread:
>
>      This is what I'm working on now. For outgoing packets, I have a way
>>      to optionally allocate sk_buffs with extra control block space. For
>>      incoming packets, my initial experiment is with preventing packet
>>      coalesce/collapse so TCP options are still in the skb headroom. I
>>      don't consider that a long-term solution, though. Some kind of
>>      lookup table will probably be needed.
>>
>> That looks interesting!
>>
>> On some systems with hardware acceleration to bypass the main CPU for
>> established connections, I guess they also have to modify the skb to sha=
re
>> info between the main CPU and another component. Do you have any ideas h=
ow
>> they are doing that? It is maybe not a real problem for them to increase
>> the size of the skb if most of the traffic goes in the "fast path".
>>
>
> Are you referring to userspace stacks (like DPDK), or optimizations like
> GRO? I'm not sure of the specific answer to your question, but from what I
> see the drivers try to allocate enough space in the skbs to accomodate the
> storage needs through the skb's lifetime.


Sorry, I was not clear. I don't know if it is common to do that, maybe not
because it is not upstream.

In short, the NIC (or another external HW module) of a router/switch is
doing some learning about the flows it needs to forward. Once this
NIC/module knows the flow, the Linux network stack no longer see the rest
of a traffic because it has been "accelerated".
Here is a longer description when this is done by the NIC:
https://www.netronome.com/media/documents/WP_Hardware_
Acceleration.pdf#WP_Hardware_Acceleration.indd%3A.3203%3A27

But I guess there are some info that the NIC/module cannot learn by itself
when looking at the beginning of the flow like what QoS to apply, if a
specific flow can be "accelerated" or not, etc. These info are certainly
shared in the skb.

Now that I am thinking more about this scenario, it will maybe not help for
our MPTCP case. I was supposing these info shared via the skb could be
randomly present. But even if the skb is bigger all the time, I guess this
is not a problem for them because at the end, the Linux network stack will
only see a very small part of the traffic, not a big deal to have more
cache misses for the slow path only (and some other exceptions).
In other words, their skb is maybe too big as well but that's not a problem.

Best regards,
Matthieu
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


------------------------------
DISCLAIMER.
This email and any files transmitted with it are confidential and intended =

solely for the use of the individual or entity to whom they are addressed. =

If you have received this email in error please notify the system manager. =

This message contains confidential information and is intended only for the =

individual named. If you are not the named addressee you should not =

disseminate, distribute or copy this e-mail. Please notify the sender =

immediately by e-mail if you have received this e-mail by mistake and =

delete this e-mail from your system. If you are not the intended recipient =

you are notified that disclosing, copying, distributing or taking any =

action in reliance on the contents of this information is strictly =

prohibited.

--===============8011982855369073512==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgTWF0LCBDaHJpc3RvcGgsPGJyPjxkaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1LCBNYXIgMSwgMjAx
OCBhdCA5OjA1IFBNLCBNYXQgTWFydGluZWF1IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0i
bWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZTx3YnI+bC5jb208L2E+Jmd0Ozwvc3Bhbj4g
d3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0ibV84OTQwOTQ2MjI2MjQxMjc0ODc5Z21haWwt
bV8zMzk2ODk3NjY1MzAxMDM4MDU2Z21haWwtIj5PbiBUaHUsIDEgTWFyIDIwMTgsIENocmlzdG9w
aCBQYWFzY2ggd3JvdGU6PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KT24gMDEvMDMvMTggLSAxODowNTo0MCwg
TWF0dGhpZXUgQmFlcnRzIHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpIaSBDaHJpc3RvcGgsPGJyPgo8YnI+
Ck9uIFdlZCwgRmViIDI4LCAyMDE4IGF0IDExOjQxIFBNLCBDaHJpc3RvcGggUGFhc2NoICZsdDs8
YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBsZS5jb20iIHRhcmdldD0iX2JsYW5rIj5jcGFhc2No
QGFwcGxlLmNvbTwvYT4mZ3Q7PGJyPgp3cm90ZTo8YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpZZWFoLCBmZWVk
YmFjayB3YXMgZGlzYXBwb2ludGluZ2x5IHNjYXJjZSA6Lzxicj4KPGJyPgpJdCBwcm9iYWJseSB3
YXMgbm90IHdoYXQgaGUgaGFkIGNvbXBsZXRlbHkgaW4gbWluZCwgYXMgaGUgZGlkbiYjMzk7dCB0
YWxrIGFib3V0PGJyPgphIFRDUC1vcHRpb24gZnJhbWV3b3JrIGJ1dCBzaW1wbHkgYWJvdXQgbW92
aW5nIFRDUC1NRDUgY29kZSBvdXQgb2YgdGhlPGJyPgpUQ1Atc3RhY2suIFNvLCB3aXRoIG91ciBw
cm9wb3NhbCB3ZSB3ZW50IGEgYml0IGZ1cnRoZXIuPGJyPgo8YnI+CjwvYmxvY2txdW90ZT4KPGJy
PgpPciBtYXliZSBzaW1wbHkgdW5sdWNreSB3aXRoIHdobyB3YXMgYXZhaWxhYmxlIGF0IHRoaXMg
dGltZSB0byBoYXZlIGEgbG9vazxicj4KYXQgdGhlbSA6KTxicj4KPGJyPgo8YnI+CjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4K
VExTIGlzIGEgZ29vZCBleGFtcGxlLiBUaGV5IGFjdHVhbGx5IGRvIGhhdmUgYSBsb29rdXAgdGFi
bGUgd2hlcmUgdGhlPGJyPgpkcml2ZXI8YnI+CmlzIGNhbGxpbmcgYmFjayBpbnRvIHRoZSBUQ1At
c3RhY2sgdG8gZ2V0IHRoZSBUTFMtcmVjb3JkIGluZm9ybWF0aW9uLjxicj4KPGJyPgpXZSBoYWQg
ZGlzY3Vzc2VkIHRoaXMgd2l0aCBwZW9wbGUgZnJvbSBNZWxsYW5veCB0aGF0IHByb3Bvc2VkIHRo
ZTxicj4KVExTIGhhcmR3YXJlIG9mZmxvYWRpbmc6IDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuMDEu
b3JnLyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy4wMS5v
cmcvPC9hPjxicj4KcGlwZXJtYWlsL21wdGNwLzIwMTctTm92ZW1iZXIvPHdicj4wMDAxNjUuaHRt
bDxicj4KPC9ibG9ja3F1b3RlPgo8YnI+Cjxicj4KVGhhbmsgeW91IGZvciB0aGUgbGluayE8YnI+
Cjxicj4KWWVzLCB0aGF0IHdvdWxkIGJlIGdvb2QhIEp1c3QgYSBzaG9ydCB3ZWVrbHkgc3luYyBj
b3VsZCBiZSB1c2VmdWwuPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQs
MjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KRG8geW91IGhhdmUgYSBXZWJleCBvciBv
dGhlciBtZWFucyB0byBzZXQgdGhpcyB1cD88YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+Ckkg
dGhpbmsgSSBjYW4gc2V0dXAgYSB3ZWJleCAoZXZlbiBpZiBpdCBpcyBsZXNzIGZ1biB0byB1c2Ug
dGhhdCBvbiBhIExpbnV4PGJyPgpkZXNrdG9wIDopICkuIFdlIGFscmVhZHkgdXNlZCA8YSBocmVm
PSJodHRwOi8vdGFsa3kuaW8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnRhbGt5
LmlvPC9hPiwgbW9yZSBMaW51eCBmcmllbmRseSBpZiB3ZSBuZWVkIHRvPGJyPgpzaGFyZSBzY3Jl
ZW4gYW5kIG90aGVycywgbWF5YmUgbm90IG5lZWRlZC48YnI+CjwvYmxvY2txdW90ZT4KPGJyPgo8
YSBocmVmPSJodHRwOi8vdGFsa3kuaW8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
PnRhbGt5LmlvPC9hPiBpcyBmaW5lIGZvciBtZSBhcyB3ZWxsLjxicj4KPC9ibG9ja3F1b3RlPgo8
YnI+PC9zcGFuPgpJIGhhdmVuJiMzOTt0IHVzZWQgaXQgYmVmb3JlLCBidXQgaXQgbG9va3MgbGlr
ZSBhIGZpbmUgb3B0aW9uLiBUaGFuayB5b3UgZm9yIHNldHRpbmcgdGhpcyB1cC48c3BhbiBjbGFz
cz0ibV84OTQwOTQ2MjI2MjQxMjc0ODc5Z21haWwtbV8zMzk2ODk3NjY1MzAxMDM4MDU2Z21haWwt
Ij48YnI+PC9zcGFuPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PiBUaGUgZ29vZCB0
aGluZyBpcyB0aGF0IHdlIGNhbiBoYXZlIGEgcHVibGljIFVSTCwganVzdCBpbiBjYXNlIHNvbWVv
bmUgZWxzZSB3b3VsZCBoZWxwIGZvciB0aGlzIHVwc3RyZWFtaW5nIHRhc2s6IDxhIGhyZWY9Imh0
dHBzOi8vdGFsa3kuaW8vbXB0Y3BfdXBzdHJlYW1pbmciIHRhcmdldD0iX2JsYW5rIj5odHRwczov
L3RhbGt5LmlvL21wdGNwX3Vwc3RyZWE8d2JyPm1pbmc8L2E+PGJyPjxicj48L2Rpdj48ZGl2Pkkg
Y2FuIGFsc28gZGVmaW5lIGEgc2hhcmVkIGtleSBpZiBuZWVkZWQuPGJyPjxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+PHNwYW4gY2xhc3M9Im1fODk0MDk0NjIyNjI0MTI3NDg3OWdtYWlsLW1fMzM5Njg5NzY2NTMw
MTAzODA1NmdtYWlsLSI+Cgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJn
YigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CkFub3RoZXIgaXNzdWUgbWF5IGJlIHRo
ZSB0aW1lLiBJIHRoaW5rIHlvdSBhcmUgYWxsIGluIHRoZSB3ZXN0IGNvYXN0IG9mIHRoZTxicj4K
VVMgOi0pPGJyPgpCdXQgSSBhbSBzdXJlIEkgY2FuIGZpbmQgdGltZSBvbiB0aGUgZXZlbmluZyBm
b3IgYSBzaG9ydCBtZWV0aW5nITxicj4KPC9ibG9ja3F1b3RlPgo8YnI+CklkZWFsbHkgZm9yIG1l
LCBpdCB3b3VsZCBiZSBhdCA5YW0gKGZvciB5b3UgNnBtKS4gT3RoZXJ3aXNlLCBJIGNhbiBtYWtl
IDhhbTxicj4KYXMgd2VsbCAoNXBtIGZvciB5b3UpLjxicj4KPGJyPgpJIGRvbiYjMzk7dCBrbm93
IHdoYXQgdGhlIG9waW5pb24gb2YgdGhlIG90aGVycyBpcyBvbiB0aGUgdGltaW5nLjxicj4KPC9i
bG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpJJiMzOTttIGFsc28gaW4gdGhlIFBhY2lmaWMgdGltZSB6
b25lLCBhcyBhcmUgbXkgY293b3JrZXJzIFBldGVyIGFuZCBPc3NhbWEuIFBlcnNvbmFsbHksIDlh
bSB3b3JrcyBiZXR0ZXIuPHNwYW4gY2xhc3M9Im1fODk0MDk0NjIyNjI0MTI3NDg3OWdtYWlsLW1f
MzM5Njg5NzY2NTMwMTAzODA1NmdtYWlsLSI+PGJyPjwvc3Bhbj48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj45YW0gKDZwbSBoZXJlKSBpcyBnb29kIGZvciBtZSE8YnI+PGJyPjwvZGl2
PjxkaXY+V2hlbiB3b3VsZCB5b3UgbGlrZSB0byBoYXZlIG91ciBmaXJzdCBtZWV0aW5nPyBBdCA2
cG0sIEkgc2hvdWxkIG5vdCBoYXZlIGFueSBvdGhlciBtZWV0aW5ncy48YnI+RXhjZXB0aW9uYWxs
eSBJIHdpbGwgbm90IGJlIGF2YWlsYWJsZSB0aGlzIFR1ZXNkYXkgNnRoIG9mIE1hcmNoLiBKdXN0
IHRvIHByb3Bvc2UgYSBkYXRlLCB3aGF0IGFib3V0IFdlZG5lc2RheSA3dGggb2YgTWFyY2g/PGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIw
NCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0ibV84OTQwOTQ2MjI2MjQx
Mjc0ODc5Z21haWwtbV8zMzk2ODk3NjY1MzAxMDM4MDU2Z21haWwtIj4KCjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KCjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4KCgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+Ckxvb2tpbmcgZm9yd2FyZCB0byB0aGUgbmV0bGluayBQTSEgOi0pPGJyPgo8
YnI+CjwvYmxvY2txdW90ZT4KPGJyPgpJIGhvcGUgSSB3aWxsIGhhdmUgdGltZSB2ZXJ5IHNvb24g
dG8gY2xlYW4gdGhpcy48YnI+Ck1hdCwgZG8geW91IHByZWZlciB0byB0YWxrIGFib3V0IHRoYXQg
ZGlyZWN0bHkgYnkgY29tbWVudGluZyB0aGUgcGF0Y2hlcyBvbjxicj4KbXB0Y3AtZGV2IE1MPzxi
cj4KPC9ibG9ja3F1b3RlPjwvYmxvY2txdW90ZT4KPGJyPjwvc3Bhbj4KVGhhdCYjMzk7cyBmaW5l
IHdpdGggbWUuIEkgZGlkIHJlYWQgdGhlIHBhcGVyICh1bmZvcnR1bmF0ZWx5IEkgaGFkbiYjMzk7
dCBjb21lIGFjcm9zcyBpdCBiZWZvcmUhKSwgYW5kIGl0IGxvb2tzIGxpa2Ugb3VyIGFwcHJvYWNo
ZXMgaGF2ZSBhIGxvdCBpbiBjb21tb24gLSBpdCB3aWxsIGJlIGluZm9ybWF0aXZlIHRvIGNvbXBh
cmUgdGhlIGRldGFpbHMuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkdvb2Qg
aWRlYSEgSSB3aWxsIHdvcmsgb24gdGhlIHJlYmFzZS9jbGVhbi11cCBhbmQgc2VuZCBpdCB0byBt
cHRjcC1kZXYgTUwuIEkgd2lsbCBhZGQgeW91IGluIGNjLjxicj48YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgoK
PkZyb20gZWFybGllciBpbiB0aGlzIHN1Yi10aHJlYWQ6PHNwYW4gY2xhc3M9Im1fODk0MDk0NjIy
NjI0MTI3NDg3OWdtYWlsLW1fMzM5Njg5NzY2NTMwMTAzODA1NmdtYWlsLSI+PGJyPgo8YnI+Cjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij4KwqAgwqAgwqBUaGlzIGlzIHdoYXQgSSYjMzk7bSB3b3JraW5nIG9uIG5vdy4gRm9yIG91
dGdvaW5nIHBhY2tldHMsIEkgaGF2ZSBhIHdheTxicj4KwqAgwqAgwqB0byBvcHRpb25hbGx5IGFs
bG9jYXRlIHNrX2J1ZmZzIHdpdGggZXh0cmEgY29udHJvbCBibG9jayBzcGFjZS4gRm9yPGJyPgrC
oCDCoCDCoGluY29taW5nIHBhY2tldHMsIG15IGluaXRpYWwgZXhwZXJpbWVudCBpcyB3aXRoIHBy
ZXZlbnRpbmcgcGFja2V0PGJyPgrCoCDCoCDCoGNvYWxlc2NlL2NvbGxhcHNlIHNvIFRDUCBvcHRp
b25zIGFyZSBzdGlsbCBpbiB0aGUgc2tiIGhlYWRyb29tLiBJPGJyPgrCoCDCoCDCoGRvbiYjMzk7
dCBjb25zaWRlciB0aGF0IGEgbG9uZy10ZXJtIHNvbHV0aW9uLCB0aG91Z2guIFNvbWUga2luZCBv
Zjxicj4KwqAgwqAgwqBsb29rdXAgdGFibGUgd2lsbCBwcm9iYWJseSBiZSBuZWVkZWQuPGJyPgo8
YnI+ClRoYXQgbG9va3MgaW50ZXJlc3RpbmchPGJyPgo8YnI+Ck9uIHNvbWUgc3lzdGVtcyB3aXRo
IGhhcmR3YXJlIGFjY2VsZXJhdGlvbiB0byBieXBhc3MgdGhlIG1haW4gQ1BVIGZvciBlc3RhYmxp
c2hlZCBjb25uZWN0aW9ucywgSSBndWVzcyB0aGV5IGFsc28gaGF2ZSB0byBtb2RpZnkgdGhlIHNr
YiB0byBzaGFyZSBpbmZvIGJldHdlZW4gdGhlIG1haW4gQ1BVIGFuZCBhbm90aGVyIGNvbXBvbmVu
dC4gRG8geW91IGhhdmUgYW55IGlkZWFzIGhvdyB0aGV5IGFyZSBkb2luZyB0aGF0PyBJdCBpcyBt
YXliZSBub3QgYSByZWFsIHByb2JsZW0gZm9yIHRoZW0gdG8gaW5jcmVhc2UgdGhlIHNpemUgb2Yg
dGhlIHNrYiBpZiBtb3N0IG9mIHRoZSB0cmFmZmljIGdvZXMgaW4gdGhlICZxdW90O2Zhc3QgcGF0
aCZxdW90Oy48YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvc3Bhbj4KQXJlIHlvdSByZWZlcnJpbmcg
dG8gdXNlcnNwYWNlIHN0YWNrcyAobGlrZSBEUERLKSwgb3Igb3B0aW1pemF0aW9ucyBsaWtlIEdS
Tz8gSSYjMzk7bSBub3Qgc3VyZSBvZiB0aGUgc3BlY2lmaWMgYW5zd2VyIHRvIHlvdXIgcXVlc3Rp
b24sIGJ1dCBmcm9tIHdoYXQgSSBzZWUgdGhlIGRyaXZlcnMgdHJ5IHRvIGFsbG9jYXRlIGVub3Vn
aCBzcGFjZSBpbiB0aGUgc2ticyB0byBhY2NvbW9kYXRlIHRoZSBzdG9yYWdlIG5lZWRzIHRocm91
Z2ggdGhlIHNrYiYjMzk7cyBsaWZldGltZS48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRp
dj5Tb3JyeSwgSSB3YXMgbm90IGNsZWFyLiBJIGRvbiYjMzk7dCBrbm93IGlmIGl0IGlzIGNvbW1v
biB0byBkbyB0aGF0LCBtYXliZSBub3QgYmVjYXVzZSBpdCBpcyBub3QgdXBzdHJlYW0uPGJyPjxi
cj48L2Rpdj48ZGl2PkluIHNob3J0LCB0aGUgTklDIChvciBhbm90aGVyIGV4dGVybmFsIEhXIG1v
ZHVsZSkgb2YgYSByb3V0ZXIvc3dpdGNoIGlzIGRvaW5nIHNvbWUgbGVhcm5pbmcgYWJvdXQgdGhl
IGZsb3dzIGl0IG5lZWRzIHRvIGZvcndhcmQuIE9uY2UgdGhpcyBOSUMvbW9kdWxlIGtub3dzIHRo
ZSBmbG93LCB0aGUgTGludXggbmV0d29yayBzdGFjayBubyBsb25nZXIgc2VlIHRoZSByZXN0IG9m
IGEgdHJhZmZpYyBiZWNhdXNlIGl0IGhhcyBiZWVuICZxdW90O2FjY2VsZXJhdGVkJnF1b3Q7Ljxi
cj5IZXJlIGlzIGEgbG9uZ2VyIGRlc2NyaXB0aW9uIHdoZW4gdGhpcyBpcyBkb25lIGJ5IHRoZSBO
SUM6IDxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5ldHJvbm9tZS5jb20vbWVkaWEvZG9jdW1lbnRzL1dQ
X0hhcmR3YXJlX0FjY2VsZXJhdGlvbi5wZGYjV1BfSGFyZHdhcmVfQWNjZWxlcmF0aW9uLmluZGQl
M0EuMzIwMyUzQTI3IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0cm9ub21lLmNvbS88
d2JyPm1lZGlhL2RvY3VtZW50cy9XUF9IYXJkd2FyZV88d2JyPkFjY2VsZXJhdGlvbi5wZGYjV1Bf
SGFyZHdhcmVfPHdicj5BY2NlbGVyYXRpb24uaW5kZCUzQS4zMjAzJTNBMjc8L2E+PGJyPjxicj48
L2Rpdj48ZGl2PkJ1dCBJIGd1ZXNzIHRoZXJlIGFyZSBzb21lIGluZm8gdGhhdCB0aGUgTklDL21v
ZHVsZSBjYW5ub3QgbGVhcm4gYnkgaXRzZWxmIHdoZW4gbG9va2luZyBhdCB0aGUgYmVnaW5uaW5n
IG9mIHRoZSBmbG93IGxpa2Ugd2hhdCBRb1MgdG8gYXBwbHksIGlmIGEgc3BlY2lmaWMgZmxvdyBj
YW4gYmUgJnF1b3Q7YWNjZWxlcmF0ZWQmcXVvdDsgb3Igbm90LCBldGMuIFRoZXNlIGluZm8gYXJl
IGNlcnRhaW5seSBzaGFyZWQgaW4gdGhlIHNrYi48YnI+PGJyPk5vdyB0aGF0IEkgYW0gdGhpbmtp
bmcgbW9yZSBhYm91dCB0aGlzIHNjZW5hcmlvLCBpdCB3aWxsIG1heWJlIG5vdCBoZWxwIGZvciBv
dXIgTVBUQ1AgY2FzZS4gSSB3YXMgc3VwcG9zaW5nIHRoZXNlIGluZm8gc2hhcmVkIHZpYSB0aGUg
c2tiIGNvdWxkIGJlIHJhbmRvbWx5IHByZXNlbnQuIEJ1dCBldmVuIGlmIHRoZSBza2IgaXMgYmln
Z2VyIGFsbCB0aGUgdGltZSwgSSBndWVzcyB0aGlzIGlzIG5vdCBhIHByb2JsZW0gZm9yIHRoZW0g
YmVjYXVzZSBhdCB0aGUgZW5kLCB0aGUgTGludXggbmV0d29yayBzdGFjayB3aWxsIG9ubHkgc2Vl
IGEgdmVyeSBzbWFsbCBwYXJ0IG9mIHRoZSB0cmFmZmljLCBub3QgYSBiaWcgZGVhbCB0byBoYXZl
IG1vcmUgY2FjaGUgbWlzc2VzIGZvciB0aGUgc2xvdyBwYXRoIG9ubHkgKGFuZCBzb21lIG90aGVy
IGV4Y2VwdGlvbnMpLjxicj5JbiBvdGhlciB3b3JkcywgdGhlaXIgc2tiIGlzIG1heWJlIHRvbyBi
aWcgYXMgd2VsbCBidXQgdGhhdCYjMzk7cyBub3QgYSBwcm9ibGVtLjxicj48YnI+PC9kaXY+PGRp
dj5CZXN0IHJlZ2FyZHMsPGJyPjwvZGl2PjxkaXY+TWF0dGhpZXU8YnI+PC9kaXY+PC9kaXY+LS0g
PGJyPjxkaXYgY2xhc3M9Im1fODk0MDk0NjIyNjI0MTI3NDg3OWdtYWlsLW1fMzM5Njg5NzY2NTMw
MTAzODA1NmdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRy
Ij48ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7VGlt
ZXMgTmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFjaW5nOm5vcm1hbDt0ZXh0LWluZGVudDowcHg7
dGV4dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNpbmc6MHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVy
PSIwIj48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIzIiBzdHlsZT0icGFkZGluZy1sZWZ0OjVweDtw
YWRkaW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2YWxpZ249InRvcCIgYWxpZ249ImxlZnQiPjxh
IGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+PGltZyBzcmM9
Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xvZ28ucG5nIiBhbHQ9IlRlc3NhcmVzIFNBIiB3
aWR0aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0iMCI+PC9hPjwvdGQ+PHRkIHN0eWxlPSJwYWRk
aW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6
MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpi
b2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5NYXR0aGlldSBCYWVydHMg
fCBSJmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5n
OjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBw
eCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVy
dHMlNDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO3RleHQtZGVjb3JhdGlv
bjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRzQHRl
c3NhcmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6MHB4O2Zv
bnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMHB4IiBhbGln
bj0ibGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQ7Y29sb3I6cmdiKDM3LDgzLDE1
NSk7ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8
YnI+PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6
cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJf
YmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNwYW4+wqA8L3NwYW4+PGJyPjxhIGhyZWY9Imh0
dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4K090
dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxnaXVtIiBzdHlsZT0iY29sb3I6cmdiKDAsMCww
KTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPjEg
QXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEtTmV1dmUsIEJlbGdpdW08L2E+PC90
ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rp
dj4KPC9kaXY+PC9kaXY+PC9kaXY+Cgo8YnI+CjxkaXY+PGJyPjxocj48L2Rpdj48Zm9udCBzaXpl
PSIxIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tncm91
bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+RElTQ0xBSU1FUi48L3NwYW4+PGJyIHN0eWxlPSJm
b250LWZhbWlseTpWZXJkYW5hLHNhbnMtc2VyaWY7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1
NSwyNTUpIj48Zm9udCBjb2xvcj0iIzAwMDAwMCIgZmFjZT0iVmVyZGFuYSwgc2Fucy1zZXJpZiIg
c3R5bGU9ImJhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+VGhpcyBlbWFpbCBhbmQg
YW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5k
ZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aG9t
IHRoZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBl
cnJvciBwbGVhc2Ugbm90aWZ5IHRoZSBzeXN0ZW0gbWFuYWdlci4gVGhpcyBtZXNzYWdlIGNvbnRh
aW5zIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhl
IGluZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgeW91
IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUgb3IgY29weSB0aGlzIGUtbWFpbC4g
UGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGUtbWFpbCBpZiB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieSBtaXN0YWtlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwg
ZnJvbSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCB5
b3UgYXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29weWluZywgZGlzdHJpYnV0aW5nIG9y
IHRha2luZyBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlzIGlu
Zm9ybWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPC9mb250PjwvZm9udD4=
--===============8011982855369073512==--
