Content-Type: multipart/mixed; boundary="===============4204829463014005151=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Wed, 04 Oct 2017 09:38:19 -0700
Message-ID: <EBF8A9B6-7133-4819-90B7-CFCA6BA40ABE@apple.com>
In-Reply-To: alpine.OSX.2.21.1710040853270.23009@syyang-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 110

--===============4204829463014005151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Oct 4, 2017, at 9:13 AM, Mat Martineau <mathew.j.martineau(a)linux.int=
el.com> wrote:
> =

> =

>> On Tue, 3 Oct 2017, Christoph Paasch wrote:
>> =

>>> On 03/10/17 - 17:22:23, Mat Martineau wrote:
>>> =

>>>> On Tue, 3 Oct 2017, Christoph Paasch wrote:
>>>> =

>>>>> On 03/10/17 - 12:26:22, Mat Martineau wrote:
>>>>> =

>>>>>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>>>>>> =

>>>>>> Hello Mat,
>>>>>> =

>>>>>>> On 02/10/17 - 16:00:56, Mat Martineau wrote:
>>>>>>> On Mon, 2 Oct 2017, Christoph Paasch wrote:
>>>>>> =

>>>>>>>> I keep on moving mptcp_trunk upwards to track upstream Linux. Curr=
ently I'm
>>>>>>>> stuck at v4.9 (there is a nasty bug that popped up with the merge =
and I
>>>>>>>> wasn't able to fix that yet).
>>>>>>>> =

>>>>>>>> =

>>>>>>>> The merge with v4.9 also forced me to bump skb->cb to 80 bytes... =
:/
>>>>>>>> I have been thinking back and forth on how we could handle this. T=
he best
>>>>>>>> way I see at the moment is to create a scratch-area at the end of =
the skb's
>>>>>>>> data (like skb_shared_info). I think it also would quite nicely fi=
t with a
>>>>>>>> KCM/ULP-style architecture where we could have a BPF-program that =
does the
>>>>>>>> scheduling.
>>>>>>>> I haven't dived very deep into the skb->cb problem yet.
>>>>>>>> =

>>>>>>> =

>>>>>>> I don't think we're the first ones to want more control block bytes=
, seems
>>>>>>> like finding a solution would help outside of MPTCP too. I've looke=
d at
>>>>>>> skb_tailroom_reserve a little bit, and also given some preliminary =
thought
>>>>>>> to stashing header info in skb_shared_info->frags (maybe by creatin=
g "header
>>>>>>> fragments").
>>>>>> =

>>>>>> =

>>>>>> =

>>>>>> Yes, I also have to look a bit more at tailroom_reserve.
>>>>>> =

>>>>>> Can you elaborate a bit more on the "header fragments" ?
>>>>> =

>>>>> The idea is to modify struct skb_frag_struct to represent different t=
ypes of
>>>>> fragments by making the page pointer a union and providing a way to d=
etect
>>>>> the difference (size =3D=3D 0?). In addition to pages of payload, it =
could also
>>>>> point to other types of content, like header information, that would =
be
>>>>> ignored as payload but available for other use like a pre-populated T=
CP
>>>>> option.
>>>> =

>>>> What if instead of using struct skb_frag_struct, we just add a field to
>>>> struct skb_shared_info? It should not be as restricted wrt to adding f=
ields
>>>> as is struct sk_buff, no?
>>>> =

>>> =

>>> I've been assuming that the resistance to increasing the size of sk_buff
>>> would also apply to skb_shared_info since you end up with larger alloca=
tions
>>> for every skb either way. The impact of a larger skb_shared_info is spr=
ead
>>> across any clones, so it's not as bad as changing sk_buff, but it's sti=
ll an
>>> increase.
>>> =

>>> However, a larger skb_shared_info could be *optional* if we defined a n=
ew
>>> SKB_ALLOC_SHARED_CB flag to pass to __alloc_skb. We get a bunch of spac=
e to
>>> play with and everyone else gets the same size structs and allocations =
that
>>> they're used to.
>> =

>> I like that!
>> =

> =

> ...
> =

>> =

>>> =

>>>> =

>>>> We had a similar approach prior to switching to the tcp_skb_cb->dss mo=
de
>>>> (which was done by Octavian). I detailled this old approach in my thes=
is
>>>> (https://inl.info.ucl.ac.be/system/files/phd-thesis_1.pdf), starting a=
t page
>>>> 101.
>>>> =

>>>> =

>>>> I just reread what the issue was and the problem was that pskb_copy()
>>>> would then not copy the DSS-option. So, before every call to pskb_copy=
() in
>>>> the TCP-stack we were adjusting skb->data and skb->len to make sure th=
at it
>>>> all got taken care of.
>>> =

>>> I've re-read that now as well, and it sounds like I am reinventing the =
older
>>> v0.88 approach that has various corner cases but not the pksb_copy prob=
lem.
>>> Unfortunately it sounds like it was complicated in practice!
>>> =

>>>> Now, if we can handle this cleaner in pskb_copy() we could go back to =
what
>>>> we had before. I think we just need to store in the skb how much data =
is
>>>> sitting on top of skb->data that needs to be copied as well. And then =
we are
>>>> good to go IMO.
>>> =

>>> Another variation is to have a "copy_headroom" bit in sk_buff that makes
>>> pskb_copy copy everything from skb->head to skb->tail. But I like the
>>> SKB_ALLOC_SHARED_CB idea better.
>> =

>> Agreed, SKB_ALLOC_SHARED_CB looks good to me. It's very generic and can =
be
>> used later on by other protocols,...
>> =

> =

> ...
> =

>> =

>> From what I see, the SKB_ALLOC_SHARED_CB approach seems to me the most
>> promising and generic. Let's try to aim for this.
>> =

>> Do you have cycles to investigate this approach?
>> =

> =

> Yes, I'll work on SKB_ALLOC_SHARED_CB.
> =

> I like the idea of a variable-length shared control buffer, but it would =
introduce more complexity to request a specific length and ensure that it's=
 accessed safely. Slightly leaning toward a fixed length 48 bytes, just lik=
e sk_buff->cb. Any thoughts on that?

Yes, fixed length of 48 bytes sounds good to me.


Christoph =


> =

> --
> Mat Martineau
> Intel OTC

--===============4204829463014005151==--
