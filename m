Content-Type: multipart/mixed; boundary="===============3857790036813446465=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Fix bug processing options
Date: Sat, 26 Oct 2019 10:04:29 +0200
Message-ID: <c8b8201f-765a-74c2-be31-0ca4b23c7537@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910251640160.66912@srpullel-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2336

--===============3857790036813446465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

On 26/10/2019 01:40, Mat Martineau wrote:
> =

> On Tue, 22 Oct 2019, Peter Krystad wrote:
> =

>> Do not process incoming options if the subflow is not MPTCP.
>>
>> Observed crash when running against out-of-tree kernel with
>> mis-matched checksum options.
>>
>> Peter Krystad (2):
>> =C2=A0mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
>> =C2=A0mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
>>
>> net/mptcp/options.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
> =

> Both changes look good to me. Thanks, Peter!

Thank you for the patches and the reviews!

- 6eb607af7475: "squashed" patch 1/2 in "mptcp: Implement MPTCP receive =

path"
- ea443b296417: "squashed" patch 2/2 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- 22b6803a0c48..a89f2feb5b90: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3857790036813446465==--
