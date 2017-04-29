Content-Type: multipart/mixed; boundary="===============6324166189995637099=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Sat, 29 Apr 2017 01:29:13 -0700
Message-ID: <4d7f1dff-3bcf-2fa4-4e20-74e3b9dd2fe2@oracle.com>
In-Reply-To: 20170429073658.GN82766@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 24

--===============6324166189995637099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/29/2017 12:36 AM, Christoph Paasch wrote:
> Hello,
>
> On 28/04/17 - 15:52:53, Mat Martineau wrote:
>> On Wed, 26 Apr 2017, Rao Shoaib wrote:
>>
>>> Hi,
>>>
>>> Here is an attempt to not use tcp_skb_cb with minimal change to MPTCP
>>> code and skb code. I have tested the change by using wget from
>>> multipath-tcp.org. pcap file is attached.
>>>
>>> The approach that I have taken is very straight forward. On Tx when an
>>> skb is allocated and the underlying socket is MPTCP , 32 bytes extra are
>>> allocated[1] and reserved as the head room. This space is used for
>>> passing what was being passed in tcp_skb_cb. An used bit in sk_buff is
>>> used to indicate this special case and when skb is copied the extra data
>>> is also copied. clone is not an issue as the data is shared. This work
>>> for retransmission also because tcp_transmit_skb clones the original
>>> skb.
>>>
>>> On the Rx side, options are parsed in tcp at that point we can reuse the
>>> space that was used for ether and IP  headers and no extra space is
>>> required.
>>>
>>> The space used is always right below the skb head pointer because the
>>> location of head never changes.
>>>
>>> Please take a look and let me know what I have missed.
>> Hi Rao -
>>
>> It's quite a bit easier to review patches on a mailing list when they're
>> plain text (as opposed to attachments), so I'd like ask that we stick to=
 the
>> kernel patch guidelines:
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>
>> (I recognize that it's a long read - using 'git send-email' will get you
>> most of the way there!)
>>
>>
>> I'm wary of using the skb data to hide away an extra control block. The
>> number of data bytes consumed isn't really accounted for (other than bei=
ng
>> hard coded for the MPTCP use case), and keeping track of the size of the
>> extra control block would take some space in the skb, which is what we're
>> trying to avoid. On the rx side, overwriting the network or mac headers
>> doesn't seem right - what if the skb was cloned for monitoring purposes?
>> We'd have to force an skb_copy before modifying the buffer. It might be
>> safer to use space after skb_end_pointer() - but that's where the
>> skb_shared_info struct is, so maybe what we need is a way to optionally =
put
>> something after skb_shared_info?
>>
>> I think we need to take a step back: what data does MPTCP really need to
>> attach to an skb? If we have extra mptcp data with the tcp_sock for the
>> subflow, is there a way to keep track of auxiliary data outside the skb?
>> I'll think on this some more too.
> What we really need is basically the DSS-mapping. Because, every byte that
> has been scheduled on a subflow is linked to a DSS-mapping that is built =
of
> the 32-bit subflow-sequence-number, the data-length (16 bits) and the
> data-sequence number (32 or 64 bits). That's all we really need.
>
> I still think that tcp_skb_cb is the best place to store it. And currentl=
y,
> we would be fine wrt to not increasing the skb, if we get rid of dss_off
> (which should be easily doable).
> Then we are only adding 1 byte to tcp_skb_cb (mptcp_flags), and it fits n=
icely
> into the existing hole.
> The reason why I think it is the best place to store it is because
> tcp_skb_cb has a meaning only inside the TCP-stack. It's a scratch-buffer
> that on the other layers can be used for other stuff.
Please take a look at the latest tcp_skb_cb. As I mentioned before, the =

space has been completely used up. If you can re-arrange something and =

recover 24 bytes than that is the path we should take.

> Another solution would be to have some kind of a hashmap for each subflow,
> where we can map each byte of the subflow's send-queue to its correspondi=
ng
> DSS-mapping. I don't think that's a path we should go down. It seems quite
> complex to do.
I don't want to go down this path either because it will have =

performance implications.
>
>
> On the RX-side, I would not worry too much. When we need the data
> sequence-number we can always just look it up again in the TCP-header. Wh=
ich
> is actually what we are doing right now (almost - we still use dss_off to
> quickly find it, but that can be changed easily).
That is what I thought we can do also. I was wondering if we could just =

not process MPTCP options till the packet is received by MPTCP. However =

that would mean parsing the options twice. Since I found space I used =

it. Another option would be to allocate the structure and overload a =

pointer, but as I pointed out in my latest email, we have space so why =

complicate life.


Rao.
>
>
> Christoph
>
>
>> --
>> Mat Martineau
>> Intel OTC
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp


--===============6324166189995637099==--
