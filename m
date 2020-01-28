Content-Type: multipart/mixed; boundary="===============0772547063783160419=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v1 4/4] mptcp: handle tcp fallback when
 using syn cookies
Date: Tue, 28 Jan 2020 20:48:12 +0100
Message-ID: <20200128194812.GF795@breakpoint.cc>
In-Reply-To: cb174326-928a-4037-b366-68f9eecb52c1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3546

--===============0772547063783160419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> On 28/01/2020 16:01, Florian Westphal wrote:
> > I decided to remove the ifdef on tcp_rsk "is_mptcp" member because
> > if (IS_ENABLED()) is easier to read than "#ifdef IS_ENABLED()/#endif" p=
air.
> =

> I agree with you that it is easier to read but will it be OK for upstream?
> Should we use a bitfield and include 'tfo_listener' in it?

It doesn't increase struct size, so I think its OK.  bitfield would be
better but not for -net, we can do this in 2 weeks when net-next opens agai=
n.
--===============0772547063783160419==--
