Content-Type: multipart/mixed; boundary="===============7197093544870339034=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Tue, 03 Oct 2017 17:22:23 -0700
Message-ID: <alpine.OSX.2.21.1710031442470.15575@jrschiff-mobl.amr.corp.intel.com>
In-Reply-To: 20171003211346.GO92528@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 107

--===============7197093544870339034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 3 Oct 2017, Christoph Paasch wrote:

> On 03/10/17 - 12:26:22, Mat Martineau wrote:
>>
>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>>
>>> Hello Mat,
>>>
>>> On 02/10/17 - 16:00:56, Mat Martineau wrote:
>>>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>>>
>>>>> I keep on moving mptcp_trunk upwards to track upstream Linux. Current=
ly I'm
>>>>> stuck at v4.9 (there is a nasty bug that popped up with the merge and=
 I
>>>>> wasn't able to fix that yet).
>>>>>
>>>>>
>>>>> The merge with v4.9 also forced me to bump skb->cb to 80 bytes... :/
>>>>> I have been thinking back and forth on how we could handle this. The =
best
>>>>> way I see at the moment is to create a scratch-area at the end of the=
 skb's
>>>>> data (like skb_shared_info). I think it also would quite nicely fit w=
ith a
>>>>> KCM/ULP-style architecture where we could have a BPF-program that doe=
s the
>>>>> scheduling.
>>>>> I haven't dived very deep into the skb->cb problem yet.
>>>>>
>>>>
>>>> I don't think we're the first ones to want more control block bytes, s=
eems
>>>> like finding a solution would help outside of MPTCP too. I've looked at
>>>> skb_tailroom_reserve a little bit, and also given some preliminary tho=
ught
>>>> to stashing header info in skb_shared_info->frags (maybe by creating "=
header
>>>> fragments").
>>>
>>>
>>>
>>> Yes, I also have to look a bit more at tailroom_reserve.
>>>
>>> Can you elaborate a bit more on the "header fragments" ?
>>
>> The idea is to modify struct skb_frag_struct to represent different type=
s of
>> fragments by making the page pointer a union and providing a way to dete=
ct
>> the difference (size =3D=3D 0?). In addition to pages of payload, it cou=
ld also
>> point to other types of content, like header information, that would be
>> ignored as payload but available for other use like a pre-populated TCP
>> option.
>
> What if instead of using struct skb_frag_struct, we just add a field to
> struct skb_shared_info? It should not be as restricted wrt to adding fiel=
ds
> as is struct sk_buff, no?
>

I've been assuming that the resistance to increasing the size of sk_buff =

would also apply to skb_shared_info since you end up with larger =

allocations for every skb either way. The impact of a larger =

skb_shared_info is spread across any clones, so it's not as bad as =

changing sk_buff, but it's still an increase.

However, a larger skb_shared_info could be *optional* if we defined a new =

SKB_ALLOC_SHARED_CB flag to pass to __alloc_skb. We get a bunch of space =

to play with and everyone else gets the same size structs and allocations =

that they're used to.

>> A downside is that this would involve making sure that every user of the=
 skb
>> frags array understands what's up, which would touch a lot of driver cod=
e.
>
> True, this would impact a big code base and could be error-prone.
>
>>
>>>
>>> At one point, I had a more or less crazy idea of storing it inside the
>>> payload.
>>>
>>> Here was my train of thought:
>>>
>>> Basically, the big problem with MPTCP (ignoring implementations) is tha=
t the
>>> IETF decided to put the DSS-option in the TCP option-space. Thus, this
>>> inherintly links a TCP-option with the payload of the packet (due to the
>>> DSS-mapping).
>>> Such linking is bad, for TSO, LRO/GRO, middleboxes splitting segments,.=
..
>>>
>>> It would have been much better if the IETF would have placed the DSS-op=
tion
>>> (not the DATA_ACK) in the payload and leave the TCP-options just for tr=
uly
>>> signalling options (DATA_ACK, ADD_ADDR, REMOVE_ADDR, MP_PRIO,...).
>>
>> Agreed!
>>
>>> So, I was thinking that we could fake this and the MPTCP-level would do=
 a
>>> regular tcp_sendmsg on the subsockets with the DSS-mapping as part of t=
he
>>> payload. It would also just pass a flag down to tcp_sendmsg, that indic=
ates
>>> that the payload contains a DSS-mapping. This flag would then be stored=
 in
>>> the relevant skb (just one bit - I think we have that space).
>>>
>>> Then, later in tcp_options_write, we just need to check on that flag and
>>> extract the DSS-mapping and write it into the TCP header space (and adj=
ust
>>> skb->data,...).
>>>
>>>
>>> In principle, I think this would have been very clean IMO.
>>>
>>>
>>> But it doesn't work, because this DSS-mapping will no be accounted in T=
CP's
>>> sequence space (aka., snd_nxt,...) but in the end it won't be sent out.=
 So,
>>> that would screw up TCP completly. Basically, skb->len will include the
>>> DSS-mapping in the payload but it won't be sent out as part of the payl=
oad
>>> but as part of the TCP option-space.
>>>
>>> So, because of this I gave up on this avenue.
>>>
>>> If you think this could work in another way or something like that, let=
 me
>>> know :)
>>
>> I've been looking at a very similar approach, pre-populating the DSS opt=
ion
>> and setting a flag telling tcp_options_write to use those option bytes a=
s-is
>> and build the rest of the TCP header before it.
>
> These pre-populated bytes would be sitting in the linear part of the memo=
ry
> above skb->data ?

By "above" I'm not sure if you mean "in the headroom between skb->head and =

skb->data" or "starting at skb->data". The latter is what I intended: =

skb->data points to the option kind byte.

>
> We had a similar approach prior to switching to the tcp_skb_cb->dss mode
> (which was done by Octavian). I detailled this old approach in my thesis
> (https://inl.info.ucl.ac.be/system/files/phd-thesis_1.pdf), starting at p=
age
> 101.
>
>
> I just reread what the issue was and the problem was that pskb_copy()
> would then not copy the DSS-option. So, before every call to pskb_copy() =
in
> the TCP-stack we were adjusting skb->data and skb->len to make sure that =
it
> all got taken care of.

I've re-read that now as well, and it sounds like I am reinventing the =

older v0.88 approach that has various corner cases but not the pksb_copy =

problem. Unfortunately it sounds like it was complicated in practice!

> Now, if we can handle this cleaner in pskb_copy() we could go back to what
> we had before. I think we just need to store in the skb how much data is
> sitting on top of skb->data that needs to be copied as well. And then we =
are
> good to go IMO.

Another variation is to have a "copy_headroom" bit in sk_buff that makes =

pskb_copy copy everything from skb->head to skb->tail. But I like the =

SKB_ALLOC_SHARED_CB idea better.

>> The TCP sequence numbers
>> could also detect the prepopulated header and account for it.
>
> I'm not sure what you mean by that. How would the sequence numbers account
> for the prepopulated header?

I didn't phrase that well, my apologies. If the TCP option was =

prepopulated at skb->data, the current TCP code would see it as part of =

the payload. The code doing the TCP sequence number assignment would have =

to know the actual TCP payload length in order to set the sequence numbers =

correctly in the header.

>> I don't think
>> this has the problem you identified since all of the skb payload is sent.
>> Maybe this doesn't play nice with cloned skbs (which can't modify the
>> payload), but doesn't the mapping need to stay the same if it's
>> retransmitted?
>
> Yes, it must stay the same. Otherwise there will be trouble with the
> DSS-csum.
>
> But it does not need to be on all segments that are covered by the mappin=
g.
> Meaning, if we split an skb thanks to an incoming SACK-block or a partial=
 ACK,
> we don't have to make sure that the new skb has the DSS-option as well.
> Because part of it has been ack'd (or sack'd) and thus the receiver got
> the DSS-option.

Regards,

--
Mat Martineau
Intel OTC

--===============7197093544870339034==--
