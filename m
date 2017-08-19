Content-Type: multipart/mixed; boundary="===============9026035930957772991=="
MIME-Version: 1.0
From: Lorenzo Colitti <lorenzo at google.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming strategy and design
Date: Sat, 19 Aug 2017 13:43:38 +0900
Message-ID: <CAKD1Yr1RpFoy-OjniVhn5=2cCc=p_xHByE8Ae1x8cqRAetCL6g@mail.gmail.com>
In-Reply-To: 20170802050903.GF66276@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 78

--===============9026035930957772991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All,

Sorry I'm late to this thread. I've been thinking about this for a while,
and wanted to share some of those thoughts in the hope that they are useful.

Reading through the 4.4 patch, many of the points made by Mat make sense to
me. Especially, off-by-default is important (upstream cares deeply about
backwards compatibility). In fact, personally I don't see a lot of
advantage to enabling MPTCP on unmodified applications that directly call
the socket API. But perhaps there are use cases there that I don't see.

Having as much code in userspace as possible will help.  Moving path
management to userspace seems like it could be an easy way to do that (and
thinking specifically about how Android does networking, the kernel doesn't
really have enough information to decide which subflows should go where,
anyway). For a mobile device, the simplest approach seems to be to just to
have zero or one subflows per interface, with explicit addition and removal
of subflows from userspace, and possibly a setsockopt to add and disable
MP_PRIO.

What I think that means is that there needs to be a subflow abstraction
that userspace can see. One way to do this might be to expose the subflows
as individual sockets on which read() and write() return EINVAL, but on
which connect() and setsockopt() can operate as normal - connect() to
establish a subflow, setsockopt() to do things like set subflows to backup,
ask the kernel to send the MP_PRIO option, and so on. Not sure what you'd
do on a server to get the subflows for accepted connections, though. For
blocking calls you could use accept() on the master socket, but really you
want an asynchronous notification when a connection comes in. Perhaps give
up support for urgent data and re-use POLLPRI? There is precedent for
reusing POLLPRI for things that aren't urgent data, but such as solution
might be seen as too hacky by upstream.

The alternative would be to expose only one filedescriptor and use
subsetsockopts to affect the individual flows, like
draft-hesmans-mptcp-socket-02
does. On Android specifically, routing traffic on a particular network
(e.g., wifi vs. cellular) requires that sk->sk_mark be set to an
appropriate value, so there must be a way to do that for each subflow.

One general thing I've heard is that having the API flow be similar to the
single-TCP-socket model is an advantage - for example, I hear that one of
the reasons for the low adoption of TFO on Linux is that the API is
different to standard TCP because it uses sendto() instead of connect, and
that makes it hard to use lots of libraries such as openssl that want "a
filedescriptor of a connected socket".

The scheduler seems like it could belong in the kernel, because it has to
react quickly to events such as receiving packets. Perhaps this could use
similar mechanisms to the existing pluggable congestion control algorithms?
Another option, for advanced clients, would be to have userspace pass in a
scheduling algorithm written in EBPF. One thing that might be helpful is to
have a "send all packets on all subflows" scheduler for cases, though I'm
not sure if that's feasible.

Regards,
Lorenzo

On Wed, Aug 2, 2017 at 2:09 PM, Christoph Paasch <cpaasch(a)apple.com> wrot=
e:

