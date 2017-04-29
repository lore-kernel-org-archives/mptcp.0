Content-Type: multipart/mixed; boundary="===============2626015413306851476=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Fri, 28 Apr 2017 21:03:25 -0700
Message-ID: <4b010288-b6ba-93c2-5729-55ac8bbc9c9a@oracle.com>
In-Reply-To: 24838fd9-b183-bd45-5ff3-ad5ebb1e2719@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 21

--===============2626015413306851476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/28/2017 08:23 PM, Rao Shoaib wrote:
>
>
> On 04/28/2017 03:52 PM, Mat Martineau wrote:
>> On Wed, 26 Apr 2017, Rao Shoaib wrote:
>>
>>> Hi,
>>>
>>> Here is an attempt to not use tcp_skb_cb with minimal change to =

>>> MPTCP code and skb code. I have tested the change by using wget from =

>>> multipath-tcp.org. pcap file is attached.
>>>
>>> The approach that I have taken is very straight forward. On Tx when =

>>> an skb is allocated and the underlying socket is MPTCP , 32 bytes =

>>> extra are allocated[1] and reserved as the head room. This space is =

>>> used for passing what was being passed in tcp_skb_cb. An used bit in =

>>> sk_buff is used to indicate this special case and when skb is copied =

>>> the extra data is also copied. clone is not an issue as the data is =

>>> shared. This work for retransmission also because tcp_transmit_skb =

>>> clones the original skb.
>>>
>>> On the Rx side, options are parsed in tcp at that point we can reuse =

>>> the space that was used for ether and IP  headers and no extra space =

>>> is required.
>>>
>>> The space used is always right below the skb head pointer because =

>>> the location of head never changes.
>>>
>>> Please take a look and let me know what I have missed.
>>
>> Hi Rao -
>>
>> It's quite a bit easier to review patches on a mailing list when =

>> they're plain text (as opposed to attachments), so I'd like ask that =

>> we stick to the kernel patch guidelines: =

>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>
>> (I recognize that it's a long read - using 'git send-email' will get =

>> you most of the way there!)
> Sorry about that. I have never posted a patch before.
>>
>>
>> I'm wary of using the skb data to hide away an extra control block. =

>> The number of data bytes consumed isn't really accounted for (other =

>> than being hard coded for the MPTCP use case), =

> I don't understand this concern. Why do they have to be accounted for =

> and what code needs that ? The total size allocated is still billed to =

> the socket. This is same as allocating maximum size  tcp header and =

> not using all the space OR one can think of it as a new protocol =

> header that gets added because we are running ethernet over Infiniband.
>
>> and keeping track of the size of the extra control block would take =

>> some space in the skb, which is what we're trying to avoid. =

> The way I have coded it, it does not, and that is the whole point of =

> taking this approach because upstream folks do not want the size of =

> 'struct sk_buff' increased.
>
> Perhaps I do not understand your concern about counting, can you give =

> me an example of the issue that you have in mind.
>
>> On the rx side, overwriting the network or mac headers doesn't seem =

>> right - what if the skb was cloned for monitoring purposes? =

> This is a valid concern -- let me think about it a little bit. Where =

> would the buffer be cloned ?
Oh I just realized, I sent out a pcap file while doing mostly Rx =

traffic. I did not see any corruption so I am not sure this is an issue. =

To be sure I would have to dig into the code as to what happens when the =

promiscuous mode is on.

Rao.


--===============2626015413306851476==--
