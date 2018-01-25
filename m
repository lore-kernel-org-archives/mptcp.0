Content-Type: multipart/mixed; boundary="===============5013094377274574535=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] TCP options framework and MD5 patch set
Date: Thu, 25 Jan 2018 11:41:53 -0800
Message-ID: <alpine.OSX.2.21.1801251107590.28492@mjmartin-mac01.sea.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 296

--===============5013094377274574535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph -

Thanks again for posting the RFC patch set to netdev in December. In case =

folks on this mailing list missed it, here's the link:

https://www.spinics.net/lists/netdev/msg472988.html

Other than the license information change, are you considering any other =

modifications?

I suggest modifying the last section of the cover letter (the part =

starting with "One point of discussion...") for the next round:

"""
There is still work to be done to more efficiently check for extra TCP =

options in performance-sensitive code paths. A rate-limited static key =

would nearly eliminate overhead if no extra TCP options are in use =

system-wide, or a flag in a likely-hot cache line could work well.

For now we opted for a simple if (unlikely(!hlist_empty(...)) check.
"""

Regards,

--
Mat Martineau
Intel OTC

--===============5013094377274574535==--
