Content-Type: multipart/mixed; boundary="===============5970154487564956155=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Tue, 07 Nov 2017 15:23:42 -0800
Message-ID: <d8c5760d-5716-98f1-22b8-13f17b4bb8b3@oracle.com>
In-Reply-To: 20171107211502.GH5226@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 158

--===============5970154487564956155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 11/07/2017 01:15 PM, Christoph Paasch wrote:
> hese are meta-level retransmissions that are being sent on a different
> subflow and/or on the same subflow but with new TCP sequence numbers and a
> new DSS-mapping. These indeed end up going through mptcp_skb_entail().
>
> The retransmissions I mean are the TCP-level retransmissions (aka.,
> fast-retransmits, tail-loss-probe, RTO,...). They don't go through
> mptcp_skb_entail again.
>
> I will take a look at the trace in the other mail.
>
>
> Christoph
RTO will go through this code.
Partial ACK and fast-retransmit etc are fine if they are transmitted =

with the same mapping (or else DSS will fail as well) In fact it is =

required. On the receiver an adjustment is made for the TCP flow's seq =

number.=C2=A0 See mptcp_detect_mapping() it requires that the (partial)=C2=
=A0 skb =

has the exact same mapping as if it was transmitted as part of the =

original skb and than look at mptcp_validate_mapping() and =

mptcp_prepare_skb() that adjust the data sequence number based on the =

tcp sequence number of the packet.

If not than can you explain how the current mechanism works and what =

happens to the DSS settings in case of retransmission. Where/How does it =

gets updated because mptcp_options_write() only does a copy with the =

updated ACK.

When I have some more time I will verify by hacking the kernel. Sorry I =

can not upload the complete kernel as it is a mess right now, I changed =

a lot of things, that is why it has taken this long to even get ssh =

working. I will try to get you just the patch for this fix.

Shoaib

--===============5970154487564956155==--
