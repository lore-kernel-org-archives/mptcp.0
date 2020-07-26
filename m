Content-Type: multipart/mixed; boundary="===============5005115525091591431=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt v2
Date: Sun, 26 Jul 2020 00:46:44 -0700
Message-ID: <20200726.004644.71243023033363639.davem@davemloft.net>
In-Reply-To: 20200726070311.GA16687@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5297

--===============5005115525091591431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig <hch(a)lst.de>
Date: Sun, 26 Jul 2020 09:03:11 +0200

> On Fri, Jul 24, 2020 at 03:43:42PM -0700, David Miller wrote:
>> > Changes since v1:
>> >  - check that users don't pass in kernel addresses
>> >  - more bpfilter cleanups
>> >  - cosmetic mptcp tweak
>> =

>> Series applied to net-next, I'm build testing and will push this out when
>> that is done.
> =

> The buildbot found one warning with the isdn debug code after a few
> days, here is what I think is the best fix:

I already fixed this in net-next.
--===============5005115525091591431==--
