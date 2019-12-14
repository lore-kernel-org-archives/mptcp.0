Content-Type: multipart/mixed; boundary="===============1643080709411145140=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/15] Multipath TCP part 2: Single subflow
Date: Sat, 14 Dec 2019 09:15:19 +0100
Message-ID: <36805222-6110-7130-13d8-1d1cf6dd95c1@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912132330360.40703@amhui-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3067

--===============1643080709411145140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Peter,

On 14/12/2019 08:38, Mat Martineau wrote:
> =

> On Fri, 13 Dec 2019, Matthieu Baerts wrote:
> =

>> These patches depend on the "Multipath TCP part 1: Prerequisites" patch
>> set sent earlier.
>>
>> This set adds MPTCP connection establishment, writing & reading MPTCP
>> options on data packets, a sysctl to allow MPTCP per-namespace, and self
>> tests. This is sufficient to establish and maintain a connection with a
>> MPTCP peer, but will not yet allow or initiate establishment of
>> additional MPTCP subflows.
>>
>> Clone/fetch:
>> https://github.com/multipath-tcp/mptcp_net-next.git (tag: =

>> netdev-v1-part2)
>>
>> Browse:
>> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v1-part2
>>
>> Thank your for your review. You can find us at mptcp(a)lists.01.org and
>> https://is.gd/mptcp_upstream
>>
> =

> Matthieu -
> =

> Here are the three commits that we modified for the netdev-v1-part2 =

> submission:
> =

> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/1d9cd488687c4fcb72=
55f2a6428980e6f0bfb68f =

> =

> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/eb7be7fa655c8fd491=
06c2e83edc1d24b50d73be =

> =

> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/519412484946e9eb80=
7d6b486a72b0d26f49daec =


Thank you for the summary and improving the commit messages!

- [t/mptcp-Handle-MPTCP-TCP-options b1367325fa4e] tg:msg: mention MP_CAPABLE
- [t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections =

f7feab2d5abe] tg:msg: we also capture MP_CAP in SYN-ACK
- [t/mptcp-Add-key-generation-and-token-tree 467cd5f2bc8e] tg:msg: =

mention overriden 'ops' callbacks
- f789d4ea2ca1..796df64ae016: result (empty, normal)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1643080709411145140==--
