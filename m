Content-Type: multipart/mixed; boundary="===============1230650713920494735=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Tue, 03 Oct 2017 12:26:22 -0700
Message-ID: <alpine.OSX.2.21.1710031145580.15575@jrschiff-mobl.amr.corp.intel.com>
In-Reply-To: 20171002232832.GI31629@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 105

--===============1230650713920494735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 2 Oct 2017, Christoph Paasch wrote:

> Hello Mat,
>
> On 02/10/17 - 16:00:56, Mat Martineau wrote:
>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>
>>> I keep on moving mptcp_trunk upwards to track upstream Linux. Currently=
 I'm
>>> stuck at v4.9 (there is a nasty bug that popped up with the merge and I
>>> wasn't able to fix that yet).
>>>
>>>
>>> The merge with v4.9 also forced me to bump skb->cb to 80 bytes... :/
>>> I have been thinking back and forth on how we could handle this. The be=
st
>>> way I see at the moment is to create a scratch-area at the end of the s=
kb's
>>> data (like skb_shared_info). I think it also would quite nicely fit wit=
h a
>>> KCM/ULP-style architecture where we could have a BPF-program that does =
the
>>> scheduling.
>>> I haven't dived very deep into the skb->cb problem yet.
>>>
>>
>> I don't think we're the first ones to want more control block bytes, see=
ms
>> like finding a solution would help outside of MPTCP too. I've looked at
>> skb_tailroom_reserve a little bit, and also given some preliminary thoug=
ht
>> to stashing header info in skb_shared_info->frags (maybe by creating "he=
ader
>> fragments").
>
>
>
> Yes, I also have to look a bit more at tailroom_reserve.
>
> Can you elaborate a bit more on the "header fragments" ?

The idea is to modify struct skb_frag_struct to represent different types =

of fragments by making the page pointer a union and providing a way to =

detect the difference (size =3D=3D 0?). In addition to pages of payload, it =

could also point to other types of content, like header information, that =

would be ignored as payload but available for other use like a =

pre-populated TCP option.

A downside is that this would involve making sure that every user of the =

skb frags array understands what's up, which would touch a lot of driver =

code.

>
> At one point, I had a more or less crazy idea of storing it inside the
> payload.
>
> Here was my train of thought:
>
> Basically, the big problem with MPTCP (ignoring implementations) is that =
the
> IETF decided to put the DSS-option in the TCP option-space. Thus, this
> inherintly links a TCP-option with the payload of the packet (due to the
> DSS-mapping).
> Such linking is bad, for TSO, LRO/GRO, middleboxes splitting segments,...
>
> It would have been much better if the IETF would have placed the DSS-opti=
on
> (not the DATA_ACK) in the payload and leave the TCP-options just for truly
> signalling options (DATA_ACK, ADD_ADDR, REMOVE_ADDR, MP_PRIO,...).

Agreed!

> So, I was thinking that we could fake this and the MPTCP-level would do a
> regular tcp_sendmsg on the subsockets with the DSS-mapping as part of the
> payload. It would also just pass a flag down to tcp_sendmsg, that indicat=
es
> that the payload contains a DSS-mapping. This flag would then be stored in
> the relevant skb (just one bit - I think we have that space).
>
> Then, later in tcp_options_write, we just need to check on that flag and
> extract the DSS-mapping and write it into the TCP header space (and adjust
> skb->data,...).
>
>
> In principle, I think this would have been very clean IMO.
>
>
> But it doesn't work, because this DSS-mapping will no be accounted in TCP=
's
> sequence space (aka., snd_nxt,...) but in the end it won't be sent out. S=
o,
> that would screw up TCP completly. Basically, skb->len will include the
> DSS-mapping in the payload but it won't be sent out as part of the payload
> but as part of the TCP option-space.
>
> So, because of this I gave up on this avenue.
>
> If you think this could work in another way or something like that, let me
> know :)

I've been looking at a very similar approach, pre-populating the DSS =

option and setting a flag telling tcp_options_write to use those option =

bytes as-is and build the rest of the TCP header before it. The TCP =

sequence numbers could also detect the prepopulated header and account for =

it. I don't think this has the problem you identified since all of the skb =

payload is sent. Maybe this doesn't play nice with cloned skbs (which =

can't modify the payload), but doesn't the mapping need to stay the same =

if it's retransmitted?


--
Mat Martineau
Intel OTC

--===============1230650713920494735==--
