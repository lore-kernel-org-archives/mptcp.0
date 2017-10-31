Content-Type: multipart/mixed; boundary="===============8736404598965760507=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Tue, 31 Oct 2017 14:58:01 -0700
Message-ID: <alpine.OSX.2.21.1710311143390.11962@bkdaas-mobl1.amr.corp.intel.com>
In-Reply-To: 20171031041711.GV29152@da0602a-dhcp227.apple.com
X-Status: 
X-Keywords:                  
X-UID: 146

--===============8736404598965760507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph,

On Mon, 30 Oct 2017, Christoph Paasch wrote:

> On 30/10/17 - 15:44:03, Mat Martineau wrote:
>>
>> On Sun, 29 Oct 2017, Christoph Paasch wrote:
>>
>>> How do you want to proceed for submitting it upstream? I fear that with=
out a
>>> user of skb_shared_info_ext, netdev won't accept it.
>>>
>>> Shouldn't we try to find a user that would benefit from it?
>>
>> I was expecting to wait for an MPTCP patch set that would make use of the
>> shared control block, but I agree it would be better to find an existing
>> struct sk_buff user that would benefit. I'll look around for a protocol =
with
>> a crowded skb->cb - there could be some cases where there are painful wo=
rk
>> arounds for the size constraints.
>
> Yes, having another user of it is definitely better. I looked a bit throu=
gh
> the code, but couldn't find a good use-case though.

The requirements are fairly narrow to use the shared cb, which makes it =

hard to use outside MPTCP:

* Only tx skbs (rx skbs allocated by a driver don't know when to add the ex=
tra =

space)

* Data in the shared cb is read-only (or safely shared)

* Other users don't conflict with MPTCP


The closest I've found so far is dccp_skb_cb... but:

We could do something with __build_skb() instead, allocating our own data =

with extra bytes at the end. I think a bit in tcp_skb_cb would still be =

necessary so the header writing code could tell if the extended MPTCP cb =

is present. The size of the extra data is more flexible this way, since =

it's not baked in to the common skb code. Zero changes to the global skb =

code is very compelling and makes it easier to upstream. Thoughts?

--
Mat Martineau
Intel OTC

--===============8736404598965760507==--
