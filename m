Content-Type: multipart/mixed; boundary="===============5547446591382429560=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size using
 'struct tcp_skb_cb_ext'
Date: Tue, 23 May 2017 11:32:16 -0700
Message-ID: <c663a358-7ffd-54c2-3f5a-fcd71cd22c6c@oracle.com>
In-Reply-To: alpine.OSX.2.21.1705191425460.33772@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 42

--===============5547446591382429560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 05/19/2017 03:29 PM, Mat Martineau wrote:
>
> On Thu, 18 May 2017, Rao Shoaib wrote:
>
>>
>>
>> On 05/18/2017 05:08 PM, Mat Martineau wrote:
>>>
>>> Rao,
>>>
>>> If we take the approach we discussed yesterday (rx side defers MPTCP =

>>> processing until skb reaches the MPTCP layer, tx side pre-populates =

>>> the TCP option), is it necessary to alter the tcp control block as =

>>> this patch does?
>> That idea came to me when I was working on coding this solution as I =

>> did not like allocating a buffer on the Rx side. Since I was almost =

>> done I posted it. I will be working on the alternate solution.
>>
>>>
>>> I think with one bit in struct tcp_skb_cb, TCP could be told to =

>>> interpret the beginning of the buffer as a TCP option (the kind & =

>>> length encoded in the option would give enough context to finish =

>>> writing the TCP header).
>> Where will be the content of the option ?
>
> At skb->data. An sk_buff waiting to be transmitted (or retransmitted) =

> would look like this:
>
> head ->  +------------+
>          | (headroom) |
>          |            |
>          |            |
>          |            |
> data ->  +------------+
>          | DSS Option |
>          +------------+
>          | Packet     |
>          | payload    |
>          |            |
>          |            |
>          |            |
>          |            |
> tail ->  +------------+
>          | (tailroom) |
>          |            |
>          |            |
> end  ->  +------------+
>
> The DSS option has a length encoded in it, so TCP can determine the =

> length of the option and account for the already-used option space. =

> TCP then writes the rest of the header:
>
> head ->  +------------+
>          | (headroom) |
>          |            |
> data ->  +------------+
>          | TCP Header | (including other options)
>          | ...        |
>          | DSS Option | (this option in-place from earlier)
>          +------------+
>          | Packet     |
>          | payload    |
>          |            |
>          |            |
>          |            |
>          |            |
> tail ->  +------------+
>          | (tailroom) |
>          |            |
>          |            |
> end  ->  +------------+
>
>
>> How will retransmission work ?
>
> TCP retransmission makes a copy of the skb, so that should work ok for =

> (the cb is copied, so the tcp_skb_cb "data includes a TCP option" bit =

> would be kept). MPTCP retransmission on different subflows would =

> depend on how we keep a copy of the data around at the MPTCP layer - =

> I'm thinking we could avoid sharing skbs across subflows, possibly =

> using some zerocopy techniques when passing data from MPTCP to the TCP =

> layer.
>
> -- =

> Mat Martineau
> Intel OTC
Hi Mat,

Got it. This is what we discussed earlier.

Thanks,

Rao.

--===============5547446591382429560==--
