Content-Type: multipart/mixed; boundary="===============1758071305182727272=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] TCP options framework and MD5 patch set
Date: Thu, 25 Jan 2018 14:13:57 -0800
Message-ID: <20180125221357.GV5151@da0602a-dhcp225.apple.com>
In-Reply-To: alpine.OSX.2.21.1801251107590.28492@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 297

--===============1758071305182727272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On 25/01/18 - 11:41:53, Mat Martineau wrote:
> =

> Hi Christoph -
> =

> Thanks again for posting the RFC patch set to netdev in December. In case
> folks on this mailing list missed it, here's the link:
> =

> https://www.spinics.net/lists/netdev/msg472988.html
> =

> Other than the license information change, are you considering any other
> modifications?

no, not really. I was planning to get some performance numbers. But couldn't
get to it because of other unrelated urgencies that took my time.

> I suggest modifying the last section of the cover letter (the part starti=
ng
> with "One point of discussion...") for the next round:
> =

> """
> There is still work to be done to more efficiently check for extra TCP
> options in performance-sensitive code paths. A rate-limited static key wo=
uld
> nearly eliminate overhead if no extra TCP options are in use system-wide,=
 or
> a flag in a likely-hot cache line could work well.
> =

> For now we opted for a simple if (unlikely(!hlist_empty(...)) check.
> """

That sounds good!


What do you suggest - should we simply resubmit the RFCs as v2 with the
minor changes? (the timing of the first submission was probably fairly bad
as most people were out on Christmas vacation)


Christoph


--===============1758071305182727272==--
