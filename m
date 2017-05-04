Content-Type: multipart/mixed; boundary="===============1624521810124677673=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Thu, 04 May 2017 10:25:09 -0700
Message-ID: <42d4a34e-623b-3a6a-9c80-5fe357d9b0f9@oracle.com>
In-Reply-To: alpine.OSX.2.21.1705021147001.5117@jfkilman-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 29

--===============1624521810124677673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 05/02/2017 01:50 PM, Mat Martineau wrote:
> On Fri, 28 Apr 2017, Rao Shoaib wrote:
>
>>
>>
>> On 04/28/2017 03:52 PM, Mat Martineau wrote:
>>> On Wed, 26 Apr 2017, Rao Shoaib wrote:
>>>
>>>> Hi,
>>>>
>>>> Here is an attempt to not use tcp_skb_cb with minimal change to =

>>>> MPTCP code and skb code. I have tested the change by using wget =

>>>> from multipath-tcp.org. pcap file is attached.
>>>>
>>>> The approach that I have taken is very straight forward. On Tx when =

>>>> an skb is allocated and the underlying socket is MPTCP , 32 bytes =

>>>> extra are allocated[1] and reserved as the head room. This space is =

>>>> used for passing what was being passed in tcp_skb_cb. An used bit =

>>>> in sk_buff is used to indicate this special case and when skb is =

>>>> copied the extra data is also copied. clone is not an issue as the =

>>>> data is shared. This work for retransmission also because =

>>>> tcp_transmit_skb clones the original skb.
>>>>
>>>> On the Rx side, options are parsed in tcp at that point we can =

>>>> reuse the space that was used for ether and IP  headers and no =

>>>> extra space is required.
>>>>
>>>> The space used is always right below the skb head pointer because =

>>>> the location of head never changes.
>>>>
>>>> Please take a look and let me know what I have missed.
>>>
>>> Hi Rao -
>>>
>>> It's quite a bit easier to review patches on a mailing list when =

>>> they're plain text (as opposed to attachments), so I'd like ask that =

>>> we stick to the kernel patch guidelines: =

>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>>
>>> (I recognize that it's a long read - using 'git send-email' will get =

>>> you most of the way there!)
>> Sorry about that. I have never posted a patch before.
>>>
>>>
>>> I'm wary of using the skb data to hide away an extra control block. =

>>> The number of data bytes consumed isn't really accounted for (other =

>>> than being hard coded for the MPTCP use case), =

>> I don't understand this concern. Why do they have to be accounted for =

>> and what code needs that ? The total size allocated is still billed =

>> to the socket. This is same as allocating maximum size  tcp header =

>> and not using all the space OR one can think of it as a new protocol =

>> header that gets added because we are running ethernet over Infiniband.
>
> If another layer of the networking stack checks skb_headroom() on an =

> skb with a struct tucked away at skb->head, that layer will have no =

> reason to avoid writing to the "free" header space.
>
> It's different from a new protocol header in that real protocol =

> headers use skb_push() and only maintain valid data between skb->data =

> and skb->tail.
>
> The maintainers aren't going to like breaking the rules about where =

> valid data lives in the buffer space because it will impact the =

> maintainability of the code. Unless someone is familiar with the =

> quirks of MPTCP's buffer space usage, they could get tripped up when =

> doing some kind of encapsulation/deencapsulation, for example.
>
>>
>>> and keeping track of the size of the extra control block would take =

>>> some space in the skb, which is what we're trying to avoid. =

>> The way I have coded it, it does not, and that is the whole point of =

>> taking this approach because upstream folks do not want the size of =

>> 'struct sk_buff' increased.
>
> We are in agreement here. I was pointing out that modifying your =

> approach to have a variable size for MPTCP_SEG_INFO() (or a generic =

> version of it) is also not workable because of the sk_buff size =

> constraint.
>
>> Perhaps I do not understand your concern about counting, can you give =

>> me an example of the issue that you have in mind.
>
> I think I got to this above - skb_headroom() reports bytes available, =

> and a lower layer is free to overwrite the MPTCP_SEG_INFO bytes.
>
>>> On the rx side, overwriting the network or mac headers doesn't seem =

>>> right - what if the skb was cloned for monitoring purposes? =

>> This is a valid concern -- let me think about it a little bit. Where =

>> would the buffer be cloned ?
>
> There are so many places it could be cloned it's easier to talk about =

> where it can't. If the skb is newly created or provided by some piece =

> of code that guarantees it hasn't been cloned, then you know it's not =

> cloned. Otherwise it may or may not be a clone, but that's checkable =

> with skb_cloned().
>
>>> We'd have to force an skb_copy before modifying the buffer. It might =

>>> be safer to use space after skb_end_pointer() =

>> Yes that can be done (I think). I choose the head just to test things =

>> out.
>>> - but that's where the skb_shared_info struct is, so maybe what we =

>>> need is a way to optionally put something after skb_shared_info?
>> This can not be done currently based on how the buffer is =

