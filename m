Content-Type: multipart/mixed; boundary="===============4890971582116424561=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Sat, 29 Apr 2017 01:59:22 -0700
Message-ID: <fd443839-269a-e3fd-c65b-3de12f99e5cf@oracle.com>
In-Reply-To: 20170429083953.GO82766@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 26

--===============4890971582116424561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/29/2017 01:39 AM, Christoph Paasch wrote:
>
>> Please take a look at the latest tcp_skb_cb. As I mentioned before, the
>> space has been completely used up. If you can re-arrange something and
>> recover 24 bytes than that is the path we should take.
> Oh, my bad. I was on mptcp_trunk. Sorry about that.
>
> Back to the drawing board :)
>
>
> Christoph
>
:-)
A quick look suggests that all that is needed is the data sequence. The =

rest can be calculated. However we will have to recalculating every time =

the packet is retransmitted. Right now we do not even have space to =

store/pass the data sequence.

Rao

--===============4890971582116424561==--
