Content-Type: multipart/mixed; boundary="===============5093684805971631299=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 0/2] mptcp: partial recvmsg() refactor
Date: Sat, 21 Sep 2019 13:16:29 +0200
Message-ID: <653214bc-1499-18e3-c36b-1b3d8bb9342f@tessares.net>
In-Reply-To: alpine.OSX.2.21.1909181541490.40632@tvtrimel-mobl5.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1900

--===============5093684805971631299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 19/09/2019 00:42, Mat Martineau wrote:
> On Wed, 18 Sep 2019, Paolo Abeni wrote:
> =

>> This 2 patches start the recvmsg() refactor discussed in last mtg.
>> The explicit 'duplicate data' handling in 1/2 fix some stream
>> corruption I
>> observe with re-injection, and the 2nd one fix another stream
>> corruption at
>> the end of the stream, still triggered=C2=A0 by re-injection.
>>
>> With the above 2 patches I still stream corruptions with re-injection,
>> are
>> almost gone - even if I can still hit them with in at least a very
>> rare corner
>> case.
>>
>> Only minor changes since v1, to address Mat's feedback, details in the
>> individual changelog
>>
>> Paolo Abeni (2):
>> =C2=A0mptcp: refactor recvmsg()
>> =C2=A0mptcp: recvmsg() should really try to deliver 'len' bytes to
>> =C2=A0=C2=A0 user-space
>>
>> net/mptcp/protocol.c | 120 +++++++++++++++++++------------------------
>> 1 file changed, 54 insertions(+), 66 deletions(-)
>>
>> --=C2=A0
>> 2.21.0
> =

> Thanks for the v2. These look good to merge.

Thank you for the patches and the reviews!

- ae3e015a67e3: "squashed" the first one in "mptcp: Implement MPTCP
receive path"
- signed off was already there
- eebee22fe45e: "squashed" the second one in "mptcp: Implement MPTCP
receive path" as well.
- 380876e851ad: conflict in
t/mptcp-Make-MPTCP-socket-block-wakeup-ignore-sk_receive_queue
- 782be479bf43..0341ab0068b3: result

This fixed all the previous failed tests, that's good :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5093684805971631299==--
