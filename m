Content-Type: multipart/mixed; boundary="===============8651956753598623092=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Wed, 12 Jun 2019 10:38:12 +0200
Message-ID: <9c7eb1996dfcdcc1ffa2a7ada3781d7a1b19b5e6.camel@redhat.com>
In-Reply-To: 20190611211340.GS5495@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 1343

--===============8651956753598623092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-11 at 14:13 -0700, Christoph Paasch wrote:
> Now, ATS will be doing a 9.0.0-release soon that will be the first
> release with this MPTCP-option in the ATS-config.

This is probably a question more for Leif, how far/near is such
release?

> So, we are wondering how we can do binary compatibility without having to
> wait for MPTCP to land upstream. Could the MPTCP-code expose maybe a sysc=
tl
> that indicates the "API-version" ? That way, upon startup ATS can simply
> check the API-version and if it doesn't match, just disable MPTCP.
> =

> What are your thoughts?

I think we may look at other pieces of the kernel/networking stack that
alreday implement "versioning"

- AF_PACKET. A getsockopt() is used to retrieve the API version
(specifying e.g. the metadata layout). There is an additional possible
difference: packet sockets allow user space to set the API version via
setsockopt().

- nftables exposes an API version number via netlink (@Florian can you
give more details?)

- schedstat exposes the stats layout version number via a field in the
same procfs entry

- Others?!?

First 2 approaches look viable to me.

Cheers,

Paolo



--===============8651956753598623092==--
