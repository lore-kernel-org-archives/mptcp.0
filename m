Content-Type: multipart/mixed; boundary="===============0903760350039214735=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] New Linux TCP feature: generic upper layer protocol
Date: Fri, 16 Jun 2017 17:12:14 -0700
Message-ID: <alpine.OSX.2.21.1706161610100.43467@tgates-mobl1.amr.corp.intel.com>
In-Reply-To: 20170616230449.GB82528@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 46

--===============0903760350039214735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 16 Jun 2017, Christoph Paasch wrote:

> Hello Mat,
>
> On 15/06/17 - 16:35:17, Mat Martineau wrote:
>>
>> Hello,
>>
>> A new piece of TCP extension infrastructure was just merged to net-next:
>> generic upper layer protocol (ULP) support for TCP.
>>
>> The relevant commit is https://git.kernel.org/pub/scm/linux/kernel/git/d=
avem/net-next.git/commit/?id=3D734942cc4ea6478eed125af258da1bdbb4afe578
>
> thanks for the pointer. That's really interesting.
>
>
> One thing I am wondering is, how this covers against races?
>
> Because, one might do the setsockopt() at the same time as calling sendms=
g().
>
> The following scenario could happen in my opinion:
>
> setsockopt is first, goes all the way until lock_sock() in do_tcp_setsock=
opt().
> Then, sendmsg() gets some CPU-cycles and goes until tcp_sendmsg() (thanks=
 to
> sk->sk_prot->sendmsg) and blocks on the lock_sock(). Now, back to the set=
sockopt,
> which will end up changing sk->sk_prot. setsockopt now finishes and relea=
ses
> the lock.
>
> Now we end up with the sendmsg inside tcp_sendmsg(), while it should be in
> the ULP's sendmsg. This looks extremely unsafe to me.

Yes, indeed. Glad you spotted that.

>
> I will check on netdev if there has been discussion about this.

I spent some time yesterday looking for any discussion of the ULP patch =

and the only thing I found in the archives was the original suggestion to =

create the generalized ULP feature:

http://www.mail-archive.com/netdev(a)vger.kernel.org/msg160375.html

--
Mat Martineau
Intel OTC

--===============0903760350039214735==--
