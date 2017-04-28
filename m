Content-Type: multipart/mixed; boundary="===============4908290488720258147=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Fri, 28 Apr 2017 15:52:53 -0700
Message-ID: <alpine.OSX.2.21.1704281335460.85462@mjmartin-mac01.local>
In-Reply-To: 0591abe1-066b-2a2c-59ba-4956a183348c@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 18

--===============4908290488720258147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Apr 2017, Rao Shoaib wrote:

> Hi,
>
> Here is an attempt to not use tcp_skb_cb with minimal change to MPTCP cod=
e =

> and skb code. I have tested the change by using wget from multipath-tcp.o=
rg. =

> pcap file is attached.
>
> The approach that I have taken is very straight forward. On Tx when an sk=
b is =

> allocated and the underlying socket is MPTCP , 32 bytes extra are =

> allocated[1] and reserved as the head room. This space is used for passin=
g =

> what was being passed in tcp_skb_cb. An used bit in sk_buff is used to =

> indicate this special case and when skb is copied the extra data is also =

> copied. clone is not an issue as the data is shared. This work for =

> retransmission also because tcp_transmit_skb clones the original skb.
>
> On the Rx side, options are parsed in tcp at that point we can reuse the =

> space that was used for ether and IP  headers and no extra space is requi=
red.
>
> The space used is always right below the skb head pointer because the =

> location of head never changes.
>
> Please take a look and let me know what I have missed.

Hi Rao -

It's quite a bit easier to review patches on a mailing list when they're =

plain text (as opposed to attachments), so I'd like ask that we stick to =

the kernel patch guidelines: =

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

(I recognize that it's a long read - using 'git send-email' will get you =

most of the way there!)


I'm wary of using the skb data to hide away an extra control block. The =

number of data bytes consumed isn't really accounted for (other than being =

hard coded for the MPTCP use case), and keeping track of the size of the =

extra control block would take some space in the skb, which is what we're =

trying to avoid. On the rx side, overwriting the network or mac headers =

doesn't seem right - what if the skb was cloned for monitoring purposes? =

We'd have to force an skb_copy before modifying the buffer. It might be =

safer to use space after skb_end_pointer() - but that's where the =

skb_shared_info struct is, so maybe what we need is a way to optionally =

put something after skb_shared_info?

I think we need to take a step back: what data does MPTCP really need to =

attach to an skb? If we have extra mptcp data with the tcp_sock for the =

subflow, is there a way to keep track of auxiliary data outside the skb? =

I'll think on this some more too.

--
Mat Martineau
Intel OTC

--===============4908290488720258147==--
