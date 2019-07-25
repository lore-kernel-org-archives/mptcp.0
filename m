Content-Type: multipart/mixed; boundary="===============2323181538976681563=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Wed, 24 Jul 2019 17:47:32 -0700
Message-ID: <alpine.OSX.2.21.1907241635190.19997@wjohns3x-mobl.amr.corp.intel.com>
In-Reply-To: 0d1770b4273b833cb2c305439bf3fca3b5af17b2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1553

--===============2323181538976681563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 17 Jul 2019, Paolo Abeni wrote:

> Hi,
>
> On Mon, 2019-07-08 at 16:54 -0700, Mat Martineau wrote:
>> Can we get anywhere by using bh_lock_sock() to protect the flag? Might be
>> worthwhile to do a slow-but-correct fix and then figure out something mo=
re
>> efficient.
>
> I'm sorry for lagging behind this. I think it should work. Also the
> sk_stream_write_space()/sk_stream_wait_memory() functions are possibly
> a good reference code (even if it acquires/relies on the full socket
> lock).

Ok, I'm trying that out.

>
> Another (crazy???) alternative I'm wondering about is changing a bit
> the overall locking schema using an intermediate work/timer/whatever
> between subflow->data_ready() and the msk recvmsg(). This new function
> can and will acquire the msk and subflow locks in the correct order
> (msk lock -> subflow lock) and really enqueue the skb into msk receive
> queue, so that finally we could use the plain sk_data_ready() function
> to wake-up the reader.
>
> I *think* the above implementation, even if more convoluted than the
> present one and possibly with some latency problem, could help dealing
> in the future with multiple subflows.
>
> WDYT?
>

It's not only a matter of enqueuing an skb in the msk receive queue, it =

would be necessary to enqueue the right data bytes for an entire mapped =

segment as defined by the DSS. However, it may work to use an intermediate =

step just to signal the wakeup - I need to think about that some more.

--
Mat Martineau
Intel

--===============2323181538976681563==--
