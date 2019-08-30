Content-Type: multipart/mixed; boundary="===============3318058922210862929=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Fri, 30 Aug 2019 15:37:12 +0200
Message-ID: <373429e5-bb3b-05c0-4a7a-1af38a98de7e@tessares.net>
In-Reply-To: 41b88dcf7d0234302d36ef958c3eb93ef110f208.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1770

--===============3318058922210862929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 29/08/2019 18:30, Paolo Abeni wrote:
> On Thu, 2019-08-22 at 14:14 -0700, Mat Martineau wrote:
>> On Thu, 22 Aug 2019, Paolo Abeni wrote:
>>
>>> On Fri, 2019-08-02 at 17:16 -0700, Mat Martineau wrote:
>>>> The MPTCP-level socket doesn't use sk_receive_queue, so it was possible
>>>> for mptcp_recvmsg() to remain blocked when there was data ready for it
>>>> to read. When the MPTCP socket is waiting for additional data and it
>>>> releases the subflow socket lock, the subflow may have incoming packets
>>>> ready to process and it sometimes called subflow_data_ready() before t=
he
>>>> MPTCP socket called sk_wait_data().
>>>>
>>>> This change adds a new function for the MPTCP socket to use when waiti=
ng
>>>> for a data ready signal. Atomic bitops with memory barriers are used to
>>>> set, test, and clear a MPTCP socket flag that indicates waiting subflow
>>>> data. This flag replaces the sk_receive_queue checks used by other
>>>> socket types.
>>>>
>>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>>
>>> (sorry for lagging behind so much)
>>>
>>> The patch LGTM, but I have some related questions: how do you reproduce
>>> the issue fixed here? can we add that to the self-tests? (I assume/sort
>>> of recall the patch fix the issue in your scenario).
>>>
>>
>> I was seeing the issue between the multipath-tcp.org kernel and ours, wi=
th =

>> a couple of simple test programs. The multipath-tcp.org system had a =

>> program running that would do a recvmsg() and then immediately send =

>> anything it received, and the prototype system would send data and then =

>> try to read it back. The prototype system could get stuck waiting for a =

>> blocked recvmsg() to return even though the peer had sent the data.
>>
>> It may have been timing-dependent, I'll see if I can make it happen in a =

>> self test.
> =

> Ok, I think that a self-test here is not strictly required. =

> =

> I think we can merge this patch as is.

Thank you for the patch and the review!

Just added at the end of the series.

https://github.com/multipath-tcp/mptcp_net-next/commits/export

I had a minor conflicts:


diff --cc net/mptcp/protocol.h
index 68877e952780,7a515d8e99d0..000000000000
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@@ -117,10 -101,10 +120,14 @@@ struct mptcp_sock
        u64             write_seq;
        u64             ack_seq;
        u32             token;
++<<<<<<< HEAD
 +      u16             dport;
++=3D=3D=3D=3D=3D=3D=3D
+       unsigned long   flags;
++>>>>>>> mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue
        struct list_head conn_list;
        struct socket   *subflow; /* outgoing
connect/listener/!mp_capable */
 -      struct pm_data  pm;
 +      struct mptcp_pm_data    pm;
        u8              addr_signal;
  };


Fixed with:


diff --cc net/mptcp/protocol.h
index 68877e952780,7a515d8e99d0..000000000000
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@@ -117,10 -101,10 +120,11 @@@ struct mptcp_sock
        u64             write_seq;
        u64             ack_seq;
        u32             token;
+       unsigned long   flags;
 +      u16             dport;
        struct list_head conn_list;
        struct socket   *subflow; /* outgoing
connect/listener/!mp_capable */

 -      struct pm_data  pm;
 +      struct mptcp_pm_data    pm;
        u8              addr_signal;
  };



Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3318058922210862929==--
