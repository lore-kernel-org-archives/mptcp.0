Content-Type: multipart/mixed; boundary="===============8337749713050803975=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Conference talk ideas, round 2
Date: Mon, 14 May 2018 17:18:27 +0200
Message-ID: <CAKuKrBmjLFC2LM1i9yWzSMXFi-Nj_cD1F4VKAnNc-9w+BtuSpQ@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1805132031200.60813@gemorgan-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 625

--===============8337749713050803975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On Mon, May 14, 2018 at 6:02 AM, Mat Martineau <
mathew.j.martineau(a)linux.intel.com> wrote:

>
> Hello -
>
> We had a meeting last week to discuss reshaping our netdev conference
> MPTCP talk proposal based on feedback from the committee. The plan is to
> re-focus on upstreaming concerns, challenges, and progress.
>
> I worked on outlining some topics that might fit with the talk. I don't
> think this is exhaustive, and I'm also not saying everything here is
> required to be in the talk. I'm looking forward to your comments and
> additional ideas.
>

Thank you for the list!

Should we focus our talk on: Why is adding intrusive protocols like MPTCP
to the upstream kernel so complicated?

If you want and if nobody has already started it, I can have a look to
prepare a first draft for a description for this talk.

Best regards,
Matthieu

* Why is adding MPTCP to the upstream kernel complicated?
>
>     * Differences in requirements and features from existing implementati=
on
>
>         * Every TCP socket affected vs. staying out of the way for normal
> TCP
>
>         * Multipath protocol development and research vs giving TCP
> users/maintainers weight
>
>     * Protocol challenges
>
>         * Coupled receive windows across TCP subflows
>
>         * Behavior change for duplicate acks
>
>         * Per-packet metadata (tx path) and option writing
>
>         * TCP option parsing - packets are currently dropped after options
> are parsed
>
>         * Collapse/coalesce of skbs after receive - per-packet headers
> lost in TCP layer
>
>     * Must do all this without adversely affecting TCP or networking
> structs (like sk_buff)
>
>         * TCP performance not reduced
>
>         * Memory requirements for TCP not increased
>
>         * Maintainability not made harder
>
>     * Compare to KCM, which adds metadata to each stream, didn't require
> TCP changes
>
> * What fits well in the networking subsystem
>
>     * Some connection code (callbacks exist)
>
>     * Creating a new socket type for MPTCP
>
>     * New ULP capability
>
>         * No rules yet for multiple users, because TLS is the only user
>
>     * In-kernel sockets
>
>     * do_tcp_sendpages() to send data buffered at the connection level
>
>     * tcp_read_sock() to get incoming skbs
>
> * What's a challenge in the networking subsystem
>
>     * Indirect calls are now more expensive
>
>     * MPTCP builds on TCP in a unique way
>
> * What we have tried
>
>     * Identify where other features could use TCP extension capabilities
> and merge before MPTCP
>
>         * Options framework used by TCP-MD5 and SMC
>
>         * Didn't work out - expensive indirect calls and no MPTCP frame of
> reference for the maintainer
>
>     * Sharing code demonstrating architectural approaches that use current
> upstream netdev functionality
>
>     * Moving components to userspace
>
>     * Forking and reducing functionality of existing MPTCP code base
>
> * Large change logistics
>
>     * Reshaping code in to a reviewable patch set or patch sets. Implement
> functionality in stages?
>
> * Fundamental challenge of "show us the code" - must decide what seems
> upstreamable, implement it, share, and iterate.
>
>
> Thanks,
>
> --
> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
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

