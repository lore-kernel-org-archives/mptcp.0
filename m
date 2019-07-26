Content-Type: multipart/mixed; boundary="===============2867350402827289578=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] roadmap proposal/discussion
Date: Fri, 26 Jul 2019 15:46:59 -0700
Message-ID: <alpine.OSX.2.21.1907261012060.28553@wjohns3x-mobl.amr.corp.intel.com>
In-Reply-To: 0220bc31c1297158107e87df9198635c2acdbb07.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1567

--===============2867350402827289578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2019, Paolo Abeni wrote:

> Hi all,
>
> I spent some time reviewing the current code-base looking for missing
> pieces required for multiple subflow support, and I think there are a
> bunch of things that would be needed no matter what.
>
> I'd like to share the list, with some random implementation details, to
> possibly avoid duplicate effort and/or large misunderstanding on my
> side. Here it goes:
>
> * Update msk data_ack:
>  - hook in mptcp_attach_dss() - possibly rename the function to
>      mptcp_data_ready()

That's a good place for a hook. Peter's current MP_JOIN patch set has a =

rename already.

>  - cope with 32bit ack

The current prototype cheats by ignoring the incoming acks. With the =

single-subflow assumption, the MPTCP-level socket isn't yet keeping a copy =

of the transmitted data and there's no action to take with incoming acks. =

The peer may send 32-bit acks so we do need to handle both ack lengths =

when we add ack handling.

>  - possibly some additional msk-level [spin-]lock would be required to
>    protect from concurrent updates when multiple sub-flows are running

Possibly. cmpxchg (with appropriate barriers) might work well for updating =

the ack since it keeps moving forward. If there was a concurrent update it =

would get detected and it would be clear whether the update should be =

attempted again. The mptcp-level transmit buffer could be trimmed later =

when the mptcp socket can be properly locked.

>    - while at this, eventually re-consider (again!) conn_list
>      locking ?!?
>
> * Store in msk pending data, to allow retransmissions
>  - in sendmsg(), queue pending (unacked) xmit msg on msk rtx_queue
>    - does it need to be a rb tree?
>      - sort by mptcp seq
>        - cope with 32bit seq

I don't think we need an rb tree. Most of the usage will be appending new =

data and trimming the head of the list as acks arrive. If we need to =

retransmit, we start from the first non-acked byte, which is the head of =

the list. Since we don't have SACK functionality, it doesn't seem like we =

will attempt to retransmit from the middle of the unacked data unless =

there's a subflow failure we're trying to recover from - and that's a rare =

enough event we can just go through the pending data linearly. Maybe the =

multipath-tcp.org kernel has some lessons for us here :)

>  - allocate the node element from the msk page frag's allocator
>    - each node must contains: all the data frag, mptcp seq,
>      [mptcp seq_end?]

Do we need much beyond a list of page frags, the mptcp seq for the =

beginning byte, and the length?

If we get fancy about handling retransmissions we could keep track of =

which subflow the data was already sent on, but it looks like we don't =

need that to get basic functionality up and running.

>  - NO need to check vs mptcp window before tcp_push()
>        unless we want to update the window size as per RFC
>          (max of subflow's window size)
>        because msk ws is greater equal than subflows ws
>  - free acked nodes (and data) still in sendmsg(),
>    just after acquiring msk lock, before doing any real
>    sendmsg related work

We can also check on the recvmsg side and in a workqueue (maybe shared =

with the retransmit check?) so memory gets freed up even when the socket =

isn't sending all the time.

>
> * Implement msk-level retransmission
>  - add msk-level [hr-]timer
>  - schedule it in sendmsg, after tcp_push()
>    - e.g. if msk ack !=3D msk seq
>    - which timeout? subflow's rtt based ?

The RFC mentions "a few subflow-level retransmission timeouts" as a =

conservative policy (section 3.3.6).

>  - when the timer expires, trigger retransmit if msk ack is not
>    changed (increased) since the timer's scheduling
>    - reuse/factor-out part of current sendmsg_frag() retransmit
>      a bunch of already-in-kernel page frags.

That's what I've been thinking. Whether a first-time transmission or a =

retransmission, we'll take the data from a list of page frags and =

do_tcp_sendpages().

>
> I hope the all above can be quite independent from e.g. path management
> implementation.

Yes, it should be.

>
> If there is agreement on that, my plan would be to work on the listed
> items, in order. As usual, any feedback more than welcome!

Ok. I've been planning to work on these tasks too, but am not ready to =

start on them today. You should dive in. After I get a couple of other =

tasks out of the way I can coordinate with you.


--
Mat Martineau
Intel

--===============2867350402827289578==--
