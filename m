Content-Type: multipart/mixed; boundary="===============0975731055788984575=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 0/3] mptcp: refactor xmit path
Date: Tue, 14 May 2019 18:10:47 +0200
Message-ID: <7a76b25f-3e0f-08f5-fde4-2df95f7e7789@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905101738350.59728@julieann-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1168

--===============0975731055788984575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/05/2019 02:43, Mat Martineau wrote:
> =

> On Fri, 10 May 2019, Paolo Abeni wrote:
> =

>> this series refactor the mptcp xmit path trying to make sendmsg behavior
>> more consistent, memory efficent and improve its performances.
>>
>> Self-test results are not affected: tests fail in similar way before and
>> after this series.
>>
>> To support MP_JOIN and multiple subflows, the idea is adding, with later
>> patches, an RB-tree structure containing references to the pending page
>> fragments, their length and the associated mptcp write_seq number (is
>> subflow
>> rel_write_seq needed, too?).
> =

> rel_write_seq doesn't need to be stored for later, it will be different
> for every copy of the data that is sent.
> =

>> RB-tree node can be allocated using the same
>> page frag used in this series for skb data. Each RB-tree node will own a
>> reference to the page frag.
> =

> I think this is a nice improvement for the sendmsg code, the earlier
> issues are resolved and we should merge the series to mptcp_net-next.

Thank you for the new version of the patches and the reviews. Just added
at the end of the series.

https://github.com/multipath-tcp/mptcp_net-next/commits/export

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0975731055788984575==--