>> constructed.  I would avoid doing that any ways as it would cause =

>> more concern for upstream folks as it is more disruptive since it =

>> changes the location of the end of the structure. In the current =

>> scheme no assumption is broken about where everything lies and all =

>> pointers retain their current interpretation.
>
> My (speculative) suggestion was to add some optional space at skb->end =

> + sizeof(struct skb_shared_info), which changes the location of the =

> end of the allocated space but doesn't change where any current =

> structures end or the values of any existing pointers. The tradeoff is =

> that the extra size information needs to get in to __alloc_skb() somehow.
>
>>>
>>> I think we need to take a step back: what data does MPTCP really =

>>> need to attach to an skb? If we have extra mptcp data with the =

>>> tcp_sock for the subflow, is there a way to keep track of auxiliary =

>>> data outside the skb? I'll think on this some more too.
>> You can not use tcp_sock because the data is per sk_buff and not per =

>> flow. Additionally same buffer could be transmitted on several flows. =

>> We could implement some kind of lookup but that will kill the =

>> performance.
>
> Yeah, "some kind of lookup" is what I was getting at, if it could be =

> made fast enough.
>
>> I am working on a generic solution but I am not optimistic that =

>> upstream folks will accept it because it will require more changes to =

>> the existing code.
>
> If we're adding functionality that's seen as useful or an improvement =

> over what's there now, I think it will get a fair shot so long as the =

> normal structure size is the same or smaller (and the changes to =

> existing code are not too risky, etc).
>
>>
>> If a better scheme is proposed that works I am all for it.
>
> Yes, I definitely agree! We have a tough set of constraints to work =

> within, but we haven't exhausted the possibilities. I'm still trying =

> to come up with other alternatives to consider.

Hi Mat,

You have raised concern about someone using the head room. I would like =

to understand how Linux SKB's work as I have a different understanding.

I assumed that all code in Linux follows the basic principle that header =

space is reserved when the skb is allocated. That is why there is

LL_MAX_HEADER -- /* Compute the worst-case header length according to =

the protocols used */

Plus the SKB usage rules are very clear about references.

