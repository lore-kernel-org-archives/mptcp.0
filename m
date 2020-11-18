Content-Type: multipart/mixed; boundary="===============8197872833965024707=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 6/6] mptcp: use mptcp backlog.
Date: Wed, 18 Nov 2020 12:11:22 -0800
Message-ID: <147c408b-7d0-f7b6-5c8f-1ba7c153222c@linux.intel.com>
In-Reply-To: 476acc885c0900d52f388c780218c78e67491840.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6793

--===============8197872833965024707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Nov 2020, Paolo Abeni wrote:

> On Wed, 2020-11-18 at 11:01 +0100, Paolo Abeni wrote:
>> On Tue, 2020-11-17 at 16:21 -0800, Mat Martineau wrote:
>>> Is there anything happening here in mptcp_do_backlog() that doesn't work
>>> in mptcp_release_cb()?
>>
>> Yes, we can't call mptcp_push_pending() in release_cb(),
>> because mptcp_push_pending() requires a non atomic context, while
>> release_cb is invoked under the msk socket spin lock.
>>
>> We can't use __mptcp_subflow_push_pending() - this latter can be
>> invoked under atomic context - because we don't have an ssk handy. We
>> could look-up a suitable ssk and invoke __mptcp_subflow_push_pending(),
>> but I think is preferrable leveraging mptcp_push_pending().
>
> Uhm... I was too optimistic about __mptcp_subflow_push_pending() usage:
> mptcp_release_cb() will need to acquire the ssk socket lock, but it
> can't because:
> - in atomic context
> - there will be a AB-BA deadlock (the rx path acquires ssk lock -> msk
> spinlock in order, release cb held the msk spinlock and will need to
> acquire the ssk lock)

Looking at release_sock(), it invokes __release_sock() under the msk =

socket spin lock right before release_cb(), so they're running in the same =

context.

__release_sock() unlocks/relocks the spin lock around the call to =

sk_backlog_rcv(). Seems like release_cb() could do the same to release the =

spin lock when calling mptcp_push_pending()?

>>> The zeroed-out bl_entry skb seems fragile. The current code in the
>>> backlog ends up handling it ok today, but that could easily change. Not
>>> that I'm trying to veto the idea, but it does need some more discussion=
 :)
>>
>> I think we can avoid the backlog usage with the above alternative.
>
> So the above is not feasible, and backlog usage looks required.
> Why do you think zeroed bl_entry would be fragile ?!? are you wondering
> about skb->data / skb_shinfo(skb) access? If so, do you think providing
> a valid data ptr would be the way to go? (looks a little overkill to
> me, we can add that later if required)

I assume that a skb pointer is pointing to memory that has been =

initialized by one of the alloc_skb functions (or copied/cloned/etc) - I =

figure others would assume the same?

The few skb functions called by __sk_add_backlog() and sk_backlog_rcv() =

happen to behave today with a zeroed-out skb, and problematic change to =

those functions would probably break our self tests if run with a suitable =

kernel config. But it would be preferable to avoid that (and the extra =

size in the msk struct) *if* we can.

--
Mat Martineau
Intel
--===============8197872833965024707==--
