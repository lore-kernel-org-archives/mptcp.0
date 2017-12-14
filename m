Content-Type: multipart/mixed; boundary="===============4270695297248217496=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 03/15] tcp: Pass sock and skb to tcp_options_write
Date: Thu, 14 Dec 2017 12:12:53 -0800
Message-ID: <20171214201253.GF64966@da0602a-dhcp135.apple.com>
In-Reply-To: alpine.OSX.2.21.1712121546010.15459@sjweber-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 259

--===============4270695297248217496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/12/17 - 16:00:16, Mat Martineau wrote:
> =

> On Mon, 11 Dec 2017, Christoph Paasch wrote:
> =

> > Because, to write the extra-options, we need the request-socket to pars=
e the
> > list of extra-options to be written to the TCP-header.
> > The skb is also needed so that extra-options like TCP_MD5SIG can compute
> > the hash properly.
> =

> Without reading ahead in the patch set, people won't know what
> "extra-options" are. A little more context would help:
> =

> """
> =

> An upcoming patch adds a configurable, per-socket list of TCP options to
> populate in the TCP header. This requires tcp_options_write() to know the
> socket (to use the options list) and the skb (to provide visibility to the
> packet data for options like TCP_MD5SIG).
> =

> """

Thanks, updated the commit-message.


Christoph


--===============4270695297248217496==--
