Content-Type: multipart/mixed; boundary="===============6317105611341301735=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size using
 'struct tcp_skb_cb_ext'
Date: Fri, 19 May 2017 15:29:05 -0700
Message-ID: <alpine.OSX.2.21.1705191425460.33772@mjmartin-mac01.sea.intel.com>
In-Reply-To: c5ab6a44-1895-394c-1c81-7870637b327e@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 41

--===============6317105611341301735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 18 May 2017, Rao Shoaib wrote:

>
>
> On 05/18/2017 05:08 PM, Mat Martineau wrote:
>> =

>> Rao,
>> =

>> If we take the approach we discussed yesterday (rx side defers MPTCP =

>> processing until skb reaches the MPTCP layer, tx side pre-populates the =
TCP =

>> option), is it necessary to alter the tcp control block as this patch do=
es?
> That idea came to me when I was working on coding this solution as I did =
not =

> like allocating a buffer on the Rx side. Since I was almost done I posted=
 it. =

> I will be working on the alternate solution.
>
>> =

>> I think with one bit in struct tcp_skb_cb, TCP could be told to interpre=
t =

>> the beginning of the buffer as a TCP option (the kind & length encoded i=
n =

>> the option would give enough context to finish writing the TCP header).
> Where will be the content of the option ?

At skb->data. An sk_buff waiting to be transmitted (or retransmitted) =

would look like this:

head ->  +------------+
          | (headroom) |
          |            |
          |            |
          |            |
data ->  +------------+
          | DSS Option |
          +------------+
          | Packet     |
          | payload    |
          |            |
          |            |
          |            |
          |            |
tail ->  +------------+
          | (tailroom) |
          |            |
          |            |
end  ->  +------------+

The DSS option has a length encoded in it, so TCP can determine the length =

of the option and account for the already-used option space. TCP then =

writes the rest of the header:

head ->  +------------+
          | (headroom) |
          |            |
data ->  +------------+
          | TCP Header | (including other options)
          | ...        |
          | DSS Option | (this option in-place from earlier)
          +------------+
          | Packet     |
          | payload    |
          |            |
          |            |
          |            |
          |            |
tail ->  +------------+
          | (tailroom) |
          |            |
          |            |
end  ->  +------------+


> How will retransmission work ?

TCP retransmission makes a copy of the skb, so that should work ok for =

(the cb is copied, so the tcp_skb_cb "data includes a TCP option" bit =

would be kept). MPTCP retransmission on different subflows would depend on =

how we keep a copy of the data around at the MPTCP layer - I'm thinking we =

could avoid sharing skbs across subflows, possibly using some zerocopy =

techniques when passing data from MPTCP to the TCP layer.

--
Mat Martineau
Intel OTC

--===============6317105611341301735==--
