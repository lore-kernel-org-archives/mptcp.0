Content-Type: multipart/mixed; boundary="===============0910494254636927593=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH net-next] mptcp: mptcp option len must be skb
 independent
Date: Wed, 08 May 2019 17:19:25 +0200
Message-ID: <c590463ca3c2d5491a1407ee48ed3d76c116798a.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1905071456160.21662@ldraghi-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1127

--===============0910494254636927593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-05-07 at 16:48 -0700, Mat Martineau wrote:
> On Tue, 7 May 2019, Paolo Abeni wrote:
> =

> > Otherwise the TCP stack can't compute correctly the mss and
> > that will break segmentation. Note that we can't observe the
> > issue with the self-test until we allow skb collapsing -
> > loopback default MTU is pretty big and we dont build big enogh
> > skb otherwise.
> > =

> > Fix the issue always reserving space for map in tcp_established_options=
().
> > The map is effectively added according to skb extensions,
> > if available.
> > Overall we underestimate the MSS (always accounting for the map), but
> > we emit the map only if needed.
> > =

> > v1 -> v2:
> > - rebased on top of current git
> > - use slightly different way to compute the opt len
> =

> In reviewing the code, I only had one minor comment (not requiring a =

> change to the patch). That's inline with the code below.
> =

> =

> When I applied and ran the self tests with the patch, the first three =

> cases ran ok. The fourth test, where packets get routed and segmentation =

> happens, seemed to behave better in terms of segmentation but had corrupt =

> TCP options following the MPTCP DSS option.
> =

> With mptcp_established_options_dss() always reporting the largest DSS =

> option size (both DSS map and DSS ack), the full 40 bytes get allocated =

> for the TCP option header. When there's no mapping data to fill all those =

> option bytes, which happens in ACK packets or segments without the DSS =

> mapping, the MPTCP option only has length 12. That leaves 16 uninitialize=
d =

> bytes at the end of the TCP options.
> =

> Did you consider only reporting the extra DSS bytes when skb =3D=3D NULL =
in =

> mptcp_established_options_dss?

I just gave the above a spin, and it looks like a better solution,
thanks.

> My initial reaction was to want to move use_checksum from struct mptcp_ex=
t =

> to struct mptcp_out_options, but it would make struct mptcp_out_options =

> larger without offering other improvements. I think it's fine to leave =

> use_checksum where it is, until we run out of bits in the mptcp_ext =

> bitfield.

Oks, I'll keep this part unchanged.

I'll submit the next version soon.

Paolo


--===============0910494254636927593==--