> Hello,
>
> I'm adding Lorenzo (in CC) from Google to this thread. Lorenzo works on t=
he
> networking of Android at Google.
> Lorenzo, you can subscribe to the mailing-list at
> https://lists.01.org/mailman/listinfo/mptcp.
>
>
> I discussed MPTCP with him at the IETF two weeks back, and he was
> interested
> in helping making MPTCP upstreamable.
> I let him chime in on the discussion.
>
>
>
> Wrt. to the below, yes I agree with the appraoch Mat outlined.
> On my side, I will be able to spend more cycles now on Linux. I will start
> by porting the code from multipath-tcp.org up to upstream's version (we
> have
> been lagging behind quite a bit again). That way we have a common base
> where
> we can easily see how well the RFC-patches (for example more generic
> capabilities in TCP) would work with MPTCP.
>
>
> Cheers,
> Christoph
>
>
>
> On 18/07/17 - 17:31:51, Mat Martineau wrote:
> >
> > Hello everyone,
> >
> > Our goal on this mailing list is to add an MPTCP implementation to the
> > upstream Linux kernel. There's a fair amount of work to be done to
> achieve
> > this, and a number of options for how to go about it. Some of this
> revisits
> > previous discussions on this list and elsewhere, but I want to be sure =
we
> > have some level of consensus about the direction to head in.
> >
> > A couple of us on this list have had discussions with the Linux net
> > maintainers, and they have some some specific needs concerning
> modifications
> > to the Linux TCP stack:
> >
> >  * TCP complexity can't increase. It's already a complex,
> > performance-sensitive piece of software that every Linux user depends o=
n.
> > Intrusive changes have a risk of creating bugs or changing operation of
> the
> > stack in unexpected ways.
> >
> >  * sk_buff structure size can't get bigger. It's already large and, if
> > anything, they hope to reduce it's size. Changes to the data structure
> size
> > are amplified by the large number of instances in a system handling a
> lot of
> > traffic.
> >
> >  * An additional protocol like MPTCP should be opt-in, so users of
> regular
> > TCP continue to get the same type of connection and performance unless
> MPTCP
> > is requested.
> >
> > I also recommend reading "On submitting kernel patches"
> > (http://halobates.de/on-submitting-patches.pdf) to get an idea of the
> > process and hurdles involved in merging major core functionality for the
> > Linux kernel.
> >
> >
> > Various Strategies
> > ------------------
> >
> > One approach is to attempt to merge the multipath-tcp.org fork. This is
> an
> > implementation in which the multipath-tcp.org community has invested a
> lot
> > of time and effort, and it is in production for major applications (see
> > https://tools.ietf.org/html/rfc8041). This is a tremendous amount of
> code to
> > review at once (even separating out modules), and currently doesn't fit
> with
> > what the maintainers have asked for (non-intrusive, sk_buff size, MPTCP
> by
> > default). I don't think the maintainers would consider merging such an
> > extensive piece git history, especially where there are a fair number of
> > commits without an "mptcp:" label on the subject line or without a DCO
> > signoff (https://www.kernel.org/doc/html/latest/process/
> submitting-patches.html#sign-your-work-the-developer-s-
> certificate-of-origin).
> > Today, the fork is at kernel v4.4 and current upstream development is at
> > v4.13-rc1, so the fork would have to catch up and stay current.
> >
> > The other extreme is to rewrite from scratch. This would allow
> incremental
> > development with maintainer review from the start, but doesn't take
> > advantage of existing code.
> >
> > The most realistic approach is somewhere in between, where we write new
> code
> > that fits maintainer expectations and utilize components from the fork
> where
> > licensing allows and the code fits. We'll have to find the right balanc=
e:
> > over-reliance on new code could take extra time, but constantly reworki=
ng
> > the fork and keeping it up-to-date with net-next is also a lot of
> overhead.
> >
> > To start with, we can create RFC patches (code that's ready for comment
> > rather than merge -- not "RFC" in the IETF sense) that allow us to exte=
nd
> > TCP in the ways that are useful for both MPTCP and other extended TCP
> > features. The maintainers would be able to review those standalone
> patches,
> > and there's potential to backport the patches to prove them out with the
> > multipath-tcp.org code. Does this sound sensible? Any other approaches
> to
> > consider, or details that we should discuss here?
> >
> >
> > Design for Upstream
> > -------------------
> >
> > As a starting point for discussion, here are some characteristics that
> might
> > make MPTCP more upstream-friendly:
> >
> >  * MPTCP is used when requested by the application, either through an
> > IPPROTO_MPTCP parameter to socket() or by using the new ULP (Upper Layer
> > Protocol) capability.
> >
> >  * Move away from meta-sockets, treating each subflow more like a regul=
ar
> > TCP connection. The overall MPTCP connection is coordinated by an upper
> > layer socket that is distinct from tcp_sock.
> >
> >  * Move functionality to userspace where possible, like tracking
> ADD_ADDRs
> > received, initiating new subflows, or accepting new subflows.
> >
> >  * Avoid adding locks to coordinate access to data that's shared between
> > subflows. Utilize capabilities like compare-and-swap (cmpxchg), atomics,
> and
> > RCU to deal with shared data efficiently.
> >
> >  * Add generic capabilities to the TCP stack where it looks useful to
> other
> > protocol extensions. Examples: dynamically register handlers for TCP
> option
> > headers, make it possible to pass TCP options to/from an upper layer.
> >
> > Any comment on these? Maybe each deserves a thread of its own.
> >
> >
> > Thanks again to Rao, Christoph, Peter, and Ossama for your help, work,
> and
> > interest. I'm looking forward to your insights.
> >
> >
> > --
> > Mat Martineau
> > Intel OTC
> > _______________________________________________
> > mptcp mailing list
> > mptcp(a)lists.01.org
> > https://lists.01.org/mailman/listinfo/mptcp
>

--===============9026035930957772991==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+QWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+U29ycnkgSSYjMzk7bSBsYXRl
IHRvIHRoaXMgdGhyZWFkLiBJJiMzOTt2ZSBiZWVuIHRoaW5raW5nIGFib3V0IHRoaXMgZm9yIGEg
d2hpbGUsIGFuZCB3YW50ZWQgdG8gc2hhcmUgc29tZSBvZiB0aG9zZSB0aG91Z2h0cyBpbiB0aGUg
aG9wZSB0aGF0IHRoZXkgYXJlIHVzZWZ1bC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlYWRp
bmcgdGhyb3VnaCB0aGUgNC40IHBhdGNoLCBtYW55IG9mIHRoZSBwb2ludHMgbWFkZSBieSBNYXQg
bWFrZSBzZW5zZSB0byBtZS4gRXNwZWNpYWxseSwgb2ZmLWJ5LWRlZmF1bHQgaXMgaW1wb3J0YW50
ICh1cHN0cmVhbSBjYXJlcyBkZWVwbHkgYWJvdXQgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkpLiBJ
biBmYWN0LCBwZXJzb25hbGx5IEkgZG9uJiMzOTt0IHNlZSBhIGxvdCBvZiBhZHZhbnRhZ2UgdG8g
ZW5hYmxpbmcgTVBUQ1Agb24gdW5tb2RpZmllZCBhcHBsaWNhdGlvbnMgdGhhdCBkaXJlY3RseSBj
YWxsIHRoZSBzb2NrZXQgQVBJLiBCdXQgcGVyaGFwcyB0aGVyZSBhcmUgdXNlIGNhc2VzIHRoZXJl
IHRoYXQgSSBkb24mIzM5O3Qgc2VlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SGF2aW5nIGFz
IG11Y2ggY29kZSBpbiB1c2Vyc3BhY2UgYXMgcG9zc2libGUgd2lsbCBoZWxwLsKgIE1vdmluZyBw
YXRoIG1hbmFnZW1lbnQgdG8gdXNlcnNwYWNlIHNlZW1zIGxpa2UgaXQgY291bGQgYmUgYW4gZWFz
eSB3YXkgdG8gZG8gdGhhdCAoYW5kIHRoaW5raW5nIHNwZWNpZmljYWxseSBhYm91dCBob3cgQW5k
cm9pZCBkb2VzIG5ldHdvcmtpbmcsIHRoZSBrZXJuZWwgZG9lc24mIzM5O3QgcmVhbGx5IGhhdmUg
ZW5vdWdoIGluZm9ybWF0aW9uIHRvIGRlY2lkZSB3aGljaCBzdWJmbG93cyBzaG91bGQgZ28gd2hl
cmUsIGFueXdheSkuIEZvciBhIG1vYmlsZSBkZXZpY2UsIHRoZSBzaW1wbGVzdCBhcHByb2FjaCBz
ZWVtcyB0byBiZSB0byBqdXN0IHRvIGhhdmUgemVybyBvciBvbmUgc3ViZmxvd3MgcGVyIGludGVy
ZmFjZSwgd2l0aCBleHBsaWNpdCBhZGRpdGlvbiBhbmQgcmVtb3ZhbCBvZiBzdWJmbG93cyBmcm9t
IHVzZXJzcGFjZSwgYW5kIHBvc3NpYmx5IGEgc2V0c29ja29wdCB0byBhZGQgYW5kIGRpc2FibGUg
TVBfUFJJTy7CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2hhdCBJIHRoaW5rIHRoYXQgbWVh
bnMgaXMgdGhhdCB0aGVyZSBuZWVkcyB0byBiZSBhIHN1YmZsb3cgYWJzdHJhY3Rpb24gdGhhdCB1
c2Vyc3BhY2UgY2FuIHNlZS4gT25lIHdheSB0byBkbyB0aGlzIG1pZ2h0IGJlIHRvIGV4cG9zZSB0
aGUgc3ViZmxvd3MgYXMgaW5kaXZpZHVhbCBzb2NrZXRzIG9uIHdoaWNoIHJlYWQoKSBhbmQgd3Jp
dGUoKSByZXR1cm4gRUlOVkFMLCBidXQgb24gd2hpY2ggY29ubmVjdCgpIGFuZCBzZXRzb2Nrb3B0
KCkgY2FuIG9wZXJhdGUgYXMgbm9ybWFsIC0gY29ubmVjdCgpIHRvIGVzdGFibGlzaCBhIHN1YmZs
b3csIHNldHNvY2tvcHQoKSB0byBkbyB0aGluZ3MgbGlrZSBzZXQgc3ViZmxvd3MgdG8gYmFja3Vw
LCBhc2sgdGhlIGtlcm5lbCB0byBzZW5kIHRoZSBNUF9QUklPIG9wdGlvbiwgYW5kIHNvIG9uLiBO
b3Qgc3VyZSB3aGF0IHlvdSYjMzk7ZCBkbyBvbiBhIHNlcnZlciB0byBnZXQgdGhlIHN1YmZsb3dz
IGZvciBhY2NlcHRlZCBjb25uZWN0aW9ucywgdGhvdWdoLiBGb3IgYmxvY2tpbmcgY2FsbHMgeW91
IGNvdWxkIHVzZSBhY2NlcHQoKSBvbiB0aGUgbWFzdGVyIHNvY2tldCwgYnV0IHJlYWxseSB5b3Ug
d2FudCBhbiBhc3luY2hyb25vdXMgbm90aWZpY2F0aW9uIHdoZW4gYSBjb25uZWN0aW9uIGNvbWVz
IGluLiBQZXJoYXBzIGdpdmUgdXAgc3VwcG9ydCBmb3IgdXJnZW50IGRhdGEgYW5kIHJlLXVzZSBQ
T0xMUFJJPyBUaGVyZSBpcyBwcmVjZWRlbnQgZm9yIHJldXNpbmcgUE9MTFBSSSBmb3IgdGhpbmdz
IHRoYXQgYXJlbiYjMzk7dCB1cmdlbnQgZGF0YSwgYnV0IHN1Y2ggYXMgc29sdXRpb24gbWlnaHQg
YmUgc2VlbiBhcyB0b28gaGFja3kgYnkgdXBzdHJlYW0uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5UaGUgYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gZXhwb3NlIG9ubHkgb25lIGZpbGVkZXNjcmlw
dG9yIGFuZCB1c2Ugc3Vic2V0c29ja29wdHMgdG8gYWZmZWN0IHRoZSBpbmRpdmlkdWFsIGZsb3dz
LCBsaWtlwqBkcmFmdC1oZXNtYW5zLW1wdGNwLTx3YnI+c29ja2V0LTAyIGRvZXMuIE9uIEFuZHJv
aWQgc3BlY2lmaWNhbGx5LCByb3V0aW5nIHRyYWZmaWMgb24gYSBwYXJ0aWN1bGFyIG5ldHdvcmsg
KGUuZy4sIHdpZmkgdnMuIGNlbGx1bGFyKSByZXF1aXJlcyB0aGF0IHNrLSZndDtza19tYXJrIGJl
IHNldCB0byBhbiBhcHByb3ByaWF0ZSB2YWx1ZSwgc28gdGhlcmUgbXVzdCBiZSBhIHdheSB0byBk
byB0aGF0IGZvciBlYWNoIHN1YmZsb3cuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PbmUgZ2Vu
ZXJhbCB0aGluZyBJJiMzOTt2ZSBoZWFyZCBpcyB0aGF0IGhhdmluZyB0aGUgQVBJIGZsb3cgYmUg
c2ltaWxhciB0byB0aGUgc2luZ2xlLVRDUC1zb2NrZXQgbW9kZWwgaXMgYW4gYWR2YW50YWdlIC0g
Zm9yIGV4YW1wbGUsIEkgaGVhciB0aGF0IG9uZSBvZiB0aGUgcmVhc29ucyBmb3IgdGhlIGxvdyBh
ZG9wdGlvbiBvZiBURk8gb24gTGludXggaXMgdGhhdCB0aGUgQVBJIGlzIGRpZmZlcmVudCB0byBz
dGFuZGFyZCBUQ1AgYmVjYXVzZSBpdCB1c2VzIHNlbmR0bygpIGluc3RlYWQgb2YgY29ubmVjdCwg
YW5kIHRoYXQgbWFrZXMgaXQgaGFyZCB0byB1c2UgbG90cyBvZiBsaWJyYXJpZXMgc3VjaCBhcyBv
cGVuc3NsIHRoYXQgd2FudCAmcXVvdDthIGZpbGVkZXNjcmlwdG9yIG9mIGEgY29ubmVjdGVkIHNv
Y2tldCZxdW90Oy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBzY2hlZHVsZXIgc2VlbXMg
bGlrZSBpdCBjb3VsZCBiZWxvbmcgaW4gdGhlIGtlcm5lbCwgYmVjYXVzZSBpdCBoYXMgdG8gcmVh
Y3QgcXVpY2tseSB0byBldmVudHMgc3VjaCBhcyByZWNlaXZpbmcgcGFja2V0cy4gUGVyaGFwcyB0
aGlzIGNvdWxkIHVzZSBzaW1pbGFyIG1lY2hhbmlzbXMgdG8gdGhlIGV4aXN0aW5nIHBsdWdnYWJs
ZSBjb25nZXN0aW9uIGNvbnRyb2wgYWxnb3JpdGhtcz8gQW5vdGhlciBvcHRpb24sIGZvciBhZHZh
bmNlZCBjbGllbnRzLCB3b3VsZCBiZSB0byBoYXZlIHVzZXJzcGFjZSBwYXNzIGluIGEgc2NoZWR1
bGluZyBhbGdvcml0aG0gd3JpdHRlbiBpbiBFQlBGLiBPbmUgdGhpbmcgdGhhdCBtaWdodCBiZSBo
ZWxwZnVsIGlzIHRvIGhhdmUgYSAmcXVvdDtzZW5kIGFsbCBwYWNrZXRzIG9uIGFsbCBzdWJmbG93
cyZxdW90OyBzY2hlZHVsZXIgZm9yIGNhc2VzLCB0aG91Z2ggSSYjMzk7bSBub3Qgc3VyZSBpZiB0
aGF0JiMzOTtzIGZlYXNpYmxlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rp
dj48ZGl2PkxvcmVuem88L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBXZWQsIEF1ZyAyLCAyMDE3IGF0IDI6MDkgUE0sIENo
cmlzdG9waCBQYWFzY2ggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86Y3BhYXNj
aEBhcHBsZS5jb20iIHRhcmdldD0iX2JsYW5rIj5jcGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7PC9z
cGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+SGVsbG8sPGJyPgo8YnI+CkkmIzM5O20gYWRkaW5nIExvcmVuem8gKGluIENDKSBmcm9tIEdv
b2dsZSB0byB0aGlzIHRocmVhZC4gTG9yZW56byB3b3JrcyBvbiB0aGU8YnI+Cm5ldHdvcmtpbmcg
b2YgQW5kcm9pZCBhdCBHb29nbGUuPGJyPgpMb3JlbnpvLCB5b3UgY2FuIHN1YnNjcmliZSB0byB0
aGUgbWFpbGluZy1saXN0IGF0PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLjAxLm9yZy9tYWls
bWFuL2xpc3RpbmZvL21wdGNwIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL2xpc3RzLjAxLm9yZy9tYWlsbWFuLzx3YnI+bGlzdGluZm8vbXB0Y3A8L2E+Ljxicj4KPGJy
Pgo8YnI+CkkgZGlzY3Vzc2VkIE1QVENQIHdpdGggaGltIGF0IHRoZSBJRVRGIHR3byB3ZWVrcyBi
YWNrLCBhbmQgaGUgd2FzIGludGVyZXN0ZWQ8YnI+CmluIGhlbHBpbmcgbWFraW5nIE1QVENQIHVw
c3RyZWFtYWJsZS48YnI+CkkgbGV0IGhpbSBjaGltZSBpbiBvbiB0aGUgZGlzY3Vzc2lvbi48YnI+
Cjxicj4KPGJyPgo8YnI+CldydC4gdG8gdGhlIGJlbG93LCB5ZXMgSSBhZ3JlZSB3aXRoIHRoZSBh
cHByYW9jaCBNYXQgb3V0bGluZWQuPGJyPgpPbiBteSBzaWRlLCBJIHdpbGwgYmUgYWJsZSB0byBz
cGVuZCBtb3JlIGN5Y2xlcyBub3cgb24gTGludXguIEkgd2lsbCBzdGFydDxicj4KYnkgcG9ydGlu
ZyB0aGUgY29kZSBmcm9tIDxhIGhyZWY9Imh0dHA6Ly9tdWx0aXBhdGgtdGNwLm9yZyIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+bXVsdGlwYXRoLXRjcC5vcmc8L2E+IHVwIHRvIHVw
c3RyZWFtJiMzOTtzIHZlcnNpb24gKHdlIGhhdmU8YnI+CmJlZW4gbGFnZ2luZyBiZWhpbmQgcXVp
dGUgYSBiaXQgYWdhaW4pLiBUaGF0IHdheSB3ZSBoYXZlIGEgY29tbW9uIGJhc2Ugd2hlcmU8YnI+
CndlIGNhbiBlYXNpbHkgc2VlIGhvdyB3ZWxsIHRoZSBSRkMtcGF0Y2hlcyAoZm9yIGV4YW1wbGUg
bW9yZSBnZW5lcmljPGJyPgpjYXBhYmlsaXRpZXMgaW4gVENQKSB3b3VsZCB3b3JrIHdpdGggTVBU
Q1AuPGJyPgo8YnI+Cjxicj4KQ2hlZXJzLDxicj4KQ2hyaXN0b3BoPGJyPgo8YnI+Cjxicj4KPGJy
PgpPbiAxOC8wNy8xNyAtIDE3OjMxOjUxLCBNYXQgTWFydGluZWF1IHdyb3RlOjxicj4KJmd0Ozxi
cj4KJmd0OyBIZWxsbyBldmVyeW9uZSw8YnI+CiZndDs8YnI+CiZndDsgT3VyIGdvYWwgb24gdGhp
cyBtYWlsaW5nIGxpc3QgaXMgdG8gYWRkIGFuIE1QVENQIGltcGxlbWVudGF0aW9uIHRvIHRoZTxi
cj4KJmd0OyB1cHN0cmVhbSBMaW51eCBrZXJuZWwuIFRoZXJlJiMzOTtzIGEgZmFpciBhbW91bnQg
b2Ygd29yayB0byBiZSBkb25lIHRvIGFjaGlldmU8YnI+CiZndDsgdGhpcywgYW5kIGEgbnVtYmVy
IG9mIG9wdGlvbnMgZm9yIGhvdyB0byBnbyBhYm91dCBpdC4gU29tZSBvZiB0aGlzIHJldmlzaXRz
PGJyPgomZ3Q7IHByZXZpb3VzIGRpc2N1c3Npb25zIG9uIHRoaXMgbGlzdCBhbmQgZWxzZXdoZXJl
LCBidXQgSSB3YW50IHRvIGJlIHN1cmUgd2U8YnI+CiZndDsgaGF2ZSBzb21lIGxldmVsIG9mIGNv
bnNlbnN1cyBhYm91dCB0aGUgZGlyZWN0aW9uIHRvIGhlYWQgaW4uPGJyPgomZ3Q7PGJyPgomZ3Q7
IEEgY291cGxlIG9mIHVzIG9uIHRoaXMgbGlzdCBoYXZlIGhhZCBkaXNjdXNzaW9ucyB3aXRoIHRo
ZSBMaW51eCBuZXQ8YnI+CiZndDsgbWFpbnRhaW5lcnMsIGFuZCB0aGV5IGhhdmUgc29tZSBzb21l
IHNwZWNpZmljIG5lZWRzIGNvbmNlcm5pbmcgbW9kaWZpY2F0aW9uczxicj4KJmd0OyB0byB0aGUg
TGludXggVENQIHN0YWNrOjxicj4KJmd0Ozxicj4KJmd0O8KgICogVENQIGNvbXBsZXhpdHkgY2Fu
JiMzOTt0IGluY3JlYXNlLiBJdCYjMzk7cyBhbHJlYWR5IGEgY29tcGxleCw8YnI+CiZndDsgcGVy
Zm9ybWFuY2Utc2Vuc2l0aXZlIHBpZWNlIG9mIHNvZnR3YXJlIHRoYXQgZXZlcnkgTGludXggdXNl
ciBkZXBlbmRzIG9uLjxicj4KJmd0OyBJbnRydXNpdmUgY2hhbmdlcyBoYXZlIGEgcmlzayBvZiBj
cmVhdGluZyBidWdzIG9yIGNoYW5naW5nIG9wZXJhdGlvbiBvZiB0aGU8YnI+CiZndDsgc3RhY2sg
aW4gdW5leHBlY3RlZCB3YXlzLjxicj4KJmd0Ozxicj4KJmd0O8KgICogc2tfYnVmZiBzdHJ1Y3R1
cmUgc2l6ZSBjYW4mIzM5O3QgZ2V0IGJpZ2dlci4gSXQmIzM5O3MgYWxyZWFkeSBsYXJnZSBhbmQs
IGlmPGJyPgomZ3Q7IGFueXRoaW5nLCB0aGV5IGhvcGUgdG8gcmVkdWNlIGl0JiMzOTtzIHNpemUu
IENoYW5nZXMgdG8gdGhlIGRhdGEgc3RydWN0dXJlIHNpemU8YnI+CiZndDsgYXJlIGFtcGxpZmll
ZCBieSB0aGUgbGFyZ2UgbnVtYmVyIG9mIGluc3RhbmNlcyBpbiBhIHN5c3RlbSBoYW5kbGluZyBh
IGxvdCBvZjxicj4KJmd0OyB0cmFmZmljLjxicj4KJmd0Ozxicj4KJmd0O8KgICogQW4gYWRkaXRp
b25hbCBwcm90b2NvbCBsaWtlIE1QVENQIHNob3VsZCBiZSBvcHQtaW4sIHNvIHVzZXJzIG9mIHJl
Z3VsYXI8YnI+CiZndDsgVENQIGNvbnRpbnVlIHRvIGdldCB0aGUgc2FtZSB0eXBlIG9mIGNvbm5l
Y3Rpb24gYW5kIHBlcmZvcm1hbmNlIHVubGVzcyBNUFRDUDxicj4KJmd0OyBpcyByZXF1ZXN0ZWQu
PGJyPgomZ3Q7PGJyPgomZ3Q7IEkgYWxzbyByZWNvbW1lbmQgcmVhZGluZyAmcXVvdDtPbiBzdWJt
aXR0aW5nIGtlcm5lbCBwYXRjaGVzJnF1b3Q7PGJyPgomZ3Q7ICg8YSBocmVmPSJodHRwOi8vaGFs
b2JhdGVzLmRlL29uLXN1Ym1pdHRpbmctcGF0Y2hlcy5wZGYiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHA6Ly9oYWxvYmF0ZXMuZGUvb24tPHdicj5zdWJtaXR0aW5nLXBhdGNo
ZXMucGRmPC9hPikgdG8gZ2V0IGFuIGlkZWEgb2YgdGhlPGJyPgomZ3Q7IHByb2Nlc3MgYW5kIGh1
cmRsZXMgaW52b2x2ZWQgaW4gbWVyZ2luZyBtYWpvciBjb3JlIGZ1bmN0aW9uYWxpdHkgZm9yIHRo
ZTxicj4KJmd0OyBMaW51eCBrZXJuZWwuPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IFZhcmlv
dXMgU3RyYXRlZ2llczxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDs8YnI+CiZn
dDsgT25lIGFwcHJvYWNoIGlzIHRvIGF0dGVtcHQgdG8gbWVyZ2UgdGhlIDxhIGhyZWY9Imh0dHA6
Ly9tdWx0aXBhdGgtdGNwLm9yZyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+bXVs
dGlwYXRoLXRjcC5vcmc8L2E+IGZvcmsuIFRoaXMgaXMgYW48YnI+CiZndDsgaW1wbGVtZW50YXRp
b24gaW4gd2hpY2ggdGhlIDxhIGhyZWY9Imh0dHA6Ly9tdWx0aXBhdGgtdGNwLm9yZyIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+bXVsdGlwYXRoLXRjcC5vcmc8L2E+IGNvbW11bml0
eSBoYXMgaW52ZXN0ZWQgYSBsb3Q8YnI+CiZndDsgb2YgdGltZSBhbmQgZWZmb3J0LCBhbmQgaXQg
aXMgaW4gcHJvZHVjdGlvbiBmb3IgbWFqb3IgYXBwbGljYXRpb25zIChzZWU8YnI+CiZndDsgPGEg
aHJlZj0iaHR0cHM6Ly90b29scy5pZXRmLm9yZy9odG1sL3JmYzgwNDEiIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vdG9vbHMuaWV0Zi5vcmcvaHRtbC88d2JyPnJmYzgw
NDE8L2E+KS4gVGhpcyBpcyBhIHRyZW1lbmRvdXMgYW1vdW50IG9mIGNvZGUgdG88YnI+CiZndDsg
cmV2aWV3IGF0IG9uY2UgKGV2ZW4gc2VwYXJhdGluZyBvdXQgbW9kdWxlcyksIGFuZCBjdXJyZW50
bHkgZG9lc24mIzM5O3QgZml0IHdpdGg8YnI+CiZndDsgd2hhdCB0aGUgbWFpbnRhaW5lcnMgaGF2
ZSBhc2tlZCBmb3IgKG5vbi1pbnRydXNpdmUsIHNrX2J1ZmYgc2l6ZSwgTVBUQ1AgYnk8YnI+CiZn
dDsgZGVmYXVsdCkuIEkgZG9uJiMzOTt0IHRoaW5rIHRoZSBtYWludGFpbmVycyB3b3VsZCBjb25z
aWRlciBtZXJnaW5nIHN1Y2ggYW48YnI+CiZndDsgZXh0ZW5zaXZlIHBpZWNlIGdpdCBoaXN0b3J5
LCBlc3BlY2lhbGx5IHdoZXJlIHRoZXJlIGFyZSBhIGZhaXIgbnVtYmVyIG9mPGJyPgomZ3Q7IGNv
bW1pdHMgd2l0aG91dCBhbiAmcXVvdDttcHRjcDomcXVvdDsgbGFiZWwgb24gdGhlIHN1YmplY3Qg
bGluZSBvciB3aXRob3V0IGEgRENPPGJyPgomZ3Q7IHNpZ25vZmYgKDxhIGhyZWY9Imh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVz
Lmh0bWwjc2lnbi15b3VyLXdvcmstdGhlLWRldmVsb3Blci1zLWNlcnRpZmljYXRlLW9mLW9yaWdp
biIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cua2VybmVsLm9y
Zy9kb2MvPHdicj5odG1sL2xhdGVzdC9wcm9jZXNzLzx3YnI+c3VibWl0dGluZy1wYXRjaGVzLmh0
bWwjc2lnbi08d2JyPnlvdXItd29yay10aGUtZGV2ZWxvcGVyLXMtPHdicj5jZXJ0aWZpY2F0ZS1v
Zi1vcmlnaW48L2E+KS48YnI+CiZndDsgVG9kYXksIHRoZSBmb3JrIGlzIGF0IGtlcm5lbCB2NC40
IGFuZCBjdXJyZW50IHVwc3RyZWFtIGRldmVsb3BtZW50IGlzIGF0PGJyPgomZ3Q7IHY0LjEzLXJj
MSwgc28gdGhlIGZvcmsgd291bGQgaGF2ZSB0byBjYXRjaCB1cCBhbmQgc3RheSBjdXJyZW50Ljxi
cj4KJmd0Ozxicj4KJmd0OyBUaGUgb3RoZXIgZXh0cmVtZSBpcyB0byByZXdyaXRlIGZyb20gc2Ny
YXRjaC4gVGhpcyB3b3VsZCBhbGxvdyBpbmNyZW1lbnRhbDxicj4KJmd0OyBkZXZlbG9wbWVudCB3
aXRoIG1haW50YWluZXIgcmV2aWV3IGZyb20gdGhlIHN0YXJ0LCBidXQgZG9lc24mIzM5O3QgdGFr
ZTxicj4KJmd0OyBhZHZhbnRhZ2Ugb2YgZXhpc3RpbmcgY29kZS48YnI+CiZndDs8YnI+CiZndDsg
VGhlIG1vc3QgcmVhbGlzdGljIGFwcHJvYWNoIGlzIHNvbWV3aGVyZSBpbiBiZXR3ZWVuLCB3aGVy
ZSB3ZSB3cml0ZSBuZXcgY29kZTxicj4KJmd0OyB0aGF0IGZpdHMgbWFpbnRhaW5lciBleHBlY3Rh
dGlvbnMgYW5kIHV0aWxpemUgY29tcG9uZW50cyBmcm9tIHRoZSBmb3JrIHdoZXJlPGJyPgomZ3Q7
IGxpY2Vuc2luZyBhbGxvd3MgYW5kIHRoZSBjb2RlIGZpdHMuIFdlJiMzOTtsbCBoYXZlIHRvIGZp
bmQgdGhlIHJpZ2h0IGJhbGFuY2U6PGJyPgomZ3Q7IG92ZXItcmVsaWFuY2Ugb24gbmV3IGNvZGUg
Y291bGQgdGFrZSBleHRyYSB0aW1lLCBidXQgY29uc3RhbnRseSByZXdvcmtpbmc8YnI+CiZndDsg
dGhlIGZvcmsgYW5kIGtlZXBpbmcgaXQgdXAtdG8tZGF0ZSB3aXRoIG5ldC1uZXh0IGlzIGFsc28g
YSBsb3Qgb2Ygb3ZlcmhlYWQuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRvIHN0YXJ0IHdpdGgsIHdlIGNh
biBjcmVhdGUgUkZDIHBhdGNoZXMgKGNvZGUgdGhhdCYjMzk7cyByZWFkeSBmb3IgY29tbWVudDxi
cj4KJmd0OyByYXRoZXIgdGhhbiBtZXJnZSAtLSBub3QgJnF1b3Q7UkZDJnF1b3Q7IGluIHRoZSBJ
RVRGIHNlbnNlKSB0aGF0IGFsbG93IHVzIHRvIGV4dGVuZDxicj4KJmd0OyBUQ1AgaW4gdGhlIHdh
eXMgdGhhdCBhcmUgdXNlZnVsIGZvciBib3RoIE1QVENQIGFuZCBvdGhlciBleHRlbmRlZCBUQ1A8
YnI+CiZndDsgZmVhdHVyZXMuIFRoZSBtYWludGFpbmVycyB3b3VsZCBiZSBhYmxlIHRvIHJldmll
dyB0aG9zZSBzdGFuZGFsb25lIHBhdGNoZXMsPGJyPgomZ3Q7IGFuZCB0aGVyZSYjMzk7cyBwb3Rl
bnRpYWwgdG8gYmFja3BvcnQgdGhlIHBhdGNoZXMgdG8gcHJvdmUgdGhlbSBvdXQgd2l0aCB0aGU8
YnI+CiZndDsgPGEgaHJlZj0iaHR0cDovL211bHRpcGF0aC10Y3Aub3JnIiByZWw9Im5vcmVmZXJy
ZXIiIHRhcmdldD0iX2JsYW5rIj5tdWx0aXBhdGgtdGNwLm9yZzwvYT4gY29kZS4gRG9lcyB0aGlz
IHNvdW5kIHNlbnNpYmxlPyBBbnkgb3RoZXIgYXBwcm9hY2hlcyB0bzxicj4KJmd0OyBjb25zaWRl
ciwgb3IgZGV0YWlscyB0aGF0IHdlIHNob3VsZCBkaXNjdXNzIGhlcmU/PGJyPgomZ3Q7PGJyPgom
Z3Q7PGJyPgomZ3Q7IERlc2lnbiBmb3IgVXBzdHJlYW08YnI+CiZndDsgLS0tLS0tLS0tLS0tLS0t
LS0tLTxicj4KJmd0Ozxicj4KJmd0OyBBcyBhIHN0YXJ0aW5nIHBvaW50IGZvciBkaXNjdXNzaW9u
LCBoZXJlIGFyZSBzb21lIGNoYXJhY3RlcmlzdGljcyB0aGF0IG1pZ2h0PGJyPgomZ3Q7IG1ha2Ug
TVBUQ1AgbW9yZSB1cHN0cmVhbS1mcmllbmRseTo8YnI+CiZndDs8YnI+CiZndDvCoCAqIE1QVENQ
IGlzIHVzZWQgd2hlbiByZXF1ZXN0ZWQgYnkgdGhlIGFwcGxpY2F0aW9uLCBlaXRoZXIgdGhyb3Vn
aCBhbjxicj4KJmd0OyBJUFBST1RPX01QVENQIHBhcmFtZXRlciB0byBzb2NrZXQoKSBvciBieSB1
c2luZyB0aGUgbmV3IFVMUCAoVXBwZXIgTGF5ZXI8YnI+CiZndDsgUHJvdG9jb2wpIGNhcGFiaWxp
dHkuPGJyPgomZ3Q7PGJyPgomZ3Q7wqAgKiBNb3ZlIGF3YXkgZnJvbSBtZXRhLXNvY2tldHMsIHRy
ZWF0aW5nIGVhY2ggc3ViZmxvdyBtb3JlIGxpa2UgYSByZWd1bGFyPGJyPgomZ3Q7IFRDUCBjb25u
ZWN0aW9uLiBUaGUgb3ZlcmFsbCBNUFRDUCBjb25uZWN0aW9uIGlzIGNvb3JkaW5hdGVkIGJ5IGFu
IHVwcGVyPGJyPgomZ3Q7IGxheWVyIHNvY2tldCB0aGF0IGlzIGRpc3RpbmN0IGZyb20gdGNwX3Nv
Y2suPGJyPgomZ3Q7PGJyPgomZ3Q7wqAgKiBNb3ZlIGZ1bmN0aW9uYWxpdHkgdG8gdXNlcnNwYWNl
IHdoZXJlIHBvc3NpYmxlLCBsaWtlIHRyYWNraW5nIEFERF9BRERSczxicj4KJmd0OyByZWNlaXZl
ZCwgaW5pdGlhdGluZyBuZXcgc3ViZmxvd3MsIG9yIGFjY2VwdGluZyBuZXcgc3ViZmxvd3MuPGJy
PgomZ3Q7PGJyPgomZ3Q7wqAgKiBBdm9pZCBhZGRpbmcgbG9ja3MgdG8gY29vcmRpbmF0ZSBhY2Nl
c3MgdG8gZGF0YSB0aGF0JiMzOTtzIHNoYXJlZCBiZXR3ZWVuPGJyPgomZ3Q7IHN1YmZsb3dzLiBV
dGlsaXplIGNhcGFiaWxpdGllcyBsaWtlIGNvbXBhcmUtYW5kLXN3YXAgKGNtcHhjaGcpLCBhdG9t
aWNzLCBhbmQ8YnI+CiZndDsgUkNVIHRvIGRlYWwgd2l0aCBzaGFyZWQgZGF0YSBlZmZpY2llbnRs
eS48YnI+CiZndDs8YnI+CiZndDvCoCAqIEFkZCBnZW5lcmljIGNhcGFiaWxpdGllcyB0byB0aGUg
VENQIHN0YWNrIHdoZXJlIGl0IGxvb2tzIHVzZWZ1bCB0byBvdGhlcjxicj4KJmd0OyBwcm90b2Nv
bCBleHRlbnNpb25zLiBFeGFtcGxlczogZHluYW1pY2FsbHkgcmVnaXN0ZXIgaGFuZGxlcnMgZm9y
IFRDUCBvcHRpb248YnI+CiZndDsgaGVhZGVycywgbWFrZSBpdCBwb3NzaWJsZSB0byBwYXNzIFRD
UCBvcHRpb25zIHRvL2Zyb20gYW4gdXBwZXIgbGF5ZXIuPGJyPgomZ3Q7PGJyPgomZ3Q7IEFueSBj
b21tZW50IG9uIHRoZXNlPyBNYXliZSBlYWNoIGRlc2VydmVzIGEgdGhyZWFkIG9mIGl0cyBvd24u
PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IFRoYW5rcyBhZ2FpbiB0byBSYW8sIENocmlzdG9w
aCwgUGV0ZXIsIGFuZCBPc3NhbWEgZm9yIHlvdXIgaGVscCwgd29yaywgYW5kPGJyPgomZ3Q7IGlu
dGVyZXN0LiBJJiMzOTttIGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGluc2lnaHRzLjxicj4KJmd0
Ozxicj4KPHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPiZndDs8YnI+
CiZndDsgLS08YnI+CiZndDsgTWF0IE1hcnRpbmVhdTxicj4KJmd0OyBJbnRlbCBPVEM8YnI+CiZn
dDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPHdicj5fX19fX19fX19fX19fX19fXzxi
cj4KJmd0OyBtcHRjcCBtYWlsaW5nIGxpc3Q8YnI+CiZndDsgPGEgaHJlZj0ibWFpbHRvOm1wdGNw
QGxpc3RzLjAxLm9yZyI+bXB0Y3BAbGlzdHMuMDEub3JnPC9hPjxicj4KJmd0OyA8YSBocmVmPSJo
dHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL21wdGNwIiByZWw9Im5vcmVmZXJy
ZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuLzx3YnI+bGlz
dGluZm8vbXB0Y3A8L2E+PGJyPgo8L2ZvbnQ+PC9zcGFuPjwvYmxvY2txdW90ZT48L2Rpdj48YnI+
PC9kaXY+Cg==

--===============9026035930957772991==--