/* We divide dataref into two halves.  The higher 16 bits hold references
  * to the payload part of skb->data.  The lower 16 bits hold references to
  * the entire skb->data.
  *
In this case the dataref (lower 16 bits) will be greater than one and a =

I expect a consumer to call skb_cow_head() to determine if the header =

can be changed or does it need to make a copy. __vlan_insert_tag() for =

example does just that. So what are the condition that allow a consumer =

to disregard these rules and just use the header space ?

As evident from the 2nd patch that I have sent out,  I am not committed =

to any fix. If the team does not agree, we have to keep trying. This is =

a good exercise for me to learn the nuances of Linux networking. I will =

be an expert on SKB's by the time we are done :-).

Rao

> -- =

> Mat Martineau
> Intel OTC


--===============1624521810124677673==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxwPjxicj4KICAgIDwv
cD4KICAgIDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMDUvMDIvMjAx
NyAwMTo1MCBQTSwgTWF0IE1hcnRpbmVhdQogICAgICB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAg
IDxibG9ja3F1b3RlCmNpdGU9Im1pZDphbHBpbmUuT1NYLjIuMjEuMTcwNTAyMTE0NzAwMS41MTE3
QGpma2lsbWFuLW1vYmwxLmFtci5jb3JwLmludGVsLmNvbSIKICAgICAgdHlwZT0iY2l0ZSI+T24g
RnJpLCAyOCBBcHIgMjAxNywgUmFvIFNob2FpYiB3cm90ZToKICAgICAgPGJyPgogICAgICA8YnI+
CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgIDxicj4KICAgICAgICA8YnI+
CiAgICAgICAgT24gMDQvMjgvMjAxNyAwMzo1MiBQTSwgTWF0IE1hcnRpbmVhdSB3cm90ZToKICAg
ICAgICA8YnI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+T24gV2VkLCAyNiBBcHIg
MjAxNywgUmFvIFNob2FpYiB3cm90ZToKICAgICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAg
ICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPkhpLAogICAgICAgICAgICA8YnI+CiAgICAg
ICAgICAgIDxicj4KICAgICAgICAgICAgSGVyZSBpcyBhbiBhdHRlbXB0IHRvIG5vdCB1c2UgdGNw
X3NrYl9jYiB3aXRoIG1pbmltYWwgY2hhbmdlCiAgICAgICAgICAgIHRvIE1QVENQIGNvZGUgYW5k
IHNrYiBjb2RlLiBJIGhhdmUgdGVzdGVkIHRoZSBjaGFuZ2UgYnkKICAgICAgICAgICAgdXNpbmcg
d2dldCBmcm9tIG11bHRpcGF0aC10Y3Aub3JnLiBwY2FwIGZpbGUgaXMgYXR0YWNoZWQuCiAgICAg
ICAgICAgIDxicj4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICBUaGUgYXBwcm9hY2ggdGhh
dCBJIGhhdmUgdGFrZW4gaXMgdmVyeSBzdHJhaWdodCBmb3J3YXJkLiBPbgogICAgICAgICAgICBU
eCB3aGVuIGFuIHNrYiBpcyBhbGxvY2F0ZWQgYW5kIHRoZSB1bmRlcmx5aW5nIHNvY2tldCBpcwog
ICAgICAgICAgICBNUFRDUCAsIDMyIGJ5dGVzIGV4dHJhIGFyZSBhbGxvY2F0ZWRbMV0gYW5kIHJl
c2VydmVkIGFzIHRoZQogICAgICAgICAgICBoZWFkIHJvb20uIFRoaXMgc3BhY2UgaXMgdXNlZCBm
b3IgcGFzc2luZyB3aGF0IHdhcyBiZWluZwogICAgICAgICAgICBwYXNzZWQgaW4gdGNwX3NrYl9j
Yi4gQW4gdXNlZCBiaXQgaW4gc2tfYnVmZiBpcyB1c2VkIHRvCiAgICAgICAgICAgIGluZGljYXRl
IHRoaXMgc3BlY2lhbCBjYXNlIGFuZCB3aGVuIHNrYiBpcyBjb3BpZWQgdGhlIGV4dHJhCiAgICAg
ICAgICAgIGRhdGEgaXMgYWxzbyBjb3BpZWQuIGNsb25lIGlzIG5vdCBhbiBpc3N1ZSBhcyB0aGUg
ZGF0YSBpcwogICAgICAgICAgICBzaGFyZWQuIFRoaXMgd29yayBmb3IgcmV0cmFuc21pc3Npb24g
YWxzbyBiZWNhdXNlCiAgICAgICAgICAgIHRjcF90cmFuc21pdF9za2IgY2xvbmVzIHRoZSBvcmln
aW5hbCBza2IuCiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICBP
biB0aGUgUnggc2lkZSwgb3B0aW9ucyBhcmUgcGFyc2VkIGluIHRjcCBhdCB0aGF0IHBvaW50IHdl
CiAgICAgICAgICAgIGNhbiByZXVzZSB0aGUgc3BhY2UgdGhhdCB3YXMgdXNlZCBmb3IgZXRoZXIg
YW5kIElQoCBoZWFkZXJzCiAgICAgICAgICAgIGFuZCBubyBleHRyYSBzcGFjZSBpcyByZXF1aXJl
ZC4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICA8YnI+CiAgICAgICAgICAgIFRoZSBzcGFj
ZSB1c2VkIGlzIGFsd2F5cyByaWdodCBiZWxvdyB0aGUgc2tiIGhlYWQgcG9pbnRlcgogICAgICAg
ICAgICBiZWNhdXNlIHRoZSBsb2NhdGlvbiBvZiBoZWFkIG5ldmVyIGNoYW5nZXMuCiAgICAgICAg
ICAgIDxicj4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICBQbGVhc2UgdGFrZSBhIGxvb2sg
YW5kIGxldCBtZSBrbm93IHdoYXQgSSBoYXZlIG1pc3NlZC4KICAgICAgICAgICAgPGJyPgogICAg
ICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgPGJyPgogICAgICAgICAgSGkgUmFvIC0KICAg
ICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAgICAgICAgIEl0J3MgcXVpdGUgYSBiaXQgZWFz
aWVyIHRvIHJldmlldyBwYXRjaGVzIG9uIGEgbWFpbGluZyBsaXN0CiAgICAgICAgICB3aGVuIHRo
ZXkncmUgcGxhaW4gdGV4dCAoYXMgb3Bwb3NlZCB0byBhdHRhY2htZW50cyksIHNvIEknZAogICAg
ICAgICAgbGlrZSBhc2sgdGhhdCB3ZSBzdGljayB0byB0aGUga2VybmVsIHBhdGNoIGd1aWRlbGlu
ZXM6CiAgICAgICAgICA8YSBjbGFzcz0ibW96LXR4dC1saW5rLWZyZWV0ZXh0IiBocmVmPSJodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0
Y2hlcy5odG1sIj5odHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNz
L3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sPC9hPgogICAgICAgICAgPGJyPgogICAgICAgICAgPGJy
PgogICAgICAgICAgKEkgcmVjb2duaXplIHRoYXQgaXQncyBhIGxvbmcgcmVhZCAtIHVzaW5nICdn
aXQgc2VuZC1lbWFpbCcKICAgICAgICAgIHdpbGwgZ2V0IHlvdSBtb3N0IG9mIHRoZSB3YXkgdGhl
cmUhKQogICAgICAgICAgPGJyPgogICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICBTb3JyeSBh
Ym91dCB0aGF0LiBJIGhhdmUgbmV2ZXIgcG9zdGVkIGEgcGF0Y2ggYmVmb3JlLgogICAgICAgIDxi
cj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgIDxicj4KICAgICAg
ICAgIDxicj4KICAgICAgICAgIEknbSB3YXJ5IG9mIHVzaW5nIHRoZSBza2IgZGF0YSB0byBoaWRl
IGF3YXkgYW4gZXh0cmEgY29udHJvbAogICAgICAgICAgYmxvY2suIFRoZSBudW1iZXIgb2YgZGF0
YSBieXRlcyBjb25zdW1lZCBpc24ndCByZWFsbHkKICAgICAgICAgIGFjY291bnRlZCBmb3IgKG90
aGVyIHRoYW4gYmVpbmcgaGFyZCBjb2RlZCBmb3IgdGhlIE1QVENQIHVzZQogICAgICAgICAgY2Fz
ZSksIDwvYmxvY2txdW90ZT4KICAgICAgICBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBjb25jZXJu
LiBXaHkgZG8gdGhleSBoYXZlIHRvIGJlCiAgICAgICAgYWNjb3VudGVkIGZvciBhbmQgd2hhdCBj
b2RlIG5lZWRzIHRoYXQgPyBUaGUgdG90YWwgc2l6ZQogICAgICAgIGFsbG9jYXRlZCBpcyBzdGls
bCBiaWxsZWQgdG8gdGhlIHNvY2tldC4gVGhpcyBpcyBzYW1lIGFzCiAgICAgICAgYWxsb2NhdGlu
ZyBtYXhpbXVtIHNpemWgIHRjcCBoZWFkZXIgYW5kIG5vdCB1c2luZyBhbGwgdGhlIHNwYWNlCiAg
ICAgICAgT1Igb25lIGNhbiB0aGluayBvZiBpdCBhcyBhIG5ldyBwcm90b2NvbCBoZWFkZXIgdGhh
dCBnZXRzIGFkZGVkCiAgICAgICAgYmVjYXVzZSB3ZSBhcmUgcnVubmluZyBldGhlcm5ldCBvdmVy
IEluZmluaWJhbmQuCiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxicj4K
ICAgICAgSWYgYW5vdGhlciBsYXllciBvZiB0aGUgbmV0d29ya2luZyBzdGFjayBjaGVja3Mgc2ti
X2hlYWRyb29tKCkgb24KICAgICAgYW4gc2tiIHdpdGggYSBzdHJ1Y3QgdHVja2VkIGF3YXkgYXQg
c2tiLSZndDtoZWFkLCB0aGF0IGxheWVyIHdpbGwKICAgICAgaGF2ZSBubyByZWFzb24gdG8gYXZv
aWQgd3JpdGluZyB0byB0aGUgImZyZWUiIGhlYWRlciBzcGFjZS4KICAgICAgPGJyPgogICAgICA8
YnI+CiAgICAgIEl0J3MgZGlmZmVyZW50IGZyb20gYSBuZXcgcHJvdG9jb2wgaGVhZGVyIGluIHRo
YXQgcmVhbCBwcm90b2NvbAogICAgICBoZWFkZXJzIHVzZSBza2JfcHVzaCgpIGFuZCBvbmx5IG1h
aW50YWluIHZhbGlkIGRhdGEgYmV0d2VlbgogICAgICBza2ItJmd0O2RhdGEgYW5kIHNrYi0mZ3Q7
dGFpbC4KICAgICAgPGJyPgogICAgICA8YnI+CiAgICAgIFRoZSBtYWludGFpbmVycyBhcmVuJ3Qg
Z29pbmcgdG8gbGlrZSBicmVha2luZyB0aGUgcnVsZXMgYWJvdXQKICAgICAgd2hlcmUgdmFsaWQg
ZGF0YSBsaXZlcyBpbiB0aGUgYnVmZmVyIHNwYWNlIGJlY2F1c2UgaXQgd2lsbCBpbXBhY3QKICAg
ICAgdGhlIG1haW50YWluYWJpbGl0eSBvZiB0aGUgY29kZS4gVW5sZXNzIHNvbWVvbmUgaXMgZmFt
aWxpYXIgd2l0aAogICAgICB0aGUgcXVpcmtzIG9mIE1QVENQJ3MgYnVmZmVyIHNwYWNlIHVzYWdl
LCB0aGV5IGNvdWxkIGdldCB0cmlwcGVkCiAgICAgIHVwIHdoZW4gZG9pbmcgc29tZSBraW5kIG9m
IGVuY2Fwc3VsYXRpb24vZGVlbmNhcHN1bGF0aW9uLCBmb3IKICAgICAgZXhhbXBsZS4KICAgICAg
PGJyPgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgIDxi
cj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj5hbmQga2VlcGluZyB0cmFjayBvZiB0
aGUgc2l6ZSBvZiB0aGUKICAgICAgICAgIGV4dHJhIGNvbnRyb2wgYmxvY2sgd291bGQgdGFrZSBz
b21lIHNwYWNlIGluIHRoZSBza2IsIHdoaWNoIGlzCiAgICAgICAgICB3aGF0IHdlJ3JlIHRyeWlu
ZyB0byBhdm9pZC4gPC9ibG9ja3F1b3RlPgogICAgICAgIFRoZSB3YXkgSSBoYXZlIGNvZGVkIGl0
LCBpdCBkb2VzIG5vdCwgYW5kIHRoYXQgaXMgdGhlIHdob2xlCiAgICAgICAgcG9pbnQgb2YgdGFr
aW5nIHRoaXMgYXBwcm9hY2ggYmVjYXVzZSB1cHN0cmVhbSBmb2xrcyBkbyBub3Qgd2FudAogICAg
ICAgIHRoZSBzaXplIG9mICdzdHJ1Y3Qgc2tfYnVmZicgaW5jcmVhc2VkLgogICAgICAgIDxicj4K
ICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIFdlIGFyZSBpbiBhZ3JlZW1lbnQg
aGVyZS4gSSB3YXMgcG9pbnRpbmcgb3V0IHRoYXQgbW9kaWZ5aW5nIHlvdXIKICAgICAgYXBwcm9h
Y2ggdG8gaGF2ZSBhIHZhcmlhYmxlIHNpemUgZm9yIE1QVENQX1NFR19JTkZPKCkgKG9yIGEKICAg
ICAgZ2VuZXJpYyB2ZXJzaW9uIG9mIGl0KSBpcyBhbHNvIG5vdCB3b3JrYWJsZSBiZWNhdXNlIG9m
IHRoZSBza19idWZmCiAgICAgIHNpemUgY29uc3RyYWludC4KICAgICAgPGJyPgogICAgICA8YnI+
CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPlBlcmhhcHMgSSBkbyBub3QgdW5kZXJzdGFu
ZCB5b3VyIGNvbmNlcm4KICAgICAgICBhYm91dCBjb3VudGluZywgY2FuIHlvdSBnaXZlIG1lIGFu
IGV4YW1wbGUgb2YgdGhlIGlzc3VlIHRoYXQgeW91CiAgICAgICAgaGF2ZSBpbiBtaW5kLgogICAg
ICAgIDxicj4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIEkgdGhpbmsgSSBn
b3QgdG8gdGhpcyBhYm92ZSAtIHNrYl9oZWFkcm9vbSgpIHJlcG9ydHMgYnl0ZXMKICAgICAgYXZh
aWxhYmxlLCBhbmQgYSBsb3dlciBsYXllciBpcyBmcmVlIHRvIG92ZXJ3cml0ZSB0aGUKICAgICAg
TVBUQ1BfU0VHX0lORk8gYnl0ZXMuCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICA8YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj5PbiB0aGUg
cnggc2lkZSwgb3ZlcndyaXRpbmcgdGhlIG5ldHdvcmsKICAgICAgICAgIG9yIG1hYyBoZWFkZXJz
IGRvZXNuJ3Qgc2VlbSByaWdodCAtIHdoYXQgaWYgdGhlIHNrYiB3YXMgY2xvbmVkCiAgICAgICAg
ICBmb3IgbW9uaXRvcmluZyBwdXJwb3Nlcz8gPC9ibG9ja3F1b3RlPgogICAgICAgIFRoaXMgaXMg
YSB2YWxpZCBjb25jZXJuIC0tIGxldCBtZSB0aGluayBhYm91dCBpdCBhIGxpdHRsZSBiaXQuCiAg
ICAgICAgV2hlcmUgd291bGQgdGhlIGJ1ZmZlciBiZSBjbG9uZWQgPwogICAgICAgIDxicj4KICAg
ICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIFRoZXJlIGFyZSBzbyBtYW55IHBsYWNl
cyBpdCBjb3VsZCBiZSBjbG9uZWQgaXQncyBlYXNpZXIgdG8gdGFsawogICAgICBhYm91dCB3aGVy
ZSBpdCBjYW4ndC4gSWYgdGhlIHNrYiBpcyBuZXdseSBjcmVhdGVkIG9yIHByb3ZpZGVkIGJ5CiAg
ICAgIHNvbWUgcGllY2Ugb2YgY29kZSB0aGF0IGd1YXJhbnRlZXMgaXQgaGFzbid0IGJlZW4gY2xv
bmVkLCB0aGVuIHlvdQogICAgICBrbm93IGl0J3Mgbm90IGNsb25lZC4gT3RoZXJ3aXNlIGl0IG1h
eSBvciBtYXkgbm90IGJlIGEgY2xvbmUsIGJ1dAogICAgICB0aGF0J3MgY2hlY2thYmxlIHdpdGgg
c2tiX2Nsb25lZCgpLgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+V2UnZCBoYXZlIHRvIGZv
cmNlIGFuIHNrYl9jb3B5IGJlZm9yZQogICAgICAgICAgbW9kaWZ5aW5nIHRoZSBidWZmZXIuIEl0
IG1pZ2h0IGJlIHNhZmVyIHRvIHVzZSBzcGFjZSBhZnRlcgogICAgICAgICAgc2tiX2VuZF9wb2lu
dGVyKCkgPC9ibG9ja3F1b3RlPgogICAgICAgIFllcyB0aGF0IGNhbiBiZSBkb25lIChJIHRoaW5r
KS4gSSBjaG9vc2UgdGhlIGhlYWQganVzdCB0byB0ZXN0CiAgICAgICAgdGhpbmdzIG91dC4KICAg
ICAgICA8YnI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+LSBidXQgdGhhdCdzIHdo
ZXJlIHRoZSBza2Jfc2hhcmVkX2luZm8KICAgICAgICAgIHN0cnVjdCBpcywgc28gbWF5YmUgd2hh
dCB3ZSBuZWVkIGlzIGEgd2F5IHRvIG9wdGlvbmFsbHkgcHV0CiAgICAgICAgICBzb21ldGhpbmcg
YWZ0ZXIgc2tiX3NoYXJlZF9pbmZvPwogICAgICAgICAgPGJyPgogICAgICAgIDwvYmxvY2txdW90
ZT4KICAgICAgICBUaGlzIGNhbiBub3QgYmUgZG9uZSBjdXJyZW50bHkgYmFzZWQgb24gaG93IHRo
ZSBidWZmZXIgaXMKICAgICAgICBjb25zdHJ1Y3RlZC6gIEkgd291bGQgYXZvaWQgZG9pbmcgdGhh
dCBhbnkgd2F5cyBhcyBpdCB3b3VsZAogICAgICAgIGNhdXNlIG1vcmUgY29uY2VybiBmb3IgdXBz
dHJlYW0gZm9sa3MgYXMgaXQgaXMgbW9yZSBkaXNydXB0aXZlCiAgICAgICAgc2luY2UgaXQgY2hh
bmdlcyB0aGUgbG9jYXRpb24gb2YgdGhlIGVuZCBvZiB0aGUgc3RydWN0dXJlLiBJbgogICAgICAg
IHRoZSBjdXJyZW50IHNjaGVtZSBubyBhc3N1bXB0aW9uIGlzIGJyb2tlbiBhYm91dCB3aGVyZQog
ICAgICAgIGV2ZXJ5dGhpbmcgbGllcyBhbmQgYWxsIHBvaW50ZXJzIHJldGFpbiB0aGVpciBjdXJy
ZW50CiAgICAgICAgaW50ZXJwcmV0YXRpb24uCiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVv
dGU+CiAgICAgIDxicj4KICAgICAgTXkgKHNwZWN1bGF0aXZlKSBzdWdnZXN0aW9uIHdhcyB0byBh
ZGQgc29tZSBvcHRpb25hbCBzcGFjZSBhdAogICAgICBza2ItJmd0O2VuZCArIHNpemVvZihzdHJ1
Y3Qgc2tiX3NoYXJlZF9pbmZvKSwgd2hpY2ggY2hhbmdlcyB0aGUKICAgICAgbG9jYXRpb24gb2Yg
dGhlIGVuZCBvZiB0aGUgYWxsb2NhdGVkIHNwYWNlIGJ1dCBkb2Vzbid0IGNoYW5nZQogICAgICB3
aGVyZSBhbnkgY3VycmVudCBzdHJ1Y3R1cmVzIGVuZCBvciB0aGUgdmFsdWVzIG9mIGFueSBleGlz
dGluZwogICAgICBwb2ludGVycy4gVGhlIHRyYWRlb2ZmIGlzIHRoYXQgdGhlIGV4dHJhIHNpemUg
aW5mb3JtYXRpb24gbmVlZHMgdG8KICAgICAgZ2V0IGluIHRvIF9fYWxsb2Nfc2tiKCkgc29tZWhv
dy4KICAgICAgPGJyPgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgog
ICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgPGJyPgogICAgICAgICAg
SSB0aGluayB3ZSBuZWVkIHRvIHRha2UgYSBzdGVwIGJhY2s6IHdoYXQgZGF0YSBkb2VzIE1QVENQ
CiAgICAgICAgICByZWFsbHkgbmVlZCB0byBhdHRhY2ggdG8gYW4gc2tiPyBJZiB3ZSBoYXZlIGV4
dHJhIG1wdGNwIGRhdGEKICAgICAgICAgIHdpdGggdGhlIHRjcF9zb2NrIGZvciB0aGUgc3ViZmxv
dywgaXMgdGhlcmUgYSB3YXkgdG8ga2VlcAogICAgICAgICAgdHJhY2sgb2YgYXV4aWxpYXJ5IGRh
dGEgb3V0c2lkZSB0aGUgc2tiPyBJJ2xsIHRoaW5rIG9uIHRoaXMKICAgICAgICAgIHNvbWUgbW9y
ZSB0b28uCiAgICAgICAgICA8YnI+CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIFlvdSBj
YW4gbm90IHVzZSB0Y3Bfc29jayBiZWNhdXNlIHRoZSBkYXRhIGlzIHBlciBza19idWZmIGFuZCBu
b3QKICAgICAgICBwZXIgZmxvdy4gQWRkaXRpb25hbGx5IHNhbWUgYnVmZmVyIGNvdWxkIGJlIHRy
YW5zbWl0dGVkIG9uCiAgICAgICAgc2V2ZXJhbCBmbG93cy4gV2UgY291bGQgaW1wbGVtZW50IHNv
bWUga2luZCBvZiBsb29rdXAgYnV0IHRoYXQKICAgICAgICB3aWxsIGtpbGwgdGhlIHBlcmZvcm1h
bmNlLgogICAgICAgIDxicj4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIFll
YWgsICJzb21lIGtpbmQgb2YgbG9va3VwIiBpcyB3aGF0IEkgd2FzIGdldHRpbmcgYXQsIGlmIGl0
IGNvdWxkCiAgICAgIGJlIG1hZGUgZmFzdCBlbm91Z2guCiAgICAgIDxicj4KICAgICAgPGJyPgog
ICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj5JIGFtIHdvcmtpbmcgb24gYSBnZW5lcmljIHNv
bHV0aW9uIGJ1dCBJCiAgICAgICAgYW0gbm90IG9wdGltaXN0aWMgdGhhdCB1cHN0cmVhbSBmb2xr
cyB3aWxsIGFjY2VwdCBpdCBiZWNhdXNlIGl0CiAgICAgICAgd2lsbCByZXF1aXJlIG1vcmUgY2hh
bmdlcyB0byB0aGUgZXhpc3RpbmcgY29kZS4KICAgICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90
ZT4KICAgICAgPGJyPgogICAgICBJZiB3ZSdyZSBhZGRpbmcgZnVuY3Rpb25hbGl0eSB0aGF0J3Mg
c2VlbiBhcyB1c2VmdWwgb3IgYW4KICAgICAgaW1wcm92ZW1lbnQgb3ZlciB3aGF0J3MgdGhlcmUg
bm93LCBJIHRoaW5rIGl0IHdpbGwgZ2V0IGEgZmFpciBzaG90CiAgICAgIHNvIGxvbmcgYXMgdGhl
IG5vcm1hbCBzdHJ1Y3R1cmUgc2l6ZSBpcyB0aGUgc2FtZSBvciBzbWFsbGVyIChhbmQKICAgICAg
dGhlIGNoYW5nZXMgdG8gZXhpc3RpbmcgY29kZSBhcmUgbm90IHRvbyByaXNreSwgZXRjKS4KICAg
ICAgPGJyPgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAg
IDxicj4KICAgICAgICBJZiBhIGJldHRlciBzY2hlbWUgaXMgcHJvcG9zZWQgdGhhdCB3b3JrcyBJ
IGFtIGFsbCBmb3IgaXQuCiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxi
cj4KICAgICAgWWVzLCBJIGRlZmluaXRlbHkgYWdyZWUhIFdlIGhhdmUgYSB0b3VnaCBzZXQgb2Yg
Y29uc3RyYWludHMgdG8KICAgICAgd29yayB3aXRoaW4sIGJ1dCB3ZSBoYXZlbid0IGV4aGF1c3Rl
ZCB0aGUgcG9zc2liaWxpdGllcy4gSSdtIHN0aWxsCiAgICAgIHRyeWluZyB0byBjb21lIHVwIHdp
dGggb3RoZXIgYWx0ZXJuYXRpdmVzIHRvIGNvbnNpZGVyLgogICAgICA8YnI+CiAgICA8L2Jsb2Nr
cXVvdGU+CiAgICA8YnI+CiAgICBIaSBNYXQsPGJyPgogICAgPGJyPgogICAgWW91IGhhdmUgcmFp
c2VkIGNvbmNlcm4gYWJvdXQgc29tZW9uZSB1c2luZyB0aGUgaGVhZCByb29tLiBJIHdvdWxkCiAg
ICBsaWtlIHRvIHVuZGVyc3RhbmQgaG93IExpbnV4IFNLQidzIHdvcmsgYXMgSSBoYXZlIGEgZGlm
ZmVyZW50CiAgICB1bmRlcnN0YW5kaW5nLjxicj4KICAgIDxicj4KICAgIEkgYXNzdW1lZCB0aGF0
IGFsbCBjb2RlIGluIExpbnV4IGZvbGxvd3MgdGhlIGJhc2ljIHByaW5jaXBsZSB0aGF0CiAgICBo
ZWFkZXIgc3BhY2UgaXMgcmVzZXJ2ZWQgd2hlbiB0aGUgc2tiIGlzIGFsbG9jYXRlZC4gVGhhdCBp
cyB3aHkKICAgIHRoZXJlIGlzPGJyPgogICAgPGJyPgogICAgTExfTUFYX0hFQURFUiAtLSAvKiBD
b21wdXRlIHRoZSB3b3JzdC1jYXNlIGhlYWRlciBsZW5ndGggYWNjb3JkaW5nCiAgICB0byB0aGUg
cHJvdG9jb2xzIHVzZWQgKi88YnI+CiAgICA8YnI+CiAgICBQbHVzIHRoZSBTS0IgdXNhZ2UgcnVs
ZXMgYXJlIHZlcnkgY2xlYXIgYWJvdXQgcmVmZXJlbmNlcy4gPGJyPgogICAgPGJyPgogICAgLyog
V2UgZGl2aWRlIGRhdGFyZWYgaW50byB0d28gaGFsdmVzLqAgVGhlIGhpZ2hlciAxNiBiaXRzIGhv
bGQKICAgIHJlZmVyZW5jZXM8YnIgaWQ9Inl1aV8zXzE2XzBfeW0xOV8xXzE0OTM5MDg3MjIwNzRf
Mzk5NzAiPgogICAgoCogdG8gdGhlIHBheWxvYWQgcGFydCBvZiBza2ItJmd0O2RhdGEuoCBUaGUg
bG93ZXIgMTYgYml0cyBob2xkCiAgICByZWZlcmVuY2VzIHRvPGJyIGlkPSJ5dWlfM18xNl8wX3lt
MTlfMV8xNDkzOTA4NzIyMDc0XzM5OTcxIj4KICAgIKAqIHRoZSBlbnRpcmUgc2tiLSZndDtkYXRh
LiA8YnI+CiAgICCgKjxicj4KICAgIEluIHRoaXMgY2FzZSB0aGUgZGF0YXJlZiAobG93ZXIgMTYg
Yml0cykgd2lsbCBiZSBncmVhdGVyIHRoYW4gb25lCiAgICBhbmQgYSBJIGV4cGVjdCBhIGNvbnN1
bWVyIHRvIGNhbGwgc2tiX2Nvd19oZWFkKCkgdG8gZGV0ZXJtaW5lIGlmIHRoZQogICAgaGVhZGVy
IGNhbiBiZSBjaGFuZ2VkIG9yIGRvZXMgaXQgbmVlZCB0byBtYWtlIGEgY29weS4KICAgIF9fdmxh
bl9pbnNlcnRfdGFnKCkgZm9yIGV4YW1wbGUgZG9lcyBqdXN0IHRoYXQuIFNvIHdoYXQgYXJlIHRo
ZQogICAgY29uZGl0aW9uIHRoYXQgYWxsb3cgYSBjb25zdW1lciB0byBkaXNyZWdhcmQgdGhlc2Ug
cnVsZXMgYW5kIGp1c3QKICAgIHVzZSB0aGUgaGVhZGVyIHNwYWNlID88YnI+CiAgICA8YnI+CiAg
ICA8ZGl2IGRpcj0ibHRyIiBpZD0ieXVpXzNfMTZfMF95bTE5XzFfMTQ5Mzg0ODg0MzIwNl8xMDI1
MiI+QXMgZXZpZGVudAogICAgICBmcm9tIHRoZSAybmQgcGF0Y2ggdGhhdCBJIGhhdmUgc2VudCBv
dXQsoCBJIGFtIG5vdCBjb21taXR0ZWQgdG8KICAgICAgYW55IGZpeC4gSWYgdGhlIHRlYW0gZG9l
cyBub3QgYWdyZWUsIHdlIGhhdmUgdG8ga2VlcCB0cnlpbmcuIFRoaXMKICAgICAgaXMgYSBnb29k
IGV4ZXJjaXNlIGZvciBtZSB0byBsZWFybiB0aGUgbnVhbmNlcyBvZiBMaW51eAogICAgICBuZXR3
b3JraW5nLiBJIHdpbGwgYmUgYW4gZXhwZXJ0IG9uIFNLQidzIGJ5IHRoZSB0aW1lIHdlIGFyZSBk
b25lCiAgICAgIDotKS48YnI+CiAgICAgIDxiciBpZD0ieXVpXzNfMTZfMF95bTE5XzFfMTQ5Mzg0
ODg0MzIwNl8xMDI0MSI+CiAgICA8L2Rpdj4KICAgIFJhbzxicj4KICAgIKCgoCA8YnI+CiAgICA8
YmxvY2txdW90ZQpjaXRlPSJtaWQ6YWxwaW5lLk9TWC4yLjIxLjE3MDUwMjExNDcwMDEuNTExN0Bq
ZmtpbG1hbi1tb2JsMS5hbXIuY29ycC5pbnRlbC5jb20iCiAgICAgIHR5cGU9ImNpdGUiPi0tCiAg
ICAgIDxicj4KICAgICAgTWF0IE1hcnRpbmVhdQogICAgICA8YnI+CiAgICAgIEludGVsIE9UQwog
ICAgICA8YnI+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============1624521810124677673==--
