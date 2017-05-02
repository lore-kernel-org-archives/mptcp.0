Content-Type: multipart/mixed; boundary="===============0283347320223269384=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Tue, 02 May 2017 13:50:06 -0700
Message-ID: <alpine.OSX.2.21.1705021147001.5117@jfkilman-mobl1.amr.corp.intel.com>
In-Reply-To: 24838fd9-b183-bd45-5ff3-ad5ebb1e2719@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 27

--===============0283347320223269384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Apr 2017, Rao Shoaib wrote:

>
>
> On 04/28/2017 03:52 PM, Mat Martineau wrote:
>> On Wed, 26 Apr 2017, Rao Shoaib wrote:
>> =

>>> Hi,
>>> =

>>> Here is an attempt to not use tcp_skb_cb with minimal change to MPTCP c=
ode =

>>> and skb code. I have tested the change by using wget from =

>>> multipath-tcp.org. pcap file is attached.
>>> =

>>> The approach that I have taken is very straight forward. On Tx when an =
skb =

>>> is allocated and the underlying socket is MPTCP , 32 bytes extra are =

>>> allocated[1] and reserved as the head room. This space is used for pass=
ing =

>>> what was being passed in tcp_skb_cb. An used bit in sk_buff is used to =

>>> indicate this special case and when skb is copied the extra data is als=
o =

>>> copied. clone is not an issue as the data is shared. This work for =

>>> retransmission also because tcp_transmit_skb clones the original skb.
>>> =

>>> On the Rx side, options are parsed in tcp at that point we can reuse th=
e =

>>> space that was used for ether and IP  headers and no extra space is =

>>> required.
>>> =

>>> The space used is always right below the skb head pointer because the =

>>> location of head never changes.
>>> =

>>> Please take a look and let me know what I have missed.
>> =

>> Hi Rao -
>> =

>> It's quite a bit easier to review patches on a mailing list when they're =

>> plain text (as opposed to attachments), so I'd like ask that we stick to =

>> the kernel patch guidelines: =

>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>> =

>> (I recognize that it's a long read - using 'git send-email' will get you =

>> most of the way there!)
> Sorry about that. I have never posted a patch before.
>> =

>> =

>> I'm wary of using the skb data to hide away an extra control block. The =

>> number of data bytes consumed isn't really accounted for (other than bei=
ng =

>> hard coded for the MPTCP use case), =

> I don't understand this concern. Why do they have to be accounted for and =

> what code needs that ? The total size allocated is still billed to the =

> socket. This is same as allocating maximum size  tcp header and not using=
 all =

> the space OR one can think of it as a new protocol header that gets added =

> because we are running ethernet over Infiniband.

If another layer of the networking stack checks skb_headroom() on an skb =

with a struct tucked away at skb->head, that layer will have no reason to =

avoid writing to the "free" header space.

It's different from a new protocol header in that real protocol headers =

use skb_push() and only maintain valid data between skb->data and =

skb->tail.

The maintainers aren't going to like breaking the rules about where valid =

data lives in the buffer space because it will impact the maintainability =

of the code. Unless someone is familiar with the quirks of MPTCP's buffer =

space usage, they could get tripped up when doing some kind of =

encapsulation/deencapsulation, for example.

>
>> and keeping track of the size of the extra control block would take some =

>> space in the skb, which is what we're trying to avoid. =

> The way I have coded it, it does not, and that is the whole point of taki=
ng =

> this approach because upstream folks do not want the size of 'struct sk_b=
uff' =

> increased.

We are in agreement here. I was pointing out that modifying your approach =

to have a variable size for MPTCP_SEG_INFO() (or a generic version of it) =

is also not workable because of the sk_buff size constraint.

> Perhaps I do not understand your concern about counting, can you give me =
an =

> example of the issue that you have in mind.

I think I got to this above - skb_headroom() reports bytes available, and =

a lower layer is free to overwrite the MPTCP_SEG_INFO bytes.

>> On the rx side, overwriting the network or mac headers doesn't seem righ=
t - =

>> what if the skb was cloned for monitoring purposes? =

> This is a valid concern -- let me think about it a little bit. Where woul=
d =

> the buffer be cloned ?

There are so many places it could be cloned it's easier to talk about =

where it can't. If the skb is newly created or provided by some piece of =

code that guarantees it hasn't been cloned, then you know it's not cloned. =

Otherwise it may or may not be a clone, but that's checkable with =

skb_cloned().

>> We'd have to force an skb_copy before modifying the buffer. It might be =

>> safer to use space after skb_end_pointer() =

> Yes that can be done (I think). I choose the head just to test things out.
>> - but that's where the skb_shared_info struct is, so maybe what we need =
is =

>> a way to optionally put something after skb_shared_info?
> This can not be done currently based on how the buffer is constructed.  I =

> would avoid doing that any ways as it would cause more concern for upstre=
am =

> folks as it is more disruptive since it changes the location of the end o=
f =

> the structure. In the current scheme no assumption is broken about where =

> everything lies and all pointers retain their current interpretation.

My (speculative) suggestion was to add some optional space at skb->end + =

sizeof(struct skb_shared_info), which changes the location of the end of =

the allocated space but doesn't change where any current structures end or =

the values of any existing pointers. The tradeoff is that the extra size =

information needs to get in to __alloc_skb() somehow.

>> =

>> I think we need to take a step back: what data does MPTCP really need to =

>> attach to an skb? If we have extra mptcp data with the tcp_sock for the =

>> subflow, is there a way to keep track of auxiliary data outside the skb? =

>> I'll think on this some more too.
> You can not use tcp_sock because the data is per sk_buff and not per flow=
. =

> Additionally same buffer could be transmitted on several flows. We could =

> implement some kind of lookup but that will kill the performance.

Yeah, "some kind of lookup" is what I was getting at, if it could be made =

fast enough.

> I am working on a generic solution but I am not optimistic that upstream =

> folks will accept it because it will require more changes to the existing =

> code.

If we're adding functionality that's seen as useful or an improvement over =

what's there now, I think it will get a fair shot so long as the normal =

structure size is the same or smaller (and the changes to existing code =

are not too risky, etc).

>
> If a better scheme is proposed that works I am all for it.

Yes, I definitely agree! We have a tough set of constraints to work =

within, but we haven't exhausted the possibilities. I'm still trying to =

come up with other alternatives to consider.

--
Mat Martineau
Intel OTC

--===============0283347320223269384==--
