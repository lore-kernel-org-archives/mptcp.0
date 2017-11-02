Content-Type: multipart/mixed; boundary="===============4021333298355598602=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Thu, 02 Nov 2017 14:41:22 -0700
Message-ID: <alpine.OSX.2.21.1711021357350.14060@smahawar-mobl2.amr.corp.intel.com>
In-Reply-To: alpine.OSX.2.21.1710311143390.11962@bkdaas-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 147

--===============4021333298355598602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Oct 2017, Mat Martineau wrote:

>
> Hi Christoph,
>
> On Mon, 30 Oct 2017, Christoph Paasch wrote:
>
>> On 30/10/17 - 15:44:03, Mat Martineau wrote:
>>> =

>>> On Sun, 29 Oct 2017, Christoph Paasch wrote:
>>> =

>>>> How do you want to proceed for submitting it upstream? I fear that =

>>>> without a
>>>> user of skb_shared_info_ext, netdev won't accept it.
>>>> =

>>>> Shouldn't we try to find a user that would benefit from it?
>>> =

>>> I was expecting to wait for an MPTCP patch set that would make use of t=
he
>>> shared control block, but I agree it would be better to find an existing
>>> struct sk_buff user that would benefit. I'll look around for a protocol =

>>> with
>>> a crowded skb->cb - there could be some cases where there are painful w=
ork
>>> arounds for the size constraints.
>> =

>> Yes, having another user of it is definitely better. I looked a bit thro=
ugh
>> the code, but couldn't find a good use-case though.
>
> The requirements are fairly narrow to use the shared cb, which makes it h=
ard =

> to use outside MPTCP:
>
> * Only tx skbs (rx skbs allocated by a driver don't know when to add the =

> extra space)
>
> * Data in the shared cb is read-only (or safely shared)
>
> * Other users don't conflict with MPTCP
>
>
> The closest I've found so far is dccp_skb_cb... but:
>
> We could do something with __build_skb() instead, allocating our own data =

> with extra bytes at the end. I think a bit in tcp_skb_cb would still be =

> necessary so the header writing code could tell if the extended MPTCP cb =
is =

> present. The size of the extra data is more flexible this way, since it's=
 not =

> baked in to the common skb code. Zero changes to the global skb code is v=
ery =

> compelling and makes it easier to upstream. Thoughts?

To follow up to myself, while taking the __build_skb() approach does avoid =

changes to __alloc_skb() it still requires pskb_expand_head to know about =

and copy the area after skb_shared_memory.

--
Mat Martineau
Intel OTC

--===============4021333298355598602==--