--===============8337749713050803975==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgTWF0LDxicj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48
YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgTWF5IDE0LCAyMDE4IGF0IDY6MDIg
QU0sIE1hdCBNYXJ0aW5lYXUgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWF0
aGV3LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdGhldy5q
Lm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxicj4KSGVsbG8gLTxicj4K
PGJyPgpXZSBoYWQgYSBtZWV0aW5nIGxhc3Qgd2VlayB0byBkaXNjdXNzIHJlc2hhcGluZyBvdXIg
bmV0ZGV2IGNvbmZlcmVuY2UgTVBUQ1AgdGFsayBwcm9wb3NhbCBiYXNlZCBvbiBmZWVkYmFjayBm
cm9tIHRoZSBjb21taXR0ZWUuIFRoZSBwbGFuIGlzIHRvIHJlLWZvY3VzIG9uIHVwc3RyZWFtaW5n
IGNvbmNlcm5zLCBjaGFsbGVuZ2VzLCBhbmQgcHJvZ3Jlc3MuPGJyPgo8YnI+Ckkgd29ya2VkIG9u
IG91dGxpbmluZyBzb21lIHRvcGljcyB0aGF0IG1pZ2h0IGZpdCB3aXRoIHRoZSB0YWxrLiBJIGRv
biYjMzk7dCB0aGluayB0aGlzIGlzIGV4aGF1c3RpdmUsIGFuZCBJJiMzOTttIGFsc28gbm90IHNh
eWluZyBldmVyeXRoaW5nIGhlcmUgaXMgcmVxdWlyZWQgdG8gYmUgaW4gdGhlIHRhbGsuIEkmIzM5
O20gbG9va2luZyBmb3J3YXJkIHRvIHlvdXIgY29tbWVudHMgYW5kIGFkZGl0aW9uYWwgaWRlYXMu
PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSBmb3IgdGhlIGxp
c3QhPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TaG91bGQgd2UgZm9jdXMgb3VyIHRhbGsgb246
IFdoeSBpcyBhZGRpbmcgaW50cnVzaXZlIHByb3RvY29scyBsaWtlIE1QVENQIHRvIHRoZSB1cHN0
cmVhbSBrZXJuZWwgc28gY29tcGxpY2F0ZWQ/PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SWYgeW91IHdhbnQgYW5kIGlmIG5vYm9keSBoYXMgYWxyZWFkeSBzdGFydGVkIGl0LCBJIGNhbiBo
YXZlIGEgbG9vayB0byBwcmVwYXJlIGEgZmlyc3QgZHJhZnQgZm9yIGEgZGVzY3JpcHRpb24gZm9y
IHRoaXMgdGFsay48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgcmVnYXJkcyw8L2Rpdj48
ZGl2Pk1hdHRoaWV1PGJyPiA8L2Rpdj48ZGl2PiA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CgoqIFdoeSBpcyBhZGRpbmcgTVBUQ1AgdG8gdGhl
IHVwc3RyZWFtIGtlcm5lbCBjb21wbGljYXRlZD88YnI+Cjxicj4KwqAgwqAgKiBEaWZmZXJlbmNl
cyBpbiByZXF1aXJlbWVudHMgYW5kIGZlYXR1cmVzIGZyb20gZXhpc3RpbmcgaW1wbGVtZW50YXRp
b248YnI+Cjxicj4KwqAgwqAgwqAgwqAgKiBFdmVyeSBUQ1Agc29ja2V0IGFmZmVjdGVkIHZzLiBz
dGF5aW5nIG91dCBvZiB0aGUgd2F5IGZvciBub3JtYWwgVENQPGJyPgo8YnI+CsKgIMKgIMKgIMKg
ICogTXVsdGlwYXRoIHByb3RvY29sIGRldmVsb3BtZW50IGFuZCByZXNlYXJjaCB2cyBnaXZpbmcg
VENQIHVzZXJzL21haW50YWluZXJzIHdlaWdodDxicj4KPGJyPgrCoCDCoCAqIFByb3RvY29sIGNo
YWxsZW5nZXM8YnI+Cjxicj4KwqAgwqAgwqAgwqAgKiBDb3VwbGVkIHJlY2VpdmUgd2luZG93cyBh
Y3Jvc3MgVENQIHN1YmZsb3dzPGJyPgo8YnI+CsKgIMKgIMKgIMKgICogQmVoYXZpb3IgY2hhbmdl
IGZvciBkdXBsaWNhdGUgYWNrczxicj4KPGJyPgrCoCDCoCDCoCDCoCAqIFBlci1wYWNrZXQgbWV0
YWRhdGEgKHR4IHBhdGgpIGFuZCBvcHRpb24gd3JpdGluZzxicj4KPGJyPgrCoCDCoCDCoCDCoCAq
IFRDUCBvcHRpb24gcGFyc2luZyAtIHBhY2tldHMgYXJlIGN1cnJlbnRseSBkcm9wcGVkIGFmdGVy
IG9wdGlvbnMgYXJlIHBhcnNlZDxicj4KPGJyPgrCoCDCoCDCoCDCoCAqIENvbGxhcHNlL2NvYWxl
c2NlIG9mIHNrYnMgYWZ0ZXIgcmVjZWl2ZSAtIHBlci1wYWNrZXQgaGVhZGVycyBsb3N0IGluIFRD
UCBsYXllcjxicj4KPGJyPgrCoCDCoCAqIE11c3QgZG8gYWxsIHRoaXMgd2l0aG91dCBhZHZlcnNl
bHkgYWZmZWN0aW5nIFRDUCBvciBuZXR3b3JraW5nIHN0cnVjdHMgKGxpa2Ugc2tfYnVmZik8YnI+
Cjxicj4KwqAgwqAgwqAgwqAgKiBUQ1AgcGVyZm9ybWFuY2Ugbm90IHJlZHVjZWQ8YnI+Cjxicj4K
wqAgwqAgwqAgwqAgKiBNZW1vcnkgcmVxdWlyZW1lbnRzIGZvciBUQ1Agbm90IGluY3JlYXNlZDxi
cj4KPGJyPgrCoCDCoCDCoCDCoCAqIE1haW50YWluYWJpbGl0eSBub3QgbWFkZSBoYXJkZXI8YnI+
Cjxicj4KwqAgwqAgKiBDb21wYXJlIHRvIEtDTSwgd2hpY2ggYWRkcyBtZXRhZGF0YSB0byBlYWNo
IHN0cmVhbSwgZGlkbiYjMzk7dCByZXF1aXJlIFRDUCBjaGFuZ2VzPGJyPgo8YnI+CiogV2hhdCBm
aXRzIHdlbGwgaW4gdGhlIG5ldHdvcmtpbmcgc3Vic3lzdGVtPGJyPgo8YnI+CsKgIMKgICogU29t
ZSBjb25uZWN0aW9uIGNvZGUgKGNhbGxiYWNrcyBleGlzdCk8YnI+Cjxicj4KwqAgwqAgKiBDcmVh
dGluZyBhIG5ldyBzb2NrZXQgdHlwZSBmb3IgTVBUQ1A8YnI+Cjxicj4KwqAgwqAgKiBOZXcgVUxQ
IGNhcGFiaWxpdHk8YnI+Cjxicj4KwqAgwqAgwqAgwqAgKiBObyBydWxlcyB5ZXQgZm9yIG11bHRp
cGxlIHVzZXJzLCBiZWNhdXNlIFRMUyBpcyB0aGUgb25seSB1c2VyPGJyPgo8YnI+CsKgIMKgICog
SW4ta2VybmVsIHNvY2tldHM8YnI+Cjxicj4KwqAgwqAgKiBkb190Y3Bfc2VuZHBhZ2VzKCkgdG8g
c2VuZCBkYXRhIGJ1ZmZlcmVkIGF0IHRoZSBjb25uZWN0aW9uIGxldmVsPGJyPgo8YnI+CsKgIMKg
ICogdGNwX3JlYWRfc29jaygpIHRvIGdldCBpbmNvbWluZyBza2JzPGJyPgo8YnI+CiogV2hhdCYj
Mzk7cyBhIGNoYWxsZW5nZSBpbiB0aGUgbmV0d29ya2luZyBzdWJzeXN0ZW08YnI+Cjxicj4KwqAg
wqAgKiBJbmRpcmVjdCBjYWxscyBhcmUgbm93IG1vcmUgZXhwZW5zaXZlPGJyPgo8YnI+CsKgIMKg
ICogTVBUQ1AgYnVpbGRzIG9uIFRDUCBpbiBhIHVuaXF1ZSB3YXk8YnI+Cjxicj4KKiBXaGF0IHdl
IGhhdmUgdHJpZWQ8YnI+Cjxicj4KwqAgwqAgKiBJZGVudGlmeSB3aGVyZSBvdGhlciBmZWF0dXJl
cyBjb3VsZCB1c2UgVENQIGV4dGVuc2lvbiBjYXBhYmlsaXRpZXMgYW5kIG1lcmdlIGJlZm9yZSBN
UFRDUDxicj4KPGJyPgrCoCDCoCDCoCDCoCAqIE9wdGlvbnMgZnJhbWV3b3JrIHVzZWQgYnkgVENQ
LU1ENSBhbmQgU01DPGJyPgo8YnI+CsKgIMKgIMKgIMKgICogRGlkbiYjMzk7dCB3b3JrIG91dCAt
IGV4cGVuc2l2ZSBpbmRpcmVjdCBjYWxscyBhbmQgbm8gTVBUQ1AgZnJhbWUgb2YgcmVmZXJlbmNl
IGZvciB0aGUgbWFpbnRhaW5lcjxicj4KPGJyPgrCoCDCoCAqIFNoYXJpbmcgY29kZSBkZW1vbnN0
cmF0aW5nIGFyY2hpdGVjdHVyYWwgYXBwcm9hY2hlcyB0aGF0IHVzZSBjdXJyZW50IHVwc3RyZWFt
IG5ldGRldiBmdW5jdGlvbmFsaXR5PGJyPgo8YnI+CsKgIMKgICogTW92aW5nIGNvbXBvbmVudHMg
dG8gdXNlcnNwYWNlPGJyPgo8YnI+CsKgIMKgICogRm9ya2luZyBhbmQgcmVkdWNpbmcgZnVuY3Rp
b25hbGl0eSBvZiBleGlzdGluZyBNUFRDUCBjb2RlIGJhc2U8YnI+Cjxicj4KKiBMYXJnZSBjaGFu
Z2UgbG9naXN0aWNzPGJyPgo8YnI+CsKgIMKgICogUmVzaGFwaW5nIGNvZGUgaW4gdG8gYSByZXZp
ZXdhYmxlIHBhdGNoIHNldCBvciBwYXRjaCBzZXRzLiBJbXBsZW1lbnQgZnVuY3Rpb25hbGl0eSBp
biBzdGFnZXM/PGJyPgo8YnI+CiogRnVuZGFtZW50YWwgY2hhbGxlbmdlIG9mICZxdW90O3Nob3cg
dXMgdGhlIGNvZGUmcXVvdDsgLSBtdXN0IGRlY2lkZSB3aGF0IHNlZW1zIHVwc3RyZWFtYWJsZSwg
aW1wbGVtZW50IGl0LCBzaGFyZSwgYW5kIGl0ZXJhdGUuPGJyPgo8YnI+Cjxicj4KVGhhbmtzLDxi
cj4KPGJyPgotLTxicj4KTWF0IE1hcnRpbmVhdTxicj4KSW50ZWwgT1RDPGJyPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX188d2JyPl9fX19fX19fX19fX19fX19fPGJyPgptcHRjcCBtYWls
aW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0cy4wMS5vcmciIHRhcmdldD0i
X2JsYW5rIj5tcHRjcEBsaXN0cy4wMS5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3Rz
LjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL21wdGNwIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2w8d2JyPmlzdGluZm8vbXB0Y3A8
L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBjbGVhcj0iYWxsIj48YnI+LS0gPGJy
PjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25h
dHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJs
dHIiPjx0YWJsZSBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7
O2xldHRlci1zcGFjaW5nOm5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9u
ZTt3b3JkLXNwYWNpbmc6MHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwIj48dGJvZHk+PHRyPjx0
ZCByb3dzcGFuPSIzIiBzdHlsZT0icGFkZGluZy1sZWZ0OjVweDtwYWRkaW5nLXJpZ2h0OjVweCIg
d2lkdGg9IjEwIiB2YWxpZ249InRvcCIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Imh0dHA6Ly93d3cu
dGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+PGltZyBzcmM9Imh0dHA6Ly93d3cudGVzc2Fy
ZXMubmV0L3NpZ2xvZ28ucG5nIiBhbHQ9IlRlc3NhcmVzIFNBIiB3aWR0aD0iODAiIGhlaWdodD0i
ODAiIGJvcmRlcj0iMCI+PC9hPjwvdGQ+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWls
eTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIg
YWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4
MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5NYXR0aGlldSBCYWVydHMgfCBSJmFtcDtEIEVuZ2luZWVy
PC9zcGFuPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpI
ZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxp
Z249ImxlZnQiPjxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHMlNDB0ZXNzYXJlcy5uZXQi
IHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5s
aW5lIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDxicj48L2E+
PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGlj
YSxBcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMHB4IiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5
bGU9ImZvbnQtd2VpZ2h0OmJvbGQ7Y29sb3I6cmdiKDM3LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUi
PlRlc3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+PC9zcGFuPjxhIGhyZWY9
Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRl
Y29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJl
cy5uZXQ8L2E+PHNwYW4+wqA8L3NwYW4+PGJyPjxhIGhyZWY9Imh0dHBzOi8vd3d3Lmdvb2dsZS5j
b20vbWFwcz9xPTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4K090dGlnbmllcy1Mb3V2YWluLWxh
LU5ldXZlLCtCZWxnaXVtIiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246
bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPjEgQXZlbnVlIEplYW4gTW9ubmV0
LCAxMzQ4IExvdXZhaW4tbGEtTmV1dmUsIEJlbGdpdW08L2E+PC90ZD48L3RyPjwvdGJvZHk+PC90
YWJsZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4KPC9kaXY+PC9kaXY+PC9k
aXY+Cgo8YnI+CjxkaXY+PGJyPjxocj48L2Rpdj48Zm9udCBzaXplPSIxIj48c3BhbiBzdHlsZT0i
Zm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwy
NTUsMjU1KSI+RElTQ0xBSU1FUi48L3NwYW4+PGJyIHN0eWxlPSJmb250LWZhbWlseTpWZXJkYW5h
LHNhbnMtc2VyaWY7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj48Zm9udCBjb2xv
cj0iIzAwMDAwMCIgZmFjZT0iVmVyZGFuYSwgc2Fucy1zZXJpZiIgc3R5bGU9ImJhY2tncm91bmQt
Y29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+VGhpcyBlbWFpbCBhbmQgYW55IGZpbGVzIHRyYW5zbWl0
dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUg
dXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aG9tIHRoZXkgYXJlIGFkZHJlc3Nl
ZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVhc2Ugbm90aWZ5
IHRoZSBzeXN0ZW0gbWFuYWdlci4gVGhpcyBtZXNzYWdlIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBp
bmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIGluZGl2aWR1YWwgbmFtZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgeW91IHNob3VsZCBub3QgZGlzc2Vt
aW5hdGUsIGRpc3RyaWJ1dGUgb3IgY29weSB0aGlzIGUtbWFpbC4gUGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGUtbWFpbCBpZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUt
bWFpbCBieSBtaXN0YWtlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwgZnJvbSB5b3VyIHN5c3RlbS4g
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCB5b3UgYXJlIG5vdGlmaWVkIHRo
YXQgZGlzY2xvc2luZywgY29weWluZywgZGlzdHJpYnV0aW5nIG9yIHRha2luZyBhbnkgYWN0aW9u
IGluIHJlbGlhbmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlzIGluZm9ybWF0aW9uIGlzIHN0cmlj
dGx5IHByb2hpYml0ZWQuPC9mb250PjwvZm9udD4=
--===============8337749713050803975==--
