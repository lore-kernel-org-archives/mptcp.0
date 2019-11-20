Content-Type: multipart/mixed; boundary="===============5664644238901807185=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Feedback to the IETF
Date: Wed, 20 Nov 2019 09:49:27 -0800
Message-ID: <alpine.OSX.2.21.1911200903300.15309@gpmelz-mobl1.amr.corp.intel.com>
In-Reply-To: 9DF9C238-3239-496B-A229-423477DD767A@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2625

--===============5664644238901807185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 20 Nov 2019, Christoph Paasch wrote:

> Hello,
> I have mentioned to the IETF that the upstreaming effort brought forward =
some feedback,... to the IETF-draft.
> =

> Now, the draft is about to become an RFC very soon. Currently it is in th=
e "RFC-Editor" stage, which is the last stage before
> official publication.
> =

> Ideally, we should get feedback to the IETF as soon as possible so that t=
he working-group can make adjustements before
> publication. Otherwise, it would need to got through an "Errata" process =
which means to correct the published RFC.
> =

> =

> So, let me try to compile a list of things that came up. Please correct o=
r add anything:
>
>  *  Clarifying that the reception of a DATA_ACK means that the server suc=
cessfully received the MP_CAPABLE (Text "If B has data
>     to send first, then the reliable delivery of the ACK can be inferred =
by the receipt of this data with an MPTCP DATA_ACK
>     inside the DSS option (Section 3.3).)
>
>  *  Should we vouch to disallow early or late DSS mappings that are cover=
ing a TCP-sequence space different than the packet they
>     are being sent on (cfr., our discussion on/around September 25th)

I think late DSS mappings should be disallowed. This would make it clear =

that unmapped data is to be discarded.

Allowing at most one early mapping would limit the implementation =

complexity and handle any coalescing of consecutive packets where the =

early part of the coalesced payload is covered by a previous mapping. If =

this coalescing is not something that actually happens in practice, then =

get rid of early mappings! Also, it would be a headache to have some =

implementations that allow one early mapping and some that ignore them.

It's also important that a DATA_FIN with a length-1 mapping (not covering =

any data payload) is not discarded when it arrives on a packet with an =

already-mapped TCP sequence space. While this isn't really an "early" =

mapping, it is a corner case to be aware of when processing mapping =

headers.

>
>  *  ADD_ADDR-option size - last =C2=A0week we discussed this briefly and =
I replied by mail that the size-problem is actually for the
>     non-Echo option. In that one there is no way to get around it and all=
 the bits need to be presented. Do you agree on that?
>

--
Mat Martineau
Intel

--===============5664644238901807185==--
