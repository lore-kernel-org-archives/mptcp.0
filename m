Content-Type: multipart/mixed; boundary="===============8591416869959343828=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: Basic single-subflow DATA_FIN
Date: Wed, 04 Dec 2019 22:25:56 +0100
Message-ID: <41795da8-33bd-8bc0-f73a-bf043fe104e5@tessares.net>
In-Reply-To: 0ffcef214516d5478455cd6745e312352b498fd5.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2785

--===============8591416869959343828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo, Peter,

On 27/11/2019 04:39, Peter Krystad wrote:
> =

> Hi Matt -
> =

> On Tue, 2019-11-26 at 10:07 +0100, Matthieu Baerts wrote:
>> Hi Mat, Paolo,
>>
>> On 25/11/2019 18:00, Paolo Abeni wrote:
>>> On Fri, 2019-11-22 at 15:01 -0800, Mat Martineau wrote:
>>>> Send a DATA_FIN along with any subflow TCP FIN flag when the MPTCP
>>>> socket is closing or shutting down writes.
>>>>
>>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>>
>>> The patch LGTM, thanks!
>>
>> Thank you for the new version and the review!
>>
>> Where can I apply it? I would like to apply it just before the
>> introduction of the kselftests but please tell me if it is better to
>> squash it / apply it somewhere else.
> =

> Mat is out this week. I've checked that the changes to options.c and
> protocol.c can be squashed to 'Write MPTCP DSS headers to outgoing data
> packets' and the changes to subflow.c squash to 'Implement MPTCP receive
> path'.

Thank you again for the patch, the reviews and the instructions!

Sorry for the delay. I feel bad because I was suspecting conflicts with =

other commits of the series but there was no conflict at all!

- 825f10f90667: "squashed" in "mptcp: Write MPTCP DSS headers to =

outgoing data packets"
- 7a9b711a86ee: "squashed" in "mptcp: Implement MPTCP receive path"
- bcf60b29e527..b887804d061e: result

Each commit still compiles and tests are still passing!

Hopefully tomorrow, I can apply MPTCPv1 patches and all others waiting =

to be applied :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8591416869959343828==--
