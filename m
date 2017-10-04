Content-Type: multipart/mixed; boundary="===============6723044642025138798=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Wed, 04 Oct 2017 09:13:03 -0700
Message-ID: <alpine.OSX.2.21.1710040853270.23009@syyang-mobl2.amr.corp.intel.com>
In-Reply-To: 20171004062221.GE4897@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 109

--===============6723044642025138798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 3 Oct 2017, Christoph Paasch wrote:

> On 03/10/17 - 17:22:23, Mat Martineau wrote:
>>
>> On Tue, 3 Oct 2017, Christoph Paasch wrote:
>>
>>> On 03/10/17 - 12:26:22, Mat Martineau wrote:
>>>>
>>>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>>>>
>>>>> Hello Mat,
>>>>>
>>>>> On 02/10/17 - 16:00:56, Mat Martineau wrote:
>>>>>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>>>>>
>>>>>>> I keep on moving mptcp_trunk upwards to track upstream Linux. Curre=
ntly I'm
>>>>>>> stuck at v4.9 (there is a nasty bug that popped up with the merge a=
nd I
>>>>>>> wasn't able to fix that yet).
>>>>>>>
>>>>>>>
>>>>>>> The merge with v4.9 also forced me to bump skb->cb to 80 bytes... :/
>>>>>>> I have been thinking back and forth on how we could handle this. Th=
e best
>>>>>>> way I see at the moment is to create a scratch-area at the end of t=
he skb's
>>>>>>> data (like skb_shared_info). I think it also would quite nicely fit=
 with a
>>>>>>> KCM/ULP-style architecture where we could have a BPF-program that d=
oes the
>>>>>>> scheduling.
>>>>>>> I haven't dived very deep into the skb->cb problem yet.
>>>>>>>
>>>>>>
>>>>>> I don't think we're the first ones to want more control block bytes,=
 seems
>>>>>> like finding a solution would help outside of MPTCP too. I've looked=
 at
>>>>>> skb_tailroom_reserve a little bit, and also given some preliminary t=
hought
>>>>>> to stashing header info in skb_shared_info->frags (maybe by creating=
 "header
>>>>>> fragments").
>>>>>
>>>>>
>>>>>
>>>>> Yes, I also have to look a bit more at tailroom_reserve.
>>>>>
>>>>> Can you elaborate a bit more on the "header fragments" ?
>>>>
>>>> The idea is to modify struct skb_frag_struct to represent different ty=
pes of
>>>> fragments by making the page pointer a union and providing a way to de=
tect
>>>> the difference (size =3D=3D 0?). In addition to pages of payload, it c=
ould also
>>>> point to other types of content, like header information, that would be
>>>> ignored as payload but available for other use like a pre-populated TCP
>>>> option.
>>>
>>> What if instead of using struct skb_frag_struct, we just add a field to
>>> struct skb_shared_info? It should not be as restricted wrt to adding fi=
elds
>>> as is struct sk_buff, no?
>>>
>>
>> I've been assuming that the resistance to increasing the size of sk_buff
>> would also apply to skb_shared_info since you end up with larger allocat=
ions
>> for every skb either way. The impact of a larger skb_shared_info is spre=
ad
>> across any clones, so it's not as bad as changing sk_buff, but it's stil=
l an
>> increase.
>>
>> However, a larger skb_shared_info could be *optional* if we defined a new
>> SKB_ALLOC_SHARED_CB flag to pass to __alloc_skb. We get a bunch of space=
 to
>> play with and everyone else gets the same size structs and allocations t=
hat
>> they're used to.
>
> I like that!
>

...

>
>>
>>>
>>> We had a similar approach prior to switching to the tcp_skb_cb->dss mode
>>> (which was done by Octavian). I detailled this old approach in my thesis
>>> (https://inl.info.ucl.ac.be/system/files/phd-thesis_1.pdf), starting at=
 page
>>> 101.
>>>
>>>
>>> I just reread what the issue was and the problem was that pskb_copy()
>>> would then not copy the DSS-option. So, before every call to pskb_copy(=
) in
>>> the TCP-stack we were adjusting skb->data and skb->len to make sure tha=
t it
>>> all got taken care of.
>>
>> I've re-read that now as well, and it sounds like I am reinventing the o=
lder
>> v0.88 approach that has various corner cases but not the pksb_copy probl=
em.
>> Unfortunately it sounds like it was complicated in practice!
>>
>>> Now, if we can handle this cleaner in pskb_copy() we could go back to w=
hat
>>> we had before. I think we just need to store in the skb how much data is
>>> sitting on top of skb->data that needs to be copied as well. And then w=
e are
>>> good to go IMO.
>>
>> Another variation is to have a "copy_headroom" bit in sk_buff that makes
>> pskb_copy copy everything from skb->head to skb->tail. But I like the
>> SKB_ALLOC_SHARED_CB idea better.
>
> Agreed, SKB_ALLOC_SHARED_CB looks good to me. It's very generic and can be
> used later on by other protocols,...
>

...

>
> From what I see, the SKB_ALLOC_SHARED_CB approach seems to me the most
> promising and generic. Let's try to aim for this.
>
> Do you have cycles to investigate this approach?
>

Yes, I'll work on SKB_ALLOC_SHARED_CB.

I like the idea of a variable-length shared control buffer, but it would =

introduce more complexity to request a specific length and ensure that =

it's accessed safely. Slightly leaning toward a fixed length 48 bytes, =

just like sk_buff->cb. Any thoughts on that?

--
Mat Martineau
Intel OTC

--===============6723044642025138798==--
