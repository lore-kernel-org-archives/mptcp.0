Content-Type: multipart/mixed; boundary="===============4088043998120241012=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: be careful on MPTCP-level ack.
Date: Wed, 02 Dec 2020 17:10:05 +0100
Message-ID: <2ac90c38-c82a-8aeb-2c01-b44a6de1bf57@gmail.com>
In-Reply-To: 665bb3a603afebdcc85878f6b45bcf0313607994.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7011

--===============4088043998120241012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/2/20 4:37 PM, Paolo Abeni wrote:
> On Wed, 2020-12-02 at 14:18 +0100, Eric Dumazet wrote:
>>
>> On 11/24/20 10:51 PM, Paolo Abeni wrote:
>>> We can enter the main mptcp_recvmsg() loop even when
>>> no subflows are connected. As note by Eric, that would
>>> result in a divide by zero oops on ack generation.
>>>
>>> Address the issue by checking the subflow status before
>>> sending the ack.
>>>
>>> Additionally protect mptcp_recvmsg() against invocation
>>> with weird socket states.
>>>
>>> v1 -> v2:
>>>  - removed unneeded inline keyword - Jakub
>>>
>>> Reported-and-suggested-by: Eric Dumazet <eric.dumazet(a)gmail.com>
>>> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
>>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>>> ---
>>>  net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++++++++------------
>>>  1 file changed, 49 insertions(+), 18 deletions(-)
>>>
>>
>> Looking at mptcp recvmsg(), it seems that a read(fd, ..., 0) will
>> trigger an infinite loop if there is available data in receive queue ?
> =

> Thank you for looking into this!
> =

> I can't reproduce the issue with the following packetdrill ?!?
> =

> +0.0  connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
> +0.1   > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8,mpcapabl=
e v1 fflags[flag_h] nokey>
> +0.1   < S. 0:0(0) ack 1 win 65535 <mss 1460,sackOK,TS val 700 ecr 100,no=
p,wscaale 8,mpcapable v1 flags[flag_h] key[skey=3D2] >
> +0.1  > . 1:1(0) ack 1 <nop, nop, TS val 100 ecr 700,mpcapable v1 flags[f=
lag_h]] key[ckey,skey]>
> +0.1 fcntl(3, F_SETFL, O_RDWR) =3D 0
> +0.1   < .  1:201(200) ack 1 win 225 <dss dack8=3D1 dsn8=3D1 ssn=3D1 dll=
=3D200 nocs,  nop, nop>
> +0.1   > .  1:1(0) ack 201 <nop, nop, TS val 100 ecr 700, dss dack8=3D201=
 dll=3D00 nocs>
> +0.1 read(3, ..., 0) =3D 0
> =

> The main recvmsg() loop is interrupted by the following check:
> =

>                 if (copied >=3D target)
>                         break;

@copied should be 0, and @target should be 1

Are you sure the above condition is triggering ?

Maybe read(fd, ..., 0) does not reach recvmsg() at all.

You could try recvmsg() or recvmmsg(), =


> =

> I guess we could loop while the msk has available rcv space and some
> subflow is feeding new data. If so, I think moving:
> =

> 	if (skb_queue_empty(&msk->receive_queue) &&
>                     __mptcp_move_skbs(msk, len - copied))
>                         continue;
> =

> after the above check should address the issue, and will make the
> common case faster. Let me test the above - unless I underlooked
> something relevant!
> =

> Thanks,
> =

> Paolo
>=20
--===============4088043998120241012==--
